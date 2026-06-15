CREATE OR ALTER PROCEDURE [dbo].[SP_MGM_GetClientGPSTracking] @userId INT, @givenDate DATE
AS
BEGIN

    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#UserClientGpsTrackingIds') IS NOT NULL
        DROP TABLE #UserClientGpsTrackingIds;

    CREATE TABLE #UserClientGpsTrackingIds
    (
        UserId INT NOT NULL PRIMARY KEY
    );

    INSERT INTO #UserClientGpsTrackingIds
    SELECT UserId
    FROM F_Hybrid_GetPermittedUsers(@userId);

    WITH ClientGpsTracking AS (
        SELECT UserId,
               Firm,
               ClientId,
               CreatedDate,
               FinalizedDate,
               CreatedLatitude,
               CreatedLongitude,
               FinalizedLatitude,
               FinalizedLongitude,
               ROW_NUMBER() OVER (PARTITION BY UserId, Firm, CLientId ORDER BY TimeStamp DESC) AS Position
        FROM (
                 SELECT ugd.UserId,
                        Firm,
                        ClientId,
                        ugd.CreatedDate TimeStamp,
                        ugd.CreatedDate,
                        ugd.FinalizedDate,
                        ugd.CreatedLatitude,
                        ugd.CreatedLongitude,
                        ugd.FinalizedLatitude,
                        ugd.FinalizedLongitude
                 FROM WPM_TaskTicket ugd WITH (NOLOCK)
                 WHERE CreatedDate >= @givenDate
                   AND CreatedDate < DateAdd(DAY, 1, @givenDate)
                   AND UserId IN (SELECT UserId FROM #UserClientGpsTrackingIds)

                 UNION ALL

                 SELECT DISTINCT route.UserId,
                                 route.Firm,
                                 route.TigerClientId ClientId,
                                 Date AS             TimeStamp,
                                 NULL AS             CreatedDate,
                                 NULL AS             FinalizedDate,
                                 NULL AS             CreatedLatitude,
                                 NULL AS             CreatedLongitude,
                                 NULL AS             FinalizedLatitude,
                                 NULL AS             FinalizedLongitude
                 FROM MD_Route route WITH (NOLOCK)
                          JOIN F_GetAllPermittedClient() pc ON route.UserId = pc.UserId AND route.Firm = pc.Firm AND route.TigerClientId = pc.ClientId
                 WHERE route.[Date] = @givenDate
                   AND route.UserId IN (SELECT UserId FROM #UserClientGpsTrackingIds)
                   AND route.Status = 0
             ) t
    )

    SELECT UserId,
           ClientId AS ClientId,
           CreatedDate AS StartTime,
           FinalizedDate AS EndTime,
           FinalizedLatitude AS Latitude,
           FinalizedLongitude AS Longitude,
           Cast(IIF((SELECT count(*)
                     FROM MD_Route WITH (NOLOCK)
                     WHERE Firm = t.Firm
                       AND TigerClientId = t.ClientId
                       AND UserId = t.UserId
                       AND Date = @givenDate
                       AND Status = 0) = 0, IIF(CreatedDate IS NULL, 1, 0), 1) AS BIT) AS InRoute
    FROM ClientGpsTracking t
    WHERE Position = 1
    ORDER BY CreatedDate DESC

END
