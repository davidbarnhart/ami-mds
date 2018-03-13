
CREATE VIEW MDS.GentekSupplyCenterMap
AS

WITH 
GentekSupplyCenters AS
(
SELECT 
		'GC' + LTRIM(RTRIM(ALBRCH)) as [Code],
		LTRIM(RTRIM(ALDESC)) as [Name]
	FROM Stage.BAPAMLOCP
	WHERE NULLIF(LTRIM(RTRIM(ALBRCH)),'') IS NOT NULL
	UNION ALL
	SELECT 
		'GU' + LTRIM(RTRIM(ALBRCH)) as [Code],
		LTRIM(RTRIM(ALDESC)) as [Name]
	FROM Stage.BAPUSAMLOCP
	WHERE NULLIF(LTRIM(RTRIM(ALBRCH)),'') IS NOT NULL
	AND LTRIM(RTRIM(ALDESC)) <> 'WOODBRIDGE (REVERE)'
),
Final AS
(
	SELECT 
		CAST([Code] as nvarchar(250)) as [Code],
		CAST([Name] as nvarchar(250)) as [Name]
	FROM GentekSupplyCenters
)
SELECT *
FROM Final