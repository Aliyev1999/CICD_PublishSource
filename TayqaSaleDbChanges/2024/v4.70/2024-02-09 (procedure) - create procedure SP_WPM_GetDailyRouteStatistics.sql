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
                     COUNT(DISTINCT CASE WHEN TaskTicket.ManualRouteClientId IS NULL AND TaskTicket.IsCompleted = 1 THEN TaskTicket.ClientId END)  as RouteCompletedCount,
                     COUNT(DISTINCT CASE WHEN TaskTicket.ManualRouteClientId >0 AND TaskTicket.IsCompleted = 1 THEN TaskTicket.ClientId END)       as NonRouteCount,
                     sum(iif(TaskTicket.ManualRouteClientId IS NULL,
                             iif(@forceTicketLiveDuration = 1 and Task.ForceTicketLiveDuration = 1
                                     and Task.MaximumTicketLiveDurationWithMinutes <
                                         datediff(minute, TaskTicket.CreatedDate, TaskTicket.FinalizedDate),
                                 Task.MaximumTicketLiveDurationWithMinutes * 60,
                                 datediff(second, TaskTicket.CreatedDate, TaskTicket.FinalizedDate)), 0)) as TotalRouteTime,
                     sum(iif(TaskTicket.ManualRouteClientId is not null,
                             iif(@forceTicketLiveDuration = 1 and Task.ForceTicketLiveDuration = 1
                                     and Task.MaximumTicketLiveDurationWithMinutes <
                                         datediff(minute, TaskTicket.CreatedDate, TaskTicket.FinalizedDate),
                                 Task.MaximumTicketLiveDurationWithMinutes * 60,
                                 datediff(second, TaskTicket.CreatedDate, TaskTicket.FinalizedDate)), 0)) as TotalNonRouteTime,
                     datediff(second, WorkTime.StartTime, WorkTime.EndTime)     as TotalWorkTime,
					 sum(iif(Task.ClientListType = iif(@isSaleRouteRequest = 1, 4, 2)
                                 and TaskTicket.IsCompleted = 0
                                 and TaskTicket.CreatedDate >= @minDate
                                 and TaskTicket.CreatedDate <= @maxDate, 1, 0))                           as NonCompletedTickets,
                     min(cast(TaskTicket.CreatedDate as time))                                            as FirstClientVisitTime,
                     max(cast(TaskTicket.FinalizedDate as time))                                          as LastClientVisitTime
              from WPM_TaskTicket TaskTicket with (nolock)
                       join WPM_Task Task with (nolock) on TaskTicket.TaskId = Task.Id
					   left  join WPM_Route WorkTime with(nolock) on WorkTime.UserId=TaskTicket.UserId and cast(WorkTime.Date as date)=cast(TaskTicket.CreatedDate as date)
              where Task.Type = 4
                and Task.ClientListType = iif(@isSaleRouteRequest = 1, 4, 2)
                and ((TaskTicket.FinalizedDate between @minDate and @maxDate) OR (TaskTicket.CreatedDate between @minDate and @maxDate))
              group by TaskTicket.UserId,datediff(second, WorkTime.StartTime, WorkTime.EndTime) )
Select cast(TaskUser.UserId  as bigint)                  as UserId,
       Users.Name                         as Name,
       Users.Surname                      as Surname,
       ParentUserIds.ParentUserIds        as ParentUserIds,
       isnull(RouteData.Planned,0)                as RoutePlannedCount,
       Data.RouteCompletedCount           as RouteCompletedCount,
       Data.NonRouteCount                 as NonRouteCount,
       cast(Data.TotalRouteTime as float)        as TotalRouteTime,
       cast(Data.TotalNonRouteTime  as float)    as TotalNonRouteTime,
       Data.TotalWorkTime                 as TotalWorkTime,
       Data.NonCompletedTickets           as NonCompletedTickets,
       Data.FirstClientVisitTime          as FirstClientVisitTime,
       Data.LastClientVisitTime           as LastClientVisitTime,
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
from WPM_UserTask TaskUser with (nolock)
         join Data on Data.Id = TaskUser.UserId
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
		left join (select UserId,count(distinct TigerClientId) as Planned from MD_Route Route with(nolock)
		where Date between cast(@minDate as date) and dateadd(day,-1,cast(@maxDate as date)) group by UserId) RouteData on TaskUser.UserId=RouteData.UserId
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