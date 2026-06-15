create or ALTER   function [dbo].[F_MGM_GetPushNotification]( @firm Smallint, @notificationId INT)
RETURNS TABLE
AS
RETURN
SELECT 
TransitionLocation as LinkKey,
Name as Subject,
	CASE 
        WHEN Unmuted = 1 THEN 0
        ELSE 1
    END AS IsMuted,
TransitionType as Type
from MSG_Notification where Id = @notificationId
and Firm=@firm