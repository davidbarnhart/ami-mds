CREATE TABLE [Stage].[AlwinPurchasingSiteType] (
    [Name]                 VARCHAR (30) NULL,
    [Description]          VARCHAR (60) NULL,
    [Status]               TINYINT      NULL,
    [PurchasingSiteTypeID] INT          NULL,
    [IsVisibleOnPortal]    TINYINT      NULL,
    [AccountPrefix]        VARCHAR (15) NULL,
    [AuditKey]             INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinPurchasingSiteType]
    ON [Stage].[AlwinPurchasingSiteType]([PurchasingSiteTypeID] ASC);

