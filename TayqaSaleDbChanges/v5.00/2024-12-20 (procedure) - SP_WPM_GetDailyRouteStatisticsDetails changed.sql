CREATE OR ALTER PROCEDURE [dbo].[SP_WPM_GetDailyRouteStatisticsDetails] @userId int,
                                                               @beginDate datetime,
                                                               @endDate datetime,
                                                               @routeType tinyint,
                                                               @visitStatus tinyint,
                                                               @clientCodeName nvarchar(100),
                                                               @sorting nvarchar(100),
                                                               @skipCount int,
                                                               @maxResultCount int,
                                                               @isExcelExport bit,
                                                               @totalCount int out
AS
BEGIN

    declare @Result table
                    (
                        OrderNo            int,
                        TaskTicketId       int,
                        ClientId           int,
                        ClientCode         nvarchar(100),
                        ClientName         nvarchar(250),
                        StartDate          datetime,
                        FinishDate         datetime,
                        StartDistance      float,
                        FinishDistance     float,
                        VisitStatus        tinyint,
                        IsInRoute          bit,
                        TimeSpent          time,
                        OperationCount     smallint,
                        CreatedLongitude   float,
                        CreatedLatitude    float,
                        ClientLongitude    float,
                        ClientLatitude     float,
                        FinalizedLongitude float,
                        FinalizedLatitude  float
                    );

    declare @Query nvarchar(max) = '

with CombinedData as (select coalesce(Routes.Firm, Ticket.Firm)                                      as Firm,
                             coalesce(Routes.TigerClientId, Ticket.ClientId)                         as ClientId,
                             coalesce(Routes.UserId, Ticket.UserId)                                  as UserId,
                             coalesce(Routes.Date, cast(Ticket.CreatedDate as date))                 as Date,
                             iif(Routes.UserId is not null, 1, 0)                                    as IsInRoute,
                             case
                                 when Routes.UserId is not null and Ticket.UserId is null then 1
                                 when Ticket.CreatedDate is not null and Ticket.FinalizedDate is null then 2
                                 when Ticket.FinalizedDate is not null then 3 end                    as VisitStatus,
                             Ticket.Id                                                               as TaskTicketId,
                             Ticket.CreatedDate                                                      as StartDate,
                             Ticket.FinalizedDate                                                    as FinishDate,
                             Ticket.CreatedLatitude                                                  as StartLatitude,
                             Ticket.CreatedLongitude                                                 as StartLongitude,
                             Ticket.FinalizedLatitude                                                as FinishLatitude,
                             Ticket.FinalizedLongitude                                               as FinishLongitude,
                             Ticket.TicketActionCount                                                as OperationCount

                      from MD_Route Routes with (nolock)
                               full outer join WPM_TaskTicket Ticket with (nolock) on Ticket.Firm = Routes.Firm and Routes.TigerClientId = Ticket.ClientId
                          and Routes.UserId = Ticket.UserId and Routes.Date = cast(Ticket.CreatedDate as date)

                      where coalesce(Routes.Date, cast(Ticket.CreatedDate as date)) between @beginDate and @endDate
                        and coalesce(Routes.UserId, Ticket.UserId) = @userId 
                        and (Ticket.Id is null or Ticket.TaskId in (select Id from WPM_Task with (nolock) where Type = 4)))

select row_number() over (order by coalesce(StartDate, ''2999.12.31''))                                                                                         as OrderNo,
       Data.TaskTicketId                                                                                                                                        as TaskTicketId,
       Client.TigerId                                                                                                                                           as ClientId,
       Client.Code                                                                                                                                              as ClientCode,
       Client.Name                                                                                                                                              as ClientName,
       StartDate                                                                                                                                                as StartDate,
       FinishDate                                                                                                                                               as FinishDate,

       nullif(round(iif(Client.Latitude = 0 or Client.Latitude not between -90 and 90 OR Client.Longitude not between -180 and 180
                            OR StartLatitude is null or StartLatitude = 0 OR StartLongitude not between -180 and 180,
                        -1,
                        geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(geography::Point(StartLatitude, StartLongitude, 4326))), 0), -1)   as StartDistance,


       nullif(round(iif(Client.Latitude = 0 or Client.Latitude not between -90 and 90 OR Client.Longitude not between -180 AND 180
                            OR FinishLatitude is null or FinishLatitude = 0 or FinishLongitude not between -180 and 180,
                        -1,
                        geography::Point(Client.Latitude, Client.Longitude, 4326).STDistance(geography::Point(FinishLatitude, FinishLongitude, 4326))), 0), -1) as FinishDistance,

       Data.VisitStatus                                                                                                                                         as VisitStatus,
       Data.IsInRoute                                                                                                                                           as IsInRoute,
       cast(dateadd(second, datediff(second, Data.StartDate, Data.FinishDate), ''00:00:00'') as time)                                                           as TimeSpent,
       Data.OperationCount                                                                                                                                      as OperationCount,
       Data.StartLongitude                                                                                                                                      as CreatedLatitude,
       Data.StartLatitude                                                                                                                                       as CreatedLatitude,
       Client.Longitude                                                                                                                                         as ClientLongitude,
       Client.Latitude                                                                                                                                          as ClientLatitude,
       Data.FinishLongitude                                                                                                                                     as FinalizedLongitude,
       Data.FinishLatitude                                                                                                                                      as FinalizedLatitude


from CombinedData Data with (nolock)
         join MD_Client Client with (nolock) on Client.TigerId = Data.ClientId and Client.Firm = Data.Firm
where 1=1 ';


    if @routeType is not null
        set @Query = concat(@Query,
                            case
                                when @routeType = 1 then ' and IsInRoute=1 '
                                when @routeType = 2 then ' and IsInRoute=0 '
                                end);

    if @visitStatus <> 4 -- means except all -> if "all" is selected in UI, no filter is needed
        set @Query = concat(@Query, ' and VisitStatus=@visitStatus ');

    if @clientCodeName is not null
        set @Query = concat(@Query, ' and (Client.Name LIKE ''%'' + @clientCodeName + ''%'' or Client.Code like ''%'' + @clientCodeName + ''%'') ');

    insert into @Result
        exec sp_executesql @Query,
             N'@userId int,
               @beginDate datetime,
               @endDate datetime,
               @routeType tinyint,
               @visitStatus tinyint,
               @clientCodeName nvarchar(100),
               @sorting nvarchar(100),
               @skipCount int,
               @maxResultCount int',
             @userId=@userId,
             @beginDate=@beginDate,
             @endDate=@endDate,
             @routeType=@routeType,
             @visitStatus=@visitStatus,
             @clientCodeName=@clientCodeName,
             @sorting=@sorting,
             @skipCount=@skipCount,
             @maxResultCount=@maxResultCount;


    set @totalCount = (select count(*) from @Result);

    select *
    from @Result
    order by coalesce(@sorting, 'StartDate', '2999.12.31')
    offset iif(@isExcelExport = 0, @skipCount, 0) rows fetch next iif(@isExcelExport = 0, @maxResultCount, 100000) rows only

END;