CREATE OR ALTER PROC [dbo].[SP_WPM_GetPhotoGallery] as
-- Created by TayqaTech for TayqaSale (Kanan Mammadov)
-- Description: the query returns the gallery photos from app user

begin
    SELECT Files.Id                     as Id,
           Files.Url                    as Url,
           Files.ReferenceId            as ReferenceId,
           Files.CreatedDate            as CreatedDate,
           CAST(1 as tinyint)           as SourceType,
           Response.Id                  as ParentReferenceId,
           Response.Firm                as Firm,
           isnull(Response.ClientId, 0) as ClientId,
           Response.UserId              as UserId,
           Survey.Name                  as Name,
           Question.Name                as TaskMessage,
           ''                           as TaskActionMessage,
           CAST(0 as int)               as TaskId
    FROM CHL_Attachment Files with (nolock)
             JOIN CHL_UserSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
             JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
             JOIN CHL_Question Question with (nolock) ON Details.QuestionId = Question.Id
             JOIN CHL_Survey Survey on Response.SurveyId = Survey.Id and Response.Firm = Survey.Firm
    WHERE Files.Type = 3

    UNION

    SELECT Files.Id                   as Id,
           Files.Url                  as Url,
           Files.ReferenceId          as ReferenceId,
           Files.CreatedDate          as CreatedDate,
           CAST(2 as tinyint)         as SourceType,
           TicketActions.TaskTicketId as ParentReferenceId,
           Tickets.Firm               as Firm,
           Tickets.ClientId           as ClientId,
           Tickets.UserId             as UserId,
           Task.Name                  as Name,
           Task.Message               as TaskMessage,
           TaskAction.Message         as TaskActionMessage,
           Task.Id                    as TaskId
    FROM WPM_Attachment Files with (nolock)
             JOIN WPM_TaskTicketAction TicketActions with (nolock) ON Files.ReferenceId = TicketActions.Id
             JOIN WPM_TaskAction TaskAction with (nolock) ON TicketActions.ActionId = TaskAction.Id
             JOIN WPM_TaskTicket Tickets with (nolock) ON TicketActions.TaskTicketId = Tickets.Id
             JOIN WPM_Task Task with (nolock) on Tickets.TaskId = Task.Id
    WHERE TaskAction.ActionType = 1
      AND Files.Type = 3

    union

    select Files.Id              as Id,
           Files.FilePath        as Url,
           Files.Id              as ReferenceId,
           Files.FileCreatedDate as CreatedDate,
           CAST(5 as tinyint)    as SourceType,
           CAST(0 as int)        as ParentReferenceId,
           Files.Firm            as Firm,
           Client.TigerId        as ClientId,
           Files.UploadedUserId  as UserId,
           Reasons.Name          as Name,
           Files.Note            as TaskMessage,
           ''                    as TaskActionMessage,
           isnull(Mapping.TaskId,0) as TaskId
    from OP_FileUploadLog Files with (nolock)
             join MD_StopReason Reasons with (nolock) on Reasons.Id = Files.ReasonId
             join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Client.Firm = Files.Firm
             left join WPM_PhotoTaskMapping Mapping with (nolock) on Mapping.AttachmentId = Files.Id and Mapping.SourceType = 3
			 where FileCreatedDate is not null and Files.ContentType=1


    union

    select Files.Id                 as Id,
           Files.ImagePath          as Url,
           Files.Id                 as ReferenceId,
           History.CreatedDate      as CreatedDate,
           CAST(4 as tinyint)       as SourceType,
           CAST(0 as int)           as ParentReferenceId,
           History.Firm             as Firm,
           History.ClientTigerId    as ClientId,
           History.CreatorUserId    as UserId,
           Inventory.RegistrationNr as Name,
           Reason.Description       as TaskMessage,
           ''                       as TaskActionMessage,
           isnull(Mapping.TaskId,0)           as TaskId

    from IM_InventoryStateHistoryImage Files with (nolock)
             join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
             join IM_Inventory Inventory with (nolock) on Inventory.Id = History.InventoryId and Inventory.Firm = History.Firm
             join IM_StaticContent Reason with (nolock) on Reason.Id = History.InventoryStateId and Reason.Type = 3 
             left join WPM_PhotoTaskMapping Mapping with (nolock) on Mapping.AttachmentId = Files.Id and Mapping.SourceType = 4

    union

    select Files.Id            as Id,
           Files.FilePath      as Url,
           Visits.Id            as ReferenceId,
           Visits.CreatedDate   as CreatedDate,
           CAST(3 as tinyint)  as SourceType,
           CAST(0 as int)      as ParentReferenceId,
           Visits.Firm          as Firm,
           Visits.ClientId      as ClientId,
           Visits.CreatedUserId as UserId,
           Reason.Name         as Name,
           Visits.Note          as TaskMessage,
           ''                  as TaskActionMessage,
           isnull(Mapping.TaskId,0)      as TaskId

    from OP_ClientVisitLog Visits with (nolock)
         join OP_FileUploadLog Files with (nolock) on Visits.DocId = Files.DocId and Files.ContentType = 2
         left join MD_StopReason Reason with (nolock) on Reason.Id = Visits.ReasonId
         left join WPM_PhotoTaskMapping Mapping with (nolock) on Mapping.AttachmentId = Visits.Id and Mapping.SourceType = 5
			 where Files.FilePath is not null and Files.FilePath != '' and Files.ContentType = 2
end