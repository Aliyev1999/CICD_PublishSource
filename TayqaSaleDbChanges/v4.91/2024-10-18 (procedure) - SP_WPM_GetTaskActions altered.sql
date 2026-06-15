alter proc [dbo].[SP_WPM_GetTaskActions] @firm smallint, @userId bigint, @notConsiderDeletedTasksDate datetime, @taskId int = null
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
      and Mapping.IsActive = 1;

    select Task.Id                    as TaskId,
           Task.ModifiedDate          as TaskModifiedDate,
           Task.CreatedDate           as TaskCreatedDate,
           TaskAction.Id              as ActionId,
           TaskAction.Message         as ActionMessage,
           TaskAction.ActionType      as ActionType,
           TaskAction.Status          as ActionStatus,
           TaskAction.Params          as Params,
           TaskAction.OrderNo         as TaskActionOrderNo,
           TaskAction.Priority        as TaskActionPriority,
           TaskAction.IsOptional      as TaskActionIsOptional,
           TaskAction.IsGpsRestricted as IsGpsRestricted,
           TaskAction.ClientId        as TaskActionClientId,
           TaskAction.StartActionGroupId TaskActionStartActionGroupId
    from @UserTasks UserTask
             join WPM_Task Task with (nolock) on userTask.TaskId = Task.Id
             left join WPM_TaskAction TaskAction with (nolock) on Task.Id = TaskAction.TaskId
    where Task.Firm = @firm
      and TaskAction.StartActionGroupId is null
      and (@taskId IS NULL OR Task.Id = @taskId)
      and NOT (Task.IsDeleted = 1 and Task.ModifiedDate < @notConsiderDeletedTasksDate)

END
go