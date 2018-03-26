﻿CREATE TABLE [Stage].[BAPOESMFP] (
    [SLSTAT]   VARCHAR (1)  NULL,
    [SLDTCR]   NUMERIC (7)  NULL,
    [SLDTUP]   NUMERIC (7)  NULL,
    [SLBRCH]   VARCHAR (2)  NULL,
    [SLSLS#]   VARCHAR (4)  NULL,
    [SLNAME]   VARCHAR (35) NULL,
    [SLSMRG]   VARCHAR (2)  NULL,
    [SLACCT]   VARCHAR (5)  NULL,
    [SLPHNE]   VARCHAR (10) NULL,
    [SLCELL]   VARCHAR (10) NULL,
    [SLMSL#]   VARCHAR (5)  NULL,
    [SLEXTN]   VARCHAR (5)  NULL,
    [AuditKey] INT          NULL
);


GO
CREATE CLUSTERED INDEX [cxStage_BAPOESMFP]
    ON [Stage].[BAPOESMFP]([SLBRCH] ASC, [SLSLS#] ASC);
