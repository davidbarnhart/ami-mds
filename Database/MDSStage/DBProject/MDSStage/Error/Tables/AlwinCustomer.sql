CREATE TABLE [Error].[AlwinCustomer] (
    [Name]              VARCHAR (MAX) NULL,
    [Status]            VARCHAR (MAX) NULL,
    [CustomerID]        VARCHAR (MAX) NULL,
    [AccountNumber]     VARCHAR (MAX) NULL,
    [CustomerSegmentID] VARCHAR (MAX) NULL,
    [FriendlyName]      VARCHAR (MAX) NULL,
    [CustomerTypeID]    VARCHAR (MAX) NULL,
    [CanBuyDirect]      VARCHAR (MAX) NULL,
    [StartDate]         VARCHAR (MAX) NULL,
    [EndDate]           VARCHAR (MAX) NULL,
    [AddressLine1]      VARCHAR (MAX) NULL,
    [AddressLine2]      VARCHAR (MAX) NULL,
    [City]              VARCHAR (MAX) NULL,
    [County]            VARCHAR (MAX) NULL,
    [State]             VARCHAR (MAX) NULL,
    [Country]           VARCHAR (MAX) NULL,
    [Zip]               VARCHAR (MAX) NULL,
    [BuyingGroupID]     VARCHAR (MAX) NULL,
    [AuditKey]          INT           NULL,
    [ErrorRowId]        INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]         INT           NULL,
    [ErrorColumn]       INT           NULL,
    [ErrorColumnName]   VARCHAR (128) NULL,
    [ErrorDescription]  VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinCustomer]
    ON [Error].[AlwinCustomer]([ErrorRowId] ASC);

