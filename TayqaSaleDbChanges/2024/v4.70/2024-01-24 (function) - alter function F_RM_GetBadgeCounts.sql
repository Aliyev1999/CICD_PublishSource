
ALTER FUNCTION [dbo].[F_RM_GetBadgeCounts](
    @userId INT,
    @firm SMALLINT
    )
    RETURNS TABLE
        AS
        RETURN
            (
                WITH tasks AS (SELECT DISTINCT u.TaskId, UserId
                               FROM WPM_UserTask u WITH (NOLOCK)
                                        JOIN WPM_TaskSchedule s WITH (NOLOCK)
                                             ON s.TaskId = u.TaskId AND s.Status = 0 AND u.Status = 0
                                        JOIN WPM_Task t WITH (NOLOCK)
                                             ON t.Id = s.TaskId AND t.Status = 0 AND t.IsDeleted = 0
                               WHERE UserId = @userId
                                 AND CAST(s.StartDate as date) <= CAST(GETDATE() as DATE)
                                 AND CAST(s.EndDate as date) >= CAST(GETDATE() as date)
                                 AND t.Type = 1)

                SELECT (SELECT count(*)
                        FROM tasks
                                 LEFT JOIN WPM_TaskTicket t ON t.UserId = tasks.UserId AND t.TaskId = tasks.TaskId
                        WHERE t.Id IS NULL)                                      AS NotStartedTaskCount,

                       (SELECT COUNT(*)
                        FROM IM_RepairTask task WITH (NOLOCK)
                                 JOIN IM_RepairDemand Demand WITH (NOLOCK) ON task.DemandId = Demand.Id
                        WHERE AssignedUserId = @userId
                          AND Demand.Firm = @firm
                          AND task.Status IN (5, 6, 7, 12)
                          AND task.CreationTime >= DATEADD(DAY, -30, GETDATE())) AS RepairTaskCount,

                       (SELECT COUNT(*)
                        FROM IM_RepairTask task WITH (NOLOCK)
                                 JOIN IM_RepairDemand Demand WITH (NOLOCK) ON task.DemandId = Demand.Id
                        where Demand.CreatorUserId = @userId
                          AND Firm = @firm
                          AND task.Status IN (9, 10)
                          AND task.CreationTime >= DATEADD(DAY, -30, GETDATE())) AS RepairExecutionCount
            )