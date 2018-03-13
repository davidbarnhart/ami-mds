CREATE VIEW MDS.SalesTerritoryHierarchy AS
WITH
SalesHierachyFlat AS
(
	SELECT 
		t.TerritoryID,
		l1.SalesRepID as l1SalesRepID, l1.displayName as l1displayname, l1.EmailAddress as l1EmailAddress, l1.Title as l1Title,
		l2.SalesRepID as l2SalesRepID, l2.displayName as l2displayname, l2.EmailAddress as l2EmailAddress, l2.Title as l2Title, 
		l3.SalesRepID as l3SalesRepID, l3.displayName as l3displayname, l3.EmailAddress as l3EmailAddress, l3.Title as l3Title, 
		l4.SalesRepID as l4SalesRepID, l4.displayName as l4displayname, l4.EmailAddress as l4EmailAddress, l4.Title as l4Title
	FROM Stage.AlwinSalesRep l1
	LEFT OUTER JOIN Stage.AlwinSalesRep l2
		ON l2.SalesRepID = l1.ManagerSalesRepID
	LEFT OUTER JOIN Stage.AlwinSalesRep l3
		ON l3.SalesRepID = l2.ManagerSalesRepID
	LEFT OUTER JOIN Stage.AlwinSalesRep l4
		ON l4.SalesRepID = l3.ManagerSalesRepID
	INNER JOIN Stage.AlwinTerritory t
		ON t.SalesRepID = l1.SalesRepID
),
Territories AS
(
	SELECT 
		t.TerritoryID as Code,
		LTRIM(RTRIM(t.[Name])) as [Name],
		CASE
			WHEN DivisionID = 1 THEN 'A'
			WHEN DivisionID = 2 THEN 'G'
			ELSE NULL
		END as Division,
		TerritoryNumber,
		LTRIM(RTRIM(r.[Name])) as Region,
		LTRIM(RTRIM(a.[Name])) as Area,
		shf.l1displayname as SalesRep,
		CASE
			WHEN shf.l1Title like '%Area%' THEN shf.l1SalesRepID
			WHEN shf.l2Title like '%Area%' THEN shf.l2SalesRepID
			WHEN shf.l3Title like '%Area%' THEN shf.l3SalesRepID
			WHEN shf.l4Title like '%Area%' THEN shf.l4SalesRepID
			ELSE shf.l1SalesRepID
		END as AreaSalesManagerID,
		CASE
			WHEN shf.l1Title like '%Area%' THEN shf.l1displayname
			WHEN shf.l2Title like '%Area%' THEN shf.l2displayname
			WHEN shf.l3Title like '%Area%' THEN shf.l3displayname
			WHEN shf.l4Title like '%Area%' THEN shf.l4displayname
			ELSE shf.l1displayname
		END as AreaSalesManager,
		CASE
			WHEN shf.l1Title like '%Area%' THEN shf.l1EmailAddress
			WHEN shf.l2Title like '%Area%' THEN shf.l2EmailAddress
			WHEN shf.l3Title like '%Area%' THEN shf.l3EmailAddress
			WHEN shf.l4Title like '%Area%' THEN shf.l4EmailAddress
			ELSE shf.l1EmailAddress
		END as AreaSalesManagerEmailAddress,
		CASE
			WHEN shf.l1Title like '%Regional%' THEN shf.l1SalesRepID
			WHEN shf.l2Title like '%Regional%' THEN shf.l2SalesRepID
			WHEN shf.l3Title like '%Regional%' THEN shf.l3SalesRepID
			WHEN shf.l4Title like '%Regional%' THEN shf.l4SalesRepID
			ELSE shf.l1SalesRepID
		END as RegionalSalesManagerID,
		CASE
			WHEN shf.l1Title like '%Regional%' THEN shf.l1displayname
			WHEN shf.l2Title like '%Regional%' THEN shf.l2displayname
			WHEN shf.l3Title like '%Regional%' THEN shf.l3displayname
			WHEN shf.l4Title like '%Regional%' THEN shf.l4displayname
			ELSE shf.l1displayname
		END as RegionalSalesManager,
		CASE
			WHEN shf.l1Title like '%Regional%' THEN shf.l1EmailAddress
			WHEN shf.l2Title like '%Regional%' THEN shf.l2EmailAddress
			WHEN shf.l3Title like '%Regional%' THEN shf.l3EmailAddress
			WHEN shf.l4Title like '%Regional%' THEN shf.l4EmailAddress
			ELSE shf.l1EmailAddress
		END as RegionalSalesManagerEmailAddress
	FROM Stage.AlwinTerritory t
	LEFT OUTER JOIN Stage.AlwinRegion r
		ON r.RegionID = t.RegionID
	LEFT OUTER JOIN Stage.AlwinArea a
		ON a.AreaID = t.AreaID
	LEFT OUTER JOIN SalesHierachyFlat shf
		ON shf.TerritoryID = t.TerritoryID
	WHERE t.[Status] = 1
),
Final AS
(
	SELECT 
		CAST(Code as nvarchar(250)) as Code,
		CAST([Name] as nvarchar(250)) as [Name],
		CAST(Division as nvarchar(250)) as Division,
		CAST(TerritoryNumber as nvarchar(10)) as TerritoryNumber,
		CAST(Region as nvarchar(50)) as Region,
		CAST(Area as nvarchar(50)) as Area,
		CAST(SalesRep as nvarchar(50)) as SalesRep,
		CAST(AreaSalesManagerID as nvarchar(250)) as AreaSalesManagerID,
		CAST(AreaSalesManager as nvarchar(250)) as AreaSalesManager,
		CAST(AreaSalesManagerEmailAddress as nvarchar(100)) as AreaSalesManagerEmailAddress,
		CAST(RegionalSalesManagerID as nvarchar(250)) as RegionalSalesManagerID,
		CAST(RegionalSalesManager as nvarchar(250)) as RegionalSalesManager,
		CAST(RegionalSalesManagerEmailAddress as nvarchar(100)) as RegionalSalesManagerEmailAddress
	FROM Territories
)

SELECT *
FROM Final