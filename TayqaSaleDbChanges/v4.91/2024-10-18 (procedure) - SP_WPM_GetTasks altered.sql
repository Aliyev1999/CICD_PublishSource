alter proc [dbo].[SP_WPM_GetTasks] @firm smallint, @userId bigint, @notConsiderDeletedTasksDate datetime, @taskId int = null
AS
BEGIN

    declare @UserTasks table
                       (
                           TaskId int
                       )

    insert into @UserTasks (TaskId)
    select TaskId
    from WPM_UserTask Task with (nolock)
    where UserId = @UserId
      and Status = 0
    union
    select TaskId
    from WPM_TaskUserGroups Task with (nolock)
             join MD_UserGroupMapping Mapping with (nolock) on Mapping.GroupId = Task.UserGroupId
    where Mapping.UserId = @UserId
      and Mapping.IsActive = 1


    ------------------------------------------------------------------------------------------------------------

    select distinct Task.Id                                   as Id,
                    Task.Name                                 as Name,
                    Task.Message                              as Message,
                    Task.AssignmentType                       as AssignmentType,
                    Task.Type                                 as Type,
                    Task.FormType                             as FormType,
                    Task.PreExecution                         as PreExecution,
                    Task.PostExecution                        as PostExecution,
                    Task.Firm                                 as Firm,
                    Task.ClientListType                       as ClientListType,
                    Task.Note                                 as Note,
                    Task.IsStartGpsRestricted                 as IsStartGpsRestricted,
                    Task.IsStopGpsRestricted                  as IsStopGpsRestricted,
                    Task.IsClientOrderRequired                as IsClientOrderRequired,
                    Task.OnStartSelectVisitType               as OnStartSelectVisitType,
                    Task.OnStopSelectReason                   as OnStopSelectReason,
                    Task.ModifiedDate                         as TaskModifiedDate,
                    Task.CreatedDate                          as TaskCreatedDate,
                    Task.MinimumTicketLiveDurationWithMinutes as MinimumTicketLiveDurationWithMinutes,
                    Task.MaximumTicketLiveDurationWithMinutes as MaximumTicketLiveDurationWithMinutes,
                    Task.ForceTicketLiveDuration              as ForceTicketLiveDuration,
                    Task.AllowOfflineActions                  as AllowOfflineActions,
                    Task.OnlySaleRouteClients                 as OnlySaleRouteClients,
                    Task.ScanAtStart                          as ScanAtStart,
                    Task.ScanAtStop                           as ScanAtStop,
                    0                                         as OrderNo,
                    Task.IsOptional                           as IsOptional,
                    Task.Priority                             as Priority,
                    Task.Status                               as Status,
                    Attachment.SecureUrl                      as Url,
                    Attachment.Id                             as AttachmentId,
                    null                                      as TagId,
                    null                                      as TagName

    from WPM_Task Task with (nolock)
             join @UserTasks UserTask on UserTask.TaskId = Task.Id
             left join WPM_Attachment Attachment with (nolock) on task.Id = attachment.ReferenceId and attachment.Type = 1
    where (@taskId IS NULL OR Task.Id = @taskId)
      and NOT (task.IsDeleted = 1 and ModifiedDate < @notConsiderDeletedTasksDate)

END
go