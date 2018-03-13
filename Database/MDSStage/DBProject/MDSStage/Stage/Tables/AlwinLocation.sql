CREATE TABLE [Stage].[AlwinLocation] (
    [Location]     VARCHAR (30) NULL,
    [LocationName] VARCHAR (30) NULL,
    [AuditKey]     INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinLocation]
    ON [Stage].[AlwinLocation]([Location] ASC);

