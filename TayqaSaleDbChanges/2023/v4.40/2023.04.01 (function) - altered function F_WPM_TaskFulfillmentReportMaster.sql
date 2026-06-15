alter   FUNCTION [dbo].[F_WPM_TaskFulfillmentReportMaster](@firm SMALLINT, @currentUserId BIGINT)
    Returns Table
        AS
        RETURN
            (
                select Firm.Name                                                                as FirmName,
                       Firm.Nr                                                                  as FirmNr,
                       cast(Task.CreatedDate as date)                                           as TaskCreationDate,
                       Task.Id                                                                  as TaskId,
                       Task.Name                                                                as TaskName,
                       ISNULL(TaskCategory.Id, 0)                                               as CategoryId,
                       ISNULL(TaskSubCategory.Id, 0)                                            as SubcategoryId,
                       ISNULL(TaskGroup.Id, 0)                                                  as GroupId,
                       TaskCategory.Name                                                        as CategoryName,
                       TaskSubCategory.Name                                                     as SubcategoryName,
                       TaskGroup.Name                                                           as GroupName,
                       Schedule.StartDate                                                       as TaskStartDate,
                       Schedule.EndDate                                                         as TaskEndDate,
                       TaskSource.Name                                                          as TaskSourceName,
                       TaskSource.Id                                                            as TaskSourceId,
                       Users.UserName                                                           as UserName,
                       Users.Id                                                                 as UserId,
                       Client.Code                                                              as ClientCode,
                       Client.Name                                                              as ClientName,
                       Client.TigerId                                                           as ClientId,
                       Client.Edino                                                             as ClientEdino,
                       TaskTicket.CreatedDate                                                   as StartDateOfTaskExecution,
                       TaskTicket.FinalizedDate                                                 as FinalizedDateOfTaskExecution,

                       TaskTicket.CreatedLatitude                                               as TaskTicketCreatedLatitude,
                       TaskTicket.CreatedLongitude                                              as TaskTicketCreatedLongitude,
                       TaskTicket.FinalizedLatitude                                             as TaskTicketFinalizedLatitude,
                       TaskTicket.FinalizedLongitude                                            as TaskTicketFinalizedLongitude,
                       Client.Longitude                                                         as ClientLongitude,
                       Client.Latitude                                                          as ClientLatitude,
					   CONCAT(Users.Name,' ',Users.Surname)                                     as ExecutorName,
					   CONCAT(CreatedUsers.Name,' ',CreatedUsers.Surname)						as CreatorName,
					   CreatedUsers.UserName													as CreatorUserName,

                       convert(NVARCHAR(8), dateadd(s, datediff(Second, TaskTicket.CreatedDate, TaskTicket.FinalizedDate), '1900-1-1'),
                                            8)                                                  AS TimeConsuption,
                       concat(isnull(FulfilledActionsCount, 0), '/', ToBeFulfilledActionsCount) as ActionsCount,

                       case
                           when TaskTicket.CreatedDate is null then 1 -- Baslamamis
                           when TaskTicket.IsCompleted = 0 then 2     -- Icraatda
                           else 3 end                                 -- Tamamlanmis
                                                                                                as [Status]


                from WPM_TaskSchedule Schedule with (nolock)
                         join WPM_Task Task with (nolock)
                              on Task.Id = Schedule.TaskId and Schedule.PeriodType = 1 and Task.Firm = @firm and Task.IsDeleted = 0 and Task.Type = 1
                         join WPM_TaskClient TaskClient with (nolock) on TaskClient.TaskId = Task.Id
                         join MD_Client Client with (nolock) on Client.TigerId = TaskClient.ClientId and Client.Firm = Task.Firm and Client.IsDeleted = 0
                         join WPM_UserTask UserTask with (nolock) on UserTask.TaskId = Task.Id
                         join AbpUsers Users with (nolock) on Users.Id = UserTask.UserId and Users.IsDeleted = 0
						 join AbpUsers CreatedUsers with(nolock)on CreatedUsers.Id=Task.CreatedUserId
                         join F_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.UserId = Users.Id
                         join MD_Firm Firm with (nolock) on Firm.Nr = Task.Firm
                         left join MD_StopReason TaskCategory with (nolock)
                                   on TaskCategory.Id = Task.CategoryReason and TaskCategory.IsDeleted = 0 and TaskCategory.Type = 13 and
                                      TaskCategory.IsActive = 1
                         left join MD_StopReason TaskSubCategory with (nolock)
                                   on TaskSubCategory.Id = Task.SubcategoryReason and TaskSubCategory.IsDeleted = 0 and TaskSubCategory.Type = 14 and
                                      TaskSubCategory.IsActive = 1
                         left join MD_StopReason TaskGroup with (nolock) on TaskGroup.Id = Task.GroupReason and TaskGroup.IsDeleted = 0 and TaskGroup.Type = 15
                         left join MD_StopReason TaskSource with (nolock)
                                   on TaskSource.Id = Task.TaskSource and TaskSource.IsDeleted = 0 and TaskSource.Type = 8
                         left join WPM_TaskTicket TaskTicket with (nolock)
                                   on TaskTicket.ClientId = TaskClient.ClientId and TaskTicket.TaskId = Task.Id and TaskTicket.UserId = Users.Id and
                                      TaskTicket.Firm = Task.Firm

                    -- Fulfilled actions means the number of actions started on a task ticket
                         left join (select UserId, TaskId, TaskTickets.Id, count(TicketActions.Id) as FulfilledActionsCount
                                    from WPM_TaskTicketAction TicketActions with (nolock)
                                             join WPM_TaskTicket TaskTickets with (nolock) on TicketActions.TaskTicketId = TaskTickets.Id
                                    group by UserId, TaskId, ClientId, TaskTickets.Id) TicketActions
                                   on TicketActions.UserId = Users.Id and TicketActions.TaskId = Task.Id and TicketActions.Id = TaskTicket.Id

                    -- To be fulfilled actions means the number of actions possible to start on a task
                         left join (select UserId, UserTask.TaskId, count(TaskActions.Id) as ToBeFulfilledActionsCount
                                    from WPM_TaskAction TaskActions with (nolock)
                                             join WPM_UserTask UserTask with (nolock) on TaskActions.TaskId = UserTask.TaskId and TaskActions.Status = 0
                                    group by UserId, UserTask.TaskId, ClientId) ToBeFulfilledActions
                                   on ToBeFulfilledActions.UserId = Users.Id and ToBeFulfilledActions.TaskId = Task.Id
            )

