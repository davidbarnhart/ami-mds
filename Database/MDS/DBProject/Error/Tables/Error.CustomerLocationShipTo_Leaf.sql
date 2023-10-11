CREATE TABLE [Error].[CustomerLocationShipTo_Leaf] (
    [Code]                 NVARCHAR (MAX) NULL,
    [Name]                 NVARCHAR (MAX) NULL,
    [ImportType]           NVARCHAR (MAX) NULL,
    [ImportStatus_ID]      NVARCHAR (MAX) NULL,
    [Number]               NVARCHAR (MAX) NULL,
    [Location]             NVARCHAR (MAX) NULL,
    [ShipToAddressName]    NVARCHAR (MAX) NULL,
    [ShipToAddressStreet]  NVARCHAR (MAX) NULL,
    [ShipToAddressStreet2] NVARCHAR (MAX) NULL,
    [ShipToAddressCity]    NVARCHAR (MAX) NULL,
    [ShipToAddressState]   NVARCHAR (MAX) NULL,
    [ShipToAddressZip]     NVARCHAR (MAX) NULL,
    [ShipToAddressCounty]  NVARCHAR (MAX) NULL,
    [GentekTerritory]      NVARCHAR (MAX) NULL,
    [MDSErrorCode]         NVARCHAR (MAX) NULL,
    [AuditKey]             INT            NULL,
    [ErrorRowId]           INT            IDENTITY (1, 1) NOT NULL,
    [ErrorCode]            INT            NULL,
    [ErrorColumn]          INT            NULL,
    [ErrorColumnName]      VARCHAR (128)  NULL,
    [ErrorDescription]     VARCHAR (MAX)  NULL
);


GO
CREATE CLUSTERED INDEX [cxError_CustomerLocationShipTo_Leaf]
    ON [Error].[CustomerLocationShipTo_Leaf]([ErrorRowId] ASC);

