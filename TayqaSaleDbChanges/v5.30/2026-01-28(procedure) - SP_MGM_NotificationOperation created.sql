CREATE OR ALTER  PROCEDURE [dbo].[SP_MGM_NotificationOperation] @userId BIGINT, @notificationId INT, @clientId INT, @operationType TINYINT
AS
BEGIN
  SET NOCOUNT ON;

  CREATE TABLE #TempTable (
    NotificationUserId INT
   ,NotificationClientId INT
  );

  INSERT INTO #TempTable (NotificationUserId, NotificationClientId)
    SELECT
      nu.Id
     ,mnc.Id
    FROM MSG_NotificationClient mnc WITH (NOLOCK)
    JOIN MSG_Notification N WITH (NOLOCK)
      ON N.Id = mnc.NotificationId
    JOIN MSG_NotificationUser nu WITH (NOLOCK)
      ON nu.NotificationId = N.Id
    WHERE N.Id = @notificationId
    AND nu.UserId = @userId
    AND mnc.ClientId = @clientId;

  INSERT INTO MSG_NotificationClientReadLog (NotificationUserId, NotificationClientId)
    SELECT
      tt.NotificationUserId
     ,tt.NotificationClientId
    FROM #TempTable tt
    LEFT JOIN MSG_NotificationClientReadLog t
      ON t.NotificationUserId = tt.NotificationUserId
        AND t.NotificationClientId = tt.NotificationClientId
    WHERE t.NotificationUserId IS NULL
    AND t.NotificationClientId IS NULL;

  DROP TABLE #TempTable;
END;