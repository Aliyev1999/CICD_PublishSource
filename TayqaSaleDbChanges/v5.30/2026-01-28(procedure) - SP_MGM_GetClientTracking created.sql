


CREATE OR ALTER  PROCEDURE [dbo].[SP_MGM_GetClientTracking] @userId bigint, @Date DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    with UserTracking as (select *
                          from F_MGM_GetUserGpsTracking(@userId, @Date)),

         ClientTracking as (select *
                            from F_MGM_GetClientGPSTracking(@userId, @Date)),


         Result as (select * from F_MGM_GetVisitCount(@userId, @Date)),
         Actions as (select coalesce(log.Id, taskaction.Id) as operationId,
                            actiontype.Id                   as OperationType,
                            CASE
                                WHEN
                                    log.Id IS NULL and actiontype.Id IN (15, 11, 7, 10, 13, 14, 12) THEN N'Sənəd gözləmədədir'
                                ELSE
                                    action.Message END      as OperationDescription,
                            taskaction.FinalizedDate        as Time,
                            CASE
                                WHEN actiontype.Id IN (15, 11, 7, 10, 13, 14, 12) AND JsonLine.ReferenceId IS NOT NULL THEN 1
                                WHEN actiontype.Id IN (1, 2, 5, 6, 48, 49) AND taskaction.FinalizedDate IS NOT NULL THEN 1
                                ELSE 0
                                END                         as HasDetail,
                            ticket.ClientId                 as ClientId,
                            ticket.UserId                   as UserId,
                            log.Id                          as LogId


                     FROM WPM_TaskTicketAction taskaction with (nolock)
                              join WPM_TaskTicket ticket with (nolock) on ticket.Id = taskaction.TaskTicketId
                              join WPM_Task task with (nolock) on task.Id = ticket.TaskId

                              join WPM_TaskAction action with (nolock) on taskaction.ActionId = action.Id
                              join WPM_TaskActionType actiontype with (nolock) on action.ActionType = actiontype.Id
                           
							  left join WPM_TaskTicketActionJsonLine as JsonLine with (nolock) on taskaction.Id=JsonLine.TaskTicketActionId
                              left join OP_IncomingLog log with (nolock)
                                       on cast(JsonLine.ReferenceId as nvarchar(50)) = log.DocId and task.Firm = log.Firm
                              left join OP_GeneralLog general with (nolock) on general.RequestId = log.Id

                     where cast(taskaction.CreatedDate as date) between @Date and DateAdd(day, 1, @Date)
                       and ticket.UserId = @userId
                       
                       and actiontype.Id not in (3, 4, 8, 9, 40)

                     union all
                     select distinct visit.Id            as OperationId,
                                     8                   as OperationType,
                                     ''                  as OperationDescription,
                                     visit.Date          as Time,
                                     1                   as HasDetail,
                                     visit.ClientId      as ClientId,
                                     visit.CreatedUserId as UserId,
                                     ''                  as LogId

                     from OP_ClientVisitLog visit with (nolock)

                     where cast(visit.Date as date) between @Date and dateadd(day, 1, @Date)
                       and visit.CreatedUserId = @userId

                     union all

                     SELECT coalesce(taskaction.Id, inventory.Id)                   AS operationId,
                            40                                                      AS OperationType,
                            isnull(action.Message, '')                              AS OperationDescription,
                            isnull(taskaction.FinalizedDate, inventory.CreatedDate) AS Time,
                            0                                                       AS HasDetail,
                            coalesce(ticket.ClientId, inventory.ClientTigerId)      AS ClientId,
                            coalesce(ticket.UserId, inventory.CreatorUserId)        AS UserId,
                            ''                                                      as LogId
                     FROM IM_InventoryStateHistory inventory WITH (NOLOCK)
                              LEFT JOIN (SELECT taction.*,
                                                JsonLine.ReferenceId AS RefUId
                                         FROM WPM_TaskTicketAction taction
												  left join WPM_TaskTicketActionJsonLine  as JsonLine WITH (NOLOCK) 
												          ON taction.Id = JsonLine.TaskTicketActionId) AS taskaction
                                        ON inventory.UId = TRY_CAST(taskaction.RefUId AS UNIQUEIDENTIFIER)
                              LEFT JOIN WPM_TaskTicket ticket WITH (NOLOCK)
                                        ON ticket.Id = taskaction.TaskTicketId
                              LEFT JOIN WPM_Task task WITH (NOLOCK)
                                        ON task.Id = ticket.TaskId
                              LEFT JOIN WPM_TaskAction action WITH (NOLOCK)
                                        ON taskaction.ActionId = action.Id
                              LEFT JOIN WPM_TaskActionType actiontype WITH (NOLOCK)
                                        ON action.ActionType = actiontype.Id
                     WHERE CAST(inventory.CreatedDate AS DATE) BETWEEN @date AND DATEADD(DAY, 1, @date)
                       AND CreatorUserId = @userId

                     union all

                     select distinct survey.Id                                            as operationId,
                                     cast(9 as int)                                       as OperationType,
                                     action.Message                                       as OperationDescription,
                                     coalesce(survey.SavedDate, taskaction.FinalizedDate) as Time,
                                     1                                                    as HasDetail,
                                     coalesce(survey.ClientId, ticket.ClientId)           as ClientId,
                                     coalesce(survey.UserId, ticket.UserId)               as UserId,
                                     ''                                                   as LogId

                     from CHL_UserSurveyResponse survey with (nolock)
                              left join CHL_UserSurveyResponseDetail detail with (nolock) on detail.UserSurveyResponseId = survey.Id
                           
                              left join WPM_TaskTicketActionJsonLine as JsonLine with (nolock) on JsonLine.ReferenceId=survey.UId
							  left join WPM_TaskTicketAction as taskaction  with (nolock) on taskaction.Id=JsonLine.TaskTicketActionId
                              left join WPM_TaskTicket ticket with (nolock) on ticket.Id = taskaction.TaskTicketId
                              left join WPM_Task task with (nolock) on task.Id = ticket.TaskId
                              left join WPM_TaskAction action with (nolock) on taskaction.ActionId = action.Id
                              left join WPM_TaskActionType actiontype with (nolock) on action.ActionType = actiontype.Id

                     where cast(survey.CreatedDate as date) between @Date and dateadd(day, 1, @Date)
                       and coalesce(ticket.UserId, survey.UserId) = @userId
                       and survey.Id is not null

                     union all

                     select RequestId as                              operationId,
                            case
                                when ActionTypeId = 1 then 7
                                when ActionTypeId = 2 then 13
                                when ActionTypeId = 3 then 14
                                when ActionTypeId = 4 then 10
                                when ActionTypeId = 5 then 11
                                when ActionTypeId = 6 then 12
                                when ActionTypeId = 7 then 15
                                end
                                      as                              OperationType,
                            Note COLLATE SQL_Latin1_General_CP1_CI_AS OperationDescription,
                            CreatedDate                               Time,
                            iif(LogId is null, 0, 1)                  HasDetail,
                            clientId  as                              ClientId,
                            UserId    as                              UserId,
                            LogId
                     from F_MGM_GetClientOperationInfo(@Date, @userId)
                     where ActionTypeId in (1, 2, 3, 4, 5, 6, 7)),
         FinalResult as (SELECT distinct users.Id                                                    as UserId,
                                         users.UserName                                              as UserName,
                                         concat(users.Name, ' ', users.Surname)                      as UserFullName,
                                         usertracking.TimeStamp                                      as UserLastSeen,
                                         usertracking.ProfilePhotoUrl                                as ProfilePhotoUrl,
                                         usertracking.Latitude                                       as Latitude,
                                         usertracking.Longitude                                      as Longitude,
                                         client.TigerId                                              as ClientId,
                                         client.Name                                                 as ClientName,
                                         client.Code                                                 as ClientCode,
                                         clienttracking.CreatedDate   as StartTime,
                                         clienttracking.FinalizedDate as EndTime,
                                         client.Latitude                                             as ClientLatitude,
                                         client.Longitude                                            as ClientLongitude,
                                         isnull(cast(RouteStatus as tinyint), 1)                     as RouteStatus,
                                         case
                                             when client.Latitude is null or client.Longitude is null or clienttracking.CreatedLatitude is null or
                                                  clienttracking.CreatedLongitude is null or client.Latitude = 0 or ClientTracking.CreatedLatitude = 0
                                                 then 0
                                             when dbo.FN_CalculateDistance(client.Latitude, client.Longitude,
                                                                           ClientTracking.CreatedLatitude, ClientTracking.CreatedLongitude) * 1000 < 300
                                                 then 1
                                             else 2
                                             end                                                     as LocationStatus,
                                         actions.operationId                                         as OperationId,
                                         actions.OperationType                                       as OperationType,
                                         actions.OperationDescription                                as OperationDescription,
                                         actions.Time                as Time,
                                         actions.HasDetail                                           as HasDetail,
                                         LogId,
										 usertracking.IsOnline as IsOnline


                         from ClientTracking clienttracking
                                  join AbpUsers users with (nolock) on users.Id = clienttracking.UserId
                                  join MD_Client client with (nolock) on clienttracking.ClientId = client.TigerId
                                  left join UserTracking usertracking on clienttracking.UserId = usertracking.UserId
                                  left join Result result on result.UserId = clienttracking.UserId and result.ClientId = clienttracking.ClientId
                                  left join Actions actions on actions.UserId = clienttracking.UserId and actions.ClientId = clienttracking.ClientId
								  )

    select *
    from FinalResult
    order by StartTime desc, Time asc

END
