
CREATE OR ALTER FUNCTION [dbo].[FN_WPM_GetGeneralAnalysisCardsData](
    @startDate DATETIME2,
    @endDate DATETIME2,
    @userFilterType INT,
    @searchReference NVARCHAR(MAX),
    @currentUserId BIGINT
    )
    RETURNS @Result TABLE
                    (
                        Title          VARCHAR(50),
                        MainValue      DECIMAL(18, 2),
                        SecondaryValue DECIMAL(18, 2)
                    )
    as
    begin
        declare @previousStartDate datetime2 = dateadd(day, -datediff(day, @startDate, @endDate) - 1, @startDate);
        declare @previousendDate datetime2 = dateadd(day, -1, @startDate);

        declare @TreeUsers table
                           (
                               UserId int
                           );

-- İstifadəçi filtrasiyası
        if @searchReference is not null and LEN(LTRIM(RTRIM(@searchReference))) > 0
            begin
                -- User-based filter
                if @userFilterType = 1
                    begin
                        insert into @TreeUsers (UserId)
                        select Users.Id
                        from F_GetPermittedUsers(@currentUserId) TreeUsers
                                 join AbpUsers Users with (nolock)
                                      on Users.Id = TreeUsers.UserId
                        where Users.Id IN (select try_cast(value as INT)
                                           from string_split(@searchReference, ','))
                          and Users.IsDeleted = 0
                          and Users.IsActive = 1;
                    end
                    -- Group-based filter
                ELSE
                    IF @userFilterType = 2
                        begin
                            insert into @TreeUsers (UserId)
                            select distinct UserGroupMapping.UserId
                            from F_GetPermittedUsers(@currentUserId) TreeUsers
                                     join MD_UserGroupMapping UserGroupMapping with (nolock)
                                          on UserGroupMapping.UserId = TreeUsers.UserId
                            where UserGroupMapping.GroupId IN (select try_cast(value as INT)
                                                               from string_split(@searchReference, ','));
                        end
            end
        ELSE
            begin
                -- Əgər searchReference null və ya boşdursa, bütün permitted users əlavə et
                insert into @TreeUsers(UserId)
                select UserId
                from F_GetPermittedUsers(@currentUserId);
            end;
        WITH Routes as
                 (select Routes.UserId, Routes.TigerClientId as ClientId, Routes.Date
                  from MD_Route Routes with (nolock)
                           join @TreeUsers Permitted on Permitted.UserId = Routes.UserId
                  where Routes.Date between @previousStartDate and @endDate
                    and Routes.Status = 0),

             Actions as
                 (select TaskTicket.UserId                       as UserId,
                         TaskTicket.ClientId                     as ClientId,
                         cast(TaskTicket.CreatedDate as DATE)    as Date,
                         DATEDIFF(Minute, TaskTicket.CreatedDate,
                                  IIF(TaskTicket.FinalizedDate is null, TaskTicket.CreatedDate,
                                      TaskTicket.FinalizedDate)) as TimeSpentMinutes,
                         TaskTicket.FinalizedDate
                  from WPM_TaskTicket TaskTicket with (nolock)
                           join @TreeUsers Permitted on Permitted.UserId = TaskTicket.UserId
						   join  WPM_Task Task with (nolock)   on TaskTicket.TaskId=Task.Id and TaskTicket.Firm=Task.Firm
                  where cast(TaskTicket.CreatedDate as date) between @previousStartDate and @endDate
				    and Task.Type=4),

             Combined as
                 (select distinct coalesce(Routes.UserId, Actions.UserId)     as UserId,
                                  coalesce(Routes.ClientId, Actions.ClientId) as ClientId,
                                  coalesce(Routes.Date, Actions.Date)         as Date,
                                  iif(Routes.UserId IS NOT NULL, 1, 0)        as IsRoute,
                                    case when Actions.UserId is not null  Then 1 else 0  end        as IsVisited,
                                  iif(coalesce(Routes.Date, Actions.Date) between @startDate and @endDate, 1,
                                      0)                                      as IsCurrentPeriod,
                                  iif(
                                          coalesce(Routes.Date, Actions.Date) between @previousStartDate and @previousendDate,
                                          1,
                                          0)                                  as IsPreviousPeriod
                  from Routes
                           full outer join Actions
                                           on Routes.ClientId = Actions.ClientId
                                               and Routes.UserId = Actions.UserId
                                               and Routes.Date = Actions.Date),
             VisitTotal as (select
                                -- Mövcud hesablamalar
                                sum(iif(IsRoute = 1 and IsVisited = 1 and IsCurrentPeriod = 1, 1, 0))  as InRouteVisit_Current,

                                sum(iif(IsRoute = 1 and IsCurrentPeriod = 1, 1, 0))                    as Planned_Current,

                                sum(iif(IsRoute = 1 and IsVisited = 1 and IsPreviousPeriod = 1, 1, 0)) as InRouteVisit_Previous,

                                sum(iif(IsRoute = 1 and IsPreviousPeriod = 1, 1, 0))                   as Planned_Previous

                            -- -- Route üzrə ziyarət edib amma tapşırıq bitirməyən (cari period)
                            -- isnull(sum(iif( IsCurrentPeriod = 1
                            --             and FinalizedDate IS NULL,
                            --         1,
                            --         0))  ,0)                                                       as CompletedClientsCurrent,

                            --isnull(sum(iif(IsPreviousPeriod = 1
                            --             and FinalizedDate IS  NULL,
                            --         1,
                            --         0))  ,0)                                                       as CompletedClientsPrevious


                            from Combined),


             RouteCompletion as
                 (select Isnull(cast(iif(Planned_Current = 0, 0, (InRouteVisit_Current * 100) /
                                                                 Planned_Current) as INT), 0) as PlanCompletion_Current,
                         isnull(cast(iif(Planned_Previous = 0, 0, (InRouteVisit_Previous * 100) /
                                                                  Planned_Previous) as INT),
                                0)                                                            as PlanCompletion_Previous
                  from VisitTotal),
-----2,3.activefields--pendingtargets
             EmployeeStats as (select


                                   -- Tapşırığı bitirənlər
                                   COUNT(DISTINCT IIF(Tickets.FinalizedDate IS NOT NULL
                                                          AND Tickets.CreatedDate between @startDate
                                                          AND @endDate,
                                                      Tickets.UserId, NULL))   AS CompletedEmployees,

                                   -- Bütün işçilər
                                   count(distinct UserTask.UserId)             as TotalEmployees,
                                   count(distinct case
                                                      when Tickets.CreatedDate between @StartDate and @EndDate and
                                                           Tickets.FinalizedDate is null and tasks.type = 4
                                                          then Tickets.Id end) as CompletedClientsCurrent,
                                   count(distinct case
                                                      when
                                                          Tickets.CreatedDate between @previousStartDate and @previousendDate and
                                                          Tickets.FinalizedDate is null and tasks.type = 4
                                                          then Tickets.Id end) as CompletedClientsPrevious
                               from WPM_UserTask UserTask with (nolock)
                                        join WPM_Task Tasks with (nolock)
                                             on Tasks.Id = UserTask.TaskId
                                                 and Tasks.IsDeleted = 0
                                        join WPM_TaskSchedule Schedule with (nolock)
                                             on Schedule.TaskId = Tasks.Id
                                        join @TreeUsers Users
                                             on Users.UserId = UserTask.UserId
                                        LEFT join WPM_TaskTicket Tickets with (nolock)
                                                  on Tickets.UserId = UserTask.UserId
                                                      and Tickets.TaskId = Tasks.Id
                               where UserTask.Status = 0
                                 and Schedule.StartDate < DATEADD(DAY, 1, @endDate)
                                 and Schedule.endDate >= @startDate),
             -- 4. average tıme on sıte
             TimeStats
                 as (SELECT CAST(
                                    ISNULL(
                                            AVG(CurrentTime), 0
                                    ) AS DECIMAL(18, 2)
                            ) AS CurrentAvgTime_Minutes,

                            CAST(
                                    ISNULL(
                                            AVG(PreviousTime), 0
                                    ) AS DECIMAL(18, 2)
                            ) AS PreviousAvgTime_Minutes
                     FROM (SELECT ClientId,
                                  SUM(CASE
                                          WHEN Date BETWEEN @startDate AND @endDate THEN TimeSpentMinutes
                                          ELSE 0 END) AS CurrentTime,
                                  SUM(CASE
                                          WHEN Date BETWEEN @previousStartDate AND @previousendDate
                                              THEN TimeSpentMinutes
                                          ELSE 0 END) AS PreviousTime
                           FROM Actions
                           GROUP BY ClientId) t)
--------Rut tamamlanma faizi
        insert
        into @Result (Title, MainValue, SecondaryValue)

        SELECT 'RouteCompletion'                                                 AS Title,
               CAST(PlanCompletion_Current AS DECIMAL)                           AS MainValue,
               CAST(PlanCompletion_Current - PlanCompletion_Previous AS DECIMAL) AS SecondaryValue
        FROM RouteCompletion

        UNION ALL

-- ActiveFieldAgents
        SELECT 'ActiveFieldAgents'                 AS Title,
               CAST(CompletedEmployees AS DECIMAL) AS MainValue,
               CAST(TotalEmployees AS DECIMAL)     AS SecondaryValue
        FROM EmployeeStats

        UNION ALL

-- PendingTickets
        SELECT 'PendingTickets'                          AS Title,
               CAST(CompletedClientsCurrent AS DECIMAL)  AS MainValue,
               CAST(CompletedClientsPrevious AS DECIMAL) AS SecondaryValue
        FROM EmployeeStats

        UNION ALL

-- AverageTimeOnSite
        SELECT 'AverageTimeOnSite'                                               AS Title,
               CAST(CurrentAvgTime_Minutes AS DECIMAL)                           AS MainValue,
               CAST(CurrentAvgTime_Minutes - PreviousAvgTime_Minutes AS DECIMAL) AS SecondaryValue
        FROM TimeStats;
        return;
    end;
    