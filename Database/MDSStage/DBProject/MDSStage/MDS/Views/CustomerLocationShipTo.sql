

CREATE VIEW [MDS].[CustomerLocationShipTo]
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
		l.Code as [Location],
		NULL as ShipToAddressName,
		CST_STREET as ShipToAddressStreet,
		NULLIF(LTRIM(RTRIM(CST_ADDITIONAL)),'') as ShipToAddressStreet2,
		CST_CITY as ShipToAddressCity,
		CST_STATE as ShipToAddressState,
		CST_ZIP as ShipToAddressZip,
		CST_COUNTY as ShipToAddressCounty,
		NULL as GentekTerritory
	FROM Stage.AS400CustMstr cm
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CST_COMPANY
		AND l.Division = 'A'
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
BAPCanadaCustomers AS
(
	SELECT 
		CONCAT('GC-',cm.CMBRCH,'-',cm.CMCUST,'-',CAST(cm.CMSHIP as varchar(10))) as Code,
		cm.CMNAME as [Name],
		cm.CMCUST as Number,		
		l.Code as [Location],
		cm.CMNAME as ShipToAddressName,
		CMADD1 as ShipToAddressStreet,
		NULLIF(LTRIM(RTRIM(CMADD2)),'') as ShipToAddressStreet2,
		CMCITY as ShipToAddressCity,
		CMPROV as ShipToAddressState,
		CMPOST as ShipToAddressZip,
		NULL as ShipToAddressCounty,
		ct.TerritoryID as GentekTerritory
	FROM Stage.BAPOECMFP AS cm
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CMBRCH
		AND l.Division = 'G'
	LEFT OUTER JOIN CustomerTerritory ct
		ON ct.AccountNumber = CONCAT('C-',cm.CMBRCH,'-',LEFT(cm.CMCUST,5),'-',CAST(cm.CMSHIP as varchar(10)))
	WHERE cm.CMBRCH NOT IN  ('99')
),

BAPUSCustomers AS
(
	SELECT 
		CONCAT('GU-',cm.CMBRCH,'-',cm.CMCUST,'-',CAST(cm.CMSHIP as varchar(10))) as Code,
		CMNAME as [Name],
		cm.CMCUST as Number,		
		l.Code as [Location],
		cm.CMNAME as ShipToAddressName,
		CMADD1 as ShipToAddressStreet,
		NULLIF(LTRIM(RTRIM(CMADD2)),'') as ShipToAddressStreet2,
		CMCITY as ShipToAddressCity,
		CMPROV as ShipToAddressState,
		CMPOST as ShipToAddressZip,
		NULL as ShipToAddressCounty,
		ct.TerritoryID as GentekTerritory
	FROM Stage.BAPUSOECMFP AS cm
	LEFT OUTER JOIN MDS.[Location] AS l
		ON l.Number = cm.CMBRCH
		AND l.Division = 'G'
	LEFT OUTER JOIN CustomerTerritory ct
		ON ct.AccountNumber = CONCAT('U-',cm.CMBRCH,'-',LEFT(cm.CMCUST,5),'-',CAST(cm.CMSHIP as varchar(10)))
	WHERE cm.CMBRCH NOT IN  ('99')

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
	CAST([Location] as nvarchar(250)) as [Location],
	CAST(ShipToAddressName as nvarchar(100)) as ShipToAddressName,
	CAST(ShipToAddressStreet as nvarchar(250)) as ShipToAddressStreet, 
	CAST(ShipToAddressStreet2 as nvarchar(250)) as ShipToAddressStreet2, 
	CAST(ShipToAddressCity as nvarchar(100)) as ShipToAddressCity, 
	CAST(ShipToAddressState as nvarchar(250)) as ShipToAddressState, 
	CAST(ShipToAddressZip as nvarchar(10)) as ShipToAddressZip, 
	CAST(ShipToAddressCounty as nvarchar(100)) as ShipToAddressCounty, 
	CAST(GentekTerritory as nvarchar(250)) as GentekTerritory
FROM AllCustomers
)

SELECT 
	*
FROM Final