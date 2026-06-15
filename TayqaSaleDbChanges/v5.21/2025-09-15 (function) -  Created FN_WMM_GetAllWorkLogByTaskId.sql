CREATE FUNCTION [dbo].[FN_WMM_GetAllWorkLogByTaskId](@taskId INT)
RETURNS TABLE 
AS
RETURN 
(
SELECT workLog.TimeSpentMinutes, workLog.ReferenceType, workLog.ReferenceId FROM WMM_WorkLog workLog
JOIN WMM_TaskActivity taskActivity ON workLog.ReferenceType = 1 AND workLog.ReferenceId = taskActivity.Id
WHERE taskActivity.TaskId = @taskId

UNION

SELECT workLog.TimeSpentMinutes, workLog.ReferenceType, workLog.ReferenceId FROM WMM_WorkLog workLog
JOIN WMM_Task wmmTask ON workLog.ReferenceType = 2 AND workLog.ReferenceId = wmmTask.Id
WHERE wmmTask.Id = @taskId
) 
GO


