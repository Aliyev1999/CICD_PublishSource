alter proc [dbo].[SP_WPM_GetTaskSchedules] @firm smallint, @userId bigint, @notConsiderDeletedTasksDate datetime, @taskId int = null
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


    -----------------------------------------------------------------------------------------------------------------------
    select Task.Id              as TaskId,
           Task.ModifiedDate    as TaskModifiedDate,
           Task.CreatedDate     as TaskCreatedDate,
           Schedule.Id          as ScheduleId,
           Schedule.StartDate   as StartDate,
           Schedule.EndDate     as EndDate,
           Schedule.StartTime   as StartTime,
           Schedule.EndTime     as EndTime,
           Schedule.PeriodType  as PeriodType,
           Schedule.PeriodStep  as PeriodStep,
           Schedule.AlarmPeriod as AlarmPeriod,
           Schedule.Status      as ScheduleStatus
    from @UserTasks UserTask
             join WPM_Task Task with (nolock) on UserTask.TaskId = Task.Id
             join WPM_TaskSchedule Schedule with (nolock) on Task.Id = Schedule.TaskId
    where Task.Firm = @firm
      and (@taskId IS NULL OR Task.Id = @taskId)
      and NOT (Task.IsDeleted = 1 and ModifiedDate < @notConsiderDeletedTasksDate)

END
go