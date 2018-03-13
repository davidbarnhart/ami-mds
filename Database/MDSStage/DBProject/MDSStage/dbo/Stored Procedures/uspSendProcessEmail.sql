
/*
========================================================================
Copyright (c) 2011 BlueGranite
========================================================================
Name:        uspSendProcessEmail
Developer:   Jim Bennett
Create Date: 06/10/2011
Purpose:     The uspSendProcessEmail SP sends an email based
             on information provided in the ProcessEmail table

------------------------------------------------------------------------
Revision History
Revision# Date       Who  Description
--------- ---------  ---  ----------------------------------------------
 

Example:
EXEC dbo.uspSendProcessEmail 'Test','GENERALERROR'
========================================================================
*/
CREATE PROCEDURE [dbo].[uspSendProcessEmail]
	(
	@ProcessName varchar(100),
	@ProcessState varchar(50),
	@Custom1 varchar(max) = NULL,
	@Custom2 varchar(max) = NULL,
	@Custom3 varchar(max) = NULL,
	@Custom4 varchar(max) = NULL,
	@Custom5 varchar(max) = NULL,
	@Custom6 varchar(max) = NULL,
	@Custom7 varchar(max) = NULL,
	@Custom8 varchar(max) = NULL,
	@Custom9 varchar(max) = NULL,
	@Custom10 varchar(max) = NULL
	)
AS
SET NOCOUNT ON
BEGIN TRY

DECLARE @emailbody varchar(max)
DECLARE @emailsubject varchar(max)
DECLARE @emailrecipients varchar(max)
DECLARE @emailCCrecipients varchar(max)
DECLARE @emailBCCrecipients varchar(max)
DECLARE @emailpriority varchar(6)

SELECT TOP 1
	@emailrecipients = pe.EmailRecipients,
	@emailCCrecipients = pe.EmailCCRecipients,
	@emailBCCrecipients = pe.EmailBCCRecipients,
	@emailsubject = pe.EmailSubject,
	@emailbody = pe.EmailMessage,
	@emailpriority = CASE ISNULL(pe.HighPriority,0)
							WHEN 1 THEN 'HIGH'
							ELSE 'NORMAL'
						END
FROM ProcessEmail AS pe
WHERE pe.ProcessName = CASE 
						WHEN @ProcessState = 'GENERALERROR' THEN pe.ProcessName
						ELSE @ProcessName
						END
AND pe.ProcessState = @ProcessState

--Override with custom values
SELECT	@emailsubject = REPLACE(@emailsubject,'<<PROCESSNAME>>',@ProcessName),
		@emailbody = REPLACE(@emailbody,'<<PROCESSNAME>>',@ProcessName)
IF @Custom1 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM1>>',@Custom1),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM1>>',@Custom1)
IF @Custom2 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM2>>',@Custom2),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM2>>',@Custom2)
IF @Custom3 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM3>>',@Custom3),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM3>>',@Custom3)
IF @Custom4 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM4>>',@Custom4),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM4>>',@Custom4)
IF @Custom5 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM5>>',@Custom5),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM5>>',@Custom5)
IF @Custom6 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM6>>',@Custom6),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM6>>',@Custom6)
IF @Custom7 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM7>>',@Custom7),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM7>>',@Custom7)
IF @Custom8 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM8>>',@Custom8),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM8>>',@Custom8)
IF @Custom9 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM9>>',@Custom9),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM9>>',@Custom9)
IF @Custom10 IS NOT NULL 
	SELECT	@emailsubject = REPLACE(@emailsubject,'<<CUSTOM10>>',@Custom10),
			@emailbody = REPLACE(@emailbody,'<<CUSTOM10>>',@Custom10)


--Send the email
EXEC msdb.dbo.sp_send_dbmail 
	@profile_name = 'DBMail',
	@recipients = @emailrecipients,
	@copy_recipients = @emailCCrecipients,
	@blind_copy_recipients = @emailBCCrecipients,
	@subject = @emailsubject,
	@body = @emailbody,
	@importance = @emailpriority,
	@body_format = 'HTML';

-- Update the email table
UPDATE pe
SET LastSentDate = getdate()
FROM ProcessEmail AS pe
WHERE pe.ProcessName = CASE 
						WHEN @ProcessState = 'GENERALERROR' THEN pe.ProcessName
						ELSE @ProcessName
						END
AND pe.ProcessState = @ProcessState

END TRY
BEGIN CATCH
	DECLARE @ErrorMessage varchar(max)
	DECLARE @ErrorSeverity int

	SELECT 
		@ErrorMessage = 'Proc: ' + OBJECT_NAME(@@PROCID) + ' - Line: '+ CONVERT(VARCHAR(255),ERROR_LINE()) + ' - ' + CONVERT(VARCHAR(255),ERROR_NUMBER()) + ' --- ' + CONVERT(varchar(4000), ERROR_MESSAGE()),
		@ErrorSeverity = ERROR_SEVERITY()
	RAISERROR (@ErrorMessage,@ErrorSeverity,1)
END CATCH
RETURN