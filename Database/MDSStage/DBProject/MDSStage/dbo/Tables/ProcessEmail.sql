CREATE TABLE [dbo].[ProcessEmail] (
    [ProcessName]        VARCHAR (100) NOT NULL,
    [ProcessState]       VARCHAR (50)  NOT NULL,
    [EmailRecipients]    VARCHAR (500) NOT NULL,
    [EmailCCRecipients]  VARCHAR (500) NULL,
    [EmailBCCRecipients] VARCHAR (500) NULL,
    [EmailSubject]       VARCHAR (200) NOT NULL,
    [EmailMessage]       VARCHAR (MAX) NULL,
    [HighPriority]       BIT           NOT NULL,
    [LastSentDate]       DATETIME      NULL,
    CONSTRAINT [PK_ProcessEmail] PRIMARY KEY CLUSTERED ([ProcessName] ASC, [ProcessState] ASC)
);

