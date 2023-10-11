﻿CREATE TABLE [Error].[AS400CustMstr] (
    [CST_COMPANY]            VARCHAR (MAX) NULL,
    [CST_CUSTOMER_NBR]       VARCHAR (MAX) NULL,
    [CST_STATE_CODE]         VARCHAR (MAX) NULL,
    [CST_TAX_CODE]           VARCHAR (MAX) NULL,
    [CST_TERRITORY]          VARCHAR (MAX) NULL,
    [CST_CUSTOMER_NAME]      VARCHAR (MAX) NULL,
    [CST_CUSTOMER_GROUP]     VARCHAR (MAX) NULL,
    [CST_STREET]             VARCHAR (MAX) NULL,
    [CST_ADDITIONAL]         VARCHAR (MAX) NULL,
    [CST_CITY]               VARCHAR (MAX) NULL,
    [CST_STATE]              VARCHAR (MAX) NULL,
    [CST_ZIP]                VARCHAR (MAX) NULL,
    [CST_COUNTY]             VARCHAR (MAX) NULL,
    [CST_VENDOR]             VARCHAR (MAX) NULL,
    [CST_FILLER_BL]          VARCHAR (MAX) NULL,
    [CST_SIDING_BL]          VARCHAR (MAX) NULL,
    [CST_ACCESSORY_BL]       VARCHAR (MAX) NULL,
    [CST_GUTTER_BL]          VARCHAR (MAX) NULL,
    [CST_DELUXE_GTR_BL]      VARCHAR (MAX) NULL,
    [CST_RIGID_BRICK_BL]     VARCHAR (MAX) NULL,
    [CST_DOORS_BL]           VARCHAR (MAX) NULL,
    [CST_SPEC_PRICE_FLAG]    VARCHAR (MAX) NULL,
    [CST_TERMS_CODE]         VARCHAR (MAX) NULL,
    [CST_PCT_DISCOUNT]       VARCHAR (MAX) NULL,
    [CST_CREDIT_LIMIT]       VARCHAR (MAX) NULL,
    [CST_DATE_OPENED]        VARCHAR (MAX) NULL,
    [CST_NEW_ACCT_CODE]      VARCHAR (MAX) NULL,
    [CST_SALES_AGREEMENT]    VARCHAR (MAX) NULL,
    [CST_AGREEMENT_DATE]     VARCHAR (MAX) NULL,
    [CST_ACTIVITY_DATE]      VARCHAR (MAX) NULL,
    [CST_PHONE_NUMBER]       VARCHAR (MAX) NULL,
    [CST_DISCOUNT]           VARCHAR (MAX) NULL,
    [CST_BENC_CODE]          VARCHAR (MAX) NULL,
    [CST_SPEC_CODE]          VARCHAR (MAX) NULL,
    [CST_SALES_SIZE]         VARCHAR (MAX) NULL,
    [CST_FILLER]             VARCHAR (MAX) NULL,
    [CST_DELETION_CODE]      VARCHAR (MAX) NULL,
    [CST_TWA]                VARCHAR (MAX) NULL,
    [CST_147]                VARCHAR (MAX) NULL,
    [CST_VIA]                VARCHAR (MAX) NULL,
    [CST_PRICING_IND]        VARCHAR (MAX) NULL,
    [CST_PC]                 VARCHAR (MAX) NULL,
    [CST_SHIP_TO_NAME]       VARCHAR (MAX) NULL,
    [CST_SHIP_TO_STREET]     VARCHAR (MAX) NULL,
    [CST_SHIP_TO_ADDITIONAL] VARCHAR (MAX) NULL,
    [CST_SHIP_TO_CITY]       VARCHAR (MAX) NULL,
    [CST_SHIP_TO_STATE]      VARCHAR (MAX) NULL,
    [CST_SHIP_TO_ZIP]        VARCHAR (MAX) NULL,
    [CST_SHIP_TO_COUNTY]     VARCHAR (MAX) NULL,
    [CST_TAX_PRODUCT_CODE]   VARCHAR (MAX) NULL,
    [CST_HIDE_ACCOUNT]       VARCHAR (MAX) NULL,
    [AuditKey]               INT           NULL,
    [ErrorRowId]             INT           IDENTITY (1, 1) NOT NULL,
    [ErrorCode]              INT           NULL,
    [ErrorColumn]            INT           NULL,
    [ErrorColumnName]        VARCHAR (128) NULL,
    [ErrorDescription]       VARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cxError_AS400CustMstr]
    ON [Error].[AS400CustMstr]([ErrorRowId] ASC);

