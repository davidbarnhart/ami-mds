CREATE VIEW MDS.CustomerGroup AS
WITH 
BAPCanadaCustomerGroups AS
(
	SELECT 
		CONCAT('GC',CMBRCH,'-',CMCUST) as Code,
		CMNAME as 'Name',
		'G' as Division
	FROM [Stage].[BAPOECMFP]
	WHERE CMBRCH = '99'
	AND CMCUST NOT IN ('01025')
	AND CMSTAT = 'A'
),
BAPUSCustomerGroups AS
(
	SELECT 
		CONCAT('GU',CMBRCH,'-',CMCUST) as Code,
		CMNAME as 'Name',
		'G' as Division
	FROM Stage.BAPUSOECMFP
	WHERE CMBRCH = '99'
	--AND CMCUST NOT IN ('01025')
	AND CMSTAT = 'A'
),
Combined AS
(
	SELECT * FROM BAPCanadaCustomerGroups
	UNION ALL
	SELECT * FROM BAPUSCustomerGroups
),
Final AS
(
	SELECT 
		CAST(Code as nvarchar(250)) as Code,
		CAST([Name] as nvarchar(250)) as [Name],
		CAST(Division as nvarchar(250)) as Division
	FROM Combined
)
SELECT *
FROM Final