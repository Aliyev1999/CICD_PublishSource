
ALTER procedure [dbo].[SP_WPM_GetDailyRouteStatistics](
    @minDate datetime,--
    @maxDate datetime,--
    @userSpecodes nvarchar(200),--
    @users nvarchar(200),--
    @forceTicketLiveDuration bit,--
    @isSaleRouteRequest bit,-- true 4 false 2 
    @currentUserId BIGINT--
)
As
Begin

    declare @Query nvarchar(max) ='with Data as (
	           select TaskTicket.UserId                                                                    as Id,
                     COUNT(DISTINCT CASE 
                        WHEN route.TigerClientId IS NOT NULL 
                             AND TaskTicket.IsCompleted = 1 
                             THEN CONCAT(TaskTicket.ClientId, CAST(TaskTicket.CreatedDate AS DATE)) 
                        END) AS RouteCompletedCount,
        COUNT(DISTINCT CASE 
                        WHEN route.TigerClientId IS NULL 
                             AND TaskTicket.IsCompleted = 1 
                             THEN CONCAT(TaskTicket.ClientId, CAST(TaskTicket.CreatedDate AS DATE)) 
                        END) AS NonRouteCount,
                     sum(iif(route.TigerClientId is not null,
                             iif(@forceTicketLiveDuration = 1 and Task.ForceTicketLiveDuration = 1
                                     and Task.MaximumTicketLiveDurationWithMinutes <
                                         datediff(minute, TaskTicket.CreatedDate, TaskTicket.FinalizedDate),
                                 Task.MaximumTicketLiveDurationWithMinutes * 60,
                                 datediff(second, TaskTicket.CreatedDate, TaskTicket.FinalizedDate)), 0)) as TotalRouteTime,
                     sum(iif(route.TigerClientId is null,
                             iif(@forceTicketLiveDuration = 1 and Task.ForceTicketLiveDuration = 1
                                     and Task.MaximumTicketLiveDurationWithMinutes <
                                         datediff(minute, TaskTicket.CreatedDate, TaskTicket.FinalizedDate),
                                 Task.MaximumTicketLiveDurationWithMinutes * 60,
                                 datediff(second, TaskTicket.CreatedDate, TaskTicket.FinalizedDate)), 0)) as TotalNonRouteTime,
                     (select sum(Total) from (
						 select Date, datediff(second, min(WorkTime.StartTime), max(WorkTime.EndTime)) as Total 
						 from WPM_Route WorkTime 
						 where UserId = TaskTicket.UserId and WorkTime.Date between @minDate and @maxDate
						 group by Date) t)																		as TotalWorkTime,
					 sum(iif(Task.ClientListType = iif(@isSaleRouteRequest = 1, 4, 2)
                                 and TaskTicket.IsCompleted = 0
                                 and cast(TaskTicket.CreatedDate as date) >= @minDate
                                 and cast(TaskTicket.CreatedDate as date) <= @maxDate, 1, 0))                           as NonCompletedTickets,
                     min(cast(TaskTicket.CreatedDate as time))                                            as FirstClientVisitTime,
                     max(cast(TaskTicket.FinalizedDate as time))                                          as LastClientVisitTime
              from WPM_TaskTicket TaskTicket with (nolock)
                       join WPM_Task Task with (nolock) on TaskTicket.TaskId = Task.Id
					   left  join WPM_Route WorkTime with(nolock) on WorkTime.UserId=TaskTicket.UserId and cast(WorkTime.Date as date)=cast(TaskTicket.CreatedDate as date)
					   left join MD_Route route with(nolock) on TaskTicket.UserId=route.UserId and cast(TaskTicket.CreatedDate as date)=route.Date 
																and route.Firm=TaskTicket.Firm and route.TigerClientId=TaskTicket.ClientId
              where Task.Type = 4
                and Task.ClientListType = iif(@isSaleRouteRequest = 1, 4, 2)
                and ((cast(TaskTicket.FinalizedDate as date) between @minDate and @maxDate) OR (cast(TaskTicket.CreatedDate as date) between @minDate and @maxDate))
              group by TaskTicket.UserId),
	RouteData as (select UserId,count( TigerClientId) as Planned 
	      from MD_Route Route with(nolock)
		where Date between cast(@minDate as date) and cast(@maxDate as date) 
		group by UserId)
Select distinct cast(RouteData.UserId  as bigint)                  as UserId,
                Users.Name                                          as Name,
                Users.Surname                                       as Surname,
                ParentUserIds.ParentUserIds                        as ParentUserIds,
                isnull( RouteData.Planned, 0)  as RoutePlannedCount,
                isnull(Data.RouteCompletedCount, 0)                 as RouteCompletedCount,
                isnull(Data.NonRouteCount, 0)                       as NonRouteCount,
                isnull(cast(Data.TotalRouteTime as float),0)        as TotalRouteTime,
                isnull(cast(Data.TotalNonRouteTime as float),0)     as TotalNonRouteTime,
                isnull(Data.TotalWorkTime,0)                        as TotalWorkTime,
                isnull(Data.NonCompletedTickets,0)                  as NonCompletedTickets,
                isnull(Data.FirstClientVisitTime, CAST(''00:00:00'' as time)) as FirstClientVisitTime,
			    isnull(Data.LastClientVisitTime, CAST(''00:00:00'' as time)) as LastClientVisitTime,
       Schedule.Id                        as Id,
       Task.Id                            as TaskId,
       cast(iif(@isSaleRouteRequest = 1, 4, 2) as tinyint) as ClientListType,
       Schedule.StartDate                 as StartDate,
       Schedule.EndDate                   as EndDate,
       Schedule.StartTime                 as StartTime,
       Schedule.EndTime                   as EndTime,
       cast(Schedule.PeriodType as tinyint)   as PeriodType,
       Schedule.PeriodStep                as PeriodStep,
       Schedule.AlarmPeriod               as AlarmPeriod,
       PeriodType.Name                    as PeriodName,
       isnull(TaskClientCount.TaskClientCount ,0)   as TaskClientCount,
       cast(Task.Status  as bit)                      as IsPassive
from RouteData with (nolock)
		 join WPM_UserTask TaskUser with (nolock) on TaskUser.UserId=RouteData.UserId
         left join Data with (nolock) on Data.Id = TaskUser.UserId
         join WPM_Task Task with (nolock) on TaskUser.TaskId = Task.Id
         join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Task.Id
         join AbpUsers Users with (nolock) on Users.Id = TaskUser.UserId
		 join F_DTM_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.Id = Users.Id
         left join WPM_TaskSchedulePeriodType PeriodType with (nolock) on PeriodType.Id = Schedule.PeriodType
         left join (select TaskId, count(ClientId) as TaskClientCount
                    from WPM_TaskClient Client with (nolock)
                    group by TaskId) TaskClientCount on TaskClientCount.TaskId = TaskUser.TaskId
		 left join UIM_UserProperty Specodes with (nolock) on Specodes.UserId = Users.Id and Specodes.Firm = Task.Firm
		 left join (select UserId, string_agg(Parents.ParentUserId, '','') as ParentUserIds
                from F_UIM_GetOrganizationUserParentswithoutHeader() Parents
                group by UserId) as ParentUserIds on ParentUserIds.UserId = Users.Id
		 where 1=1
'

    if @users is not null
        set @Query = concat(@Query, ' and Users.Id IN (SELECT LTRIM(Value) FROM F_SplitList(@users, '',''))')

    if @userSpecodes is not null
        set @Query = concat(@Query,
                            ' and (Specodes.Specode1 like ''%''+@userSpecodes+''%'' or Specodes.Specode2 like ''%''+@userSpecodes+''%'' or 
							Specodes.Specode3 like ''%''+@userSpecodes+''%'' or Specodes.Specode4 like ''%''+@userSpecodes+''%''  or Specodes.Specode5 like ''%''+@userSpecodes+''%'') ')

execute sp_executesql @Query,
            N' @minDate datetime, 
			   @maxDate datetime,
               @users nvarchar(500)= null,
			   @userSpecodes nvarchar(200),
			   @forceTicketLiveDuration bit,
			   @isSaleRouteRequest bit,
               @currentUserId BIGINT',
            @minDate=@minDate,
			@maxDate=@maxDate,
			@users=@users,
			@userSpecodes=@userSpecodes,
			@forceTicketLiveDuration=@forceTicketLiveDuration,
			@isSaleRouteRequest=@isSaleRouteRequest,
            @currentUserId = @currentUserId
End

