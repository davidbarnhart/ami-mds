USE TestMasterData
GO

CREATE TABLE Error.AreaSalesManager_Leaf(
    [Code] nvarchar(max),
    [Name] nvarchar(max),
    [ImportType] nvarchar(max),
    [ImportStatus_ID] nvarchar(max),

    EmailAddress nvarchar(max),
    

	[MDSErrorCode] nvarchar(max),
    [AuditKey] int,
	[ErrorRowId] int IDENTITY(1,1) NOT NULL,
	[ErrorCode] int,
    [ErrorColumn] int,
	[ErrorColumnName] varchar(128),
	[ErrorDescription] varchar(max)
);

GO

CREATE CLUSTERED INDEX cxError_AreaSalesManager_Leaf ON Error.AreaSalesManager_Leaf([ErrorRowId]);
GO
