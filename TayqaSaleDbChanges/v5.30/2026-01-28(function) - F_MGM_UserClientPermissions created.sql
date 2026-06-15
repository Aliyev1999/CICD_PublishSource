CREATE OR ALTER function [dbo].[F_MGM_UserClientPermissions](@User bigint)
    RETURNS TABLE AS RETURN
        select ClientId
        from F_GetAllPermittedUsersPermittedClients(@User)