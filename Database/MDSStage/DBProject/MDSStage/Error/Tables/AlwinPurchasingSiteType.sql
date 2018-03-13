CREATE TABLE [Error].[AlwinPurchasingSiteType] (
    [Name]                 VARCHAR (MAX) NULL,
    [Description]          VARCHAR (MAX) NULL,
    [Status]               VARCHAR (MAX) NULL,
    [PurchasingSiteTypeID] VARCHAR (MAX) NULL,
    [IsVisibleOnPortal]    VARCHAR (MAX) NULL,
    [AccountPrefix]        VARCHAR (MAX) NULL,
    [AuditKey]             INT           NULL,
    [ErrorRowId]           INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]            INT           NULL,
    [ErrorColumn]          INT           NULL,
    [ErrorColumnName]      VARCHAR (128) NULL,
    [ErrorDescription]     VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinPurchasingSiteType]
    ON [Error].[AlwinPurchasingSiteType]([ErrorRowId] ASC);

