
CREATE VIEW [MDS].[Location]
AS

WITH Locations AS
(
	SELECT 
		ps.SiteNumber as Code,
		ps.[Description] as [Name],
		ps.PurchasingSiteTypeId as LocationType,
		CASE
			WHEN PurchasingSiteTypeId = 7 THEN COALESCE(cl.ALBRCH,ul.ALBRCH)
			ELSE ps.SiteNumber
		END as Number,
		CASE
			WHEN ps.PurchasingSiteTypeId IN (7,8) THEN 'G'
			ELSE 'A'
		END as Division,
		'Y' as ActiveIndicator
	FROM [Stage].[AlwinPurchasingSite] ps
	LEFT OUTER JOIN Stage.BAPAMLOCP cl
		ON cl.ALASLC = ps.SiteNumber
	LEFT OUTER JOIN Stage.BAPUSAMLOCP ul
		ON ul.ALASLC = ps.SiteNumber
),
InActivePurchasingSites AS
(
	SELECT 
		Location as Code,
		LocationName as [Name],
		NULL as LocationType,
		NULL as Number,
		CASE
			WHEN CAST(al.Location as int) > 300 THEN 'G'
			ELSE 'A'
		END as Division,
		'N' as ActiveIndicator
	FROM Stage.AlwinLocation as al
	LEFT OUTER JOIN Locations as aps
		ON aps.Code = al.Location
	WHERE CAST(al.[Location] as int) BETWEEN 100 and 489
	AND al.[Location] NOT IN ('111','199','101')
	AND aps.Code IS NULL
),
InActiveGentekPurchasingSites AS
(
	SELECT 
		LTRIM(RTRIM(gl.ALASLC)) as [Code],
		LTRIM(RTRIM(ALDESC)) as [Name],
		NULL as LocationType,
		NULL as Number,
		'G' as Division,
		'N' as ActiveIndicator
	FROM Stage.BAPAMLOCP as gl
	LEFT OUTER JOIN Locations as l
		ON LTRIM(RTRIM(gl.ALASLC)) = l.Code
	LEFT OUTER JOIN InActivePurchasingSites as il
		ON LTRIM(RTRIM(gl.ALASLC)) = il.Code
	WHERE l.Code IS NULL
	AND il.Code IS NULL
	UNION ALL
	SELECT 
		LTRIM(RTRIM(gl.ALASLC))  as [Code],
		LTRIM(RTRIM(ALDESC)) as [Name],
		NULL as LocationType,
		NULL as Number,
		'G' as Division,
		'N' as ActiveIndicator
	FROM Stage.BAPUSAMLOCP as gl
	LEFT OUTER JOIN Locations as l
		ON LTRIM(RTRIM(gl.ALASLC)) = l.Code
	LEFT OUTER JOIN InActivePurchasingSites as il
		ON LTRIM(RTRIM(gl.ALASLC)) = il.Code
	WHERE l.Code IS NULL
	AND il.Code IS NULL
	AND LTRIM(RTRIM(ALDESC)) <> 'WOODBRIDGE (REVERE)'
),
Combined as 
(
	SELECT  *
	FROM Locations
	UNION ALL 
	SELECT  *
	FROM InActivePurchasingSites
	UNION ALL 
	SELECT  *
	FROM InActiveGentekPurchasingSites
),
Final as
(
	SELECT 
		CAST(Code as nvarchar(250)) as Code,
		CAST([Name] as nvarchar(250)) as [Name],
		CAST(Division as nvarchar(250)) as Division,
		CAST(LocationType as nvarchar(250)) as LocationType,
		CAST(Number as nvarchar(10)) as Number,
		CAST(ActiveIndicator as nvarchar(250)) as ActiveIndicator
	FROM Combined
)
SELECT 
	*
FROM Final