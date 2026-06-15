ALTER procedure dbo.SP_WPM_GetPhotoGalleryReport(
    @startDate date,
    @endDate date,
    @firm smallint,
    @userId int,
    @skipCount int,
    @takeCount int,
    @totalImageCount int out
)
As
Begin
    set @totalImageCount = 1;
    declare @Result table
                    (
                        ClientCode          nvarchar(255),
                        ClientName          nvarchar(255),
                        CreatedUserName     nvarchar(255),
                        CreatorUserFullName nvarchar(255),
                        LikeStatus          bit,
                        StarCount           tinyint,
                        PhotoAddress        nvarchar(max),
                        SecureUrl           nvarchar(max),
                        Comment             nvarchar(max),
                        CreationDate        datetime,
                        Reason              nvarchar(255),
                        AttachmentId        int,
                        LikeUserId          bigint,
                        CommentUserId       bigint,
                        StarUserId          bigint,
                        SourceType          int,
                        IsClientOnLocation  tinyint
                    );

    with Data as (select Clients.Code                           as ClientCode,
                         Clients.Name                           as ClientName,
                         Users.UserName                         as CreatedUserName,
                         concat(Users.Name, ' ', Users.Surname) as CreatorUserFullName,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.Url                              as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         2                                      as SourceType,
                         Clients.Longitude                      as ClientLongitude,
                         Clients.Latitude                       as ClientLatitute,
                         Tickets.CreatedLongitude               as OperationLongitude,
                         Tickets.CreatedLatitude                as OperationLatitude
                  from WPM_Attachment Files with (nolock)

                           join WPM_TaskTicketAction Reference with (nolock) on Files.ReferenceId = reference.Id
                           join WPM_TaskTicket Tickets with (nolock) on Tickets.Id = Reference.TaskTicketId
                           join MD_Client Clients with (nolock)
                                on Clients.TigerId = Tickets.ClientId and Clients.Firm = Tickets.Firm and
                                   Clients.Firm = @firm
                           join AbpUsers Users with (nolock) on Users.Id = Tickets.UserId
                           join F_UIM_GetOrganizationTreeUsers(@userId) StructureUsers
                                on StructureUsers.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                           left join MD_PhotoStar Stars with (nolock)
                                     on files.Id = Stars.ReferenceId and Stars.SourceType = 2
                           left join MD_PhotoComment Comments with (nolock)
                                     on files.Id = Comments.ReferenceId and Comments.SourceType = 2
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId

                  where cast(Files.CreatedDate as date) between @startDate and @endDate
                    and Files.Type = 3

                  union all

                  select Clients.Code                           as ClientCode,
                         Clients.Name                           as ClientName,
                         Users.UserName                         as CreatedUserName,
                         concat(Users.Name, ' ', Users.Surname) as CreatorUserFullName,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.Url                              as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         1                                      as SourceType,
                         Clients.Longitude                      as ClientLongitude,
                         Clients.Latitude                       as ClientLatitute,
                         Response.CreatedLongitude              as OperationLongitude,
                         Response.CreatedLatitude               as OperationLatitude
                  from CHL_Attachment Files with (nolock)
                           join CHL_UserSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                           join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
                           join AbpUsers Users with (nolock) on Users.Id = Response.UserId
                           join MD_Client Clients with (nolock)
                                on Clients.TigerId = Response.ClientId and Clients.Firm = Response.Firm and
                                   Clients.Firm = @firm
                           join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                           left join MD_PhotoStar Stars with (nolock)
                                     on Stars.ReferenceId = Files.Id and Stars.SourceType = 1
                           left join MD_PhotoComment Comments with (nolock)
                                     on Comments.ReferenceId = Files.Id and Comments.SourceType = 1
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                  --join SPEC_UserSurveyMapping map on map. SurveyId = Response. SurveyId and Response. UserId = map. UserId
                  where Files.Type = 3
                    and cast(Files.CreatedDate as date) between @startDate and @endDate
                  union all
                  select Clients.Code                           as ClientCode,
                         Clients.Name                           as ClientName,
                         Users.UserName                         as CreatedUserName,
                         concat(Users.Name, ' ', Users.Surname) as CreatorUserFullName,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.Url                              as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         1                                      as SourceType,
                         Clients.Longitude                      as ClientLongitude,
                         Clients.Latitude                       as ClientLatitute,
                         Response.CreatedLongitude              as OperationLongitude,
                         Response.CreatedLatitude               as OperationLatitude
                  from CHL_Attachment Files with (nolock)
                           join CHL_UserDynamicSurveyResponseDetail Reference with (nolock) on Reference.Id = Files.ReferenceId
                           join CHL_UserSurveyResponse Response with (nolock) on Response.Id = UserSurveyResponseId
                           join AbpUsers Users with (nolock) on Users.Id = Response.UserId
                           join MD_Client Clients with (nolock)
                                on Clients.TigerId = Response.ClientId and Clients.Firm = Response.Firm and
                                   Clients.Firm = @firm
                           join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                           left join MD_PhotoStar Stars with (nolock)
                                     on Stars.ReferenceId = Files.Id and Stars.SourceType = 1
                           left join MD_PhotoComment Comments with (nolock)
                                     on Comments.ReferenceId = Files.Id and Comments.SourceType = 1
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                  --join SPEC_UserSurveyMapping map on map. SurveyId = Response. SurveyId and Response. UserId = map. UserId
                  where Files.Type = 3
                    and cast(Files.CreatedDate as date) between @startDate and @endDate

                  union all

                  select Client.Code                                      as ClientCode,
                         Client.Name                                      as ClientName,
                         Users.UserName                                   as CreatedUserName,
                         concat(Users.Name, ' ', Users.Surname)           as CreatorUserFullName,
                         Likes.Status                                     as LikeStatus,
                         Stars.StarCount                                  as StarCount,
                         Files.FilePath                                   as PhotoAddress,
                         Files.SecureUrl                                  as SecureUrl,
                         Comments.Comment                                 as Comment,
                         Files.FileCreatedDate                            as CreationDate,
                         Reasons.Description                              as Reason,
                         Files.Id                                         as AttachmentId,
                         Likes.CreatorUserId                              as LikeUserId,
                         Comments.CreatorUserId                           as CommentUserId,
                         Stars.CreatorUserId                              as StarUserId,
                         case ContentType when 1 then 5 when 2 then 3 end as SourceType,
                         Client.Longitude                                 as ClientLongitude,
                         Client.Latitude                                  as ClientLatitute,
                         Files.Longitude                                  as OperationLongitude,
                         Files.Latitude                                   as OperationLatitude
                  from OP_FileUploadLog Files with (nolock)
                           join MD_Client Client with (nolock)
                                on Client.TigerId = Files.ClientId and Files.Firm = Client.Firm
                           join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
                           join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock) on
                      (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) or -- Visit
                      (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos

                           left join MD_PhotoStar Stars with (nolock) on
                      (Files.Id = Stars.ReferenceId and Files.ContentType = 2 and Stars.SourceType = 3) or -- Visit
                      (Files.Id = Stars.ReferenceId and Files.ContentType = 1 and Stars.SourceType = 5) -- Client photos

                           left join MD_PhotoComment Comments with (nolock) on
                      (Files.Id = Comments.ReferenceId and Files.ContentType = 2 and
                       Comments.SourceType = 3) or -- Visit
                      (Files.Id = Comments.ReferenceId and Files.ContentType = 1 and
                       Comments.SourceType = 5) -- Client photos
                           left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

                  where cast(Files.FileCreatedDate as date) between @startDate and @endDate

                  union all

                  select Client.Code                            as ClientCode,
                         Client.Name                            as ClientName,
                         Users.UserName                         as CreatedUserName,
                         concat(Users.Name, ' ', Users.Surname) as CreatorUserFullName,
                         Likes.Status                           as LikeStatus,
                         Stars.StarCount                        as StarCount,
                         Files.ImagePath                        as PhotoAddress,
                         Files.SecureUrl                        as SecureUrl,
                         Comments.Comment                       as Comment,
                         Files.CreatedDate                      as CreationDate,
                         Reasons.Description                    as Reason,
                         Files.Id                               as AttachmentId,
                         Likes.CreatorUserId                    as LikeUserId,
                         Comments.CreatorUserId                 as CommentUserId,
                         Stars.CreatorUserId                    as StarUserId,
                         4                                      as SourceType,
                         Client.Longitude                       as ClientLongitude,
                         Client.Latitude                        as ClientLatitute,
                         null                                   as OperationLongitude,
                         null                                   as OperationLatitude
                  from IM_InventoryStateHistoryImage Files with (nolock)
                           join IM_InventoryStateHistory History with (nolock)
                                on History.Id = Files.InventoryStateHistoryId
                           join MD_Client Client with (nolock)
                                on Client.TigerId = History.ClientTigerId and History.Firm = Client.Firm
                           join AbpUsers Users with (nolock) on Users.Id = History.CreatorUserId
                           join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = Users.Id
                           left join MD_PhotoLike Likes with (nolock)
                                     on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                           left join MD_PhotoStar Stars with (nolock)
                                     on Stars.ReferenceId = Files.Id and Stars.SourceType = 4
                           left join MD_PhotoComment Comments with (nolock)
                                     on Comments.ReferenceId = Files.Id and Comments.SourceType = 4
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId

                  where cast(Files.CreatedDate as date) between @startDate and @endDate)


    insert
    into @Result
    select ClientCode,
           ClientName,
           CreatedUserName,
           CreatorUserFullName,
           LikeStatus,
           StarCount,
           PhotoAddress,
           SecureUrl,
           Comment,
           CreationDate,
           Reason,
           AttachmentId,
           LikeUserId,
           CommentUserId,
           StarUserId,
           SourceType,
           case
               when
                   round(
                           iif(
                                   ClientLatitute = 0 or ClientLatitute is null OR OperationLatitude = 0 or
                                   OperationLatitude is null,
                                   null,
                                   iif(geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                               geography::Point(OperationLatitude, OperationLongitude, 4326)) < 1, 1,
                                       (geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                               geography::Point(OperationLatitude, OperationLongitude, 4326)))
                                   )
                           ),
                           5
                   ) < 300 then cast(1 as tinyint)
               when round(
                            iif(
                                    ClientLatitute = 0 or ClientLatitute is null OR OperationLatitude = 0 or
                                    OperationLatitude is null,
                                    null,
                                    iif(geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                                geography::Point(OperationLatitude, OperationLongitude, 4326)) < 1, 1,
                                        (geography::Point(ClientLatitute, ClientLongitude, 4326).STDistance(
                                                geography::Point(OperationLatitude, OperationLongitude, 4326)))
                                    )
                            ),
                            5
                    ) > 300 then cast(0 as tinyint)
               else null
               end as IsClientOnLocation

    from Data

    order by CreationDate desc

    set @totalImageCount = (select count(*) from @Result)

    select *
    from @Result
    order by CreationDate desc
    offset @skipCount rows fetch next @takeCount rows only
End
GO