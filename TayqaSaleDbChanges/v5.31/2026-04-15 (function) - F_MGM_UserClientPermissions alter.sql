Create or ALTER function [dbo].[F_MGM_UserClientPermissions](@firm smallint,@User bigint )
    RETURNS TABLE AS RETURN
        select ClientId from F_GetAllPermittedUsersPermittedClients(@User)
		where Firm=@firm 