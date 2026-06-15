
alter FUNCTION [dbo].[F_DTM_GetPermittedUsers](@currentUserId bigint) 
Returns Table
AS
RETURN(
SELECT u.TenantId,u.ProfilePictureId, U.Id, U.[Name], U.[Surname], U.UserName, U.IsDeleted, U.IsActive, UT.[Type], U.EmailAddress FROM AbpUsers U
JOIN F_GetPermittedUsers(@currentUserId) PU ON PU.UserId = U.Id
JOIN F_GetRootTypeOfUsers() UT ON U.Id = UT.UserId
)
go