CREATE TABLE [Error].[AlwinLocation] (
    [Location]         VARCHAR (MAX) NULL,
    [LocationName]     VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinLocation]
    ON [Error].[AlwinLocation]([ErrorRowId] ASC);

