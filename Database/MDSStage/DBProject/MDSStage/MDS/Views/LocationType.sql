
CREATE VIEW MDS.LocationType AS
WITH
LocationType as
(
	SELECT 
		PurchasingSiteTypeID as Code,
		[Description] as [Name]
	FROM Stage.AlwinPurchasingSiteType
	WHERE [Status] = 1
),
Final as
(
	SELECT 
		CAST(Code as nvarchar(250)) as Code,
		CAST([Name] as nvarchar(250)) as [Name]
	FROM LocationType
)
SELECT *
FROM Final