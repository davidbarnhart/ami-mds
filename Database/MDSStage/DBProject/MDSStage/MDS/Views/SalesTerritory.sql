
CREATE VIEW MDS.SalesTerritory
AS

WITH 
TerritoryList as
(
--Canadian Territories
SELECT 
	CONCAT('G-',SLBRCH,'-',LTRIM(SLSLS#)) AS TERRITORY_NUMBER, 
	LTRIM(RTRIM(SLNAME)) AS TERRITORY_NAME, 
	'CAN' AS SHIP_FROM_COUNTRY,
	'G' as Division
FROM Stage.BAPOESMFP
UNION ALL
--US Territories (Gentek)
SELECT 
	CONCAT('G-',
	CASE 
		WHEN SUBSTRING(RTRIM([SLSLS#]),1,1) = '0' AND LEN(RTRIM([SLSLS#])) = 4 
			THEN SUBSTRING(RTRIM([SLSLS#]),2,3) 
		ELSE RTRIM([SLSLS#]) 
	END) AS TERRITORY_NUMBER, 
	LTRIM(RTRIM(SLNAME)) AS TERRITORY_NAME, 
	'USA' AS SHIP_FROM_COUNTRY,
	'G' as Division
FROM Stage.BAPUSOESMFP
WHERE SLBRCH = '13' 
UNION ALL
SELECT 
	CONCAT('A-',LTRIM(RTRIM(TerritoryNumber))) as TerritoryNumber,
	[Name] as Territory_Name,
	ShipFromCountry as SHIP_FROM_COUNTRY,
	'A' as Division
FROM Stage.AlwinTerritory
WHERE DivisionID = 1
AND [status] = 1
AND NULLIF(LTRIM(RTRIM(TerritoryNumber)),'') IS NOT NULL

),
Final AS 
(
	SELECT 
		CAST(TERRITORY_NUMBER as nvarchar(250)) as Code,
		CAST(TERRITORY_NAME as nvarchar(250)) as [Name],
		CAST(Division as nvarchar(250)) as Division
	FROM TerritoryList
)
SELECT *
FROM Final