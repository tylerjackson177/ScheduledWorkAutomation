GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	Tyler Jackson
-- Description: Sends a prefilled Google Form link to the assigned service technician upon job assignment
-- =============================================
 PROCEDURE [dbo].[stproc_SendServiceSurvey]
    @ScheduledWorkID INT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE
    @LeadId         INT,
    @CustomerPID    INT,
    @SchedulerID    INT,
    @SchedulerEmail NVARCHAR(255),
    @FormBase       NVARCHAR(4000) = 
      'https://docs.google.com/forms/d/e/1FAIpQLScZ5xBk6-mgEROWHMVz4Cv3qaAtl7qdlOJ99haDyw/viewform',
    @PrefillLink    NVARCHAR(MAX),
    @BodyHTML       NVARCHAR(MAX),
    @Subject        NVARCHAR(200),
    @CustomerName   NVARCHAR(200);

  ----------------------------------------
  -- 1) Pull required info for email
  ----------------------------------------
  SELECT
    @LeadId         = SW.LeadId,
    @SchedulerID    = SW.EmpId,
    @CustomerPID    = C.PID,
    @SchedulerEmail = E.Email,
    @CustomerName   = C.LastName
  FROM dbo.ScheduledWork AS SW
  JOIN dbo.Customers      AS C ON SW.LeadId = C.ID
  JOIN dbo.Employees      AS E ON SW.EmpId = E.EmpId
  WHERE SW.ID = @ScheduledWorkID;

  IF @SchedulerEmail IS NULL OR @CustomerPID IS NULL OR @SchedulerID IS NULL
  BEGIN
    RAISERROR('Cannot send survey link: missing data for ScheduledWorkID=%d', 16, 1, @ScheduledWorkID);
    RETURN;
  END

  ----------------------------------------
  -- 2) Build prefilled Google Form link
  ----------------------------------------
  SET @PrefillLink = 
       @FormBase
    + '?entry.898882844='   + CONVERT(VARCHAR(20), @CustomerPID)      -- Customer ID
    + '&entry.1265898765='  + REPLACE(@CustomerName, ' ', '+')        -- Customer Name
    + '&entry.1832165195='  + CONVERT(VARCHAR(20), @SchedulerID)      -- Scheduler ID
    + '&entry.1638451600='  + CONVERT(VARCHAR(20), @ScheduledWorkID); -- ScheduledWorkID

  ----------------------------------------
  -- 3) Compose email body and subject
  ----------------------------------------
  SET @BodyHTML =
    '<p>Hello,</p>'
    + '<p>You have been assigned a new service job for Customer ID <b>'
    + CONVERT(VARCHAR(20), @CustomerPID) + '</b>.</p>'
    + '<p>Please <a href="' + @PrefillLink + '">click here</a> to complete the service visit survey.</p>'
    + '<p>Thank you,<br/>Service Team</p>';

  SET @Subject = 'Service Visit Survey – Job ID ' 
               + CONVERT(VARCHAR(20), @ScheduledWorkID)
               + ' (Customer ' + CONVERT(VARCHAR(20), @CustomerPID) + ')';

  ----------------------------------------
  -- 4) Send the email via Database Mail
  ----------------------------------------
  EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'DefaultMailProfile',  -- Replace with your configured mail profile
    @recipients   = @SchedulerEmail,
    @subject      = @Subject,
    @body         = @BodyHTML,
    @body_format  = 'HTML';
END
