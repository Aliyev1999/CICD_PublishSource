
CREATE FUNCTION [dbo].[FN_WPM_GetNonActionReasonActionMappings](@UserId int, @firm smallint)
RETURNS @ResultTable TABLE
(
    ActionId int,
    NonActionReasonId int
)
AS
BEGIN
    DECLARE @UserTasks TABLE
    (
        TaskId int
    )

    INSERT INTO @UserTasks (TaskId)
    SELECT TaskId
    FROM WPM_UserTask Task WITH (NOLOCK)
    WHERE UserId = @UserId
      AND Status = 0
    UNION
    SELECT TaskId
    FROM WPM_TaskUserGroups Task WITH (NOLOCK)
    JOIN MD_UserGroupMapping Mapping WITH (NOLOCK) ON Mapping.GroupId = Task.UserGroupId
    WHERE Mapping.UserId = @UserId
      AND Mapping.IsActive = 1;

    INSERT INTO @ResultTable (ActionId, NonActionReasonId)
    SELECT
        TA.Id AS ActionId,
        NAR.Id AS NonActionReasonId
    FROM @UserTasks UT
    JOIN WPM_TaskAction TA WITH (NOLOCK) ON UT.TaskId = TA.TaskId AND TA.NonActionReasonsEnabled = 1
    JOIN WPM_Task T WITH (NOLOCK) ON UT.TaskId = T.Id AND T.IsDeleted = 0 AND T.Status = 0 AND T.Firm = @firm
    JOIN WPM_NonActionReasonActionMappings NARAM ON NARAM.ReferenceId = TA.Id AND NARAM.ReferenceType = 1
    JOIN WPM_NonActionReasons NAR ON NARAM.NonActionReasonId = NAR.Id
    WHERE NAR.IsDeleted = 0 AND NAR.IsActive = 1;

    RETURN;
END
go

