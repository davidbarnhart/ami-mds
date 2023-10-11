CREATE TABLE [Stage].[AlwinArea] (
    [Name]        VARCHAR (30) NULL,
    [Description] VARCHAR (60) NULL,
    [Status]      TINYINT      NULL,
    [AreaID]      INT          NULL,
    [SegmentID]   INT          NULL,
    [AlternateID] VARCHAR (2)  NULL,
    [Manager]     VARCHAR (30) NULL,
    [AuditKey]    INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinArea]
    ON [Stage].[AlwinArea]([AreaID] ASC);

