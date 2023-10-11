CREATE TABLE [Error].[BAPUSAMLOCP] (
    [ALASLC]           VARCHAR (MAX) NULL,
    [ALBRCH]           VARCHAR (MAX) NULL,
    [ALDESC]           VARCHAR (MAX) NULL,
    [ALISTA]           VARCHAR (MAX) NULL,
    [ALCSFL]           VARCHAR (MAX) NULL,
    [ALSHIV]           VARCHAR (MAX) NULL,
    [ALNCHR]           VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_BAPUSAMLOCP]
    ON [Error].[BAPUSAMLOCP]([ErrorRowId] ASC);

