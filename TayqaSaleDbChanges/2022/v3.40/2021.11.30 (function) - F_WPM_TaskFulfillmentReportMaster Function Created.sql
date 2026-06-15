create FUNCTION [dbo].[F_WPM_TaskFulfillmentReportMaster](@firm SMALLINT, @currentUserId BIGINT) 
Returns Table
AS
RETURN(
    select
        Firm.Name                                                                    as FirmName,
        Firm.Nr                                                                    as FirmNr,
       cast(Task.CreatedDate as date)                                               as TaskCreationDate,
       Task.Id                                                                      as TaskId,
       Task.Name                                                                    as TaskName,
       TaskSchedule.StartDate                                                       as TaskStartDate,
       TaskSchedule.EndDate                                                         as TaskEndDate,
       TaskSource.Name                                                              as TaskSourceName,
       TaskSource.Id                                                                as TaskSourceId,
       Users.UserName                                                               as UserName,
       Users.Id                                                                     as UserId,
       Client.Code                                                                  as ClientCode,
       Client.Name                                                                  as ClientName,
       Client.TigerId                                                               as ClientId,
       Client.Edino                                                                 as ClientEdino,
       TaskTicket.CreatedDate                                                       as StartDateOfTaskExecution,
       TaskTicket.FinalizedDate                                                     as FinalizedDateOfTaskExecution,
       
        TaskTicket.CreatedLatitude                                                   as TaskTicketCreatedLatitude,
        TaskTicket.CreatedLongitude                                                  as TaskTicketCreatedLongitude,
        TaskTicket.FinalizedLatitude                                                 as TaskTicketFinalizedLatitude,
        TaskTicket.FinalizedLongitude                                                as TaskTicketFinalizedLongitude,
        Client.Longitude                                                as ClientLongitude,
        Client.Latitude                                                as ClientLatitude,
       
       convert(NVARCHAR(8), dateadd(s, datediff(Second, TaskTicket.CreatedDate, TaskTicket.FinalizedDate), '1900-1-1'),
                        8)                                                          AS TimeConsuption,
       concat(count(distinct TicketActions.Id), '/', count(distinct TaskAction.Id)) as ActionsCount,

       case
           when TaskTicket.CreatedDate is null then 1 -- Baslamamis
           when TaskTicket.IsCompleted = 0 then 2 -- Icraatda
           else 3 end -- Tamamlanmis
                                                                                    as [Status]

from WPM_TaskClient TaskClient with (nolock)
         join WPM_Task Task with (nolock) on Task.Id = TaskClient.TaskId and Task.IsDeleted = 0 and Task.Type = 1 and Task.Firm = @firm
         join WPM_TaskAction TaskAction on TaskAction.TaskId = Task.Id and TaskAction.[Status]=0 --
         join WPM_TaskSchedule TaskSchedule on TaskSchedule.TaskId = Task.Id and TaskSchedule.PeriodType = 1
         join MD_Firm Firm on Firm.Nr = Task.Firm
         left join MD_StopReason TaskSource on TaskSource.Id = Task.TaskSource
         join WPM_UserTask UserTask on UserTask.TaskId = Task.Id -- AND TaskTicket.UserId = UserTask.UserId
         left join WPM_TaskTicket TaskTicket with (nolock)
                   on TaskTicket.TaskId = Task.Id and TaskClient.ClientId = TaskTicket.ClientId and
                      TaskTicket.Firm = Task.Firm AND TaskTicket.UserId = UserTask.UserId
         left join WPM_TaskTicketAction TicketActions with (nolock) on TicketActions.TaskTicketId = TaskTicket.Id
         
         join AbpUsers Users on Users.Id = UserTask.UserId and Users.IsDeleted = 0
         JOIN F_GetPermittedUsers(@currentUserId) PerUser ON Users.Id = PerUser.UserId
         left join MD_Client Client with (nolock)
                   on Client.TigerId = TaskClient.ClientId and Client.Firm = Task.Firm and Client.IsDeleted = 0

group by
    Firm.Name,
    Firm.Nr,
    cast(Task.CreatedDate as date),
    Task.Id,
    Task.Name,
    TaskSchedule.StartDate,
    TaskSchedule.EndDate,
    TaskSource.Name,
    TaskSource.Id,
    Users.UserName,
    Users.Id,
    Client.Code,
    Client.TigerId,
    Client.Edino,
    Client.Name,
    TaskTicket.CreatedDate,
    TaskTicket.FinalizedDate,

    TaskTicket.CreatedLatitude,
    TaskTicket.CreatedLongitude,
    TaskTicket.FinalizedLatitude,
    TaskTicket.FinalizedLongitude,

    Client.Longitude,
    Client.Latitude,
    
    convert(CHAR(8), dateadd(s, datediff(Second, TaskTicket.CreatedDate, TaskTicket.FinalizedDate), '1900-1-1'), 8),
         case
             when TaskTicket.CreatedDate is null then 1
             when TaskTicket.IsCompleted = 0 then 2
             else 3 end
)
GO