

-- Sample Script for creating the Stage and Error Tables for a Stage Package
/*
DROP TABLE Stage.AlwinLocation
DROP TABLE Error.AlwinLocation
*/
GO

CREATE TABLE Stage.AlwinCustomerPurchasingSite (
    [Name] varchar(30),
    [Status] tinyint,
    [PurchasingSiteID] int,
    [CustomerID] int,
    [ExternalRef] varchar(30),
    [IsDefault] tinyint,
    [FriendlyName] varchar(30),
    [Email] varchar(50),
    [Phone] varchar(25),
    [TerritoryID] int,
    [StartDate] datetime,
    [EndDate] datetime,
    [IsPrimary] tinyint,
    [AddressLine1] varchar(60),
    [AddressLine2] varchar(60),
    [City] varchar(25),
    [County] varchar(25),
    [State] varchar(2),
    [Country] varchar(25),
    [Zip] varchar(12),
    [AuditKey] int
) ON [Data];
GO

CREATE CLUSTERED INDEX cxStage_AlwinCustomerPurchasingSite ON Stage.AlwinCustomerPurchasingSite(PurchasingSiteID,CustomerID) ON [Data];
GO

/*
*********************************************************
Regular Expression to change the columns to varchar(max)
*********************************************************
Find:
\]+[ ]+((tiny)*(small)*(big)*(int)(eger)*)|(uniqueidentifier)|(float)|(bit)|((small)*date(time)*(2)*)|(\][ ]+varchar\([0-9]+\))|(\][ ]+numeric\([0-9]+,[0-9]+\))|(decimal\([0-9]+,[0-9]+\))

Replace:
] varchar(max) NULL

*/


CREATE TABLE Error.AlwinCustomerPurchasingSite (
    [Name] varchar(max) NULL,
    [Status] varchar(max) NULL,
    [PurchasingSiteID] varchar(max) NULL,
    [CustomerID] varchar(max) NULL,
    [ExternalRef] varchar(max) NULL,
    [IsDefault] varchar(max) NULL,
    [FriendlyName] varchar(max) NULL,
    [Email] varchar(max) NULL,
    [Phone] varchar(max) NULL,
    [TerritoryID] varchar(max) NULL,
    [StartDate] varchar(max) NULL,
    [EndDate] varchar(max) NULL,
    [IsPrimary] varchar(max) NULL,
    [AddressLine1] varchar(max) NULL,
    [AddressLine2] varchar(max) NULL,
    [City] varchar(max) NULL,
    [County] varchar(max) NULL,
    [State] varchar(max) NULL,
    [Country] varchar(max) NULL,
    [Zip] varchar(max) NULL,
    [AuditKey] int,
	[ErrorRowId] int IDENTITY(1,1) NOT NULL,
	[ErrorCode] int,
    [ErrorColumn] int,
	[ErrorColumnName] varchar(128),
	[ErrorDescription] varchar(max)
) ON [Data];
GO

CREATE CLUSTERED INDEX cxError_AlwinCustomerPurchasingSite ON Error.AlwinCustomerPurchasingSite(ErrorRowId) ON [Data];
GO