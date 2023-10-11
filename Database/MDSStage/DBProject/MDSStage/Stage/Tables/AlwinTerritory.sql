CREATE TABLE [Stage].[AlwinTerritory] (
    [Name]            VARCHAR (50) NULL,
    [Description]     VARCHAR (60) NULL,
    [Status]          TINYINT      NULL,
    [RegionID]        INT          NULL,
    [DivisionID]      INT          NULL,
    [TerritoryID]     INT          NULL,
    [TerritoryNumber] VARCHAR (15) NULL,
    [SalesRepID]      INT          NULL,
    [AreaID]          INT          NULL,
    [Unused]          VARCHAR (30) NULL,
    [TerritoryTypeID] INT          NULL,
    [ShipFromCountry] VARCHAR (50) NULL,
    [AuditKey]        INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinTerritory]
    ON [Stage].[AlwinTerritory]([TerritoryID] ASC);

