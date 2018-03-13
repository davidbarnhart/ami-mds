/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
SET IDENTITY_INSERT [dbo].[DimAudit] ON 

GO
INSERT [dbo].[DimAudit] ([AuditKey], [ParentAuditKey], [TableName], [PkgName], [PkgGUID], [PkgVersionGUID], [PkgVersionMajor], [PkgVersionMinor], [ExecStartDT], [ExecStopDT], [ExecutionInstanceGUID], [ExtractRowCnt], [InsertRowCnt], [UpdateRowCnt], [ErrorRowCnt], [TableInitialRowCnt], [TableFinalRowCnt], [TableMaxSurrogateKey], [SuccessfulProcessingInd], [DataStartDT], [DataEndDT], [HashValue]) 
VALUES (1, -1, N'None', N'None', N'd07c408c-ea39-4e41-a5d1-a03cdca3d449', N'7156c686-435c-4914-b626-728e7bac8aa9', 0, 0, CAST(N'2000-01-01T00:00:00.000' AS DateTime), CAST(N'2000-01-01T00:00:00.000' AS DateTime), N'4e15d987-47b9-4764-86bf-20a157044e03', 0, 0, 0, 0, 0, 0, 0, N'Y', CAST(N'2000-01-01T00:00:00.000' AS DateTime), CAST(N'2000-01-01T00:00:00.000' AS DateTime), N'')
GO
SET IDENTITY_INSERT [dbo].[DimAudit] OFF
GO


INSERT [dbo].[ProcessEmail] ([ProcessName], [ProcessState], [EmailRecipients], [EmailCCRecipients], [EmailBCCRecipients], [EmailSubject], [EmailMessage], [HighPriority], [LastSentDate]) 
VALUES 
(N'ALL', N'GENERALERROR', N'jbennett@blue-granite.com', NULL, NULL, N'<<PROCESSNAME>> generated an error', N'<<CUSTOM1>>', 0, CAST(N'2015-06-12 13:37:51.713' AS DateTime)),
(N'ETL', N'Errors Exist', N'jbennett@blue-granite.com', NULL, NULL, N'ETL Package [<<CUSTOM1>>] has generated error records', N'<B>Table:</B> <<CUSTOM2>> <BR> <B>Error Record Count:</B> <<CUSTOM3>>', 0, NULL),
(N'ImportFolder', N'FilesExist', N'jbennett@blue-granite.com', NULL, NULL, N'Files are waiting for import', N'<B>Files to Import:</B> <<CUSTOM1>><BR><B>Import Folder:</B> <<CUSTOM2>>', 0, NULL)
GO
