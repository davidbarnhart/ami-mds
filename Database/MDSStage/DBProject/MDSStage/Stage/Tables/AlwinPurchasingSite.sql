CREATE TABLE [Stage].[AlwinPurchasingSite] (
    [PurchasingSiteID]     INT          NULL,
    [SiteNumber]           VARCHAR (15) NULL,
    [Name]                 VARCHAR (30) NULL,
    [PurchasingSiteTypeId] INT          NULL,
    [Description]          VARCHAR (60) NULL,
    [Status]               TINYINT      NULL,
    [RegionID]             INT          NULL,
    [SegmentID]            INT          NULL,
    [DivisionID]           INT          NULL,
    [AuditKey]             INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinPurchasingSite]
    ON [Stage].[AlwinPurchasingSite]([PurchasingSiteID] ASC);

