CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetClientVisits](
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
                                            FileUploadLog.FileName                                                   as FileName,
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
                                              join MD_Client Client with (nolock) on VisitLog.ClientId = Client.TigerId
                                         and VisitLog.Firm = Client.Firm
                                              join AbpUsers Users on Users.Id = VisitLog.CreatedUserId
                                              join F_GetPermittedUsers(@currentUserId) PermittedUsers
                                                   on PermittedUsers.UserId = VisitLog.CreatedUserId
                                              left join AbpUserProfilePhoto UserProfilePhoto with (nolock)
                                                        on Users.Id = UserProfilePhoto.UserId
                                              left join dbo.F_GetStoryUsersDetails(@currentUserId, null) StoryUsersDetails
                                                        on StoryUsersDetails.UserId = Users.Id
											  left join OP_FileUploadLog FileUploadLog
                                                        on FileUploadLog.DocId = VisitLog.DocId and
                                                           FileUploadLog.ContentType = 2
                                                        
                                     where VisitLog.Date between @beginDate and @endDate),
                    VisitCounts as (select CreatedUserId                                               as UserId,
                                           count(ClientId)                                             as ClientCount,
                                           count(Id)                                                   as VisitCount,
                                           count(FileName)                                             as PhotoCount,
                                           cast(sum(datediff(second, Date, CreatedDate)) / 3600 as varchar) + ':' +
                                           format((sum(datediff(second, Date, CreatedDate)) % 3600) / 60, '00') + ':' +
                                           format(sum(datediff(second, Date, CreatedDate)) % 60, '00') as VisitTime
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
                        join VisitCounts on VisitDetails.UserId = VisitCounts.UserId and RowNum = 1)