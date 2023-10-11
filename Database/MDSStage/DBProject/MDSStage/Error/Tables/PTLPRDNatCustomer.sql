CREATE TABLE [Error].[PTLPRDNatCustomer] (
    [NAT_CODE]         VARCHAR (MAX) NULL,
    [NAT_NAME]         VARCHAR (MAX) NULL,
    [NAT_CUST_NBR]     VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_PTLPRDNatCustomer]
    ON [Error].[PTLPRDNatCustomer]([ErrorRowId] ASC);

