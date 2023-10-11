CREATE TABLE [Stage].[AlwinSalesRep] (
    [Status]            TINYINT      NULL,
    [SalesRepID]        INT          NULL,
    [FirstName]         VARCHAR (25) NULL,
    [MiddleName]        VARCHAR (25) NULL,
    [LastName]          VARCHAR (25) NULL,
    [DisplayName]       VARCHAR (75) NULL,
    [EmailAddress]      VARCHAR (50) NULL,
    [ProfileID]         VARCHAR (25) NULL,
    [Title]             VARCHAR (50) NULL,
    [ManagerSalesRepID] INT          NULL,
    [AuditKey]          INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AlwinSalesRep]
    ON [Stage].[AlwinSalesRep]([SalesRepID] ASC);

