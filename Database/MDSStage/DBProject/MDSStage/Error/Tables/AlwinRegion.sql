CREATE TABLE [Error].[AlwinRegion] (
    [Name]             VARCHAR (MAX) NULL,
    [Description]      VARCHAR (MAX) NULL,
    [Status]           VARCHAR (MAX) NULL,
    [AccountPrefix]    VARCHAR (MAX) NULL,
    [RegionID]         VARCHAR (MAX) NULL,
    [SegmentID]        VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinRegion]
    ON [Error].[AlwinRegion]([ErrorRowId] ASC);

