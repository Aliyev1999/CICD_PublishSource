create or alter function  [dbo].[FN_MGM_GetClientVisits](
    @currentUserId int,
    @beginDate datetime,
    @endDate datetime
    )
    returns table
        as
        return(with VisitDetails as (select Visitlog.Id                                                         as Id,
                                            Visitlog.ClientId                                                   as ClientId,
                                            VisitLog.CreatedUserId                                              as CreatedUserId,
                                            VisitLog.Date                                                       as Date,
                                            VisitLog.CreatedDate                                                as CreatedDate,
                                            (select count(*)
                                             from OP_FileUploadLog
                                             where DocId = VisitLog.DocId
                                               and ContentType = 2)                                             as PhotoCount,
                                            Users.Id                                                            as UserId,
                                            Users.Name + ' ' + Users.Surname                                    as FullName,
                                            Users.Username                                                      as UserName,
                                            UserProfilePhoto.SecureUrl                                          as ProfileUrl,
                                            case
                                                when StoryUsersDetails.IsAllStoriesSeen = 0 then 1
                                                when StoryUsersDetails.IsAllStoriesSeen = 1 then 2
                                                else 0
                                                end                                                             as StoryStatus,
                                            row_number() over (partition by Users.Id order by VisitLog.Id desc) as RowNum
                                     from OP_ClientVisitLog VisitLog with (nolock)
                                              join MD_Client Client with (nolock)
                                                   on VisitLog.ClientId = Client.TigerId
                                                       and VisitLog.Firm = Client.Firm
                                              join AbpUsers Users
                                                   on Users.Id = VisitLog.CreatedUserId
                                              join F_GetPermittedUsers(@currentUserId) PermittedUsers
                                                   on PermittedUsers.UserId = VisitLog.CreatedUserId
                                              left join AbpUserProfilePhoto UserProfilePhoto with (nolock)
                                                        on Users.Id = UserProfilePhoto.UserId
                                              left join dbo.F_GetStoryUsersDetails(@currentUserId, null) StoryUsersDetails
                                                        on StoryUsersDetails.UserId = Users.Id
                                     where VisitLog.Date between @beginDate and @endDate),
                    VisitCounts as (select CreatedUserId            as UserId,
                                           count(distinct ClientId) as ClientCount,
                                           count(Id)                as VisitCount,
                                           sum(PhotoCount)          as PhotoCount,
                                           case
                                               when SUM(DATEDIFF(SECOND, Date, CreatedDate)) < 0 then '00:00:00'
                                               else
                                                   RIGHT('0' +
                                                         CAST(SUM(DATEDIFF(SECOND, Date, CreatedDate)) / 3600 as varchar),
                                                         2) + ':' +
                                                   RIGHT('0' +
                                                         CAST((SUM(DATEDIFF(SECOND, Date, CreatedDate)) % 3600) / 60 as varchar),
                                                         2) + ':' +
                                                   RIGHT('0' +
                                                         CAST(SUM(DATEDIFF(SECOND, Date, CreatedDate)) % 60 as varchar),
                                                         2)
                                               end                  as VisitTime
                                    from VisitDetails
                                    group by CreatedUserId)
               select VisitDetails.UserId,
                      VisitDetails.FullName,
                      VisitDetails.UserName,
                      VisitDetails.ProfileUrl,
                      VisitDetails.StoryStatus,
                      VisitCounts.ClientCount,
                      VisitCounts.VisitCount,
                      VisitCounts.PhotoCount,
                      VisitCounts.VisitTime
               from VisitDetails
                        join VisitCounts on VisitDetails.UserId = VisitCounts.UserId and VisitDetails.RowNum = 1)