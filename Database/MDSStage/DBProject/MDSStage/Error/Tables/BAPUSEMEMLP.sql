CREATE TABLE [Error].[BAPUSEMEMLP] (
    [EMSTAT]           VARCHAR (MAX) NULL,
    [EMDTCR]           VARCHAR (MAX) NULL,
    [EMDTUP]           VARCHAR (MAX) NULL,
    [EMTMUP]           VARCHAR (MAX) NULL,
    [EMENTY]           VARCHAR (MAX) NULL,
    [EMEMLS]           VARCHAR (MAX) NULL,
    [EMSUPP]           VARCHAR (MAX) NULL,
    [EMBRCH]           VARCHAR (MAX) NULL,
    [EMCUST]           VARCHAR (MAX) NULL,
    [EMSHIP]           VARCHAR (MAX) NULL,
    [EMRCTP]           VARCHAR (MAX) NULL,
    [EMSNDF]           VARCHAR (MAX) NULL,
    [EMEMAL]           VARCHAR (MAX) NULL,
    [EMPROC]           VARCHAR (MAX) NULL,
    [EMDTUU]           VARCHAR (MAX) NULL,
    [EMUSUP]           VARCHAR (MAX) NULL,
    [EMDTSU]           VARCHAR (MAX) NULL,
    [EMUPGM]           VARCHAR (MAX) NULL,
    [EMSWPC]           VARCHAR (MAX) NULL,
    [EMZNLY]           VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_BAPUSEMEMLP]
    ON [Error].[BAPUSEMEMLP]([ErrorRowId] ASC);

