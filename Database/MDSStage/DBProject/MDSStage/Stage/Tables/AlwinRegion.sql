CREATE TABLE [Stage].[AlwinRegion] (
    [Name]          VARCHAR (30) NULL,
    [Description]   VARCHAR (60) NULL,
    [Status]        TINYINT      NULL,
    [AccountPrefix] VARCHAR (15) NULL,
    [RegionID]      INT          NULL,
    [SegmentID]     TINYINT      NULL,
    [AuditKey]      INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinRegion]
    ON [Stage].[AlwinRegion]([RegionID] ASC);

