
CREATE OR ALTER procedure [dbo].[SP_SM_GetClientNonVisitStatistics]
(
	@startDate datetime,
	@endDate datetime,
	@clientCodeOrName nvarchar(100),
	@clientSpecode1 nvarchar(100),
	@clientSpecode2 nvarchar(100),
	@clientSpecode3 nvarchar(100),
	@selectedUsers nvarchar(500),
	@firm smallint,
	@TotalCount int out
)
As
Begin

	
declare @Query nvarchar(max) ='declare @Result table
                    (UserFullName nvarchar(255), UserName nvarchar(255),UserId int,ClientTigerId int,ClientName nvarchar(255),
					ClientCode nvarchar(255),Date date, City nvarchar(255), District nvarchar(255), Village nvarchar(255), Address nvarchar(255));
					
with RouteData as (select Route.TigerClientId,
                          Route.Firm,
                          Route.UserId as UserId,
                          Route.Date   as Date
                   from MD_Route Route with (nolock)
                   where cast(Route.Date as date) between cast(@startDate as date) and cast(@endDate as date)
                     and Status = 0
                     and Route.Firm = @firm),
     Visits as (select Ticket.Firm,
                       Ticket.ClientId,
                       Ticket.UserId,
                       Ticket.CreatedDate as Date
                from WPM_TaskTicket Ticket with (nolock)
				join WPM_Task Task with (nolock) on Ticket.TaskId = Task.Id
                where Ticket.Firm = @firm --and Task.Type = 4
                  and Ticket.IsCompleted = 1
                  and cast(Ticket.CreatedDate as date) between cast(@startDate as date) and cast(@endDate as date)

                union

                select Visit.Firm          as Firm,
                       Visit.ClientId      as ClientId,
                       Visit.CreatedUserId as UserId,
                       Visit.CreatedDate   as Date
                from OP_ClientVisitLog Visit with (nolock)
                where Visit.Firm = @firm
                  and cast(Visit.CreatedDate as date) between cast(@startDate as date) AND cast(@endDate as date)),

     Result as (select concat(Users.Name, '' '', Users.Surname) as UserFullName,
				users.UserName,
	                   cast(RouteData.UserId as int) as UserId, 
					   Client.TigerId                as ClientTigerId,
                       Client.Name                   as ClientName,
                       client.Code                   as ClientCode,
                       RouteData.Date                as Date,
                       Client.City                      as City,
                       Client.District                  as District,
                       Client.Town                   as Village,
                       Client.Address                  as Address
                from RouteData
                         join AbpUsers Users with (nolock) on RouteData.UserId = Users.Id
                         join MD_Client Client with (nolock) on Client.TigerId = RouteData.TigerClientId and Client.Firm = RouteData.Firm
                         left join UIM_UserProperty Specodes with (nolock) on Specodes.UserId = RouteData.UserId and Specodes.Firm = RouteData.Firm
                         left join F_SplitList(@selectedUsers, '','') selectedUsers on Users.Id = LTRIM(selectedUsers.Value)
                         left join Visits on Visits.ClientId = RouteData.TigerClientId and RouteData.Firm = Visits.Firm
                    and RouteData.UserId = Visits.UserId and RouteData.Date = cast(Visits.Date as date)
                where Visits.ClientId is null
                  and (Users.Id = LTRIM(selectedUsers.Value)) '


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
	)
		insert into @Result (UserFullName, UserName,UserId ,ClientTigerId ,ClientName ,ClientCode ,Date, City, District, Village, Address )

	     select * from Result where 1=1 
		 set @totalCount = (select count(*) from @Result) -- get total count


select * from @Result
where 1=1')


print @Query

execute sp_executesql @Query,
        N' @startDate datetime,
           @endDate datetime,
           @clientCodeOrName nvarchar(100),
           @clientSpecode1 nvarchar(100),
           @clientSpecode2 nvarchar(100),
           @clientSpecode3 nvarchar(100),
           @selectedUsers nvarchar(500),
           @firm smallint,
		   @TotalCount int out',
        @startDate=@startDate,
        @endDate=@endDate,
        @clientCodeOrName=@clientCodeOrName,
        @clientSpecode1=@clientSpecode1,
        @clientSpecode2=@clientSpecode2,
        @clientSpecode3=@clientSpecode3,
        @selectedUsers =@selectedUsers,
        @firm=@firm,
		@TotalCount = @TotalCount out
End
