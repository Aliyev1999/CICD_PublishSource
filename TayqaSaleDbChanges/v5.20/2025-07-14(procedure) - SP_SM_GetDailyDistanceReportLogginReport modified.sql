CREATE OR ALTER procedure [dbo].[SP_SM_GetDailyDistanceReportLogginReport](
    @userId int,
    @startDate datetime,
    @endDate datetime)
as
with RouteTime as (select RouteTime.UserId                                                  as UserId,
                          RouteTime.Date                                                    as Date,
                          iif(ObjectId = 12 and Objectvalue = 1, RouteTime.StartTime, null) as StartTime,
                          iif(ObjectId = 13 and Objectvalue = 1, RouteTime.EndTime, null)   as EndTime
                   from WPM_Route RouteTime with (nolock)
                            left join UIM_UserConfigParameter Configs with (nolock) on RouteTime.UserId = Configs.UserId
                   where ObjectId in (12, 13)
                     and RouteTime.UserId = @userId
                     and cast(Date as date) between cast(@startDate as date) and cast(@endDate as date)),

     SaleActions as (select UserId                   as UserId,
                            ProcessDate              as Date,
                            min(ILog.DocCreatedTime) as FirstAction,
                            max(ILog.DocCreatedTime) as LastAction
                     from OP_IncomingLog ILog with (nolock)
                              join OP_GeneralLog GLog with (nolock)
                                   on ILog.Id = GLog.RequestId and GLog.ImportResult = 0
                     where ILog.ProcessDate between cast(@startDate as date) and cast(@endDate as date)
                       and UserId = @userId
                     group by UserId, ProcessDate),

     Result as (select coalesce(RouteTime.UserId, SaleActions.UserId)                       as UserId,
                       cast(coalesce(RouteTime.Date, SaleActions.Date) as date)             as Date,
                       cast(coalesce(RouteTime.StartTime, SaleActions.FirstAction) as time) as MinTime,
                       cast(coalesce(RouteTime.EndTime, SaleActions.LastAction) as time)    as MaxTime
                from RouteTime
                         full outer join SaleActions on RouteTime.UserId = SaleActions.UserId and
                                                        RouteTime.Date = SaleActions.Date),

     Summary as (select UserId                                  as UserId,
                        Date                                    as Date,
                        min(MinTime)                            as MinTime,
                        max(MaxTime)                            as MaxTime,
                        sum(datediff(minute, MinTime, MaxTime)) as TotalWorkTime
                 from Result
                 group by UserId, Date),

     GeoData as (select UserId                                                                 as UserId,
                        TimeSpan                                                               as Time,
                        Latitude                                                               as SourceLatitude,
                        Longitude                                                              as SourceLongitude,
                        isnull(lag(Latitude) over (partition by UserId order by TimeSpan), 0)  as DestinationLatitude,
                        isnull(lag(Longitude) over (partition by UserId order by TimeSpan), 0) as DestinationLongitude
                 from OP_UserAllGpsData with (nolock)
                 where cast(TimeSpan as date) between cast(@startDate as date) and cast(@endDate as date)
                   and UserId = @userId),

     Distance as (select UserId,
                         Time,
                         IIF(DestinationLatitude = 0 OR SourceLatitude = 0,
                             -1,
                             geography::Point(GeoData.SourceLatitude, GeoData.SourceLongitude, 4326).STDistance(
                                     geography::Point(GeoData.DestinationLatitude, GeoData.DestinationLongitude,
                                                      4326))) as DistanceInKm
                  from GeoData),

     DistanceResult as (select UserId                             as UserId,
                               cast(Time as date)                 as Date,
                               cast(min(Time) as time)            as MinTime,
                               cast(max(Time) as time)            as MaxTime,
                               round(sum(DistanceInKm / 1000), 2) as TotalDistance
                        from Distance
                        where DistanceInKm > 0
                        group by UserId, cast(Time as date)),

     Final as (select coalesce(Summary.UserId, DistanceResult.UserId)   as UserId,
                      coalesce(Summary.Date, DistanceResult.Date)       as Date,
                      coalesce(Summary.MinTime, DistanceResult.MinTime) as MinTime,
                      coalesce(Summary.MaxTime, DistanceResult.MaxTime) as MaxTime,
                      isnull(TotalWorkTime, 0)                          as TotalWorkTime,
                      isnull(TotalDistance, 0)                          as TotalDistance
               from Summary
                        full outer join DistanceResult on Summary.Date = DistanceResult.Date)

select CAST(Date AS DATETIME)                                                    as Day,
       CAST(TotalDistance AS FLOAT)                                              as TotalDistance,
       isnull(CAST(Final.MaxTime AS TIME),'00:00')                                               as EndTime,
       isnull(CAST(Final.MinTime AS TIME),'00:00')                                               as StartTime,
       CAST(UserId AS BIGINT)                                                    as UserId,
	   isnull(DATEADD(MINUTE, DATEDIFF(MINUTE, Final.MinTime, Final.MaxTime), CAST('00:00:00' AS TIME)),'00:00') as TotalTime
from Final