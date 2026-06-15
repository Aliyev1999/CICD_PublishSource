ALTER procedure [dbo].[SP_RM_GetPhotoData](@userId int,
                                           @firm smallint,
                                           @beginDate datetime,
                                           @endDate datetime,
                                           @viewMode tinyint=1)
AS
BEGIN

-- Last modified by Kanan Mammadov to enable hierarchy of hybrid user

    select isnull(sum(iif(Likes.Status = 1, 1, 0)), 0)                                                                 as LikedPhotos,
           isnull(sum(iif(Likes.Status = 0, 1, 0)), 0)                                                                 as DislikedPhotos,
           count(Files.Id) - isnull(sum(iif(Likes.Status = 0, 1, 0)), 0) - isnull(sum(iif(Likes.Status = 1, 1, 0)), 0) as UnseenPhotos
    from MD_PhotoLike Likes with (nolock)
             right join (select WPM.Id as Id, 2 as SourceType
                         from WPM_Attachment WPM with (nolock)
                                  left join WPM_TaskTicketAction Actions with (nolock) on Actions.Id = WPM.ReferenceId and WPM.Type = 3
                                  left join WPM_TaskTicket Tickets with (nolock) on Tickets.Id = Actions.TaskTicketId
                                  left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Tickets.UserId
                         where ((@viewMode = 1 and Tickets.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                           and Tickets.Firm = @firm
                           and cast(Tickets.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)

                         union all
                         select CHL.Id as Id, 1 as SourceType
                         from CHL_Attachment CHL with (nolock)
                                  left join CHL_UserSurveyResponseDetail Answers with (nolock) on Answers.Id = CHL.ReferenceId and CHL.Type = 3
                                  left join CHL_UserSurveyResponse Response on Response.Id = Answers.UserSurveyResponseId
                                  left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Response.UserId
                         where ((@viewMode = 1 and Response.UserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                           and Response.Firm = @firm
                           and cast(Response.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)

                         union all
                         select imag.Id as Id, 4 as SourceType
                         from IM_InventoryStateHistoryImage imag
                                  join IM_InventoryStateHistory history on imag.InventoryStateHistoryId = history.Id
                                  left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = history.CreatorUserId
                         where ((@viewMode = 1 and history.CreatorUserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                           and history.Firm = @Firm
                           and cast(imag.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)
                           and history.StateHistoryType in (1, 2)

                         union all
                         select lo.Id as Id, case ContentType when 1 then 5 when 2 then 3 end as SourceType
                         from OP_FileUploadLog lo
                                  left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = lo.UploadedUserId
                         where ((@viewMode = 1 and lo.UploadedUserId = @userId) or (@viewMode = 2 and TreeUsers.UserId is not null))
                           and lo.Firm = @Firm
                           and ContentType in (1, 2)
                           and cast(lo.FileCreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date)) Files
                        on Likes.ReferenceId = Files.Id and Likes.SourceType = Files.SourceType
END;