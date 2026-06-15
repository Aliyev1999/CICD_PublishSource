Create or ALTER FUNCTION [dbo].[FN_GetTaskTicketDetails]( @Firm Smallint,
    @TaskTicketId BIGINT
    )
    RETURNS TABLE
        AS
        RETURN(SELECT ISNULL(
                              CASE JsonLine.ActionType
                                  WHEN 40 THEN inventory.Id
                                  WHEN 9 THEN survey.Id
                                  WHEN 8 THEN visit.Id
                                  ELSE COALESCE(log.Id, TaskTicketAction.Id)
                                  END,
                              0)                                                                     as Id,
                      TaskActionType.Id                                                              as OperationType,
                      TaskTicketAction.Note                                                          as Note,
                      format(TaskTicketAction.CreatedDate, 'HH:mm') + ' - ' +
                      format(TaskTicketAction.FinalizedDate, 'HH:mm')                                as TimeRange,
                      datediff(minute, TaskTicketAction.CreatedDate, TaskTicketAction.FinalizedDate) as TimeMinute,
                      AttachmentCollection.Attachments                                               as Attachments
               from WPM_TaskTicket as TaskTicket with (nolock)
                        join WPM_TaskTicketAction as TaskTicketAction with (nolock)
                             on TaskTicketAction.TaskTicketId = TaskTicket.Id
                        join WPM_TaskAction as TaskAction with (nolock)
                             on TaskTicketAction.ActionId = TaskAction.Id
                        join WPM_TaskActionType as TaskActionType with (nolock)
                             on TaskAction.ActionType = TaskActionType.Id
                        left join
                    (select ReferenceId                as TaskActionId,
                            string_agg(SecureUrl, ',') as Attachments
                     from WPM_Attachment with (nolock)
                     where Type = 3
                     group by ReferenceId) as AttachmentCollection
                    on AttachmentCollection.TaskActionId = TaskTicketAction.Id
                        left join WPM_TaskTicketActionJsonLine as JsonLine WITH (NOLOCK)
                                  ON TaskTicketAction.Id = JsonLine.TaskTicketActionId
                        left join IM_InventoryStateHistory inventory
                                  ON inventory.UId = JsonLine.ReferenceId and JsonLine.ActionType = 40
                        Left join CHL_UserSurveyResponse survey
                                  on JsonLine.ReferenceId = survey.UId and JsonLine.ActionType = 9
                        Left join OP_ClientVisitLog visit
                                  on JsonLine.ReferenceId = TRY_CAST(visit.DocId AS UNIQUEIDENTIFIER) and
                                     JsonLine.ActionType = 8
                        left join OP_IncomingLog log with (nolock)
                                  on cast(JsonLine.ReferenceId as nvarchar(50)) = log.DocId
               where TaskTicket.Id = @TaskTicketId and TaskTicket.Firm=@firm)