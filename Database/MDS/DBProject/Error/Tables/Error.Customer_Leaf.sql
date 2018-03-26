﻿CREATE TABLE [Error].[Customer_Leaf] (
    [Code]                       NVARCHAR (MAX) NULL,
    [Name]                       NVARCHAR (MAX) NULL,
    [ImportType]                 NVARCHAR (MAX) NULL,
    [ImportStatus_ID]            NVARCHAR (MAX) NULL,
    [Division]                   NVARCHAR (MAX) NULL,
    [PrimarySupplyCenter]        NVARCHAR (MAX) NULL,
    [Type]                       NVARCHAR (MAX) NULL,
    [LogisticsSegment]           NVARCHAR (MAX) NULL,
    [Vertical]                   NVARCHAR (MAX) NULL,
    [NewAccountIndicator]        NVARCHAR (MAX) NULL,
    [Status]                     NVARCHAR (MAX) NULL,
    [Number]                     NVARCHAR (MAX) NULL,
    [BillingAccountGroup]        NVARCHAR (MAX) NULL,
    [BillingMasterIndicator]     NVARCHAR (MAX) NULL,
    [BillingAddressStreet]       NVARCHAR (MAX) NULL,
    [BillingAddressStreet2]      NVARCHAR (MAX) NULL,
    [BillingAddressCity]         NVARCHAR (MAX) NULL,
    [BillingAddressState]        NVARCHAR (MAX) NULL,
    [BillingAddressZip]          NVARCHAR (MAX) NULL,
    [BillingAddressCounty]       NVARCHAR (MAX) NULL,
    [ContactPerson]              NVARCHAR (MAX) NULL,
    [Email]                      NVARCHAR (MAX) NULL,
    [PhoneNumber]                NVARCHAR (MAX) NULL,
    [FaxNumber]                  NVARCHAR (MAX) NULL,
    [PreferredCommunicationType] NVARCHAR (MAX) NULL,
    [CreditTerms]                NVARCHAR (MAX) NULL,
    [CreditLimit]                NVARCHAR (MAX) NULL,
    [CreditHoldIndicator]        NVARCHAR (MAX) NULL,
    [OpenedDate]                 NVARCHAR (MAX) NULL,
    [CreatedDate]                NVARCHAR (MAX) NULL,
    [LastActivityDate]           NVARCHAR (MAX) NULL,
    [SalesAgreementIndicator]    NVARCHAR (MAX) NULL,
    [SalesAgreementDate]         NVARCHAR (MAX) NULL,
    [DeletedIndicator]           NVARCHAR (MAX) NULL,
    [HiddenIndicator]            NVARCHAR (MAX) NULL,
    [NationalAccount]            NVARCHAR (MAX) NULL,
    [OwnerGroup]                 NVARCHAR (MAX) NULL,
    [MDSErrorCode]               NVARCHAR (MAX) NULL,
    [AuditKey]                   INT            NULL,
    [ErrorRowId]                 INT            IDENTITY (1, 1) NOT NULL,
    [ErrorCode]                  INT            NULL,
    [ErrorColumn]                INT            NULL,
    [ErrorColumnName]            VARCHAR (128)  NULL,
    [ErrorDescription]           VARCHAR (MAX)  NULL
);


GO
CREATE CLUSTERED INDEX [cxError_Customer_Leaf]
    ON [Error].[Customer_Leaf]([ErrorRowId] ASC);
