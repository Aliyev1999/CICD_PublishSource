alter proc [dbo].[SP_WPM_GetTaskClients] @firm smallint, @userId bigint, @notConsiderDeletedTasksDate datetime, @taskId int null
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

    ----------------------------------------------------------------------------------------------------------------

    select Task.Id                      TaskId,
           Task.ModifiedDate            TaskModifiedDate,
           Task.CreatedDate             TaskCreatedDate,
           Client.ClientId           as ClientId,
           Client.OrderNumber        as OrderNumber,
           Client.SpecialActionsType as SpecialActionsType
    from WPM_TaskClient Client with (nolock)
             join WPM_Task Task with (nolock) on task.Id = Client.TaskId
             join @UserTasks UserTask on UserTask.TaskId = task.Id
             join F_GetPermittedClientForUser(@userId) Permitted on Permitted.Firm = Task.Firm and Permitted.ClientId = Client.ClientId
    where Task.firm = @firm
      and (@taskId IS NULL OR Task.Id = @taskId)
      and NOT (Task.IsDeleted = 1 and ModifiedDate < @notConsiderDeletedTasksDate)

END
go