
CREATE function [dbo].[F_RM_RISK_LIMIT_GET_NOTIFIED_USERS_LIST] (@Specode nvarchar(200),@UserId int=null)
    returns table
        As return
        select distinct ParentId as UserId
        from F_UIM_GetOrganizationUserParents(@UserId, 0) UserList
                 join UIM_UserPermission Permission
                      on Permission.UserId = UserList.ParentId
        where Permission.PermissionId in (575, 576, 577, 578)
          and PermissionValue = 1





