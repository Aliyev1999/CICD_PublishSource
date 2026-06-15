 ALTER FUNCTION [dbo].[F_GetPermittedUsers](@userId INT = NULL)
    RETURNS
        @T TABLE
           (
               UserId int
           )
AS
BEGIN

    DECLARE @count int;
    set @count = (SELECT COUNT(*)
                  FROM AbpUserRoles UR with (nolock )
                           JOIN AbpRoles R with (nolock) ON R.Id = UR.RoleId
                  WHERE R.Name = 'Admin'
                    AND R.IsDeleted = 0
                    AND UR.UserId = @userId);


    IF @count > 0
        BEGIN
            insert into @T (UserId)
            SELECT U.Id AS UserId
            FROM AbpUsers U with (nolock)
            WHERE U.IsDeleted = 0
              -- AND U.IsActive = 1
              AND Id > 1
              AND UserName <> 'service_user'
        END
    ELSE
        BEGIN
            insert into @T (UserId)
                select UserId from F_UIM_GetOrganizationTreeAllUsers(@userId) where ParentType in ('App', 'Hybrid')
        END
    RETURN
END
GO