CREATE OR ALTER FUNCTION [dbo].[F_GetAllNotifications](
    @firm smallint,
    @userId int,
    @startDate bigint,
    @endDate bigint,
    @lastLogoutTime DATETIME,
    @notificationIds nvarchar(max),
    @includedClients bit,
    @isActive bit,
    @readStatus int
)
    RETURNS TABLE
        AS
        RETURN(WITH Notifications AS (SELECT DISTINCT n.Unmuted,
                                                      DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, n.StartDate))    AS StartDateTimestamp,
                                                      DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, n.EndDate))      AS EndDateTimestamp,
                                                      n.IsActive                                                                     AS IsActive,
                                                      a.Id                                                                           AS NotificationAttachmentId,
                                                      a.Url                                                                          AS Url,
                                                      IIF(crl.ClientId IS NULL, 0, 1)                                                AS NotificationIsReaded,
                                                      ISNULL(c.Id, 0)                                                                AS NotificationClientId,
                                                      ISNULL(c.IsActive, 0)                                                          AS NotificationIsActive,
                                                      ISNULL(c.CanUseByOtherModules, 0)                                              AS CanUseByOtherModules,
                                                      c.ClientId                                                                     AS ClientId,
                                                      n.Content                                                                      AS Content,
                                                      DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, n.CreationTime)) AS CreatedDateTimeStamp,
                                                      n.CreationType                                                                 AS CreationType,
                                                      n.Id                                                                           AS Id,
                                                      ISNULL(n.IsDeletable, 1)                                                       AS IsDeletable,
                                                      IIF(ul.UserId IS NULL, 0, 1)                                                   AS IsReaded,
                                                      n.TransitionLocation                                                           AS LinkKey,
                                                      n.TransitionType                                                               AS LinkType,
                                                      n.Name                                                                         AS Name,
                                                      userMap.IsActive                                                               AS NotificationUserIsActive,
                                                      n.Priority                                                                     AS Priority,
                                                      n.AnswerType,
                                                      n.IsAnswerable,
                                                      n.Type                                                                         AS Type,
                                                      CASE
                                                          WHEN crl.ClientId IS NULL AND ul.UserId IS NULL THEN 10
                                                          END                                                                        AS ReadStatus,
                                                      RTN.Reply                                                                      AS UserAnswer
													  --notification.IsAnswerable,
													  --notification.AnswerType
                                      FROM MSG_Notification n

                                               OUTER APPLY (
                                          --User target type = 1
                                          SELECT nu.UserId,
                                                 nu.IsActive
                                          FROM MSG_NotificationUser nu
                                          WHERE n.NotificationUserTargetType = 1
                                            AND nu.NotificationId = n.Id

                                          UNION ALL

                                          --UserGroup target type = 2
                                          SELECT ugm.UserId,
                                                 ug.IsActive
                                          FROM MSG_NotificationUserGroup ug
                                                   INNER JOIN MD_UserGroupMapping ugm
                                                              ON ug.UserGroupId = ugm.GroupId
                                          WHERE n.NotificationUserTargetType = 2
                                            AND ug.NotificationId = n.Id) AS userMap
                                               LEFT JOIN MSG_NotificationAttachment a ON a.NotificationId = n.Id
                                               LEFT JOIN MSG_NotificationClient c ON n.Id = c.NotificationId
                                               LEFT JOIN MSG_ReplyToNotification RTN on
                                                         --ON n.Id = RTN.NotificationId AND RTN.UserId = @userId AND N.IsAnswerable = 1
														 n.IsAnswerable = 1 and RTN.NotificationId = n.Id AND (n.Type = 1 OR RTN.ClientId = c.ClientId)
                                               LEFT JOIN MSG_NotificationClientReadLog crl
                                                         ON c.NotificationId = crl.NotificationId
                                                             AND c.ClientId = crl.ClientId
                                                             AND crl.UserId = @userId
                                               LEFT JOIN MSG_NotificationClientDeleteLog cdl
                                                         ON c.NotificationId = cdl.NotificationId
                                                             AND cdl.UserId = @userId
                                                             AND cdl.ClientId = c.ClientId

                                               LEFT JOIN MSG_NotificationUserReadLog ul
                                                         ON ul.NotificationId = n.Id
                                                             AND ul.UserId = userMap.UserId

                                      WHERE (@isActive IS NULL OR n.IsActive = @isActive)
                                        AND (@notificationIds IS NULL OR n.Id IN (SELECT value FROM F_SplitList(@notificationIds, ',')))
                                        AND (c.ClientId IS NULL OR
                                             EXISTS (SELECT 1 FROM F_GetPermittedClientForUser(@userId) t WHERE t.ClientId = c.ClientId))
                                        AND n.Firm = @firm
                                        AND userMap.UserId = @userId
                                        AND (
                                          @startDate IS NULL
                                              OR DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, n.EndDate)) >= @startDate
                                          )
                                        AND (
                                          @endDate IS NULL
                                              OR DATEDIFF_BIG(SECOND, '1970-01-01 00:00:00', DATEADD(HOUR, -4, n.StartDate)) <= @endDate
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
                      Type,
                      AnswerType,
                      IsAnswerable,
                      UserAnswer
               FROM Notifications
               WHERE @readStatus = 0
                  OR NotificationIsReaded = @readStatus)
go