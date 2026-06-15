CREATE proc [dbo].[SP_WPM_GetOnlineUserList] @firm smallint, @clientIds nvarchar(max), @imageUrls nvarchar(max)
AS
BEGIN
    SELECT u.Id                     AS UserId,
           u.UserName,
           u.Name + ' ' + u.Surname as UserFullName,
           ''                       as ProfileImage
    FROM AbpUsers u
    where u.IsActive = 1
END
go