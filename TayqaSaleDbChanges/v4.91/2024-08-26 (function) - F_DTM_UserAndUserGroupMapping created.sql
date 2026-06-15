CREATE FUNCTION [dbo].[F_DTM_UserAndUserGroupMapping]()
    Returns Table
        AS
        RETURN
        
        SELECT GroupMapping.ReportId, UserMapping.UserId, GroupMapping.TenantId, GroupMapping.ToolType
        FROM DTM_MobileReportUserGroupMapping GroupMapping WITH (NOLOCK)
                 JOIN MD_UserGroupMapping UserMapping WITH (NOLOCK) ON GroupMapping.GroupId = UserMapping.GroupId and UserMapping.IsActive = 1

        UNION

        SELECT ReportId, UserId, TenantId, ToolType
        FROM DTM_MobileReportUserMapping WITH (NOLOCK)

go