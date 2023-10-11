
CREATE PROCEDURE [dbo].[getVersionByStageTableName]
	 @TableName varchar(255)
AS
/*
========================================================================
Copyright (c) 2017 BlueGranite
========================================================================
Name:        getVersionByStageTableName
Developer:   Jim Bennett
Create Date: 04/27/2017
Purpose:     The getVersionByStageTableName SP returns the newest versionname 
             of a model based on a stage table name

------------------------------------------------------------------------
Revision History
Revision# Date       Who  Description
--------- ---------  ---  ----------------------------------------------
 

Example:
EXEC dbo.getVersionByStageTableName  'stg.Platform_Leaf';

========================================================================
*/
IF CHARINDEX('.',@TableName) > 0
	SET @TableName = RIGHT(@TableName,LEN(@TableName) - CHARINDEX('.',@TableName));

WITH VersionList AS
(
	SELECT 
		sv.Name as VersionName,
		e.Model_ID,
		sv.ID as VersionId,
		e.Model_Name as ModelName,
		e.Name as EntityName,
		e.Entity_ID as EntityId,
		e.[Model_MUID] as ModelMUID,
		e.[MUID] as EntityMUID,
		sv.MUID as VersionMUID,
		ROW_NUMBER()OVER(ORDER BY sv.VersionNbr DESC) as r  --Newest Version Number for the model
	FROM [mdm].[viw_SYSTEM_SCHEMA_ENTITY] AS e
	INNER JOIN [mdm].[viw_SYSTEM_SCHEMA_VERSION] AS sv
		ON sv.Model_ID = e.Model_ID
	WHERE e.StagingLeafTable = @TableName
	OR e.StagingConsolidatedTable = @TableName
)
SELECT 
	VersionName,
	VersionId,
	ModelName,
	Model_ID,
	EntityName,
	EntityId,
	ModelMUID,
	VersionMUID,
	EntityMUID
FROM VersionList
WHERE r = 1