CREATE TABLE [Stage].[AlwinCustomer] (
    [Name]              VARCHAR (30) NULL,
    [Status]            TINYINT      NULL,
    [CustomerID]        INT          NULL,
    [AccountNumber]     VARCHAR (15) NULL,
    [CustomerSegmentID] INT          NULL,
    [FriendlyName]      VARCHAR (30) NULL,
    [CustomerTypeID]    INT          NULL,
    [CanBuyDirect]      TINYINT      NULL,
    [StartDate]         DATETIME     NULL,
    [EndDate]           DATETIME     NULL,
    [AddressLine1]      VARCHAR (60) NULL,
    [AddressLine2]      VARCHAR (60) NULL,
    [City]              VARCHAR (25) NULL,
    [County]            VARCHAR (25) NULL,
    [State]             VARCHAR (2)  NULL,
    [Country]           VARCHAR (25) NULL,
    [Zip]               VARCHAR (12) NULL,
    [BuyingGroupID]     INT          NULL,
    [AuditKey]          INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinCustomer]
    ON [Stage].[AlwinCustomer]([CustomerID] ASC);

