CREATE TABLE [Error].[AlwinCustomerPurchasingSite] (
    [Name]             VARCHAR (MAX) NULL,
    [Status]           VARCHAR (MAX) NULL,
    [PurchasingSiteID] VARCHAR (MAX) NULL,
    [CustomerID]       VARCHAR (MAX) NULL,
    [ExternalRef]      VARCHAR (MAX) NULL,
    [IsDefault]        VARCHAR (MAX) NULL,
    [FriendlyName]     VARCHAR (MAX) NULL,
    [Email]            VARCHAR (MAX) NULL,
    [Phone]            VARCHAR (MAX) NULL,
    [TerritoryID]      VARCHAR (MAX) NULL,
    [StartDate]        VARCHAR (MAX) NULL,
    [EndDate]          VARCHAR (MAX) NULL,
    [IsPrimary]        VARCHAR (MAX) NULL,
    [AddressLine1]     VARCHAR (MAX) NULL,
    [AddressLine2]     VARCHAR (MAX) NULL,
    [City]             VARCHAR (MAX) NULL,
    [County]           VARCHAR (MAX) NULL,
    [State]            VARCHAR (MAX) NULL,
    [Country]          VARCHAR (MAX) NULL,
    [Zip]              VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinCustomerPurchasingSite]
    ON [Error].[AlwinCustomerPurchasingSite]([ErrorRowId] ASC);

