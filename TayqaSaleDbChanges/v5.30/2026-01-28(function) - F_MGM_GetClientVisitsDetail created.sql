CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetClientVisitsDetail](
    @currentUserId int,
    @beginDate datetime,
    @endDate datetime
    )
    returns table
        as
        return(with VisitDetails as (select Visitlog.Id                      as Id,
                                            Visitlog.CreatedUserId           as UserId,
                                            Users.name + ' ' + Users.surname as UserFullName,
                                            Users.username                   as UserName,
                                            UserProfilePhoto.SecureUrl       as UserProfileUrl,
                                            Client.Name                      as ClientName,
                                            Client.Code                      as ClientCode,
                                            VisitLog.Date                    as Date,
                                            Reason.Name                      as Reason,
                                            FileUploadLog.Id                 as PhotoId,
                                            FileUploadLog.SecureUrl          as PhotoUrl,
                                            VisitLog.ClientId                as ClientId,
                                            Visitlog.FileName                as FileName,
                                            Visitlog.Date                    as VisitDate,
                                            VisitLog.CreatedDate             as CreatedDate
                                     from OP_ClientVisitLog VisitLog with (nolock)
                                              join MD_Client Client with (nolock) on VisitLog.ClientId = Client.TigerId
                                         and VisitLog.Firm = Client.Firm
                                              join AbpUsers Users on Users.Id = VisitLog.CreatedUserId
                                              left join OP_FileUploadLog FileUploadLog
                                                        on FileUploadLog.UploadedUserId = VisitLog.CreatedUserId and
                                                           FileUploadLog.ContentType = 2
                                                            and FileUploadLog.ClientId = VisitLog.ClientId and
                                                           FileUploadLog.Firm = VisitLog.Firm
                                              left join AbpUserProfilePhoto UserProfilePhoto with (nolock)
                                                        on Users.Id = UserProfilePhoto.UserId
                                              left join dbo.F_GetStoryUsersDetails(@currentUserId, NULL) StoryUsersDetails
                                                        on StoryUsersDetails.UserId = Users.Id
                                              left join MD_StopReason Reason on VisitLog.ReasonId = Reason.Id
                                     where Users.Id = @currentUserId
                                       AND VisitLog.Date BETWEEN @beginDate AND @endDate)
                  , VisitCounts as (select UserId                                                           as UserId,
                                           count(ClientId)                                                  as ClientCount,
                                           count(Id)                                                        as VisitCount,
                                           count(FileName)                                                  as PhotoCount,
                                           cast(sum(datediff(second, VisitDate, CreatedDate)) / 3600 as varchar) + ':' +
                                           format((sum(datediff(second, VisitDate, CreatedDate)) % 3600) / 60, '00') +
                                           ':' +
                                           format(sum(datediff(second, VisitDate, CreatedDate)) % 60, '00') as VisitTime
                                    from VisitDetails
                                    group by UserId)
               select VisitCounts.ClientCount,
                      VisitCounts.VisitCount,
                      VisitCounts.PhotoCount,
                      VisitCounts.VisitTime,
                      VisitDetails.Id,
                      VisitDetails.UserFullName,
                      VisitDetails.UserName,
                      VisitDetails.UserProfileUrl,
                      VisitDetails.ClientName,
                      VisitDetails.ClientCode,
                      VisitDetails.VisitDate,
                      VisitDetails.Reason,
                      VisitDetails.PhotoId,
                      VisitDetails.PhotoUrl
               from VisitDetails
                        join VisitCounts on VisitDetails.UserId = VisitCounts.UserId)
