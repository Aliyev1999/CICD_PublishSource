CREATE  proc [dbo].[SP_WPM_GetTaskActions] @firm smallint, @userId bigint , @notConsiderDeletedTasksDate datetime , @taskId int null
AS
BEGIN
select Task.Id                       TaskId,
       task.ModifiedDate             TaskModifiedDate,
       task.CreatedDate              TaskCreatedDate,
       taskAction.Id                 ActionId,
       taskAction.Message            ActionMessage,
       taskAction.ActionType,
       taskAction.Status             ActionStatus,
       taskAction.Params,
       taskAction.OrderNo            TaskActionOrderNo,
       taskAction.Priority           TaskActionPriority,
       taskAction.IsOptional         TaskActionIsOptional,
       taskAction.IsGpsRestricted,
       taskAction.ClientId           TaskActionClientId,
       taskAction.StartActionGroupId TaskActionStartActionGroupId
from WPM_UserTask userTask with (nolock)
         join WPM_Task task with (nolock) on userTask.TaskId = task.Id
         left join WPM_TaskAction taskAction with (nolock) on task.Id = taskAction.TaskId
where firm = @firm
  and userTask.UserId = @userId
  And (task.CreatedDate >= 0 or task.ModifiedDate >= 0)
  and taskAction.StartActionGroupId is null
  and (@taskId IS NULL OR userTask.TaskId = @taskId)
  and  NOT (task.IsDeleted = 1 and ModifiedDate < @notConsiderDeletedTasksDate)
order by task.Id
END