CREATE OR  ALTER   function [dbo].[F_MGM_GetStories](@userId int)
    returns @Result table
                    (
                        UserId           int,
                        UserFullName         nvarchar(100),
                        ProfilePhoto     nvarchar(500),
                        HasUnseenStory bit
                    )
as
begin

    insert into @Result (UserId, UserFullName, ProfilePhoto, HasUnseenStory)

    select Users.Id                                          as UserId,
           CONCAT(Users.Name, ' ', Users.Surname)            as UserFullName,
           ProfilePhoto.SecureUrl                            as ProfilePhoto,
		   iif(count(iif(ImageSeen = 0, 1, null)) > 0, 1, 0) as HasUnseenStory

    from (

-- Checklist question answer images
             select Response.UserId                  as UserId,
                    iif(Logs.ImageURL is null, 0, 1) as ImageSeen -- 0 means image is not seen yet, 1 means image is already seen,
             from CHL_Attachment Attached with (nolock)
                      join CHL_UserSurveyResponseDetail Details with (nolock) on Attached.ReferenceId = Details.Id
                      join CHL_UserSurveyResponse Response with (nolock) on Details.UserSurveyResponseId = Response.Id
                      join F_GetPermittedUsers (@UserId) Users
                           on Users.UserId = Response.UserId -- Filters organizational structure users
                      left join MSG_UserStoryLog Logs with (nolock)
                                on Attached.SecureUrl = Logs.ImageUrl collate Azeri_Latin_100_CI_AS
                                    and Logs.SeenByUserId =
                                        @UserId -- Last join confition means is required to filter by only the logged in user
             where Attached.Type = 3
               and Attached.CreatedDate >= cast(Getdate() as Date)

             union all

-- Workplan ticket actions images
             select Ticket.UserId                    as UserId,
                    iif(Logs.ImageURL is null, 0, 1) as ImageSeen 
             from WPM_Attachment Attached with (nolock)
                      join WPM_TaskTicketAction Actions with (nolock) on Attached.ReferenceId = Actions.Id
					  join WPM_TaskAction taskactions with (nolock) on taskactions.Id=actions.ActionId
                      join WPM_TaskTicket Ticket with (nolock) on Ticket.Id = Actions.TaskTicketId
                      join F_GetPermittedUsers(@UserId) Users
                           on Users.UserId = Ticket.UserId 
                      left join MSG_UserStoryLog Logs with (nolock)
                                on Attached.SecureUrl = Logs.ImageUrl collate Azeri_Latin_100_CI_AS
                                    and Logs.SeenByUserId = @UserId 
             where Attached.Type = 3
               and Attached.CreatedDate >= cast(Getdate() as Date) and taskactions.ActionType not in (2,49)


             --Photos from Visit Operation
             union all
             Select Files.UploadedUserId                 as UserId,
                    iif(StoryLog.ImageURL is null, 0, 1) as ImageSeen 
             from OP_FileUploadLog Files with (nolock)
                      join MD_Client Clients with (nolock) on Files.Firm = Clients.Firm and Clients.TigerId = Files.ClientId
                      join F_GetPermittedUsers(@userId) StructureUsers on StructureUsers.UserId = Files.UploadedUserId
                      left join (select distinct ImageUrl, SeenByUserId
                                 from MSG_UserStoryLog with (nolock)) StoryLog
                                on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Files.SecureUrl 
                                      and StoryLog.SeenByUserId = @UserId
             where Files.ContentType = 2
               and Files.FileCreatedDate >= cast(Getdate() as Date)
             --Photos From Clients
             union all
             select Files.UploadedUserID                 as UserId,
                    iif(StoryLog.ImageURL is null, 0, 1) as ImageSeen 
             from OP_FileUploadLog Files with (nolock)
                      join MD_Client Clients with (nolock) on Files.Firm = Clients.Firm and Clients.TigerId = Files.ClientId
                      join F_GetPermittedUsers(@userId) StructureUsers on StructureUsers.UserId = Files.UploadedUserId
                      left join (select distinct ImageUrl, SeenByUserId
                                 from MSG_UserStoryLog with (nolock)) StoryLog
                                on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Files.SecureUrl
                                      and StoryLog.SeenByUserId = @UserId 
             where Files.ContentType = 1
               and Files.FileCreatedDate >= cast(Getdate() as Date)
             --Photos from Inventory
             union all
             select History.CreatorUserId                as UserId,
                    iif(StoryLog.ImageURL is null, 0, 1) as ImageSeen 
             from IM_InventoryStateHistoryImage Files with (nolock)
                      join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                      join MD_Client Clients with (nolock)
                           on Clients.TigerId = History.ClientTigerId and History.Firm = Clients.Firm
                      join F_GetPermittedUsers(@userId) StructureUsers on StructureUsers.UserId = History.CreatorUserId
                      left join (select distinct ImageUrl, SeenByUserId
                                 from MSG_UserStoryLog with (nolock)) StoryLog
                                on StoryLog.ImageUrl collate Azeri_Latin_100_CI_AS = Files.SecureUrl
                                      and StoryLog.SeenByUserId = @UserId 
             where Files.CreatedDate >= cast(Getdate() as Date)) t
             join AbpUsers Users on Users.Id = t.UserId and Users.IsDeleted = 0
             left join AbpUserProfilePhoto ProfilePhoto on ProfilePhoto.UserId = Users.Id
    group by Users.Id, Users.Name, Users.Surname, ProfilePhoto.SecureUrl

    return
end
