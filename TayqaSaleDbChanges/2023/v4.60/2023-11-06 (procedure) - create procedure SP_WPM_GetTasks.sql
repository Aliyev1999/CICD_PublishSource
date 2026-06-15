
CREATE  proc [dbo].[SP_WPM_GetTasks] @firm smallint, @userId bigint, @notConsiderDeletedTasksDate datetime, @taskId int null
AS
BEGIN

    select task.Id,
           task.Name,
           task.Message,
           task.AssignmentType,
           task.Type,
           task.FormType,
           task.PreExecution,
           task.PostExecution,
           task.Firm,
           task.ClientListType,
           task.Note,
           task.IsStartGpsRestricted,
           task.IsStopGpsRestricted,
           task.IsClientOrderRequired,
           task.OnStartSelectVisitType,
           task.OnStopSelectReason,
           task.ModifiedDate       TaskModifiedDate,
           task.CreatedDate        TaskCreatedDate,
           task.MinimumTicketLiveDurationWithMinutes,
           task.MaximumTicketLiveDurationWithMinutes,
           task.ForceTicketLiveDuration,
           task.AllowOfflineActions,
           task.OnlySaleRouteClients,
           userTask.OrderNo,
           userTask.IsOptional,
           userTask.Priority,
           userTask.Status,
           attachment.SecureUrl as Url,
           attachment.Id           AttachmentId,
           tag.Id                  TagId,
           tag.Name                TagName
    from WPM_UserTask userTask with (nolock)
             join WPM_Task task with (nolock) on userTask.TaskId = task.Id
             left join WPM_Attachment attachment with (nolock) on task.Id = attachment.ReferenceId and attachment.Type = 1
             left join WPM_TaskTag taskTag with (nolock) on task.Id = taskTag.TaskId
             left join WPM_Tag tag with (nolock) on taskTag.TagId = tag.Id
    where firm = @firm
      and userTask.UserId = @userId
      And (task.CreatedDate >= 0 or task.ModifiedDate >= 0)
      AND (@taskId IS NULL OR userTask.TaskId = @taskId)
      and NOT (task.IsDeleted = 1 and ModifiedDate < @notConsiderDeletedTasksDate)
    order by task.Id, attachment.Id, tag.Id
END