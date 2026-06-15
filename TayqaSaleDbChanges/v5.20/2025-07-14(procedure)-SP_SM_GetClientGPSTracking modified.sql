CREATE OR ALTER PROCEDURE [dbo].[SP_SM_GetClientGPSTracking] @userId INT, @givenDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#UserClientGpsTrackingIds') IS NOT NULL
        DROP TABLE #UserClientGpsTrackingIds

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
               Latitude                                                                           CreatedLatitude,
               Longitude                                                                          CreatedLongitude,
               Latitude                                                                           FinalizedLatitude,
               Longitude                                                                          FinalizedLongitude,
               ROW_NUMBER() OVER (PARTITION BY UserId, Firm, CLientId ORDER BY TimeStamp DESC) AS Position
        FROM (
                 SELECT ugd.UserId,
                        Firm,
                        ClientId,
                        last_value(SendDate) over (partition by UserId, Firm, ClientId order by DocSavedTime rows between unbounded preceding and unbounded following) as TimeStamp,
                        first_value(GpsDate) over (partition by UserId, Firm, ClientId order by GpsDate rows between unbounded preceding and unbounded following)  CreatedDate,
                        last_value(RegisteredDate) over (partition by UserId, Firm, ClientId order by RegisteredDate rows between unbounded preceding and unbounded following) FinalizedDate,
                        last_value(Latitude) over (partition by UserId, Firm, ClientId order by DocSavedTime rows between unbounded preceding and unbounded following) Latitude,
                        last_value(Longitude) over (partition by UserId, Firm, ClientId order by DocSavedTime rows between unbounded preceding and unbounded following) Longitude
                 FROM OP_UserActionGpsData ugd WITH (NOLOCK)
                 WHERE SendDate >= @givenDate
                   AND SendDate < DateAdd(DAY, 1, @givenDate)
                   AND UserId IN (SELECT UserId FROM #UserClientGpsTrackingIds)

                 UNION ALL


                 SELECT DISTINCT route.UserId,
                                 route.Firm,
                                 route.TigerClientId ClientId,
                                 Date AS             TimeStamp,
                                 NULL AS             CreatedDate,
                                 NULL AS             FinalizedDate,
                                 NULL AS             Latitude,
                                 NULL AS             Longitude
                 FROM MD_Route route WITH (NOLOCK)
                          JOIN F_GetAllPermittedClient() pc ON route.UserId = pc.UserId AND route.Firm = pc.Firm AND route.TigerClientId = pc.ClientId
                 WHERE route.[Date] = @givenDate
                   AND route.UserId IN (SELECT UserId FROM #UserClientGpsTrackingIds)
                   AND route.Status = 0


				      UNION ALL 
                 SELECT ugd.UserId,
                        Firm,
                        ClientId,
                        ugd.CreatedDate TimeStamp,
                        ugd.CreatedDate,
						ugd.FinalizedDate,
                        last_value(CreatedLatitude) over (partition by UserId, Firm, ClientId order by ugd.CreatedDate rows between unbounded preceding and unbounded following) Latitude,
                        last_value(CreatedLongitude) over (partition by UserId, Firm, ClientId order by ugd.CreatedDate rows between unbounded preceding and unbounded following) Longitude
                 FROM WPM_TaskTicket ugd WITH (NOLOCK)
                 WHERE CreatedDate >= @givenDate
                   AND CreatedDate < DateAdd(DAY, 1, @givenDate)
                   AND UserId IN (SELECT UserId FROM #UserClientGpsTrackingIds)
				
             ) t
    )

    SELECT UserId,
           Firm,
           ClientId,
           CreatedDate,
           CreatedLatitude,
           CreatedLongitude,
           FinalizedDate,
           FinalizedLatitude,
           FinalizedLongitude,
           Cast(IIF((SELECT count(*)
                     FROM MD_Route WITH (NOLOCK)
                     WHERE Firm = t.Firm
                       AND TigerClientId = t.ClientId
                       AND UserId =t.UserId
                       AND Date = @givenDate
                       AND Status = 0) = 0, 0, 1) AS BIT) AS InRoute
    FROM ClientGpsTracking t
    WHERE Position = 1
    ORDER BY CreatedDate DESC
END

