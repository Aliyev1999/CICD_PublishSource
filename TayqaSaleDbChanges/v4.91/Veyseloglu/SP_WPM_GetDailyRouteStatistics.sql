alter procedure [dbo].[SP_WPM_GetDailyRouteStatistics](
    @currentUserId int,
    @beginDate datetime,
    @endDate datetime,
    @users nvarchar(max),
    @userSpecodes nvarchar(1000),
    @visitStatus tinyint,
    @routeVisitPercentMin float,
    @routeVisitPercentMax float
)
As
Begin

    declare @Query nvarchar(max) = N'
declare @NonCompletedTasks table
                           (
                               UserId    int,
                               TaskCount int
                           )


declare @VisitStats table
                    (
                        UserId             int,
                        RouteCount         int,
                        RouteVisitCount    int,
                        NonRouteVisitCount int
                    )


declare @TimeStats table
                   (
                       UserId       int,
                       ClientTime   int,
                       RouteTime    int,
                       NonRouteTime int,
                       TotalTime    int,
                       PassiveTime  int,
                       FirstVisit   time,
                       LastVisit    time
                   )


-------------------------------------------------------------------------------------------------------------------------------------

-- Non completed tasks count for user
insert into @NonCompletedTasks (UserId, TaskCount)
select UserId, count(distinct Ticket. Id) as TaskCount
from WPM_TaskTicket Ticket with (nolock)
join WPM_Task Task with (nolock) on Task. Id = Ticket. TaskId
where Task. Type = 4
  and Ticket. FinalizedDate is null
  and Task. Id in (select TaskId
                  from WPM_TaskSchedule with (nolock)
                  where cast(StartDate as date) <= cast(@EndDate as date)
                    and cast(@BeginDate as date) <= cast(EndDate as date))
  and Ticket. CreatedDate between @BeginDate and @EndDate
group by UserId;

-------------------------------------------------------------------------------------------------------------------------------------
with Routes as (select distinct Routes. UserId, Routes. TigerClientId as ClientId, Routes. Date as Date, Routes. Firm as Firm
                from MD_Route Routes with (nolock)
                         join F_GetAllPermittedUsers(@CurrentUserId) Permitted on Permitted. UserId = Routes. UserId
                where Routes. Date between cast(@BeginDate as date) and  cast(@EndDate as date)),
     Actions as (select distinct Ticket. UserId             as UserId,
                                 Ticket. ClientId           as ClientId,
                                 cast(Ticket. CreatedDate as date) as Date,
                                 Ticket. Firm               as Firm
                 from WPM_TaskTicket Ticket with (nolock)
                          join WPM_Task Task with (nolock) on Task. Id = Ticket. TaskId
                          join F_GetAllPermittedUsers(@CurrentUserId) Permitted on Permitted. UserId = Ticket. UserId
                 where Task. Type = 4 
                   and Ticket. CreatedDate between @BeginDate and @EndDate
                   and Ticket. FinalizedDate is not null),

     Result as (select coalesce(Routes. UserId, Actions. UserId)                             as UserId,
                       iif(Routes. UserId is not null, 1, 0)                                as IsRoute,
                       iif(Routes. UserId is not null and Actions. UserId is not null, 1, 0) as IsRouteVisit,
                       iif(Routes. UserId is null and Actions. UserId is not null, 1, 0)     as IsNonRouteVisit

                from Routes
                         full outer join Actions on Actions. UserId = Routes. UserId and Actions. Date = Routes. Date and Routes. ClientId = Actions. ClientId and Actions. Firm=Routes. Firm)
insert
into @VisitStats (UserId, RouteCount, RouteVisitCount, NonRouteVisitCount)
select UserId, sum(IsRoute), sum(IsRouteVisit), sum(IsNonRouteVisit)
from Result
group by UserId;
---------------------------------------------------------------------------------------------------------------------------------------------------------

with Stats as (select Ticket. UserId                                                                                           as UserId,
                      cast(Ticket. CreatedDate as date)                                                                        as Date,
                      dbo. F_CheckIsRouteExists(Ticket. Firm, Ticket. UserId, Ticket. ClientId, cast(Ticket. CreatedDate as date)) as IsRouteVisit,
                      Ticket. CreatedDate                                                                                             as StartTime,
                      coalesce(Ticket. FinalizedDate,
                               lead(Ticket. CreatedDate) over (partition by Ticket. UserId, cast(Ticket. CreatedDate as date) order by Ticket. CreatedDate),
                               dateadd(hour, 20, cast(cast(Ticket. CreatedDate as date) as datetime)))                                as FinishTime
               from WPM_TaskTicket Ticket with (nolock)
                        join WPM_Task Task with (nolock) on Task. Id = Ticket. TaskId
                        join F_GetAllPermittedUsers(2) Permitted on Permitted. UserId = Ticket. UserId
               where Task. Type = 4 and Ticket. CreatedDate between @BeginDate and @EndDate),

     Result as (select UserId                                                                                                                        as UserId,
                       Date                                                                                                                          as Date,
                       sum(datediff(second, StartTime, iif(cast(FinishTime as time) = ''20:00:00'', StartTime, FinishTime)))                           as ClienTime,
                       sum(iif(IsRouteVisit = 1, datediff(second, StartTime, iif(cast(FinishTime as time) = ''20:00:00'', StartTime, FinishTime)), 0)) as RouteTime,
                       sum(iif(IsRouteVisit = 0, datediff(second, StartTime, iif(cast(FinishTime as time) = ''20:00:00'', StartTime, FinishTime)), 0)) as NonRouteTime,
                       min(StartTime)                                                                                                                as FirstVisitTime,
                       max(iif(cast(FinishTime as time) = ''20:00:00'', StartTime, FinishTime))                                                        as LastVisitTime,
                       datediff(second, min(StartTime), max(iif(cast(FinishTime as time) = ''20:00:00'', StartTime, FinishTime)))                      as TotalTime
                from Stats
                group by UserId, Date)
insert
into @TimeStats (UserId, ClientTime, RouteTime, NonRouteTime, TotalTime, PassiveTime, FirstVisit, LastVisit)
select UserId,
       sum(ClienTime)                    as ClienTime,
       sum(RouteTime)                    as RouteTime,
       sum(NonRouteTime)                 as NonRouteTime,
       sum(TotalTime)                    as TotalTime,
       sum(TotalTime) - sum(ClienTime)   as PassiveTime,
       cast(min(FirstVisitTime) as time) as FirstVisit,
       cast(max(LastVisitTime) as time)  as LastVisit
from Result
group by UserId


select cast(Users. Id as int)                                                                                                                    as UserId,
       Users. Name                                                                                                                               as UserFirstname,
       Users. Surname                                                                                                                            as UserLastName,

       -- visit stats
       RouteCount                                                                                                                               as RouteCount,
       RouteVisitCount                                                                                                                          as RouteClientVisitCount,
       NonRouteVisitCount                                                                                                                       as NonRouteClientVisitCount,
       isnull(NonCompletedTasks. TaskCount, 0)                                                                                                  as NonCompletedTicketCount,
       round(iif(isnull(RouteCount, 0) = 0, 0, cast(isnull(RouteVisitCount, 0) as float) / cast(RouteCount as float) * 100), 2)                 as RouteClientVisitPercent,
       round(iif(isnull(RouteCount, 0) = 0, 0,
                 cast(isnull(RouteVisitCount, 0) + isnull(NonRouteVisitCount, 0) as float) / cast(isnull(RouteCount, 0) + isnull(NonRouteVisitCount, 0) as float) * 100), 2)    as TotalClientVisitPercent,

       -- time stats
       nullif(convert(time, dateadd(second, RouteTime, ''00:00:00'')), ''00:00:00'')                                                                as TotalRouteClientVisitTime,
       nullif(convert(time, dateadd(second, iif(RouteVisitCount = 0, 0, RouteTime / RouteVisitCount), ''00:00:00'')), ''00:00:00'')                 as AverageRouteClientVisitTime,
       nullif(convert(time, dateadd(second, NonRouteTime, ''00:00:00'')), ''00:00:00'')                                                             as TotalNonRouteClientVisitTime,
       nullif(convert(time, dateadd(second, iif(NonRouteVisitCount = 0, 0, NonRouteTime / NonRouteVisitCount), ''00:00:00'')), ''00:00:00'')        as AverageNonRouteClientVisitTime,
       nullif(convert(time, dateadd(second, RouteTime + NonRouteTime, ''00:00:00'')), ''00:00:00'')                                                 as TotalClientVisitTime,
       nullif(convert(time, dateadd(second, iif((isnull(RouteVisitCount, 0) + isnull(NonRouteVisitCount, 0)) = 0, 0,
                                                (RouteTime + NonRouteTime) / (RouteVisitCount + NonRouteVisitCount)), ''00:00:00'')), ''00:00:00'') as AverageClientVisitTime,
       nullif(convert(time, dateadd(second, TotalTime, ''00:00:00'')), ''00:00:00'')                                                                as TotalWorkTime,
       nullif(convert(time, dateadd(second, PassiveTime, ''00:00:00'')), ''00:00:00'')                                                              as PassiveWorkTime,
       FirstVisit                                                                                                                                   as FirstVisitTime,
       LastVisit                                                                                                                                    as LastVisitTime

from AbpUsers Users with (nolock)
         join @VisitStats VisitStats on Users. Id = VisitStats. UserId
         left join @TimeStats as TimeStats on Users. Id = TimeStats. UserId
         left join @NonCompletedTasks NonCompletedTasks on Users. Id = NonCompletedTasks. UserId

where 1=1 '

    if @users is not null
        set @Query = concat(@Query, ' and Users. Id  IN (SELECT LTRIM(Value) FROM F_SplitList(@users, '',''))')

    if @userSpecodes is not null
        set @Query = concat(@Query,
                            ' and Users. Id in (select UserId from UIM_UserProperty with (nolock)
                                where (Specode1 like ''%''+@userSpecodes+''%'' or Specode2 like ''%''+@userSpecodes+''%''  or Specode3 like ''%''+@userSpecodes+''%'' or Specode4 like ''%''+@userSpecodes+''%'' or Specode5 like ''%''+@userSpecodes+''%'') ) ')


    if @visitStatus is not null
        set @Query = concat(@Query, case @visitStatus
                                        when 1 then ' and (RouteVisitCount > 0 or NonRouteVisitCount>0)'
                                        when 2 then ' and (RouteVisitCount = 0 and NonRouteVisitCount = 0)'
            end)

    if @routeVisitPercentMin is not null
        set @Query = concat(@Query, ' and round(iif(isnull(RouteCount, 0) = 0, 0, cast(isnull(RouteVisitCount, 0) as float) / cast(RouteCount as float) * 100), 2)
                                          between @routeVisitPercentMin and @routeVisitPercentMax ')

    execute sp_executesql @Query,
            N' @currentUserId int,
               @beginDate datetime, 
			   @endDate datetime,
               @users nvarchar(max),
			   @userSpecodes nvarchar(1000),
			   @visitStatus tinyint= null,
			   @routeVisitPercentMin float,
			   @routeVisitPercentMax float',
            @currentUserId=@currentUserId,
            @beginDate=@beginDate,
            @endDate=@endDate,
            @users=@users,
            @userSpecodes=@userSpecodes,
            @visitStatus=@visitStatus,
            @routeVisitPercentMin=@routeVisitPercentMin,
            @routeVisitPercentMax=@routeVisitPercentMax
End
go