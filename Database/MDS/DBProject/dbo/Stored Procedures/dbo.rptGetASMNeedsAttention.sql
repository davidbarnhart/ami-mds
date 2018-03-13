
CREATE PROCEDURE [dbo].[rptGetASMNeedsAttention]
	@EmailAddress varchar(100)
AS
/*
========================================================================
Copyright (c) 2017 BlueGranite
========================================================================
Name:        rptGetASMNeedsAttention
Developer:   Jim Bennett
Create Date: 11/24/2017
Purpose:     The rptGetASMNeedsAttention SP Returns the count of customers
			that need attention and associated Customer Entity Info

------------------------------------------------------------------------
Revision History
Revision# Date       Who  Description
--------- ---------  ---  ----------------------------------------------
 

Example:
EXEC dbo.rptGetASMNeedsAttention  'cbaumann@alside.com';

========================================================================
*/

DECLARE @MDSURL varchar(100);
DECLARE @EntityInfo TABLE(
	VersionName varchar(100),
	VersionId int, 
	ModelName varchar(100),
	Model_ID int,  
	EntityName varchar(250), 
	EntityID int,  
	ModelMUID uniqueidentifier, 
	VersionMUID uniqueidentifier, 
	EntityMUID uniqueidentifier
	);

INSERT INTO @EntityInfo
EXEC dbo.getVersionByStageTableName 'stg.Customer_Leaf';

SELECT @MDSURL = SettingValue
FROM mdm.viw_SYSTEM_SCHEMA_SYSTEMSETTINGS
WHERE SettingName = 'MDMRootURL'

SELECT 
	@MDSURL as MdsURL,
	CAST(ei.ModelMUID as varchar(50)) as ModelMUID,
	CAST(ei.VersionMUID as varchar(50)) as VersionMUID,
	CAST(ei.EntityMUID as varchar(50)) as EntityMUID,
	asm.EmailAddress,
	asm.[Name] as ASMName,
	count(*) as CustomerCount
FROM mdm.Customer c
INNER JOIN mdm.SalesTerritory st
	ON st.Code = c.SalesTerritory_Code
INNER JOIN mdm.AreaSalesManager asm
	ON asm.Code = st.AreaSalesManager_Code
CROSS JOIN @EntityInfo ei
WHERE asm.EmailAddress = @EmailAddress
--AND c.ASMAttentionNeededIndicator_Code = N'Y'
AND c.CreatedDate > DATEADD(dd,-14,GETDATE()) --Created in the last 2 weeks
GROUP BY 
	ei.ModelMUID,
	ei.VersionMUID,
	ei.EntityMUID,
	asm.EmailAddress,
	asm.[Name]
;