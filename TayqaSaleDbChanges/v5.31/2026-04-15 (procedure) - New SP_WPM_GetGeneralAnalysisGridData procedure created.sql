
CREATE OR ALTER   PROCEDURE [dbo].[SP_WPM_GetGeneralAnalysisGridData] @startDate DATETIME,
                                                                @endDate DATETIME,
                                                                @userFilterType TINYINT, -- 1 = İstifadəçi, 2 = İstifadəçi qrupu
                                                                @searchReference NVARCHAR(MAX), -- Vergüllə ayrılmış UserId və ya GroupId siyahısı
                                                                @currentUserId BIGINT,
                                                                @sorting NVARCHAR(MAX),
                                                                @skipCount INT = 0,
                                                                @maxResultCount INT = 10,
                                                                @totalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;


    declare @query nvarchar(max);

    declare @Result table
                    (
                        UserId                bigint,
                        UserFullName          nvarchar(500),
                        UserProfilePictureUrl nvarchar(500),
                        ClientsOnRoute        int,
                        VisitedClients        int,
                        StartTime             datetime,
                        EndTime               datetime,
                        TotalTime             bigint,
                        TimeOnClient          bigint,
                        PassiveTime           bigint
                    );

    set @query = '
    ;with TreeUsers as (
        select TreeUsers.UserId
          from F_GetPermittedUsers(@currentUserId) TreeUsers
         inner join AbpUsers Users with (nolock) on Users.Id = TreeUsers.UserId
         where @userFilterType = 1
           and Users.Id in (
                   select TRY_CAST(value as bigint)
                     from STRING_SPLIT(@searchReference, '','')
               )
           and Users.IsDeleted = 0
           and Users.IsActive = 1
           and @searchReference is not null
           and LEN(LTRIM(RTRIM(@searchReference))) > 0

        union

        select distinct TreeUsers.UserId
          from F_GetPermittedUsers(@currentUserId) TreeUsers
         inner join MD_UserGroupMapping UserGroupMapping with (nolock)
                on UserGroupMapping.UserId = TreeUsers.UserId
         where @userFilterType = 2
           and UserGroupMapping.GroupId in (
                   select TRY_CAST(value as bigint)
                     from STRING_SPLIT(@searchReference, '','')
               )
           and @searchReference is not null
           and LEN(LTRIM(RTRIM(@searchReference))) > 0
		   
    union

    -- searchReference null və ya boşdursa → bütün permitted users
    select TreeUsers.UserId
      from F_GetPermittedUsers(@currentUserId) TreeUsers
     where @searchReference is null
        or LEN(LTRIM(RTRIM(@searchReference))) = 0

    ),
  Routes as (
    select 
        Route.UserId,
        Route.TigerClientId as ClientId,
        Route.Date
    from MD_Route Route with (nolock)
	     inner join TreeUsers on TreeUsers.UserId = Route.UserId
    where Route.Date between @startDate and @endDate 
      and Route.Status = 0
),

Actions as (
    select 
        TaskTicket.UserId,
        TaskTicket.ClientId,
        cast(TaskTicket.CreatedDate as date) as Date,

        -- hər client üçün ilk giriş
        MIN(TaskTicket.CreatedDate) as CreatedDate,

        -- hər client üçün son çıxış
        MAX(TaskTicket.FinalizedDate) as FinalizedDate,

        -- ümumi aktiv vaxt (duplicate yoxdur artıq)
        SUM(ISNULL(DATEDIFF(minute, TaskTicket.CreatedDate, TaskTicket.FinalizedDate), 0)) as ActiveTime

    from WPM_TaskTicket TaskTicket with (nolock)
	         inner join TreeUsers on TreeUsers.UserId = TaskTicket.UserId
			 join  WPM_Task Task with (nolock)   on TaskTicket.TaskId=Task.Id and TaskTicket.Firm=Task.Firm
    where cast(TaskTicket.CreatedDate as date) between @startDate and @endDate 
	  and Task.Type=4
    group by 
        TaskTicket.UserId,
        TaskTicket.ClientId,
        cast(TaskTicket.CreatedDate as date)
),

Combined as (
    select distinct  
        COALESCE(Routes.UserId, Actions.UserId)     as UserId,
        COALESCE(Routes.ClientId, Actions.ClientId) as ClientId,
        COALESCE(Routes.Date, Actions.Date)         as Date,

        IIF(Routes.UserId is not null, 1, 0) as IsRoute,

        case 
            when Actions.UserId is not null 
             and Actions.FinalizedDate is not null 
            then 1 else 0 
        end as IsVisited

    from Routes
    full outer join Actions
        on Routes.ClientId = Actions.ClientId
       and Routes.UserId   = Actions.UserId
       and Routes.Date     = Actions.Date 
),

ClientStats as (
    select 
        UserId,
        COUNT(case when IsRoute = 1 then ClientId end) as ClientsOnRoute,
        COUNT(case when IsVisited = 1 and IsRoute = 1 then ClientId end) as VisitedClients
    from Combined
    group by UserId
),

TimeAnalysis as (
    select 
        UserId,

        -- ilk müştəriyə getdiyi vaxt
        MIN(CreatedDate) as StartTime,

        -- son müştəridən çıxış (NULL varsa CreatedDate götürür)
        MAX(COALESCE(FinalizedDate, CreatedDate)) as EndTime,

        -- ümumi iş vaxtı
        DATEDIFF(minute, 
                 MIN(CreatedDate), 
                 MAX(COALESCE(FinalizedDate, CreatedDate))) as TotalWorkTime,

        -- müştəri üzərində keçirdiyi vaxt
        SUM(ActiveTime) as ActiveTime,

        -- boş (passive) vaxt
        DATEDIFF(minute, 
                 MIN(CreatedDate), 
                 MAX(COALESCE(FinalizedDate, CreatedDate)))
        - SUM(ActiveTime) as PassiveTime

    from Actions
    group by UserId
)

    select Users.Id                           as UserId,
           Users.Name + '' '' + Users.Surname as UserFullName,
           UserProfilePhoto.SecureUrl         as UserProfilePictureUrl,
           ClientStats.ClientsOnRoute         as ClientsOnRoute,
           ClientStats.VisitedClients         as VisitedClients,
           TimeAnalysis.StartTime             as StartTime,
           TimeAnalysis.EndTime               as EndTime,
           TimeAnalysis.TotalWorkTime         as TotalTime,
           TimeAnalysis.ActiveTime            as TimeOnClient,
           TimeAnalysis.PassiveTime           as PassiveTime
      from ClientStats
      left join TimeAnalysis         with (nolock) on TimeAnalysis.UserId   = ClientStats.UserId
      left join AbpUsers Users       with (nolock) on Users.Id              = ClientStats.UserId
      left join AbpUserProfilePhoto UserProfilePhoto on Users.Id            = UserProfilePhoto.UserId
    ';

    insert into @Result
        exec sp_executesql @query,
             N'@startDate datetime, @endDate datetime, @userFilterType tinyint,
               @searchReference nvarchar(max), @currentUserId bigint',
             @startDate = @startDate,
             @endDate = @endDate,
             @userFilterType = @userFilterType,
             @searchReference = @searchReference,
             @currentUserId = @currentUserId;

    SET @totalCount = (SELECT COUNT(*)
                       FROM @Result);

    SET @query =
            CONCAT(@query, ' ORDER BY ' + @sorting + ' OFFSET @skipCount ROWS FETCH NEXT @maxResultCount ROWS ONLY');

    exec sp_executesql @query,
         N'@startDate datetime, @endDate datetime, @userFilterType tinyint,
           @searchReference nvarchar(max), @currentUserId bigint,
           @skipCount int, @maxResultCount int, @totalCount INT OUT',
         @startDate = @startDate,
         @endDate = @endDate,
         @userFilterType = @userFilterType,
         @searchReference = @searchReference,
         @currentUserId = @currentUserId,
         @skipCount = @skipCount,
         @maxResultCount = @maxResultCount,
         @totalCount = @totalCount OUT
end;
