

CREATE VIEW [MDS].[SupplyCenter]
AS

WITH ActivePurchasingSites AS
(
	SELECT 
		SiteNumber as Code,
		[Description] as [Name],
		CASE
			WHEN PurchasingSiteTypeId = 7 THEN 'G'
			ELSE 'A'
		END as Division,
		'Y' as ActiveIndicator
	  FROM [Stage].[AlwinPurchasingSite]
	  --WHERE PurchasingSiteTypeId IN (2,7)
),
InActivePurchasingSites AS
(
	SELECT 
		Location as Code,
		LocationName as [Name],
		CASE
			WHEN CAST(al.Location as int) > 300 THEN 'G'
			ELSE 'A'
		END as Division,
		'N' as ActiveIndicator
	FROM Stage.AlwinLocation as al
	LEFT OUTER JOIN ActivePurchasingSites as aps
		ON aps.Code = al.Location
	WHERE CAST(al.[Location] as int) BETWEEN 100 and 489
	AND al.[Location] NOT IN ('111','199','101')
	AND aps.Code IS NULL
),
InActiveGentekPurchasingSites AS
(
	SELECT 
		'GC' + LTRIM(RTRIM(ALBRCH)) as [Code],
		LTRIM(RTRIM(ALDESC)) as [Name],
		'G' as Division,
		'N' as ActiveIndicator
	FROM Stage.BAPAMLOCP as l
	INNER JOIN dbo.GentekSupplyCenterMap as m
		ON 'GC' + LTRIM(RTRIM(ALBRCH)) = m.Code
	WHERE NULLIF(LTRIM(RTRIM(ALBRCH)),'') IS NOT NULL
	AND m.SupplyCenter_Code IS NULL
	UNION ALL
	SELECT 
		'GU' + LTRIM(RTRIM(ALBRCH)) as [Code],
		LTRIM(RTRIM(ALDESC)) as [Name],
		'G' as Division,
		'N' as ActiveIndicator
	FROM Stage.BAPUSAMLOCP as l
	INNER JOIN dbo.GentekSupplyCenterMap as m
		ON 'GU' + LTRIM(RTRIM(ALBRCH)) = m.Code
	WHERE NULLIF(LTRIM(RTRIM(ALBRCH)),'') IS NOT NULL
	AND LTRIM(RTRIM(ALDESC)) <> 'WOODBRIDGE (REVERE)'
	AND m.SupplyCenter_Code IS NULL
),
Combined as 
(
	SELECT  *
	FROM ActivePurchasingSites
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
		CAST(ActiveIndicator as nvarchar(250)) as ActiveIndicator
	FROM Combined
)
SELECT *
FROM Final