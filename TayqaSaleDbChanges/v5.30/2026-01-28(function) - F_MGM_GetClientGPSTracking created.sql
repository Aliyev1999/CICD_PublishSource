CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetClientGPSTracking](
    @userId INT,
    @givenDate DATE
)
    RETURNS @result TABLE
                    (
                        UserId             INT,
                        Firm               INT,
                        ClientId           INT,
                        CreatedDate        DATETIME,
                        CreatedLatitude    FLOAT,
                        CreatedLongitude   FLOAT,
                        FinalizedDate      DATETIME,
                        FinalizedLatitude  FLOAT,
                        FinalizedLongitude FLOAT,
                        InRoute            BIT
                    )
AS
BEGIN
    DECLARE @UserClientGpsTrackingIds TABLE
                                      (
                                          UserId INT PRIMARY KEY
                                      );

    INSERT INTO @UserClientGpsTrackingIds(UserId)
    SELECT UserId
    FROM F_Hybrid_GetPermittedUsers(@userId);

    WITH ClientGpsTracking AS (SELECT UserId,
                                      Firm,
                                      ClientId,
                                      CreatedDate,
                                      FinalizedDate,
                                      Latitude  AS CreatedLatitude,
                                      Longitude AS CreatedLongitude,
                                      Latitude  AS FinalizedLatitude,
                                      Longitude AS FinalizedLongitude,
                                      TimeStamp
                               FROM (SELECT UserId,
                                            Firm,
                                            ClientId,
                                            FIRST_VALUE(GpsDate)
                                                        OVER (PARTITION BY UserId, Firm, ClientId ORDER BY GpsDate)                                                                AS CreatedDate,
                                            LAST_VALUE(SendDate)
                                                       OVER (PARTITION BY UserId, Firm, ClientId ORDER BY RegisteredDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS FinalizedDate,
                                            FIRST_VALUE(Latitude)
                                                        OVER (PARTITION BY UserId, Firm, ClientId ORDER BY DocSavedTime)                                                           AS Latitude,
                                            FIRST_VALUE(Longitude)
                                                        OVER (PARTITION BY UserId, Firm, ClientId ORDER BY DocSavedTime)                                                           AS Longitude,
                                            LAST_VALUE(SendDate)
                                                       OVER (PARTITION BY UserId, Firm, ClientId ORDER BY DocSavedTime ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)   AS TimeStamp
                                     FROM OP_UserActionGpsData UserActionGpsData WITH (NOLOCK)
                                     WHERE SendDate >= @givenDate
                                       AND SendDate < DATEADD(DAY, 1, @givenDate)
                                       AND UserId = @userId

                                     UNION ALL

                                     SELECT CreatorUserId,
                                            Firm,
                                            ClientTigerId,
                                            CreatedDate,
                                            CreatedDate,
                                            NULL,
                                            NULL,
                                            CreatedDate
                                     FROM IM_InventoryStateHistory InventoryStateHistory WITH (NOLOCK)
                                     WHERE CreatedDate >= @givenDate
                                       AND CreatedDate < DATEADD(DAY, 1, @givenDate)
                                       AND CreatorUserId = @userId

                                     UNION ALL

                                     SELECT DISTINCT route.UserId,
                                                     route.Firm,
                                                     route.TigerClientId,
                                                     NULL,
                                                     NULL,
                                                     NULL,
                                                     NULL,
                                                     [Date]
                                     FROM MD_Route route WITH (NOLOCK)
                                              JOIN F_GetAllPermittedClient() pc
                                                   ON route.UserId = pc.UserId
                                                       AND route.Firm = pc.Firm
                                                       AND route.TigerClientId = pc.ClientId
                                     WHERE route.[Date] = @givenDate
                                       AND route.UserId = @userId
                                       AND route.Status = 0

                                     UNION ALL

                                     SELECT UserId,
                                            Firm,
                                            ClientId,
                                            CreatedDate,
                                            FinalizedDate,
                                            FIRST_VALUE(CreatedLatitude)
                                                        OVER (PARTITION BY UserId, Firm, ClientId ORDER BY CreatedDate),
                                            FIRST_VALUE(CreatedLongitude)
                                                        OVER (PARTITION BY UserId, Firm, ClientId ORDER BY CreatedDate),
                                            FinalizedDate
                                     FROM WPM_TaskTicket TaskTicket WITH (NOLOCK)
                                     WHERE CreatedDate >= @givenDate
                                       AND CreatedDate < DATEADD(DAY, 1, @givenDate)
                                       AND UserId = @userId

                                     UNION ALL

                                     SELECT UserId,
                                            Firm,
                                            ClientId,
                                            CreatedDate,
                                            SavedDate,
                                            SavedLatitude,
                                            SavedLongitude,
                                            SavedDate
                                     FROM CHL_UserSurveyResponse UserSurveyResponse WITH (NOLOCK)
                                     WHERE CreatedDate >= @givenDate
                                       AND CreatedDate < DATEADD(DAY, 1, @givenDate)
                                       AND UserId = @userId) t),
         Earliest AS (SELECT *,
                             ROW_NUMBER() OVER (PARTITION BY UserId, Firm, ClientId
                                 ORDER BY ISNULL(CreatedDate, DATEADD(dd, 1, getdate())) ASC) AS rn_earliest
                      FROM ClientGpsTracking),
         Latest AS (SELECT *,
                           ROW_NUMBER() OVER (PARTITION BY UserId, Firm, ClientId
                               ORDER BY FinalizedDate DESC) AS rn_latest
                    FROM ClientGpsTracking)


    INSERT
    INTO @result
    SELECT Earliest.UserId,
           Earliest.Firm,
           Earliest.ClientId,
           Earliest.CreatedDate,
           Earliest.CreatedLatitude,
           Earliest.CreatedLongitude,
           Latest.FinalizedDate,
           Latest.FinalizedLatitude,
           Latest.FinalizedLongitude,
           CAST(
                   IIF(EXISTS (SELECT 1
                               FROM MD_Route Route WITH (NOLOCK)
                               WHERE Route.Firm = Earliest.Firm
                                 AND Route.TigerClientId = Earliest.ClientId
                                 AND Route.UserId = Earliest.UserId
                                 AND Route.[Date] = @givenDate
                                 AND Route.Status = 0), 1, 0) AS BIT
           ) AS InRoute
    FROM Earliest
             JOIN Latest
                  ON Earliest.UserId = Latest.UserId
                      AND Earliest.Firm = Latest.Firm
                      AND Earliest.ClientId = Latest.ClientId
    WHERE Earliest.rn_earliest = 1
      AND Latest.rn_latest = 1
    RETURN;
END
