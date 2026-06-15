create FUNCTION [dbo].[F_DTM_CustomAppDashboardUserAndUserGroupMapping]() Returns Table AS RETURN(
    with grp AS (
      SELECT 
        dmrugm.DashboardId, 
        mugm.UserId, 
        dmrugm.TenantId
      FROM 
        DTM_CustomAppDashboardUserGroupMapping dmrugm WITH(NOLOCK) 
        JOIN MD_UserGroupMapping mugm WITH(NOLOCK) ON dmrugm.GroupId = mugm.GroupId 
        and mugm.IsActive = 1 
      GROUP BY 
        dmrugm.DashboardId, 
        mugm.UserId, 
        dmrugm.TenantId 
      UNION 
      SELECT 
        DashboardId, 
        UserId, 
        TenantId
      FROM 
        DTM_CustomAppDashboardUserMapping WITH(NOLOCK)
    ) 
    SELECT 
      * 
    FROM 
      grp 
    GROUP BY 
      DashboardId, 
      UserId, 
      TenantId 
  )
