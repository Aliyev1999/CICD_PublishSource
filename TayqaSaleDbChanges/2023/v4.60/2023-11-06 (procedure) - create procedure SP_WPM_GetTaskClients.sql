CREATE proc [dbo].[SP_WPM_GetTaskClients] @firm smallint, @userId bigint, @notConsiderDeletedTasksDate datetime, @taskId int null
AS
BEGIN
select task.Id TaskId,
	   task.ModifiedDate       TaskModifiedDate,
       task.CreatedDate        TaskCreatedDate,
       taskClient.ClientId,
       taskClient.OrderNumber,
       taskClient.SpecialActionsType
from WPM_TaskClient taskClient with (nolock)
         join WPM_Task task with (nolock) on task.Id = taskClient.TaskId
         join WPM_UserTask userTask on userTask.TaskId = task.Id
         join MD_Client client with (nolock) on taskClient.ClientId = client.TigerId and client.Firm = task.Firm
         join F_GetPermittedClientForUser(@userId) pc
              on pc.Firm = client.Firm and pc.ClientId = client.TigerId
where task.firm = @firm
  and userTask.UserId = @userId
  and (@taskId IS NULL OR userTask.TaskId = @taskId)
  And (task.CreatedDate >= 0 or task.ModifiedDate >= 0)
  and NOT (task.IsDeleted = 1 and ModifiedDate < @notConsiderDeletedTasksDate)
order by task.Id
END