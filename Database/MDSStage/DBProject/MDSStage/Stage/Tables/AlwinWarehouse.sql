CREATE TABLE [Stage].[AlwinWarehouse] (
    [Name]                            VARCHAR (50)   NULL,
    [WarehouseNum]                    INT            NULL,
    [Address1]                        VARCHAR (35)   NULL,
    [Address2]                        VARCHAR (35)   NULL,
    [City]                            VARCHAR (30)   NULL,
    [State]                           VARCHAR (2)    NULL,
    [ZipCode]                         VARCHAR (10)   NULL,
    [Country]                         VARCHAR (20)   NULL,
    [Phone]                           VARCHAR (14)   NULL,
    [FaxPhone]                        VARCHAR (14)   NULL,
    [Contact]                         VARCHAR (35)   NULL,
    [Warehouse]                       INT            NULL,
    [Direct]                          INT            NULL,
    [S]                               INT            NULL,
    [M]                               INT            NULL,
    [T]                               INT            NULL,
    [W]                               INT            NULL,
    [TH]                              INT            NULL,
    [F]                               INT            NULL,
    [SA]                              INT            NULL,
    [EMail]                           VARCHAR (1000) NULL,
    [CommType]                        INT            NULL,
    [NFRCLogoID]                      INT            NULL,
    [NFRCLogoData]                    VARCHAR (20)   NULL,
    [QCLabelImageID]                  INT            NULL,
    [CustomerIsCastle]                INT            NULL,
    [CustModelDescTypeID]             INT            NULL,
    [ParentWarehouseNum]              VARCHAR (10)   NULL,
    [GridBumpers]                     INT            NULL,
    [ShipFOsComplete]                 INT            NULL,
    [EnableAdvancedShipmentReporting] BIT            NULL,
    [AdvancedShipmentReportingPath]   VARCHAR (300)  NULL,
    [CustomerIsWW]                    INT            NULL,
    [ASNFileFormat]                   VARCHAR (20)   NULL,
    [WarehouseCustomerGroupID]        INT            NULL,
    [CustClingLabelTypeID]            INT            NULL,
    [AuditKey]                        INT            NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinWarehouse]
    ON [Stage].[AlwinWarehouse]([WarehouseNum] ASC);

