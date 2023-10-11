CREATE TABLE [Stage].[AlwinCustomerPurchasingSite] (
    [Name]             VARCHAR (30) NULL,
    [Status]           TINYINT      NULL,
    [PurchasingSiteID] INT          NULL,
    [CustomerID]       INT          NULL,
    [ExternalRef]      VARCHAR (30) NULL,
    [IsDefault]        TINYINT      NULL,
    [FriendlyName]     VARCHAR (30) NULL,
    [Email]            VARCHAR (50) NULL,
    [Phone]            VARCHAR (25) NULL,
    [TerritoryID]      INT          NULL,
    [StartDate]        DATETIME     NULL,
    [EndDate]          DATETIME     NULL,
    [IsPrimary]        TINYINT      NULL,
    [AddressLine1]     VARCHAR (60) NULL,
    [AddressLine2]     VARCHAR (60) NULL,
    [City]             VARCHAR (25) NULL,
    [County]           VARCHAR (25) NULL,
    [State]            VARCHAR (2)  NULL,
    [Country]          VARCHAR (25) NULL,
    [Zip]              VARCHAR (12) NULL,
    [AuditKey]         INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinCustomerPurchasingSite]
    ON [Stage].[AlwinCustomerPurchasingSite]([PurchasingSiteID] ASC, [CustomerID] ASC);

