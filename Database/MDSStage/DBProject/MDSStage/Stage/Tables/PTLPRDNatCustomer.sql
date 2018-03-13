CREATE TABLE [Stage].[PTLPRDNatCustomer] (
    [NAT_CODE]     VARCHAR (5)  NULL,
    [NAT_NAME]     VARCHAR (30) NULL,
    [NAT_CUST_NBR] VARCHAR (5)  NULL,
    [AuditKey]     INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_PTLPRDNatCustomer]
    ON [Stage].[PTLPRDNatCustomer]([NAT_CODE] ASC, [NAT_CUST_NBR] ASC);

