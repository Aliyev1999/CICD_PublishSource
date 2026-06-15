CREATE OR ALTER PROCEDURE [dbo].[SP_WPM_GetTaskManagementDetail] @userId INT, @startDate DATE, @endDate DATE
AS
BEGIN

    -- Author: TayqaTech for TayqaSale (Shahri Yahyayeva)
-- Date: 29.12.2022
-- Query: returns the result of tasks and statuses for Management module in TayqaSale


    with taskdata as (select ClientTask.TaskId as TaskId, UserTasks.UserId as UserId, ClientTask.ClientId as ClientId, ClientTask.Id as TaskCLientId
                      from WPM_UserTask UserTasks with (nolock)
                               join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                                    on TreeUsers.UserId = UserTasks.UserId
                               join WPM_TaskClient ClientTask with (nolock) on ClientTask.TaskId = UserTasks.TaskId
                      union
                      select ClientTask.TaskId as TaskId, UserTasks.UserId as UserId, permitted.ClientId as ClientId, ClientTask.Id as TaskClientId
                      from WPM_TaskClient ClientTask with (nolock)
                               join F_GetAllPermittedUsersPermittedClients(@UserId) permitted
                                    on permitted.ClientId = ClientTask.ClientId
                               left join WPM_UserTask UserTasks with (nolock) on UserTasks.TaskId = ClientTask.TaskId
                               left join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                                         on TreeUsers.UserId = UserTasks.UserId
                      where UserTasks.UserId is null)

    select Tasks.Id                                                                                    as TaskId,
           taskdata.ClientId                                                                           as TaskClientId,
           Tickets.Id                                                                                  as TaskTicketId,
           Tasks.CreatedDate                                                                           as CreationDate,
           Client.Code                                                                                 as ClientCode,
           Client.Name                                                                                 as ClientName,
           isnull(Tasks.Name, '')                                                                      as TaskName,
           isnull(Tasks.Message, '')                                                                   as TaskMessage,
           AssignedUsers.Id                                                                            as AssignedUserId,
           AssignedUsers.UserName                                                                      as AssignedUserName,
           IIF(AssignedUsers.Id IS NULL, NULL, CONCAT(AssignedUsers.Name, ' ', AssignedUsers.Surname)) as AssignedUserFullName,
           CreatedUser.Id                                                                              as CreatorUserId,
           CreatedUser.UserName                                                                        as CreatorUserName,
           concat(CreatedUser.Name, ' ', CreatedUser.Surname)                                          as CreatorUserFullName,
           case
               when Tasks.ConfirmationType = 1 or (ConfirmStatus.Status = 1 or ConfirmStatus.Status = 2) and Tickets.Id is null
                   then cast(0 as bit)
               When Tasks.ConfirmationType = 0 /*and Followers.UserID = @userId*/ then cast(1 as bit)
               else cast(0 as bit)
               end
                                                                                                       as ConfirmRequired,
           case
               when ConfirmStatus.Status = 1 then cast(1 as bit)
               when ConfirmStatus.Status = 2 then cast(0 as bit)
               when ConfirmStatus.Status is null then null
               end                                                                                     as IsConfirmed,
           case
               when Tickets.Id is null then CAST(1 as tinyint)
               when Tickets.CreatedDate is not null and Tickets.FinalizedDate is null then CAST(2 as tinyint)
               when Tickets.FinalizedDate is not null and Tickets.StopReasonId is not null then CAST(4 as tinyint)
               when Tickets.FinalizedDate is not null then CAST(3 as tinyint)
               end                                                                                     as Status,
           cast(Tasks.Priority as tinyint)                                                             as Priority,
           Tickets.FinalizedDate                                                                       as FinalizedDate
    from taskdata
             left join WPM_TaskTicket Tickets with (nolock)
                       on Tickets.ClientId = taskdata.ClientId and Tickets.UserId = taskdata.UserId and
                          Tickets.TaskId = taskdata.TaskId
             join WPM_TaskSchedule Schedule with (nolock)
                  on Schedule.PeriodType = 1 and Schedule.TaskId = taskdata.TaskId
             join WPM_Task Tasks with (nolock) on tasks.Id = taskdata.TaskId and tasks.Type = 5
             join MD_Client client with (nolock) on client.TigerId = taskdata.ClientId and client.Firm = Tasks.Firm
             join AbpUsers CreatedUser with (nolock) on CreatedUser.Id = Tasks.CreatedUserId
             left join AbpUsers AssignedUsers with (nolock) on taskdata.UserId = AssignedUsers.Id
             left join WPM_WorkExecutionClientMappingStatus ConfirmStatus with (nolock)
                       on ConfirmStatus.TaskClientId = taskdata.TaskCLientId
             left join WPM_TaskFollowers Followers on Followers.TaskId = Tasks.Id and @UserId = Followers.UserId
    where Schedule.StartDate <= @endDate
      and @startDate <= Schedule.EndDate
      --and Tasks.Type in ( 1,5)
      and Tasks.IsDeleted = 0
      and Tasks.Status = 0
    --and Tasks.CreatedUserId = @userId
END
go
