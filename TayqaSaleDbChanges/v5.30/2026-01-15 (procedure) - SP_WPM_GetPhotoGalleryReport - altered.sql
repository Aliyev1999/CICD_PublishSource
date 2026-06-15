
create or alter  procedure [dbo].[SP_WPM_GetPhotoGalleryReport](
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
                         Reasons.Name                    as Reason,
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
						  left join WPM_TaskAction actions with (nolock) on actions.Id=Reference.ActionId
                           join WPM_TaskTicket Tickets with (nolock) on Tickets.Id = Reference.TaskTicketId
                           join MD_Client Clients with (nolock)
                                on Clients.TigerId = Tickets.ClientId and Clients.Firm = Tickets.Firm and
                                   Clients.Firm = @firm
                           join AbpUsers Users with (nolock) on Users.Id = Tickets.UserId
                           join F_UIM_GetOrganizationTreeUsers(@userId) StructureUsers
                                on StructureUsers.UserId = Users.Id
                            OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoLike WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 2
                       ORDER BY CreationTime DESC
                   ) Likes
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 2
                   OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoComment WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 2
                       ORDER BY CreationTime DESC
                   ) Comments
                           left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId

                  where cast(Files.CreatedDate as date) between @startDate and @endDate
                    and Files.Type = 3 and actions.ActionType not in (2,49,50)

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
                         Reasons.Name                    as Reason,
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
                                OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoLike WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 1
                       ORDER BY CreationTime DESC
                   ) Likes
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 1
                   OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoComment WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 1
                       ORDER BY CreationTime DESC
                   ) Comments
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
                         Reasons.Name                    as Reason,
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
                                OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoLike WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 1
                       ORDER BY CreationTime DESC
                   ) Likes
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 1
                   OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoComment WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 1
                       ORDER BY CreationTime DESC
                   ) Comments
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
                         Reasons.Name                              as Reason,
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
						         OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoLike WITH (NOLOCK)
                       WHERE (ReferenceId = Files.Id AND SourceType = 3 and Files.ContentType = 2) or -- Visit
							 (ReferenceId = Files.Id AND SourceType = 5 and Files.ContentType = 1) -- Client photos
                       ORDER BY CreationTime DESC
                   ) Likes
                   left join MD_PhotoStar Stars on (files.Id = Stars.ReferenceId and Stars.SourceType = 3 and Files.ContentType = 2) or -- Visit
													(files.Id = Stars.ReferenceId and Stars.SourceType = 5 and Files.ContentType = 1) -- Client photos
                   OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoComment WITH (NOLOCK)
                       WHERE (ReferenceId = Files.Id AND SourceType = 3 and Files.ContentType = 2) or  -- Visit
							 (ReferenceId = Files.Id AND SourceType = 5 and Files.ContentType = 1) -- Client photos
                       ORDER BY CreationTime DESC
                   ) Comments
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
                         Reasons.Name                    as Reason,
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
                                 OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoLike WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 4
                       ORDER BY CreationTime DESC
                   ) Likes
                   left join MD_PhotoStar Stars on files.Id = Stars.ReferenceId and Stars.SourceType = 4
                   OUTER APPLY (
                       SELECT TOP 1 *
                       FROM MD_PhotoComment WITH (NOLOCK)
                       WHERE ReferenceId = Files.Id AND SourceType = 4
                       ORDER BY CreationTime DESC
                   ) Comments
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