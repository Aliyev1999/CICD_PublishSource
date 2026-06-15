ALTER function [dbo].[F_GetStoryUsersDetails](@userId int, @firm smallint)
    returns @Result table
                    (
                        UserId           int,
                        Username         nvarchar(100),
                        ProfileImage     nvarchar(500),
                        IsAllStoriesSeen bit,
                        PhoneNumber      nvarchar(15)
                    )
as
begin

    -- Date: 22.04.2022
-- Written by TayqaTech (Fidan Bakhshizade & Shahri Yahyayeva) for TayqaSale
-- Description: the query returns table of users with details (if all stories are seen)
-- Ticket: TSC-3537

    insert into @Result (UserId, Username, ProfileImage, IsAllStoriesSeen, PhoneNumber)

    select Users.Id                                          as UserId,
           Users.UserName                                    as Username,
           ProfilePhoto.SecureUrl                            as ProfileImage,
           iif(count(iif(ImageSeen = 0, 1, null)) > 0, 0, 1) as IsAllStoriesSeen,
           Users.PhoneNumber                                 as PhoneNumber
    from (

-- Checklist question answer images
             select Response.UserId                  as UserId,
                    iif(Logs.ImageURL is null, 0, 1) as ImageSeen -- 0 means image is not seen yet, 1 means image is already seen,
             from CHL_Attachment Attached with (nolock)
                      join CHL_UserSurveyResponseDetail Details with (nolock) on Attached.ReferenceId = Details.Id
                      join CHL_UserSurveyResponse Response with (nolock) on Details.UserSurveyResponseId = Response.Id
                      join F_UIM_GetOrganizationTreeUsers(@UserId) Users
                           on Users.UserId = Response.UserId -- Filters organizational structure users
                      left join MSG_UserStoryLog Logs with (nolock)
                                on Attached.SecureUrl = Logs.ImageUrl collate Azeri_Latin_100_CI_AS
                                    and Logs.SeenByUserId =
                                        @UserId -- Last join confition means is required to filter by only the logged in user
             where Attached.Type = 3
               and Response.Firm = @firm
               and Attached.CreatedDate >= DATEADD(HOUR,-24,GETDATE())

             union all

-- Workplan ticket actions images
             select Ticket.UserId                    as UserId,
                    iif(Logs.ImageURL is null, 0, 1) as ImageSeen -- 0 means image is not seen yet, 1 means image is already seen
             from WPM_Attachment Attached with (nolock)
                      join WPM_TaskTicketAction Actions with (nolock) on Attached.ReferenceId = Actions.Id
                      join WPM_TaskTicket Ticket with (nolock) on Ticket.Id = Actions.TaskTicketId
                      join F_UIM_GetOrganizationTreeUsers(@UserId) Users
                           on Users.UserId = Ticket.UserId -- Filters organizational structure users
                      left join MSG_UserStoryLog Logs with (nolock)
                                on Attached.SecureUrl = Logs.ImageUrl collate Azeri_Latin_100_CI_AS
                                    and Logs.SeenByUserId =
                                        @UserId -- Last join confition means is required to filter by only the logged in user
             where Attached.Type = 3
               and Ticket.Firm = @firm
               and Attached.CreatedDate >= DATEADD(HOUR,-24,GETDATE())


               --Photos from Visit Operation
             union all
             Select Files.UploadedUserId                 as UserId,
                    iif(StoryLog.ImageURL is null, 0, 1) as ImageSeen -- 0 means image is not seen yet, 1 means image is already seen
             from OP_FileUploadLog Files with (nolock)
                      join MD_Client Clients with (nolock) on Files.Firm = Clients.Firm and Clients.TigerId = Files.ClientId
                      join F_UIM_GetOrganizationTreeUsers(@userId) StructureUsers on StructureUsers.UserId = Files.UploadedUserId
                      left join (select distinct ImageUrl
                                 from MSG_UserStoryLog with (nolock)) StoryLog
                                on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Files.SecureUrl
             where Files.ContentType = 2
               and Files.Firm = @firm
               and Files.FileCreatedDate >= DATEADD(HOUR,-24,GETDATE())


--Photos From Clients
             union all
             select Files.UploadedUserID                 as UserId,
                    iif(StoryLog.ImageURL is null, 0, 1) as ImageSeen -- 0 means image is not seen yet, 1 means image is already seen,
             from OP_FileUploadLog Files with (nolock)
                      join MD_Client Clients with (nolock) on Files.Firm = Clients.Firm and Clients.TigerId = Files.ClientId
                      join F_UIM_GetOrganizationTreeUsers(@userId) StructureUsers on StructureUsers.UserId = Files.UploadedUserId
                      left join (select distinct ImageUrl
                                 from MSG_UserStoryLog with (nolock)) StoryLog
                                on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Files.SecureUrl
             where Files.ContentType = 1
               and Clients.Firm = @firm
               and Files.FileCreatedDate >=DATEADD(HOUR,-24,GETDATE())
               --Photos from Inventory
             union all
             select History.CreatorUserId                as UserId,
                    iif(StoryLog.ImageURL is null, 0, 1) as ImageSeen -- 0 means image is not seen yet, 1 means image is already seen
             from IM_InventoryStateHistoryImage Files with (nolock)
                      join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                      join MD_Client Clients with (nolock)
                           on Clients.TigerId = History.ClientTigerId and History.Firm = Clients.Firm
                      join F_UIM_GetOrganizationTreeUsers(@userId) StructureUsers on StructureUsers.UserId = History.CreatorUserId
                      left join (select distinct ImageUrl
                                 from MSG_UserStoryLog with (nolock)) StoryLog
                                on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Files.SecureUrl
             where Clients.Firm = @firm
               and Files.CreatedDate >= DATEADD(HOUR,-24,GETDATE())) t
             join AbpUsers Users on Users.Id = t.UserId and Users.IsDeleted = 0
             left join AbpUserProfilePhoto ProfilePhoto on ProfilePhoto.UserId = Users.Id
    group by Users.Id, Users.UserName, ProfilePhoto.SecureUrl, Users.PhoneNumber

    return
end
