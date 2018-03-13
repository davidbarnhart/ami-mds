CREATE VIEW MDS.Customer
AS

WITH AS400PrimarySiteCustomer AS
(
	SELECT
		CST_Company, 
		CST_CUSTOMER_NBR,
		ROW_NUMBER() OVER(PARTITION BY CST_CUSTOMER_NBR ORDER By CAST(CONCAT(LEFT(CST_DATE_OPENED,2),'/',SUBSTRING(CST_DATE_OPENED,3,2),'/',RIGHT(CST_DATE_OPENED,2)) AS Date)) as r
	FROM Stage.AS400CustMstr
),
CustomerTerritory AS
(
	SELECT 
		c.AccountNumber,
		ps.SiteNumber,
		cps.TerritoryID
	FROM Stage.AlwinCustomer c
	INNER JOIN Stage.AlwinCustomerPurchasingSite cps
		ON cps.CustomerID = c.CustomerID
	INNER JOIN Stage.AlwinPurchasingSite ps
		ON ps.PurchasingSiteID = cps.PurchasingSiteID
),
AS400Customer AS
(
	SELECT 
		CONCAT('A-',LEFT(cm.CST_CUSTOMER_NBR,5)) as Code,
		LTRIM(RTRIM(CASE
			WHEN RIGHT(CST_Customer_Name,1) = '-' THEN LEFT(CST_Customer_Name,LEN(CST_Customer_Name)-1)
			ELSE CST_Customer_Name 
		END)) as [Name],
		'A' as Division,
		l.Code as PrimaryLocation,
		CASE
			WHEN LEFT(cm.CST_CUSTOMER_NBR,5) = 'E' THEN 'Y'
			ELSE 'N'
		END AS IsEmployeeAccount,
		CASE
			WHEN
				LEFT(LEFT(cm.CST_CUSTOMER_NBR,5),2) = '00'
				AND
				ISNUMERIC(RIGHT(LEFT(cm.CST_CUSTOMER_NBR,5),3)) = 1  
				AND
				CAST(RIGHT(LEFT(cm.CST_CUSTOMER_NBR,5),3) AS int) >= 100
				AND CAST(RIGHT(LEFT(cm.CST_CUSTOMER_NBR,5),3) AS int) <= 499 THEN 'Y'
			ELSE 'N'
		END as IsHouseAccount,
		NULL as [Type],
		'A' as AMISegment,
		NULL as DemandSource,
		CASE
			WHEN DATEADD(year,1,CAST(CONCAT(LEFT(CST_DATE_OPENED,2),'/',SUBSTRING(CST_DATE_OPENED,3,2),'/',RIGHT(CST_DATE_OPENED,2)) AS Date)) > getdate() 
				THEN 'Y'
			ELSE 'N'
		END as NewAccountIndicator,
		CASE
			WHEN DATEADD(year,1,CAST(CONCAT(LEFT(CST_DATE_OPENED,2),'/',SUBSTRING(CST_DATE_OPENED,3,2),'/',RIGHT(CST_DATE_OPENED,2)) AS Date)) > getdate() 
				THEN 'N'
			ELSE 'A'
		END as Status,
		LEFT(cm.CST_CUSTOMER_NBR,5) as Number,
		NULL as BillingAccountGroup,
		NULL as BillingMasterIndicator,
		CST_STREET as BillingAddressStreet,
		CST_ADDITIONAL as BillingAddressStreet2,
		CST_CITY as BillingAddressCity,
		CST_STATE as BillingAddressState,
		CST_ZIP as BillingAddressZip,
		CST_COUNTY as BillingAddressCounty,
		NULL as ContactPerson,
		NULL as Email,
		NULLIF(NULLIF(LTRIM(RTRIM(CST_Phone_NUMBER)),'0000000000'),'') as PhoneNumber,
		NULL as FaxNumber,
		NULL as PreferredCommunicationType,
		NULL as CreditTerms, --CST_TERMS_CODE
		CST_Credit_Limit as CreditLimit,
		NULL as CreditHoldIndicator, --No good way to determine this in AS400
		CAST(CONCAT(LEFT(CST_DATE_OPENED,2),'/',SUBSTRING(CST_DATE_OPENED,3,2),'/',RIGHT(CST_DATE_OPENED,2)) AS Date) as OpenedDate,
		CAST(CONCAT(LEFT(CST_DATE_OPENED,2),'/',SUBSTRING(CST_DATE_OPENED,3,2),'/',RIGHT(CST_DATE_OPENED,2)) AS Date) as CreatedDate,
		CAST(NULL as date) as LastActivityDate, --CST_ACTIVITY_DATE
		CAST(NULL as varchar(1)) as SalesAgreementIndicator, --CST_SALES_AGREEMENT
		CAST(NULL as date) as SalesAgreementDate, --CST_AGREEMENT_DATE
		CASE 
			WHEN NULLIF(LTRIM(RTRIM(CST_DELETION_CODE)),'') IS NULL THEN 'N'
			ELSE 'Y'
		END as DeletedIndicator,
		CASE 
			WHEN NULLIF(LTRIM(RTRIM(CST_HIDE_ACCOUNT)),'') IS NULL THEN 'N'
			ELSE 'Y'
		END as HiddenIndicator,
		NULL as NationalAccount,
		NULL as OwnerGroup,
		ct.TerritoryID as SalesTerritory
	FROM Stage.AS400CustMstr cm
	INNER JOIN AS400PrimarySiteCustomer psc
		ON psc.CST_CUSTOMER_NBR = cm.CST_CUSTOMER_NBR
		AND psc.CST_COMPANY = cm.CST_COMPANY
		AND psc.r = 1
	LEFT OUTER JOIN CustomerTerritory ct
		ON ct.AccountNumber = LEFT(cm.CST_CUSTOMER_NBR,5)
		AND ct.SiteNumber = cm.CST_COMPANY
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CST_Company
		AND l.Division = 'A'
),
BAPCANEmailAddessesByCustomerBase AS
(
	SELECT DISTINCT
		c.CMCUST, 
		c.CMBRCH,
		LEFT(
			STUFF((
				SELECT DISTINCT
					';' + LTRIM(RTRIM(EMEMAL))
				FROM Stage.BAPEMEMLP b
				WHERE c.CMCUST = b.EMCUST
				AND c.CMBRCH = b.EMBRCH
				FOR XML PATH('')
				), 1, 1, '') 
			,250) AS EmailAddressList
	FROM Stage.BAPOECMFP c
),
BAPCANEmailAddessesByCustomer AS
(
	SELECT 
		CMCUST,
		CMBRCH,
		LEFT(EmailAddressList,LEN(EmailAddressList) - CHARINDEX(';',REVERSE( EmailAddressList))) as EmailAddressList
	FROM BAPCANEmailAddessesByCustomerBase
),
BAPCanadaCustomerGroups AS
(
	SELECT 
		CONCAT('GC',CMBRCH,'-',CMCUST) as Code,
		CMLIMT as CustomerGroupCreditLimit
	FROM [Stage].[BAPOECMFP]
	WHERE CMBRCH = '99'
	AND CMCUST NOT IN ('01025')
	AND CMSTAT = 'A'
),
BAPCanadaCustomers AS
(
	SELECT 
		CONCAT('GC-',cm.CMBRCH,'-',cm.CMCUST) as Code,
		cm.CMNAME as [Name],
		'G' as Division,
		l.Code as PrimaryLocation,
		CASE 
			WHEN cm.CMCUST = '00097' THEN 'Y'
			WHEN CHARINDEX('EMPLOYEE',cm.CMNAME) > 0 THEN 'Y'                 
			ELSE 'N'
		END AS IsEmployeeAccount,
		CASE
			WHEN TRY_CAST(cm.CMCUST as int) < 100 THEN 'Y'
			WHEN CHARINDEX('CASH SALE',cm.CMNAME) > 0 THEN 'Y'
			ELSE 'N'
		END as IsHouseAccount,
		NULL as [Type],
		'G' as AMISegment,
		NULL as DemandSource,
		NULL as NewAccountIndicator, --CMDTCR
		CMSTAT as [Status],
		cm.CMCUST as Number,
		NULL as BillingAccountGroup,
		NULL as BillingMasterIndicator,
		CMADD1 as BillingAddressStreet,
		NULLIF(LTRIM(RTRIM(CMADD2)),'') as BillingAddressStreet2,
		CMCITY as BillingAddressCity,
		CMPROV as BillingAddressState,
		CMPOST as BillingAddressZip,
		NULL as BillingAddressCounty,
		NULLIF(LTRIM(RTRIM(CMCNTC)),'') as ContactPerson,
		e.EmailAddressList as Email,
		NULLIF(LTRIM(RTRIM(CMPHN1)),'')  as PhoneNumber,
		NULLIF(LTRIM(RTRIM(CMTFAX)),'') as FaxNumber,
		NULL as PreferredCommunicationType,
		NULL as CreditTerms, --
		COALESCE(cg.CustomerGroupCreditLimit,CMLIMT) as CreditLimit,
		CASE 
			WHEN LTRIM(RTRIM(CMCHLD)) IN ('Y','H') THEN 'Y'
			ELSE 'N'
		END as CreditHoldIndicator,
		TRY_CAST (
		CASE
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 6 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),3,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/19',LEFT(CAST(cm.CMDTCR as varchar(10)),2))
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 7 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),4,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/20',SUBSTRING(CAST(cm.CMDTCR as varchar(10)),1,2))
			ELSE NULL
		END as Date) as OpenedDate,
		TRY_CAST (
		CASE
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 6 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),3,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/19',LEFT(CAST(cm.CMDTCR as varchar(10)),2))
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 7 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),4,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/20',SUBSTRING(CAST(cm.CMDTCR as varchar(10)),1,2))
			ELSE NULL
		END as Date) as CreatedDate,
		TRY_CAST (
		CASE
			WHEN DATALENGTH(CAST(cm.CMDTLO as varchar(10))) = 6 THEN CONCAT(SUBSTRING(CAST(cm.CMDTLO as varchar(10)),3,2),'/',RIGHT(CAST(cm.CMDTLO as varchar(10)),2),'/19',LEFT(CAST(cm.CMDTLO as varchar(10)),2))
			WHEN DATALENGTH(CAST(cm.CMDTLO as varchar(10))) = 7 THEN CONCAT(SUBSTRING(CAST(cm.CMDTLO as varchar(10)),4,2),'/',RIGHT(CAST(cm.CMDTLO as varchar(10)),2),'/20',SUBSTRING(CAST(cm.CMDTLO as varchar(10)),1,2))
			ELSE NULL
		END as Date) as LastActivityDate, --
		CAST(NULL as varchar(1)) as SalesAgreementIndicator, --
		CAST(NULL as date) as SalesAgreementDate, --
		NULL as DeletedIndicator,
		NULL as HiddenIndicator,
		cg.Code as NationalAccount,
		NULL as OwnerGroup,
		ct.TerritoryID as SalesTerritory
	FROM Stage.BAPOECMFP AS cm
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CMBRCH
		AND l.Division = 'G'
	LEFT OUTER JOIN BAPCANEmailAddessesByCustomer AS e
		ON e.CMCUST = cm.CMCUST
		AND e.CMBRCH = cm.CMBRCH
	LEFT OUTER JOIN BAPCanadaCustomerGroups AS cg
		ON cg.Code = CONCAT('GC99-',CMCGRP)
	LEFT OUTER JOIN CustomerTerritory ct
		ON ct.AccountNumber = CONCAT('C-',cm.CMBRCH,'-',cm.CMCUST,'-0')
	WHERE cm.CMBRCH NOT IN  ('99')
	AND cm.CMSHIP = 0
),

BAPUSEmailAddessesByCustomerBase AS
(
	SELECT DISTINCT
		c.CMCUST, 
		c.CMBRCH,
		LEFT(
			STUFF((
				SELECT DISTINCT
					';' + LTRIM(RTRIM(EMEMAL))
				FROM Stage.BAPUSEMEMLP b
				WHERE c.CMCUST = b.EMCUST
				AND c.CMBRCH = b.EMBRCH
				FOR XML PATH('')
				), 1, 1, '') 
			,250) AS EmailAddressList
	FROM Stage.BAPUSOECMFP c
),
BAPUSEmailAddessesByCustomer AS
(
	SELECT 
		CMCUST,
		CMBRCH,
		LEFT(EmailAddressList,LEN(EmailAddressList) - CHARINDEX(';',REVERSE( EmailAddressList))) as EmailAddressList
	FROM BAPUSEmailAddessesByCustomerBase
),
BAPUSCustomerGroups AS
(
	SELECT 
		CONCAT('GU',CMBRCH,'-',CMCUST) as Code,
		CMLIMT as CustomerGroupCreditLimit
	FROM Stage.BAPUSOECMFP
	WHERE CMBRCH = '99'
	AND CMSTAT = 'A'
),
BAPUSCustomers AS
(
	SELECT 
		CONCAT('GU-',cm.CMBRCH,'-',cm.CMCUST) as Code,
		CMNAME as [Name],
		'G' as Division,
		l.Code as PrimaryLocation,
		CASE 
			WHEN cm.CMCUST = '00097' THEN 'Y'
			WHEN CHARINDEX('EMPLOYEE',cm.CMNAME) > 0 THEN 'Y'                 
			ELSE 'N'
		END AS IsEmployeeAccount,
		CASE
			WHEN TRY_CAST(cm.CMCUST as int) < 100 THEN 'Y'
			WHEN CHARINDEX('CASH SALE',cm.CMNAME) > 0 THEN 'Y'
			ELSE 'N'
		END as IsHouseAccount,
		NULL as [Type],
		'G' as AMISegment,
		NULL as DemandSource,
		NULL as NewAccountIndicator, --CMDTCR
		CMSTAT as [Status],
		cm.CMCUST as Number,
		NULL as BillingAccountGroup,
		NULL as BillingMasterIndicator,
		CMADD1 as BillingAddressStreet,
		NULLIF(LTRIM(RTRIM(CMADD2)),'') as BillingAddressStreet2,
		CMCITY as BillingAddressCity,
		CMPROV as BillingAddressState,
		CMPOST as BillingAddressZip,
		NULL as BillingAddressCounty,
		NULLIF(LTRIM(RTRIM(CMCNTC)),'') as ContactPerson,
		e.EmailAddressList as Email,
		NULLIF(LTRIM(RTRIM(CMPHN1)),'')  as PhoneNumber,
		NULLIF(LTRIM(RTRIM(CMTFAX)),'') as FaxNumber,
		NULL as PreferredCommunicationType,
		NULL as CreditTerms, --
		COALESCE(cg.CustomerGroupCreditLimit,CMLIMT) as CreditLimit,
		CASE 
			WHEN LTRIM(RTRIM(CMCHLD)) IN ('Y','H') THEN 'Y'
			ELSE 'N'
		END as CreditHoldIndicator,
		TRY_CAST (
		CASE
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 6 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),3,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/19',LEFT(CAST(cm.CMDTCR as varchar(10)),2))
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 7 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),4,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/20',SUBSTRING(CAST(cm.CMDTCR as varchar(10)),1,2))
			ELSE NULL
		END as Date) as OpenedDate,
		TRY_CAST (
		CASE
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 6 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),3,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/19',LEFT(CAST(cm.CMDTCR as varchar(10)),2))
			WHEN DATALENGTH(CAST(cm.CMDTCR as varchar(10))) = 7 THEN CONCAT(SUBSTRING(CAST(cm.CMDTCR as varchar(10)),4,2),'/',RIGHT(CAST(cm.CMDTCR as varchar(10)),2),'/20',SUBSTRING(CAST(cm.CMDTCR as varchar(10)),1,2))
			ELSE NULL
		END as Date) as CreatedDate,
		TRY_CAST (
		CASE
			WHEN DATALENGTH(CAST(cm.CMDTLO as varchar(10))) = 6 THEN CONCAT(SUBSTRING(CAST(cm.CMDTLO as varchar(10)),3,2),'/',RIGHT(CAST(cm.CMDTLO as varchar(10)),2),'/19',LEFT(CAST(cm.CMDTLO as varchar(10)),2))
			WHEN DATALENGTH(CAST(cm.CMDTLO as varchar(10))) = 7 THEN CONCAT(SUBSTRING(CAST(cm.CMDTLO as varchar(10)),4,2),'/',RIGHT(CAST(cm.CMDTLO as varchar(10)),2),'/20',SUBSTRING(CAST(cm.CMDTLO as varchar(10)),1,2))
			ELSE NULL
		END as Date) as LastActivityDate, 
		CAST(NULL as varchar(1)) as SalesAgreementIndicator, --
		CAST(NULL as date) as SalesAgreementDate, --
		NULL as DeletedIndicator,
		NULL as HiddenIndicator,
		cg.Code as NationalAccount,
		NULL as OwnerGroup,
		ct.TerritoryID as SalesTerritory
	FROM Stage.BAPUSOECMFP AS cm
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CMBRCH
		AND l.Division = 'G'
	LEFT OUTER JOIN BAPUSEmailAddessesByCustomer e
		ON e.CMCUST = cm.CMCUST
		AND e.CMBRCH = cm.CMBRCH
	LEFT OUTER JOIN BAPUSCustomerGroups cg
		ON cg.Code = CONCAT('GU99-',CMCGRP)
	LEFT OUTER JOIN CustomerTerritory ct
		ON ct.AccountNumber = CONCAT('C-',cm.CMBRCH,'-',cm.CMCUST,'-0')
	WHERE cm.CMBRCH NOT IN  ('99')
	AND cm.CMSHIP = 0
),
AllCustomers AS
(
	SELECT *
	FROM AS400Customer
	UNION ALL
	SELECT *
	FROM BAPCanadaCustomers
	UNION ALL
	SELECT *
	FROM BAPUSCustomers
),
Final AS
(
SELECT 
	CAST(Code as nvarchar(250)) as Code, 
	CAST([Name] as nvarchar(250)) as [Name], 
	CAST(Division as nvarchar(250)) as Division, 
	CAST(PrimaryLocation as nvarchar(250)) as PrimaryLocation, 
	CAST(IsEmployeeAccount as nvarchar(250)) AS IsEmployeeAccount,
	CAST(IsHouseAccount as nvarchar(250)) AS IsHouseAccount,
	CAST(AMISegment as nvarchar(250)) as AMISegment, 
	CAST(DemandSource as nvarchar(250)) as DemandSource, 
	CAST([Type] as nvarchar(250)) as [Type], 
	CAST(NewAccountIndicator as nvarchar(250)) as NewAccountIndicator, 
	CAST([Status] as nvarchar(250)) as [Status], 
	CAST(Number as nvarchar(100)) as Number, 
	CAST(BillingAccountGroup as nvarchar(250)) as BillingAccountGroup, 
	CAST(BillingMasterIndicator as nvarchar(250)) as BillingMasterIndicator, 
	CAST(BillingAddressStreet as nvarchar(250)) as BillingAddressStreet, 
	CAST(BillingAddressStreet2 as nvarchar(250)) as BillingAddressStreet2, 
	CAST(BillingAddressCity as nvarchar(100)) as BillingAddressCity, 
	CAST(BillingAddressState as nvarchar(250)) as BillingAddressState, 
	CAST(BillingAddressZip as nvarchar(10)) as BillingAddressZip, 
	CAST(BillingAddressCounty as nvarchar(100)) as BillingAddressCounty, 
	CAST(ContactPerson as nvarchar(100)) as ContactPerson, 
	CAST(Email as nvarchar(250)) as Email, 
	CAST(PhoneNumber as nvarchar(50)) as PhoneNumber, 
	CAST(FaxNumber as nvarchar(50)) as FaxNumber, 
	CAST(PreferredCommunicationType as nvarchar(100)) as PreferredCommunicationType, 
	CAST(CreditTerms as nvarchar(50)) as CreditTerms, 
	CAST(CreditLimit as decimal(12,0)) as CreditLimit, 
	CAST(CreditHoldIndicator as nvarchar(250)) as CreditHoldIndicator, 
	CAST(OpenedDate as date) as OpenedDate, 
	CAST(CreatedDate as date) as CreatedDate, 
	CAST(LastActivityDate as date) as LastActivityDate, 
	CAST(SalesAgreementIndicator as nvarchar(250)) as SalesAgreementIndicator, 
	CAST(SalesAgreementDate as date) as SalesAgreementDate, 
	CAST(DeletedIndicator as nvarchar(250)) as DeletedIndicator, 
	CAST(HiddenIndicator as nvarchar(250)) as HiddenIndicator, 
	CAST(NationalAccount as nvarchar(250)) as NationalAccount, 
	CAST(OwnerGroup as nvarchar(250)) as OwnerGroup,
	CAST(SalesTerritory as nvarchar(250)) as SalesTerritory
FROM AllCustomers
)

SELECT 
	*
FROM Final