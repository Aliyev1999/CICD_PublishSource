CREATE OR ALTER PROCEDURE [dbo].[SP_MGM_GetUserTracking] @userId BIGINT,
                                                @begin DATETIME2,
                                                @end DATETIME2
AS
BEGIN

    declare @OnlineAndStory table
                            (
                                UserId         bigint,
                                LastSeen       datetime,
                                IsOnline       bit,
                                Latitude       float,
                                Longitude      float,
                                HasStory       bit,
                                HasUnSeenStory bit
                            );

    declare @TreeUsers table
                       (
                           UserId int
                       )

    insert into @TreeUsers (UserId)
    select UserId
    from F_GetPermittedUsers(@userId);

-- Insert Last Online Data
    with LastOnline as (select Data.UserId                                                        as UserId,
                               GpsDate                                                            as LastSeen,
                               cast(iif(datediff(minute, GpsDate, getdate()) <= 30, 1, 0) as bit) as IsOnline,
                               Latitude                                                           as Latitude,
                               Longitude                                                          as Longitude
                        from OP_UserGpsData Data with (nolock)
                                 join @TreeUsers Tree on Tree.UserId = Data.UserId
                        where GpsDate = (select max(GpsDate)
                                         from OP_UserGpsData with (nolock)
                                         where UserId = Data.UserId
                                           and cast(RegisteredDate as date) between @begin and @end)),

         Story as (select Stories.UserId                               as UserId,
                          cast(iif(IsAllStoriesSeen = 1, 0, 1) AS BIT) as HasUnseenStory
                   from F_GetStoryUsersDetails(@userId, 9) Stories
                            join @TreeUsers Permitted on Permitted.UserId = Stories.UserId)

    insert
    into @OnlineAndStory (UserId, LastSeen, IsOnline, Latitude, Longitude, HasStory, HasUnSeenStory)
    select distinct coalesce(LastOnline.UserId, Story.UserId) as UserId,
                    LastOnline.LastSeen                       as LastSeen,
                    LastOnline.IsOnline                       as IsOnline,
                    LastOnline.Latitude                       as Latitude,
                    LastOnline.Longitude                      as Longitude,
                    iif(Story.UserId is not null, 1, 0)       as HasStory,
                    Story.HasUnseenStory                      as HasUnSeenStory
    from LastOnline
             full outer join Story on Story.UserId = LastOnline.UserId;
------------------------------------------------------------------------------------------------------------------------------

    with Routes as (select Routes.UserId as UserId, Routes.TigerClientId as ClientId, Routes.Date
                    from MD_Route Routes with (nolock)
                             join @TreeUsers Permitted on Permitted.UserId = Routes.UserId
                    where Routes.Date between @begin and @end
                      and Routes.Status = 0),

         Actions as (select Logs.UserId as UserId, Logs.ClientId, Logs.ProcessDate as Date
                     from OP_IncomingLog Logs with (nolock)
                              join @TreeUsers Permitted on Permitted.UserId = Logs.UserId
                     WHERE cast(COALESCE(Logs.RegisteredDate, Logs.ProcessDate) AS date) BETWEEN @begin AND @end
                       and DocType <> 26
                       and logs.ClientId <> 0

                     union
                     select Logs.CreatedUserId             as UserId,
                            Logs.ClientId                  as ClientId,
                            cast(Logs.CreatedDate as date) as Date
                     from OP_ClientVisitLog Logs with (nolock)
                              join @TreeUsers Permitted on Permitted.UserId = Logs.CreatedUserId
                     where cast(Logs.CreatedDate as date) between @begin and @end

                     union
                     select Logs.CreatorUserId, Logs.ClientTigerId as ClientId, cast(Logs.CreatedDate as date) as Date
                     from IM_InventoryStateHistory Logs with (nolock)
                              join @TreeUsers Permitted on Permitted.UserId = Logs.CreatorUserId
                     where cast(Logs.CreatedDate as date) between @begin and @end

                     union
                     select Logs.UserId, Logs.ClientId as ClientId, cast(Logs.CreatedDate as date) as Date
                     from WPM_TaskTicket Logs with (nolock)
                              join @TreeUsers Permitted on Permitted.UserId = Logs.UserId
                     where cast(Logs.CreatedDate as date) between @begin and @end

                     union
                     select Logs.UserId, Logs.ClientId as ClientId, cast(Logs.CreatedDate as date) as Date
                     from CHL_UserSurveyResponse Logs with (nolock)
                              join @TreeUsers Permitted on Permitted.UserId = Logs.UserId
                     where cast(Logs.CreatedDate as date) between @begin and @end

--                      union
--                      select Logs.CreatedUserId, Logs.ClientId as ClientId, cast(Logs.CreatedDate as date) as Date
--                      from AO_AuditOperation Logs with (nolock)
--                               join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Logs.CreatedUserId
--                      where cast(Logs.CreatedDate as date) between @begin and @end
         ),

         Combined as (select coalesce(Routes.UserId, Actions.UserId)     as UserId,
                             coalesce(Routes.ClientId, Actions.ClientId) as ClientId,
                             coalesce(Routes.Date, Actions.Date)         as Date,
                             iif(Routes.UserId is not null, 1, 0)        as IsRoute,
                             iif(Actions.UserId is not null, 1, 0)       as IsVisited
                      from Routes
                               full outer join Actions on Actions.ClientId = Routes.ClientId and
                                                          Actions.UserId = Routes.UserId and
                                                          Actions.Date = Routes.Date),

         VisitTotal as (select UserId                                        as UserId,
                               sum(IsRoute)                                  as Planned,
                               sum(iif(IsRoute = 1 and IsVisited = 1, 1, 0)) as InRouteVisit,
                               sum(iif(IsRoute = 0 and IsVisited = 1, 1, 0)) as NonRouteVisit
                        from Combined
                        group by UserId),

         Result as (select coalesce(VisitTotal.UserId, OnlineAndStory.UserId) as UserId,
                           OnlineAndStory.LastSeen                            as LastSeen,
                           isnull(Planned, 0)                                 as Planned,
                           isnull(InRouteVisit, 0)                            as InRouteVisit,
                           isnull(NonRouteVisit, 0)                           as NonRouteVisit,
                           isnull(HasStory, 0)                                as HasStory,
                           isnull(HasUnSeenStory, 0)                          as HasUnseenStory,
                           isnull(IsOnline, 0)                                as IsOnline,
                           OnlineAndStory.Latitude                            as Latitude,
                           OnlineAndStory.Longitude                           as Longitude

                    from VisitTotal
                             full outer join @OnlineAndStory OnlineAndStory
                                             on OnlineAndStory.UserId = VisitTotal.UserId)

    select Users.Id                         as UserId,
           Users.UserName                   as UserName,
           Users.Name + ' ' + Users.Surname as UserFullName,
           isnull(Planned, 0)               as Planned,
           isnull(InRouteVisit, 0)          as InRouteVisit,
           isnull(NonRouteVisit, 0)         as NonRouteVisit,
           isnull(HasStory, 0)              as HasStory,
           isnull(HasUnSeenStory, 0)        as HasUnseenStory,
           isnull(IsOnline, 0)              as IsOnline,
           Photo.SecureUrl                  as Image,
           Result.IsOnline,
           Result.Latitude,
           Result.Longitude,
           LastSeen
    from @TreeUsers Tree
             join AbpUsers Users with (nolock) on Users.Id = Tree.UserId and Users.IsDeleted = 0 and Users.IsActive = 1
             left join Result on Result.UserId = Tree.UserId
             left join AbpUserProfilePhoto Photo with (nolock) on Photo.UserId = Users.Id
END;