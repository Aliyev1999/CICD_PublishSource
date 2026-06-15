create or ALTER function [dbo].[F_MGM_LikeInfo](@firm smallint, @photoId INT, @sourceType TINYINT)
RETURNS TABLE
AS
RETURN
SELECT CONCAT(au.Name, ' ', au.Surname) AS UserFullName, up.SecureUrl AS UserProfileImage, mpc.CreationTime 
AS Date, mpc.Status AS LikeStatus
FROM MD_PhotoLike mpc
JOIN AbpUsers au on au.Id = mpc.CreatorUserId
LEFT JOIN AbpUserProfilePhoto up ON au.Id = up.UserId
WHERE mpc.ReferenceId = @photoId AND mpc.SourceType = @sourceType