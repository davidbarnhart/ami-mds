﻿CREATE TABLE [Error].[PolicyType_Leaf] (
    [Code]             NVARCHAR (MAX) NULL,
    [Name]             NVARCHAR (MAX) NULL,
    [ImportType]       NVARCHAR (MAX) NULL,
    [ImportStatus_ID]  NVARCHAR (MAX) NULL,
    [AuditKey]         INT            NULL,
    [ErrorRowId]       INT            IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT            NULL,
    [ErrorColumn]      INT            NULL,
    [ErrorColumnName]  VARCHAR (128)  NULL,
    [ErrorDescription] VARCHAR (MAX)  NULL
);


GO
CREATE CLUSTERED INDEX [cxError_PolicyType_Leaf]
    ON [Error].[PolicyType_Leaf]([ErrorRowId] ASC);

