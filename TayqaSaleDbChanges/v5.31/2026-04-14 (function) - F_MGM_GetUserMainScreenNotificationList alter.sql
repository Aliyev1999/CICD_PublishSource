CREATE or ALTER FUNCTION [dbo].[F_MGM_GetUserMainScreenNotificationList] (@firm smallint, @userId BIGINT)
RETURNS TABLE
AS
  RETURN (
  SELECT top 10000000000
    n.Id
   ,n.Name Header
   ,n.Content AS Description
   ,  n.CreationTime AS DateTime
   ,n.Type
   ,@userId AS RelatedUser
   ,ISNULL(mc.Name, '') AS RelatedClient
   ,mc.TigerId AS ClientId

   ,CASE
      WHEN nc.ClientId IS NULL THEN (CASE
          WHEN nrl.UserId IS NULL THEN 0
          ELSE 1
        END)
      WHEN ncl.ClientId IS NULL THEN 0
      ELSE 1
    END AS IsRead
  FROM MSG_Notification n
  JOIN MSG_NotificationUser nu
    ON n.Id = nu.NotificationId 
  LEFT JOIN MSG_NotificationClient nc
    ON n.Id = nc.NotificationId 
  LEFT JOIN MD_Client mc
    ON mc.TigerId = nc.ClientId and mc.Firm=n.Firm 
  LEFT JOIN MSG_NotificationUserReadLog nrl
    ON nu.UserId = nrl.UserId and nu.NotificationId = nrl.NotificationId
  LEFT JOIN MSG_NotificationClientReadLog ncl
    ON nu.UserId = ncl.UserId
    AND nc.ClientId = ncl.ClientId
	and nc.NotificationId = ncl.NotificationId
	LEFT JOIN MSG_NotificationClientDeleteLog ncdl
    ON nu.UserId = ncdl.UserId
    AND nc.ClientId = ncdl.ClientId
		and n.Id = ncdl.NotificationId
  WHERE nu.UserId = @userId and nu.IsActive = 1 and n.IsActive = 1 and n.StartDate <= GETDATE() and ncdl.Id is null and (nc.Id IS NULL OR nc.IsActive = 1)
        and mc.Firm=@firm

  order by CASE
      WHEN nc.ClientId IS NULL THEN (CASE
          WHEN nrl.UserId IS NULL THEN 0
          ELSE 1
        END)
      WHEN ncl.ClientId IS NULL THEN 0
      ELSE 1
    END asc,n.CreationTime desc
  )






