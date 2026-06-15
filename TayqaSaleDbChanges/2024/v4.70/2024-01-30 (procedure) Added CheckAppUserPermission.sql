
CREATE Procedure [dbo].[SP_CheckAppUserPermission] 
	@firm smallint,
	@permissionName nvarchar(500),
	@userId bigint
AS
BEGIN
	DECLARE @Result BIT;

	SELECT @Result = CASE 
					   WHEN COUNT(*) > 0 THEN 1 
					   ELSE 0 
					 END
	FROM UIM_Permission permission
	JOIN UIM_UserPermission userPermission ON permission.Id = userPermission.PermissionId
	WHERE permission.ObjectName = @permissionName 
	  AND userPermission.Firm = @firm
	  AND userPermission.UserId = @userId
	  And userPermission.PermissionValue = 1

	Select @Result as Result
END;
GO


