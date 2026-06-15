ALTER FUNCTION [dbo].[F_GetRootTypeOfUsers]() 
Returns Table
AS
RETURN(
select UserId, Type, TypeId, LicenseUserType from F_GetRootTypeOfAllUsersIncludingInActive() where IsActive = 1
)
