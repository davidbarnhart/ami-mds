

CREATE VIEW [MDS].[CustomerLocation]
AS

WITH 
AS400Customer AS
(
	SELECT 
		CONCAT('A-',[CST_COMPANY],'-',LEFT(cm.CST_CUSTOMER_NBR,5)) as Code,
		LTRIM(RTRIM(CASE
			WHEN RIGHT(CST_Customer_Name,1) = '-' THEN LEFT(CST_Customer_Name,LEN(CST_Customer_Name)-1)
			ELSE CST_Customer_Name 
		END)) as [Name],
		LEFT(cm.CST_CUSTOMER_NBR,5) as Number,
		NULL as BillParentIndicator,
		l.Code as [Location],
		CST_STREET as BillingAddressStreet,
		NULLIF(LTRIM(RTRIM(CST_ADDITIONAL)),'') as BillingAddressStreet2,
		CST_CITY as BillingAddressCity,
		CST_STATE as BillingAddressState,
		CST_ZIP as BillingAddressZip,
		CST_COUNTY as BillingAddressCounty,
		NULL as ContactPerson,
		NULL as Email,
		NULLIF(NULLIF(LTRIM(RTRIM(CST_Phone_NUMBER)),'0000000000'),'') as PhoneNumber,
		NULL as FaxNumber,
		CAST(CONCAT(LEFT(CST_DATE_OPENED,2),'/',SUBSTRING(CST_DATE_OPENED,3,2),'/',RIGHT(CST_DATE_OPENED,2)) AS Date) as OpenedDate,
		CAST(CONCAT(LEFT(CST_DATE_OPENED,2),'/',SUBSTRING(CST_DATE_OPENED,3,2),'/',RIGHT(CST_DATE_OPENED,2)) AS Date) as CreatedDate,
		CAST(NULL as date) as LastActivityDate --CST_ACTIVITY_DATE
	FROM Stage.AS400CustMstr cm
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CST_COMPANY
		AND l.Division = 'A'
),
BAPUSAddessesByBranchAndCustomerBase AS
(
	SELECT DISTINCT
		c.CMBRCH,
		c.CMCUST, 
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
BAPUSAddessesByBranchAndCustomer AS
(
	SELECT 
		CMBRCH,
		CMCUST,
		LEFT(EmailAddressList,LEN(EmailAddressList) - CHARINDEX(';',REVERSE( EmailAddressList))) as EmailAddressList
	FROM BAPUSAddessesByBranchAndCustomerBase
),

BAPCANAddessesByBranchAndCustomerBase AS
(
	SELECT DISTINCT
		c.CMBRCH,
		c.CMCUST, 
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
BAPCANAddessesByBranchAndCustomer AS
(
	SELECT 
		CMBRCH,
		CMCUST,
		LEFT(EmailAddressList,LEN(EmailAddressList) - CHARINDEX(';',REVERSE( EmailAddressList))) as EmailAddressList
	FROM BAPCANAddessesByBranchAndCustomerBase
),

BAPCanadaCustomers AS
(
	SELECT 
		CONCAT('GC-',cm.CMBRCH,'-',cm.CMCUST) as Code,
		CMNAME as [Name],
		cm.CMCUST as Number,		
		NULL as BillParentIndicator,
		l.Code as [Location],
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
		END as Date) as LastActivityDate
	FROM Stage.BAPOECMFP AS cm
	LEFT OUTER JOIN BAPCANAddessesByBranchAndCustomer e
		ON e.CMBRCH = cm.CMBRCH
		AND e.CMCUST = cm.CMCUST
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CMBRCH
		AND l.Division = 'G'
	WHERE cm.CMBRCH NOT IN  ('99')
	AND cm.CMSHIP = 0
),

BAPUSCustomers AS
(
	SELECT 
		CONCAT('GU-',cm.CMBRCH,'-',cm.CMCUST) as Code,
		CMNAME as [Name],
		cm.CMCUST as Number,		
		NULL as BillParentIndicator,
		l.Code as [Location],
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
		END as Date) as LastActivityDate
	FROM Stage.BAPUSOECMFP AS cm
	LEFT OUTER JOIN BAPUSAddessesByBranchAndCustomer e
		ON e.CMBRCH = cm.CMBRCH
		AND e.CMCUST = cm.CMCUST
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CMBRCH
		AND l.Division = 'G'
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
	CAST(Number as nvarchar(100)) as Number, 
	CAST(BillParentIndicator as nvarchar(250)) as BillParentIndicator, 
	CAST([Location] as nvarchar(250)) as [Location],
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
	CAST(OpenedDate as date) as OpenedDate, 
	CAST(CreatedDate as date) as CreatedDate, 
	CAST(LastActivityDate as date) as LastActivityDate
FROM AllCustomers
)

SELECT 
	*
FROM Final