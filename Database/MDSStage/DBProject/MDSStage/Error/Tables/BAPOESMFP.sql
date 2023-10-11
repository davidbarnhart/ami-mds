CREATE TABLE [Error].[BAPOESMFP] (
    [SLSTAT]           VARCHAR (MAX) NULL,
    [SLDTCR]           VARCHAR (MAX) NULL,
    [SLDTUP]           VARCHAR (MAX) NULL,
    [SLBRCH]           VARCHAR (MAX) NULL,
    [SLSLS#]           VARCHAR (MAX) NULL,
    [SLNAME]           VARCHAR (MAX) NULL,
    [SLSMRG]           VARCHAR (MAX) NULL,
    [SLACCT]           VARCHAR (MAX) NULL,
    [SLPHNE]           VARCHAR (MAX) NULL,
    [SLCELL]           VARCHAR (MAX) NULL,
    [SLMSL#]           VARCHAR (MAX) NULL,
    [SLEXTN]           VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_BAPOESMFP]
    ON [Error].[BAPOESMFP]([ErrorRowId] ASC);

