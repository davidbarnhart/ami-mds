CREATE TABLE [Error].[AS400Location] (
    [LOCATION]         VARBINARY (MAX) NULL,
    [LOCATION_NAME]    VARBINARY (MAX) NULL,
    [AuditKey]         INT             NULL,
    [ErrorRowId]       INT             IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT             NULL,
    [ErrorColumn]      INT             NULL,
    [ErrorColumnName]  VARCHAR (128)   NULL,
    [ErrorDescription] VARCHAR (MAX)   NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AS400Location]
    ON [Error].[AS400Location]([ErrorRowId] ASC);

