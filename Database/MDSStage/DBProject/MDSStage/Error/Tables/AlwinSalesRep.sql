CREATE TABLE [Error].[AlwinSalesRep] (
    [Status]            VARCHAR (MAX) NULL,
    [SalesRepID]        VARCHAR (MAX) NULL,
    [FirstName]         VARCHAR (MAX) NULL,
    [MiddleName]        VARCHAR (MAX) NULL,
    [LastName]          VARCHAR (MAX) NULL,
    [DisplayName]       VARCHAR (MAX) NULL,
    [EmailAddress]      VARCHAR (MAX) NULL,
    [ProfileID]         VARCHAR (MAX) NULL,
    [Title]             VARCHAR (MAX) NULL,
    [ManagerSalesRepID] VARCHAR (MAX) NULL,
    [AuditKey]          INT           NULL,
    [ErrorRowId]        INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]         INT           NULL,
    [ErrorColumn]       INT           NULL,
    [ErrorColumnName]   VARCHAR (128) NULL,
    [ErrorDescription]  VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AlwinSalesRep]
    ON [Error].[AlwinSalesRep]([ErrorRowId] ASC);

