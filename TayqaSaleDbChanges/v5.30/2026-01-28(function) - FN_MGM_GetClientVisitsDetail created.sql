CREATE OR ALTER FUNCTION [dbo].[FN_MGM_GetClientVisitsDetail](
    @currentUserId int,
    @userId int,
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
                                            Reason.Name                      as Reason,
                                            FileUploadLog.Id                 as PhotoId,
                                            FileUploadLog.SecureUrl          as PhotoUrl,
                                            VisitLog.ClientId                as ClientId,
                                            Visitlog.Date                    as VisitDate,
                                            Visitlog.Note                    as Note
                                     from OP_ClientVisitLog VisitLog with (nolock)
                                              join MD_Client Client with (nolock) on VisitLog.ClientId = Client.TigerId
                                         and VisitLog.Firm = Client.Firm
                                              join AbpUsers Users on Users.Id = VisitLog.CreatedUserId
											  join F_GetPermittedUsers(@currentUserId) PermittedUsers
                                                   on PermittedUsers.UserId = VisitLog.CreatedUserId
                                              left join OP_FileUploadLog FileUploadLog
                                                        on FileUploadLog.DocId = VisitLog.DocId and
                                                           FileUploadLog.ContentType = 2
                                              left join AbpUserProfilePhoto UserProfilePhoto with (nolock)
                                                        on Users.Id = UserProfilePhoto.UserId
                                              left join MD_StopReason Reason on VisitLog.ReasonId = Reason.Id
                                     where (@userId IS NULL OR Users.Id = @userId)
                                       AND VisitLog.Date BETWEEN @beginDate AND @endDate)
   
   SELECT TOP 10000  *
    FROM VisitDetails
    ORDER BY VisitDate desc 

   )