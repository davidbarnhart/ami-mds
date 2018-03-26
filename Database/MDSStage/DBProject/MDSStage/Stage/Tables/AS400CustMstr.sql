﻿CREATE TABLE [Stage].[AS400CustMstr] (
    [CST_COMPANY]            VARCHAR (3)    NULL,
    [CST_CUSTOMER_NBR]       VARCHAR (9)    NULL,
    [CST_STATE_CODE]         VARCHAR (2)    NULL,
    [CST_TAX_CODE]           VARCHAR (1)    NULL,
    [CST_TERRITORY]          VARCHAR (3)    NULL,
    [CST_CUSTOMER_NAME]      VARCHAR (31)   NULL,
    [CST_CUSTOMER_GROUP]     VARCHAR (2)    NULL,
    [CST_STREET]             VARCHAR (30)   NULL,
    [CST_ADDITIONAL]         VARCHAR (30)   NULL,
    [CST_CITY]               VARCHAR (20)   NULL,
    [CST_STATE]              VARCHAR (2)    NULL,
    [CST_ZIP]                VARCHAR (9)    NULL,
    [CST_COUNTY]             VARCHAR (25)   NULL,
    [CST_VENDOR]             VARCHAR (20)   NULL,
    [CST_FILLER_BL]          VARCHAR (8)    NULL,
    [CST_SIDING_BL]          VARCHAR (2)    NULL,
    [CST_ACCESSORY_BL]       VARCHAR (2)    NULL,
    [CST_GUTTER_BL]          VARCHAR (2)    NULL,
    [CST_DELUXE_GTR_BL]      VARCHAR (2)    NULL,
    [CST_RIGID_BRICK_BL]     VARCHAR (2)    NULL,
    [CST_DOORS_BL]           VARCHAR (2)    NULL,
    [CST_SPEC_PRICE_FLAG]    VARCHAR (1)    NULL,
    [CST_TERMS_CODE]         VARCHAR (2)    NULL,
    [CST_PCT_DISCOUNT]       NUMERIC (2, 1) NULL,
    [CST_CREDIT_LIMIT]       NUMERIC (6)    NULL,
    [CST_DATE_OPENED]        VARCHAR (6)    NULL,
    [CST_NEW_ACCT_CODE]      VARCHAR (1)    NULL,
    [CST_SALES_AGREEMENT]    VARCHAR (1)    NULL,
    [CST_AGREEMENT_DATE]     VARCHAR (6)    NULL,
    [CST_ACTIVITY_DATE]      VARCHAR (5)    NULL,
    [CST_PHONE_NUMBER]       VARCHAR (10)   NULL,
    [CST_DISCOUNT]           NUMERIC (3, 1) NULL,
    [CST_BENC_CODE]          VARCHAR (1)    NULL,
    [CST_SPEC_CODE]          VARCHAR (2)    NULL,
    [CST_SALES_SIZE]         VARCHAR (1)    NULL,
    [CST_FILLER]             VARCHAR (95)   NULL,
    [CST_DELETION_CODE]      VARCHAR (1)    NULL,
    [CST_TWA]                VARCHAR (1)    NULL,
    [CST_147]                VARCHAR (1)    NULL,
    [CST_VIA]                VARCHAR (2)    NULL,
    [CST_PRICING_IND]        VARCHAR (1)    NULL,
    [CST_PC]                 VARCHAR (1)    NULL,
    [CST_SHIP_TO_NAME]       VARCHAR (40)   NULL,
    [CST_SHIP_TO_STREET]     VARCHAR (40)   NULL,
    [CST_SHIP_TO_ADDITIONAL] VARCHAR (40)   NULL,
    [CST_SHIP_TO_CITY]       VARCHAR (40)   NULL,
    [CST_SHIP_TO_STATE]      VARCHAR (2)    NULL,
    [CST_SHIP_TO_ZIP]        VARCHAR (9)    NULL,
    [CST_SHIP_TO_COUNTY]     VARCHAR (2)    NULL,
    [CST_TAX_PRODUCT_CODE]   VARCHAR (12)   NULL,
    [CST_HIDE_ACCOUNT]       VARCHAR (1)    NULL,
    [AuditKey]               INT            NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_AS400CustMstr]
    ON [Stage].[AS400CustMstr]([CST_CUSTOMER_NBR] ASC);
