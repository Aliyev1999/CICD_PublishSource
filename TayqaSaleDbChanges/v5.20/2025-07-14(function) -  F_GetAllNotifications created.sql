CREATE OR ALTER function [dbo].[F_GetAllNotifications](@firm smallint, @userId int,@startDate bigint, @endDate bigint, @lastLogoutTime DATETIME, @notificationIds nvarchar(max),
                                              @includedClients bit, @isActive bit, @readStatus int)
    RETURNS TABLE
        AS
        RETURN
        (


        WITH Notifications AS (SELECT DISTINCT Unmuted,
                                               DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, notification.StartDate)) AS StartDateTimestamp,
                                               DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, notification.EndDate))   AS EndDateTimestamp,
                                               notification.IsActive                                                                  AS IsActive,
                                               attachment.Id                                                                          AS NotificationAttachmentId,
                                               attachment.Url                                                                         AS Url,
                                               iif(clientlog.ClientId is null, 0, 1)                                                  AS NotificationIsReaded,

                                               ISNULL(client.Id, 0)                                                       AS NotificationClientId,
                                               ISNULL(client.IsActive, 0)                                                             AS NotificationIsActive,
                                               ISNULL(client.CanUseByOtherModules, 0)                                                 AS CanUseByOtherModules,
                                               client.ClientId                                                                        AS ClientId,
                                               notification.Content                                                                   AS Content,
                                               DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, notification.CreationTime))
                                                                                                                                      AS CreatedDateTimeStamp,
                                               notification.CreationType                                                              AS CreationType,
                                               notification.Id                                                                        AS Id,
                                               ISNULL(notification.IsDeletable, 1)                                                    AS IsDeletable,
                                               iif(userlog.userId is null,0,1)                                                        AS IsReaded,
                                               notification.TransitionLocation                                                        AS LinkKey,
                                               notification.TransitionType                                                             AS LinkType,
                                               notification.Name                                                                      AS Name,
                                               notifuser.IsActive                                                                     AS NotificationUserIsActive,
                                               notification.Priority                                                                  AS Priority,
                                               notification.Type                                                                      AS Type,
                                               case
                                                   when clientlog.ClientId IS NULL and userlog.UserId is null then 10
                                                   END
                                                   AS ReadStatus
                               FROM MSG_Notification notification
                                        JOIN MSG_NotificationUser notifuser ON notification.Id = notifuser.NotificationId
                                        LEFT JOIN MSG_NotificationClient client ON notification.Id = client.NotificationId
                                        LEFT JOIN MSG_NotificationUserReadLog userlog
                                                  ON notifuser.UserId = userlog.UserId AND notifuser.NotificationId = userlog.NotificationId
                                        LEFT JOIN MSG_NotificationClientReadLog clientlog
                                                  ON notifuser.UserId = clientlog.UserId AND client.ClientId = clientlog.ClientId AND
                                                     client.NotificationId = clientlog.NotificationId
                                        LEFT JOIN MSG_NotificationClientDeleteLog clientdlog
                                                  ON notifuser.UserId = clientdlog.UserId AND client.ClientId = clientdlog.ClientId AND
                                                     notification.Id = clientdlog.NotificationId
                                        LEFT JOIN MSG_NotificationAttachment attachment ON attachment.NotificationId = notification.Id
                               WHERE(@isActive is null
                                   or notification.IsActive = @isActive)
                                 AND (@notificationIds IS NULL OR notification.Id IN (SELECT value FROM F_SplitList(@notificationIds, ',')))
                                 AND notification.Firm = @firm
                                 AND notifuser.UserId = @userId
                                 AND (
									@startDate IS NULL 
									OR DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, notification.EndDate)) >= @startDate
								)
								AND (
									@endDate IS NULL 
									OR DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, notification.StartDate)) <= @endDate
								))
        SELECT Unmuted,
               StartDateTimestamp,
               EndDateTimestamp,
               IsActive,
               NotificationAttachmentId,
               Url,
               NotificationIsReaded,
               NotificationClientId,
               NotificationIsActive,
               CanUseByOtherModules,
               ClientId,
               Content,
               CreatedDateTimeStamp,
               CreationType,
               Id,
               IsDeletable,
               IsReaded,
               LinkKey,
               LinkType,
               Name,
               NotificationUserIsActive,
               Priority,
               Type
        FROM Notifications
        WHERE @readStatus = 0
           or NotificationIsReaded = @readStatus
        )