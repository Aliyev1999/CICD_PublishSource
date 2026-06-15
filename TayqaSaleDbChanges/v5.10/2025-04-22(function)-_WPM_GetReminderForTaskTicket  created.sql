CREATE OR ALTER FUNCTION [dbo].[F_WPM_GetReminderForTaskTicket] 
(
    @userId INT,
    @clientId INT,
    @taskId INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @result NVARCHAR(MAX);

SELECT @result = taskticket.Note

  FROM WPM_TaskTicket task WITH(NOLOCK)
       JOIN  WPM_TaskTicketAction taskticket WITH(NOLOCK) ON task.Id = taskticket.TaskTicketId
       JOIN  WPM_TaskAction action WITH(NOLOCK) ON action.Id = taskticket.ActionId

    WHERE task.ClientId = @clientId 
		  AND task.UserId=@userId
          AND task.TaskId = @taskId
          AND action.ActionType = 48;

    RETURN @result;
END;