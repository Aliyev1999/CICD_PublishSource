create function [dbo].[F_GetStoriesListByUser](@UserId int, @Firm smallint, @seenByUserId int null)
    returns @Data table
                  (
                      ImageUrl     nvarchar(500),
                      ClientId     int,
                      ClientCode   nvarchar(100),
                      ClientName   nvarchar(500),
                      ClientEdino  nvarchar(100),
                      CreatedDate  datetime,
                      SourceType   int,
                      AttachmentId int,
                      StarCount    int,
                      Comment      nvarchar(MAX),
                      LikeStatus   bit,
                      IsSeen       bit
                  )
as
begin

    -- Date: 21.04.2022
-- Written by TayqaTech (Shahri Yahyayeva) for TayqaSale
-- Description: the query returns table of pictures taken in clients
-- Ticket: TSC-3532

-- Last modified on 10.06.2022 by Kanan Mammadov for additional columns

    insert into @Data (ImageUrl, ClientId, ClientCode, ClientName, ClientEdino, CreatedDate, SourceType, AttachmentId,
                       StarCount, Comment, LikeStatus, IsSeen)
--Workplan ticket actions images
    select Attachments.SecureUrl,
           Clients.TigerId                      as ClientID,
           Clients.Code                         as ClientCode,
           Clients.Name                         as ClientName,
           Clients.Edino                        as ClientEdino,
           Attachments.CreatedDate              as CreatedDate,
           2                                    as SourceType,
           Attachments.Id                       as AttachmentId,
           Stars.StarCount                      as StarCount,
           Comments.Comment                     as Comment,
           Likes.Status                         as LikeStatus,
           iif(StoryLog.ImageUrl is null, 0, 1) as IsSeen -- 0 means image is not seen yet, 1 means image is already seen
    from WPM_Attachment Attachments with (nolock)
             join WPM_TaskTicketAction Action with (nolock) on Attachments.ReferenceId = Action.Id
             join WPM_TaskTicket Ticket with (nolock) on Ticket.Id = Action.TaskTicketId
             join MD_Client Clients with (nolock) on Clients.TigerId = Ticket.ClientId and Clients.Firm = Ticket.Firm
             join AbpUsers Users with (nolock) on Users.Id = Ticket.UserId
             left join (select distinct ImageUrl
                        from MSG_UserStoryLog with (nolock)) StoryLog
                       on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Attachments.SecureUrl
             left join MD_PhotoLike Likes on Likes.ReferenceId = Attachments.Id and Likes.SourceType = 2
             left join MD_PhotoStar Stars on Attachments.Id = Stars.ReferenceId and Stars.SourceType = 2
             left join MD_PhotoComment Comments on Attachments.Id = Comments.ReferenceId and Comments.SourceType = 2
             left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId

    where Users.Id = @UserId
      and Attachments.Type = 3
      and Clients.Firm = @firm
      and Attachments.CreatedDate >= DATEADD(hour, -24, GETDATE())


    union all


--Checklist question answer images

    select Attachments.SecureUrl,
           Clients.TigerId                      as ClientID,
           Clients.Code                         as ClientCode,
           Clients.Name                         as ClientName,
           Clients.Edino                        as ClientEdino,
           Attachments.CreatedDate              as CreatedDate,
           1                                    as SourceType,
           Attachments.Id                       as AttachmentId,
           Stars.StarCount                      as StarCount,
           Comments.Comment                     as Comment,
           Likes.Status                         as LikeStatus,
           iif(StoryLog.ImageUrl is null, 0, 1) as IsSeen -- 0 means image is not seen yet, 1 means image is already seen

    from CHL_Attachment Attachments with (nolock)
             join CHL_UserSurveyResponseDetail ResponseDetail with (nolock)
                  on Attachments.ReferenceId = ResponseDetail.Id
             join CHL_UserSurveyResponse Response with (nolock) on Response.Id = ResponseDetail.UserSurveyResponseId
             join MD_Client Clients with (nolock)
                  on Response.ClientId = Clients.TigerId and Clients.Firm = Response.Firm
             join AbpUsers Users with (nolock) on Users.ID = Response.UserId
             left join (select distinct ImageUrl
                        from MSG_UserStoryLog with (nolock)) StoryLog
                       on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Attachments.SecureUrl
             left join MD_PhotoLike Likes on Likes.ReferenceId = Attachments.Id and Likes.SourceType = 1
             left join MD_PhotoStar Stars on Attachments.Id = Stars.ReferenceId and Stars.SourceType = 1
             left join MD_PhotoComment Comments on Attachments.Id = Comments.ReferenceId and Comments.SourceType = 1
             left join MD_StopReason Reasons on Reasons.Id = Comments.ReasonId
    where Users.Id = @UserId
      and Attachments.Type = 3
      and Clients.Firm = @firm
      and Attachments.CreatedDate >= DATEADD(hour, -24, GETDATE())
    return;
end
go