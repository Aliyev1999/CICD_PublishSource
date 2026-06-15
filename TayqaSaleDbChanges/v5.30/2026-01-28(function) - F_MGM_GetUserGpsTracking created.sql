CREATE OR ALTER function [dbo].[F_MGM_GetUserGpsTracking](@userId int, @givenDate date)
    returns table as return
            (
                WITH UserGpsTracking AS (SELECT UserId,
                                                Timestamp,
                                                Latitude,
                                                Longitude,
                                                ROW_NUMBER() OVER (PARTITION BY UserId ORDER BY TimeStamp DESC) AS Position
                                         FROM (SELECT ugd.UserId, ugd.CreatedDate Timestamp, ugd.CreatedLatitude Latitude, ugd.CreatedLongitude Longitude
                                               FROM WPM_TaskTicket ugd WITH (NOLOCK)
                                               WHERE CreatedDate >= @givenDate
                                                 AND CreatedDate < DateAdd(DAY, 1, @givenDate)
                                                 AND UserId =@userId

                                               UNION ALL

                                               SELECT ugd.UserId, ugd.GpsDate Timestamp, ugd.Latitude, ugd.Longitude
                                               FROM OP_UserGpsData ugd WITH (NOLOCK)
                                               WHERE GpsDate >= @givenDate
                                                 AND GpsDate < DateAdd(DAY, 1, @givenDate)
                                                 AND UserId =@userId

                                               UNION ALL

                                               SELECT route.UserId, Cast(route.[Date] AS DATETIME2) Timestamp, null AS Latitude, null AS Longitude
                                               FROM MD_Route route WITH (NOLOCK)
                                               WHERE Date >= @givenDate
                                                 AND Date < DateAdd(DAY, 1, @givenDate)
                                                 AND UserId =@userId) t)
                SELECT top 100000 ugt.UserId, 
                                  TimeStamp, 
                                  Latitude, 
                                  Longitude, 
                                  profiePhoto.SecureUrl as ProfilePhotoUrl,
								  cast(iif(datediff(minute,TimeStamp , getdate()) <= 30, 1, 0) as bit) as IsOnline
                FROM UserGpsTracking ugt
                         left join AbpUserProfilePhoto profiePhoto on ugt.UserId = profiePhoto.UserId
                WHERE Position = 1
            )
