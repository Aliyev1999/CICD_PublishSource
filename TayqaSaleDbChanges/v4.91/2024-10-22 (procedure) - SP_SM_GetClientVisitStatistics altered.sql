ALTER procedure [dbo].[SP_SM_GetClientVisitStatistics](
    @startDate datetime,
    @endDate datetime,
    @minimumPlannedVisitCount int,
    @maximumPlannedVisitCount int,
    @minimumRouteVisitCount int,
    @maximumRouteVisitCount int,
    @clientCodeOrName nvarchar(100),
    @clientSpecode1 nvarchar(100),
    @clientSpecode2 nvarchar(100),
    @clientSpecode3 nvarchar(100),
    @selectedUsers nvarchar(500),
    @firm smallint,
    @skipCount int,
    @maxResultCount int,
    @totalCount int out
)
AS
BEGIN
    set @totalCount = 1
    declare @Query nvarchar(max) ='
	declare @Result table
                    (UserFullName nvarchar(255),UserId int,ClientTigerId int,ClientName nvarchar(255),
					 ClientCode nvarchar(255),PlannedVisitCount int,RouteVisitCount int,NonRouteVisitCount int,TotalTime int, 
                     City nvarchar(255), District nvarchar(255), Village nvarchar(255), Address nvarchar(255)); 

with RouteData as (select Route.TigerClientId,
                          Route.Firm,
                          Count(*)     AS VisitCount,
                          Route.UserId AS UserId,
						  Route.Date
                   from MD_Route Route with (nolock)
                   where Route.Date between cast(@startDate as date) and cast(@endDate as date)
                     and Route.Firm = @firm and Route.Status=0 
                   group by Route.TigerClientId, Route.Firm, Route.UserId, Route.Date)
				   
	 
				   ,
     TotalTime as (select Ticket.Firm,
                          Ticket.ClientId,
                          Ticket.UserId,
                          Ticket.CreatedDate   as CreatedDate,
                          Ticket.FinalizedDate as FinalizedDate
                   from WPM_TaskTicket Ticket with (nolock)
				       join WPM_Task Task with (nolock) on Ticket.TaskId = Task.Id
                   where Ticket.Firm = @firm
                     and Ticket.IsCompleted = 1
					 --and Task.Type=4
                     and cast(Ticket.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)

                   union

                   select Visit.Firm          as Firm,
                          Visit.ClientId      as ClientId,
                          Visit.CreatedUserId as UserId,
                          Visit.CreatedDate   as CreatedDate,
                          Visit.Date      as FinalizedDate
                   from OP_ClientVisitLog Visit with (nolock)
                   where Visit.Firm = @firm
                     and cast(Visit.CreatedDate as date) between cast(@startDate as date) AND cast(@endDate as date)),
    Visits as (

                select Visit.Firm          as Firm,
                       Visit.ClientId      as ClientId,
                       Visit.CreatedUserId as UserId,
					   cast(Visit.Date as date)		   as Date
                from OP_ClientVisitLog Visit with (nolock)
                where Visit.Firm = @firm
                  and cast(Visit.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)
				  
				  union 

				SELECT 
				
                       Ticket.Firm                                                      AS Firm,
				ClientId                                                         AS ClientId,
					   cast(Ticket.UserId AS INT)                                       AS UserId,
					   cast(Ticket.CreatedDate as date)                                  AS Date
                FROM WPM_TaskTicket Ticket WITH (NOLOCK)
				join WPM_Task Task with(nolock) on Ticket.TaskId=Task.Id
                WHERE Ticket.Firm = @firm and Task.Type=1
                  AND Ticket.IsCompleted = 1 
                  AND CAST(Ticket.CreatedDate AS DATE) BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)
				  
				  )
				  ,
				  
				 
     Result as (SELECT ISNULL(RouteData.TigerClientId, Visits.ClientId)                                                  AS ClientId,
                       CAST(ISNULL(RouteData.UserId, Visits.UserId) AS INT)                                              AS UserId,
                       ISNULL(RouteData.Firm, Visits.Firm)                                                               AS Firm,
					    Isnull(RouteData.Date,Visits.Date)                                                        As Date,
						iif(RouteData.VisitCount is not null, 1, 0)                                         as PlannedVisitCount,
                       (iif(RouteData.TigerClientId is not null and Visits.ClientId is not null, 1, 0))     as RouteVisitCount,
                       (iif(RouteData.TigerClientId is null and Visits.ClientId is not null, 1, 0)) as NonRouteVisitCount
                FROM RouteData
                         FULL JOIN Visits
                                   ON Visits.ClientId = RouteData.TigerClientId AND RouteData.Firm = Visits.Firm AND RouteData.UserId = Visits.UserId and  RouteData.Date=Visits.Date 
                

                UNION 

                SELECT ClientId                                                         AS ClientId,
                       cast(Ticket.UserId AS INT)                                       AS UserId,
                       Ticket.Firm                                                      AS Firm,
					   cast(Ticket.CreatedDate as date)                                  AS Date,
					   iif(Ticket.ManualRouteClientId IS NULL, 1, 0)      as PlannedVisitCount,
                       iif(Ticket.ManualRouteClientId IS NULL, 1, 0) AS RouteVisitCount,
                       iif(Ticket.ManualRouteClientId > 0, 1, 0)     AS NonRouteVisitCount
                FROM WPM_TaskTicket Ticket WITH (NOLOCK)
				join WPM_Task Task with(nolock) on Ticket.TaskId=Task.Id
                WHERE Ticket.Firm = @firm and Task.Type=4
                  AND Ticket.IsCompleted = 1 
                  AND CAST(Ticket.CreatedDate AS DATE) BETWEEN CAST(@startDate AS DATE) AND CAST(@endDate AS DATE)
                 ),
	 ResultLast as (Select ClientId,UserId,Firm,Date,
					isnull(PlannedVisitCount,0) as PlannedVisitCount,
					sum(RouteVisitCount) as RouteVisitCount,
					sum(NonRouteVisitCount) as NonRouteVisitCount 
					from Result
	                group by ClientId,UserId,Firm,Date,isnull(PlannedVisitCount,0))
				
				,

	
     Last as (select isnull(Result.UserId, RouteData.UserId)          as UserId,
                     isnull(Result.ClientId, RouteData.TigerClientId) as ClientId,
                     isnull(Result.Firm, RouteData.Firm)              as Firm,
                     sum(RouteVisitCount)                            as RouteVisitCount,
                     sum(NonRouteVisitCount)                          as NonRouteVisitCount,
                     sum(PlannedVisitCount)             as PlannedVisitCount
              from RouteData
                       full outer join ResultLast as Result on Result.UserId = RouteData.UserId and Result.ClientId = RouteData.TigerClientId and
                                                 Result.Firm = RouteData.Firm and RouteData.Date=Result.Date
			group by isnull(Result.UserId, RouteData.UserId),isnull(Result.ClientId, RouteData.TigerClientId),isnull(Result.Firm, RouteData.Firm) 
              ),
	  Data as ( 
				  select concat(Users.Name, '' '', Users.Surname)                                         as UserFullName,
                         Users.Id                                                                       as UserId,
						 Client.TigerId                                                                 as ClientTigerId,
						 Client.Name                                                                    as ClientName,
					     client.Code                                                                    as ClientCode,
						 Last.PlannedVisitCount                                                         as PlannedVisitCount,
						 Last.RouteVisitCount                                                           as RouteVisitCount,
						 Last.NonRouteVisitCount                                                        as NonRouteVisitCount,                    
						 sum(abs(isnull(DATEDIFF(second, TotalTime.CreatedDate, TotalTime.FinalizedDate), 0))) AS TotalTime,
                         Client.City                      as City,
                       Client.District                  as District,
                       Client.Town                   as Village,
                       Client.Address                  as Address
                  from Last
						 join AbpUsers Users with (nolock) on Last.UserId = Users.Id
						 join MD_Client Client with (nolock) on Client.TigerId = Last.ClientId and Client.Firm = Last.Firm
						 left join UIM_UserProperty Specodes with (nolock) on Specodes.UserId = Last.UserId and Specodes.Firm = Last.Firm
						 left join F_SplitList(@selectedUsers, '','') selectedUsers on Users.Id = LTRIM(selectedUsers.Value)
						 LEFT JOIN TotalTime ON TotalTime.ClientId = Last.ClientId AND TotalTime.UserId = Last.UserId 
					
					where Client.Firm = @firm 
					and ( Users.Id = LTRIM(selectedUsers.Value)) '

    if @clientSpecode1 is not null
        set @Query = concat(@Query,
                            ' and ( Client.SpecialCode like ''%''+@clientSpecode1+''%'' ) ')

    if @clientSpecode2 is not null
        set @Query = concat(@Query,
                            ' and ( Client.SpecialCode2 like ''%''+ @clientSpecode2+''%'' ) ')

    if @clientSpecode3 is not null
        set @Query = concat(@Query,
                            ' and ( Client.SpecialCode3 like ''%''+@clientSpecode3+''%'' ) ')

    if @clientCodeOrName is not null
        set @Query = concat(@Query,
                            ' and ( Client.Name like ''%''+@clientCodeOrName+''%'' or Client.Code like ''%''+@clientCodeOrName+''%'') ')


    set @Query = concat(@Query, '
	GROUP BY 
	     CONCAT(Users.Name, '' '', Users.Surname),
         Users.Id,
         Client.TigerId,
         Client.Name,
         Client.Code,
         Last.PlannedVisitCount,
         Last.RouteVisitCount,
         Last.NonRouteVisitCount,
		 Client.City,
		 Client.District,
		 Client.Town,
		  Client.Address 
	)
		insert into @Result (UserFullName ,UserId ,ClientTigerId ,ClientName ,
					ClientCode ,PlannedVisitCount ,RouteVisitCount ,NonRouteVisitCount ,TotalTime, City, District, Village, Address)

	     select * from Data where 1=1 ')

    if @minimumPlannedVisitCount is not null and @maximumPlannedVisitCount is not null
        set @Query = concat(@Query,
                            ' and Data.PlannedVisitCount between @minimumPlannedVisitCount and @maximumPlannedVisitCount ')

    if @minimumRouteVisitCount is not null and @maximumRouteVisitCount is not null
        set @Query =
                concat(@Query, ' and Data.RouteVisitCount between @minimumRouteVisitCount and @maximumRouteVisitCount ')

    set @Query = concat(@Query, '
set @totalCount = (select count(*) from @Result) -- get total count


select * from @Result
where 1=1
');
    if @SkipCount is not null or @maxResultCount is not null
        set @Query =
                concat(@Query, ' order by  ClientName asc offset @SkipCount rows fetch next @maxResultCount rows only');

    execute sp_executesql @Query,
            N' @startDate datetime,
               @endDate datetime,
               @minimumPlannedVisitCount int,
               @maximumPlannedVisitCount int,
               @minimumRouteVisitCount int,
               @maximumRouteVisitCount int,
               @clientCodeOrName nvarchar(100),
               @clientSpecode1 nvarchar(100),
               @clientSpecode2 nvarchar(100),
               @clientSpecode3 nvarchar(100),
               @selectedUsers nvarchar(500),
               @firm smallint,
               @skipCount int,
               @maxResultCount int,
               @totalCount int out',
            @startDate=@startDate,
            @endDate=@endDate,
            @minimumPlannedVisitCount=@minimumPlannedVisitCount,
            @maximumPlannedVisitCount=@maximumPlannedVisitCount,
            @minimumRouteVisitCount=@minimumRouteVisitCount,
            @maximumRouteVisitCount=@maximumRouteVisitCount,
            @clientCodeOrName=@clientCodeOrName,
            @clientSpecode1=@clientSpecode1,
            @clientSpecode2=@clientSpecode2,
            @clientSpecode3=@clientSpecode3,
            @selectedUsers =@selectedUsers,
            @firm=@firm,
            @skipCount=@skipCount,
            @maxResultCount=@maxResultCount,
            @totalCount = @totalCount out

End
go