CREATE TABLE [Stage].[AS400Location] (
    [LOCATION]      VARBINARY (15)  NULL,
    [LOCATION_NAME] VARBINARY (100) NULL,
    [AuditKey]      INT             NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AS400Location]
    ON [Stage].[AS400Location]([LOCATION] ASC);

