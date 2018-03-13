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
VALUES (1, -1, N'None', N'None', N'd07c408c-ea39-4e41-a5d1-a03cdca3d449', N'7156c686-435c-4914-b626-728e7bac8aa9', 0, 0, CAST(N'2000-01-01 00:00:00.000' AS DateTime), CAST(N'2000-01-01 00:00:00.000' AS DateTime), N'4e15d987-47b9-4764-86bf-20a157044e03', 0, 0, 0, 0, 0, 0, 0, N'Y', CAST(N'2000-01-01 00:00:00.000' AS DateTime), CAST(N'2000-01-01 00:00:00.000' AS DateTime), N'')
GO