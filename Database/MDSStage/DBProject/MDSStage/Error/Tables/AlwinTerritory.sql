CREATE TABLE [Error].[AlwinTerritory] (
    [Name]             VARCHAR (MAX) NULL,
    [Description]      VARCHAR (MAX) NULL,
    [Status]           VARCHAR (MAX) NULL,
    [RegionID]         VARCHAR (MAX) NULL,
    [DivisionID]       VARCHAR (MAX) NULL,
    [TerritoryID]      VARCHAR (MAX) NULL,
    [TerritoryNumber]  VARCHAR (MAX) NULL,
    [SalesRepID]       VARCHAR (MAX) NULL,
    [AreaID]           VARCHAR (MAX) NULL,
    [Unused]           VARCHAR (MAX) NULL,
    [TerritoryTypeID]  VARCHAR (MAX) NULL,
    [ShipFromCountry]  VARCHAR (MAX) NULL,
    [AuditKey]         INT           NULL,
    [ErrorRowId]       INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]        INT           NULL,
    [ErrorColumn]      INT           NULL,
    [ErrorColumnName]  VARCHAR (128) NULL,
    [ErrorDescription] VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinTerritory]
    ON [Error].[AlwinTerritory]([ErrorRowId] ASC);

