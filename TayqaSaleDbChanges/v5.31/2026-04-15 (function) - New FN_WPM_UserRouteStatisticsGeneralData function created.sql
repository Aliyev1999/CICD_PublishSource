
CREATE OR ALTER FUNCTION [dbo].[FN_WPM_UserRouteStatisticsGeneralData]
    (
        @startDate DATE,
        @endDate DATE,
        @currentUserId INT
        )
    RETURNS TABLE
        AS
        RETURN(
 With  Routes as (
        select Route.UserId        as UserId,
               Route.TigerClientId as ClientId,
               Route.Date          as Date
          from MD_Route Route with (nolock)
        
         where Route.Date between @startDate and @endDate and Route.UserId=@currentUserId
           and Route.Status = 0
    ),
    Actions as (
        select TaskTicket.UserId                                                                as UserId,
               TaskTicket.ClientId                                                              as ClientId,
               cast(TaskTicket.CreatedDate as date)                                             as Date,
               SUM(ISNULL(DATEDIFF(minute, TaskTicket.CreatedDate, TaskTicket.FinalizedDate), 0)) as ActiveTime,
			   max(FinalizedDate)as FinalizedDate
          from WPM_TaskTicket TaskTicket with (nolock)
         
         where cast(TaskTicket.CreatedDate as date) between @startDate and @endDate and TaskTicket.UserId=@currentUserId
		     group by 
        TaskTicket.UserId, 
        TaskTicket.ClientId, 
        cast(TaskTicket.CreatedDate as date)
    ),
 Combined as(   select 
      distinct  
	    coalesce(Routes.UserId, Actions.UserId)     as UserId,
        coalesce(Routes.ClientId, Actions.ClientId) as ClientId,
        COALESCE(Routes.Date, Actions.Date)         as Date,
        IIF(Routes.UserId  is not null, 1, 0)        as IsRoute,
         case when Actions.UserId is not null and Actions.FinalizedDate is not null Then 1 else 0  end        as IsVisited,
        ISNULL(Actions.ActiveTime, 0)                as ActiveTime
    from Routes
    full outer join Actions
        on Routes.ClientId = Actions.ClientId
       and Routes.UserId   = Actions.UserId
       and cast(Routes.Date as date) = Actions.Date
)


	SELECT 

    COUNT(CASE WHEN IsRoute = 1 THEN ClientId END)                   AS TotalRoutes,

    COUNT(CASE WHEN IsRoute = 1 AND IsVisited = 1 THEN ClientId END) AS CompletedRoutes,

    CAST(
        COUNT(CASE WHEN IsRoute = 1 AND IsVisited = 1 THEN ClientId END) * 100.0 /
        NULLIF(COUNT(CASE WHEN IsRoute = 1 THEN ClientId END), 0)
    AS DECIMAL(10, 2))                                               AS RouteCompletionPercentage,

    CAST(
        SUM(CASE WHEN IsVisited = 1 THEN ActiveTime ELSE NULL END) * 1.0 /
        NULLIF(COUNT(CASE WHEN IsVisited = 1 THEN 1 END), 0)
    AS INT)                                                          AS AverageTimeOnClient

FROM Combined);
