
CREATE OR ALTER procedure [dbo].[SP_WPM_GetUsersPerformanceTrends]
(
    @startDate datetime,
    @endDate datetime,
    @userFilterType tinyint,          ---1 = İstifadəçi, 2 = İstifadəçi qrupu
    @searchReferences nvarchar(max),
    @byPercentage bit,                --- 1 = Faiz, 0 = Say
    @currentUserId bigint
)
as
begin
    set nocount on;
   

    declare @currentDate date = @startDate;
    declare @endDateOnly date = @endDate ;
    
    create table #DateRange (Date date);
    
    while @currentDate <= @endDateOnly
    begin
        insert into #DateRange (Date) values (@currentDate);
        set @currentDate = dateadd(day, 1, @currentDate);
    end
    
    ;with FilteredUsers as (
    -- Tip 1: İstifadəçi
    select TreeUsers.UserId
    from F_GetPermittedUsers(@currentUserId) TreeUsers
    inner join AbpUsers Users with (nolock) on Users.Id = TreeUsers.UserId
    where @userFilterType = 1
      and Users.IsDeleted = 0 
      and Users.IsActive = 1
      and (
            @searchReferences is null                    -- NULL gələrsə hamısını götür
            or len(ltrim(rtrim(@searchReferences))) = 0  -- boş string gələrsə hamısını götür
            or charindex(',' + cast(Users.Id as nvarchar(20)) + ',', ',' + @searchReferences + ',') > 0
          )
    
    union
    
    -- Tip 2: İstifadəçi qrupu
    select distinct TreeUsers.UserId
    from F_GetPermittedUsers(@currentUserId) TreeUsers
    inner join MD_UserGroupMapping UserGroupMapping with (nolock) 
        on UserGroupMapping.UserId = TreeUsers.UserId
    where @userFilterType = 2
      and (
            @searchReferences is null
            or len(ltrim(rtrim(@searchReferences))) = 0
            or charindex(',' + cast(UserGroupMapping.GroupId as nvarchar(20)) + ',', ',' + @searchReferences + ',') > 0
          )
),
    Routes as (
        select 
            Routes.UserId, 
            Routes.TigerClientId as ClientId, 
            Routes.Date
        from MD_Route Routes with (nolock)
        inner join FilteredUsers Users on Users.UserId = Routes.UserId
        where Routes.Date between @startDate and @endDate
          and Routes.Status = 0
    ),
    Actions as (

        select distinct
            TaskTicket.UserId, 
            TaskTicket.ClientId, 
            cast(TaskTicket.CreatedDate as date) as Date
        from WPM_TaskTicket TaskTicket with (nolock)
        inner join FilteredUsers Users on Users.UserId = TaskTicket.UserId
		join  WPM_Task Task with (nolock)   on TaskTicket.TaskId=Task.Id and TaskTicket.Firm=Task.Firm
        where cast(TaskTicket.CreatedDate as date) between @startDate and @endDate
		  and Task.Type=4

    ),
    Combined as (
        select 
            coalesce(Routes.UserId, Actions.UserId)       as UserId,
            coalesce(Routes.ClientId, Actions.ClientId)   as ClientId,
            coalesce(Routes.Date, Actions.Date)           as Date,
            iif(Routes.UserId is not null, 1, 0)          as IsRoute,
            iif(Actions.UserId is not null, 1, 0)         as IsVisited
        from Routes
        full outer join Actions
            on Routes.ClientId = Actions.ClientId
            and Routes.UserId = Actions.UserId
            and Routes.Date = Actions.Date
    ),
    DailyStats as (
        select 
            Date,
            sum(iif(IsRoute = 1, 1, 0))                     as TotalRoutes,
            sum(iif(IsRoute = 1 and IsVisited = 1, 1, 0))   as CompletedRoutes,
            sum(iif(IsRoute = 0 and IsVisited = 1, 1, 0))   as OffRouteVisits
        from Combined
        group by Date
    )
    select 
        DateRange.Date,
        case 
            when @byPercentage = 1 then null
            else cast(isnull(DailyStats.TotalRoutes, 0) as decimal)
        end                                                          as TargetValue,
        case 
            when @byPercentage = 1 then 
                case 
                    when isnull(DailyStats.TotalRoutes, 0) = 0 then 0
                    else round(
                        cast(isnull(DailyStats.CompletedRoutes, 0) + isnull(DailyStats.OffRouteVisits, 0) as decimal(18,2)) * 100 
                        / DailyStats.TotalRoutes, 
                        2
                    )
                end
            when @byPercentage = 0 then 
                isnull(DailyStats.CompletedRoutes, 0) + isnull(DailyStats.OffRouteVisits, 0)
            else 
                0
        end                                                          as ResultValue
    from #DateRange DateRange
    left join DailyStats DailyStats on DateRange.Date = DailyStats.Date
    order by DateRange.Date;
    

    drop table #DateRange;
    
end;
