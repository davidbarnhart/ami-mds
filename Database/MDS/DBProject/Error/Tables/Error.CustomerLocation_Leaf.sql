CREATE TABLE [Error].[CustomerLocation_Leaf] (
    [Code]                  NVARCHAR (MAX) NULL,
    [Name]                  NVARCHAR (MAX) NULL,
    [ImportType]            NVARCHAR (MAX) NULL,
    [ImportStatus_ID]       NVARCHAR (MAX) NULL,
    [Number]                NVARCHAR (MAX) NULL,
    [BillingAddressStreet]  NVARCHAR (MAX) NULL,
    [BillingAddressStreet2] NVARCHAR (MAX) NULL,
    [BillingAddressCity]    NVARCHAR (MAX) NULL,
    [BillingAddressState]   NVARCHAR (MAX) NULL,
    [BillingAddressZip]     NVARCHAR (MAX) NULL,
    [BillingAddressCounty]  NVARCHAR (MAX) NULL,
    [ContactPerson]         NVARCHAR (MAX) NULL,
    [Email]                 NVARCHAR (MAX) NULL,
    [PhoneNumber]           NVARCHAR (MAX) NULL,
    [FaxNumber]             NVARCHAR (MAX) NULL,
    [OpenedDate]            NVARCHAR (MAX) NULL,
    [LastActivityDate]      NVARCHAR (MAX) NULL,
    [CreatedDate]           NVARCHAR (MAX) NULL,
    [AuditKey]              INT            NULL,
    [ErrorRowId]            INT            IDENTITY (1, 1) NOT NULL,
    [ErrorCode]             INT            NULL,
    [ErrorColumn]           INT            NULL,
    [ErrorColumnName]       VARCHAR (128)  NULL,
    [ErrorDescription]      VARCHAR (MAX)  NULL
);


GO
CREATE CLUSTERED INDEX [cxError_CustomerLocation_Leaf]
    ON [Error].[CustomerLocation_Leaf]([ErrorRowId] ASC);

