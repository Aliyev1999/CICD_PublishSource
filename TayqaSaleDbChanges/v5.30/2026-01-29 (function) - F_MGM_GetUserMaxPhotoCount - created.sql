
CREATE OR ALTER  FUNCTION [dbo].[F_MGM_GetUserMaxPhotoCount]( @userId BIGINT, @begin DATETIME2, @end DATETIME2, @takeCount INT, @skipCount INT)
    RETURNS INT AS BEGIN

    declare @Count int = 0;

    with Data as (
        -- Workplan / Task images
        select count(Files.Id) as Count
        from WPM_Attachment Files with (nolock)
                 join WPM_TaskTicketAction Detail with (nolock) on Detail.Id = Files.ReferenceId
                 join WPM_TaskTicket Header with (nolock) on Header.Id = Detail.TaskTicketId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.UserId
        where Header.CreatedDate between @begin and @end
          and Files.Type = 3

        union

        -- Static surveys
        select count(Files.Id) as Count
        from CHL_Attachment Files with (nolock)
                 join CHL_UserSurveyResponseDetail Detail with (nolock) on Detail.Id = Files.ReferenceId
                 join CHL_UserSurveyResponse Header with (nolock) on Header.Id = Detail.UserSurveyResponseId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.UserId
        where Header.SavedDate between @begin and @end
          and Files.Type = 3

        union

        -- Dynamic surveys
        select count(Files.Id) as Count
        from CHL_Attachment Files with (nolock)
                 join CHL_UserDynamicSurveyResponseDetail Detail with (nolock) on Detail.Id = Files.ReferenceId
                 join CHL_UserSurveyResponse Header with (nolock) on Header.Id = Detail.UserSurveyResponseId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.UserId
        where Header.SavedDate between @begin and @end
          and Files.Type = 3

        union

        -- Visit and client photos
        select count(Files.Id) as Count
        from OP_FileUploadLog Files with (nolock)
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Files.UploadedUserId
        where Files.FileCreatedDate between @begin and @end

        union

        -- Inventory
        select count(Files.Id) as Count
        from IM_InventoryStateHistoryImage Files with (nolock)
                 join IM_InventoryStateHistory Header with (nolock) on Header.Id = Files.InventoryStateHistoryId
                 join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Header.CreatorUserId
        where Header.CreatedDate between @begin and @end)

    select @Count = sum(Count)
    from Data

    RETURN @Count;
END