CREATE FUNCTION [dbo].[F_WPM_TaskFulfillmentReportDetails]() 
Returns Table
AS
RETURN(
    SELECT
    TaskAction.Id,
    ActionType.Name AS ActionName,
    TaskAction.[Message] AS [Message],
    TicketAction.CreatedDate AS StartDate,
    TicketAction.FinalizedDate AS FinalizedDate,
    TicketAction.Id AS TicketActionId,
    convert(NVARCHAR(8), dateadd(s, datediff(Second, TicketAction.CreatedDate, TicketAction.FinalizedDate), '1900-1-1'),
                        8)                                                          AS TimeConsuption,
    TicketAction.ActionParams,
    TicketAction.CreatedLatitude,
    TicketAction.CreatedLongitude,
    TicketAction.FinalizedLatitude,
    TicketAction.FinalizedLongitude,
	TaskAction.TaskId,
    UserTask.UserId ,
    TaskClient.ClientId,
	Task.Firm,
	TaskAction.[Status] as IsPassive

FROM WPM_TaskAction TaskAction
JOIN WPM_Task Task ON TaskAction.TaskId=Task.Id
JOIN WPM_TaskClient TaskClient ON TaskAction.TaskId = TaskClient.TaskId
JOIN WPM_TaskActionType ActionType ON TaskAction.ActionType = ActionType.Id
JOIN WPM_UserTask UserTask ON UserTask.TaskId = TaskAction.TaskId
JOIN WPM_TaskSchedule TaskSchedule ON TaskSchedule.TaskId = TaskAction.TaskId AND TaskSchedule.PeriodType = 1
LEFT JOIN WPM_TaskTicket TaskTicket ON TaskTicket.ClientId = TaskClient.ClientId AND TaskTicket.TaskId = TaskClient.TaskId
LEFT JOIN WPM_TaskTicketAction TicketAction ON TaskTicket.Id = TicketAction.TaskTicketId AND TaskAction.Id = TicketAction.ActionId
)
GO


