CREATE proc [dbo].[SP_WPM_GetTaskSchedules] @firm smallint, @userId bigint, @notConsiderDeletedTasksDate datetime, @taskId int null
AS
BEGIN
    select task.Id                 TaskId,
		   task.ModifiedDate       TaskModifiedDate,
           task.CreatedDate        TaskCreatedDate,
           taskSchedule.Id         ScheduleId,
           taskSchedule.StartDate,
           taskSchedule.EndDate,
           taskSchedule.StartTime,
           taskSchedule.EndTime,
           taskSchedule.PeriodType,
           taskSchedule.PeriodStep,
           taskSchedule.AlarmPeriod,
           taskSchedule.Status as ScheduleStatus
    from WPM_UserTask userTask with (nolock)
             join WPM_Task task with (nolock) on userTask.TaskId = task.Id
             join WPM_TaskSchedule taskSchedule with (nolock) on task.Id = taskSchedule.TaskId
    where firm = @firm
      and userTask.UserId = @userId
      And (task.CreatedDate >= 0 or task.ModifiedDate >= 0)
      and (@taskId IS NULL OR userTask.TaskId = @taskId)
      and NOT (task.IsDeleted = 1 and ModifiedDate < @notConsiderDeletedTasksDate)
    order by task.Id

END