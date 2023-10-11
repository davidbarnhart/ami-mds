CREATE TABLE [Error].[AlwinArea] (
    [Name]             VARCHAR (MAX) NULL,
    [Description]      VARCHAR (MAX) NULL,
    [Status]           VARCHAR (MAX) NULL,
    [AreaID]           VARCHAR (MAX) NULL,
    [SegmentID]        VARCHAR (MAX) NULL,
    [AlternateID]      VARCHAR (MAX) NULL,
    [Manager]          VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinArea]
    ON [Error].[AlwinArea]([ErrorRowId] ASC);

