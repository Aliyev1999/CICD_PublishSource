CREATE FUNCTION [dbo].[F_RM_GetBadgeCounts]
    (
        @userId INT,
        @firm SMALLINT null
        )
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT (SELECT COUNT(*)
                        FROM IM_RepairTask task with (nolock)
                                 join IM_RepairDemand Demand with (nolock) on task.DemandId = Demand.Id
                        where AssignedUserId = @userId
                          AND Firm = @firm
                          AND task.Status = 5)     AS NotStartedTaskCount,

                       (SELECT COUNT(*)
                        FROM IM_RepairTask task with (nolock)
                                 join IM_RepairDemand Demand with (nolock) on task.DemandId = Demand.Id
                        WHERE AssignedUserId = @userId
                          AND Demand.Firm = @Firm AND task.Status in (5,6,7,12)  AND task.CreationTime >= DATEADD(DAY, -30, GETDATE()) ) AS RepairTaskCount,


						(SELECT COUNT(*)
                        FROM IM_RepairTask task with (nolock)
                                 join IM_RepairDemand Demand with (nolock) on task.DemandId = Demand.Id
                        where Demand.CreatorUserId = @userId
                          AND Firm = @Firm
                          AND task.Status in ( 9,10 ) AND task.CreationTime >= DATEADD(DAY, -30, GETDATE())) AS RepairExecutionCount
            )




