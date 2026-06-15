ALTER PROCEDURE [dbo].[SP_WPM_GetWebPhotoGalleryItem] @referenceId INT,
                                                      @sourceType TINYINT
AS
BEGIN
    IF @sourceType = 1
        BEGIN
            SELECT Files.Id                                                                             AS Id,
                   Files.SecureUrl                                                                      AS Url,
                   CONCAT(Users.Name, ' ', Users.Surname)                                               AS UserFullName,
                   Users.UserName                                                                       AS UserName,
                   Client.Name                                                                          AS ClientName,
                   Client.Code                                                                          AS ClientCode,
                   Client.TigerId                                                                       AS ClientId,
                   Files.CreatedDate                                                                    AS CreatedDate,
                   Users.Id                                                                             AS UserId,
                   Files.ReferenceId                                                                    AS ReferenceId,
                   CONCAT(Survey.Name, ' (', Survey.Code, ')')                                          AS Detail1,
                   CONCAT(Question.Name COLLATE SQL_Latin1_General_CP1_CI_AS, ' (', Question.Code, ')') AS Detail2,
                   Question.Description COLLATE SQL_Latin1_General_CP1_CI_AS                            AS Detail3,
                   fn.Answers COLLATE SQL_Latin1_General_CP1_CI_AS                                      AS Detail4,
                   fn.Reasons COLLATE SQL_Latin1_General_CP1_CI_AS                                      AS Detail5,
                   AtachReasonName.Name COLLATE SQL_Latin1_General_CP1_CI_AS                            AS Detail6,
                   Comments.Comment                                                                     AS PhotoComment,
                   Reasons.Name                                                                         AS ReasonName,
                   Likes.Status                                                                         AS LikeStatus,
                   CONCAT(LikeUser.Name, ' ', LikeUser.Surname)                                         AS LikeDislikeUser,
                   Likes.CreationTime                                                                   AS LikeDislikeTime,
                   ISNULL(Stars.StarCount, 0)                                                           AS StarCount,
                   ISNULL(TaskCountMain.TaskCount, 0)                                                   AS TaskCount,
                   CAST(1 AS TINYINT)                                                                   AS SourceType
            FROM CHL_Attachment Files with (nolock)
                     JOIN CHL_UserSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
                     JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
                     JOIN CHL_Question Question with (nolock) ON Details.QuestionId = Question.Id
                     JOIN CHL_Survey Survey with (nolock) on Response.SurveyId = Survey.Id and Response.Firm = Survey.Firm
                     JOIN MD_Client Client with (nolock) on Client.TigerId = Response.ClientId and Response.Firm = Client.Firm
                     JOIN AbpUsers Users with (nolock) on Users.Id = Response.UserId
                     left join MD_PhotoComment Comments with (nolock) on Files.Id = Comments.ReferenceId and Comments.SourceType = 1
                     left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                     left join CHL_UserSurveyResponseDetailAttachmentReason AtachReas with (nolock)
                               on AtachReas.UserSurveyResponseDetailId = Files.ReferenceId and AtachReas.AttachmentId = Files.Id
                     left join MD_StopReason AtachReasonName with (nolock) on AtachReas.ReasonId = AtachReasonName.Id
                     LEFT JOIN CHL_QuestionGroup qgroup with (nolock) on qgroup.Id = Question.QuestionGroupId
                     LEFT JOIN CHL_Answer Answer with (nolock) ON Details.AnswerId = Answer.Id
                     LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                     LEFT JOIN MD_PhotoStar Stars with (nolock) on files.Id = Stars.ReferenceId and Stars.SourceType = 1
                     LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
                     left join [F_CHL_GetSurveyQuestionReportAnswers]('20000101', getdate()) fn
                               on Response.Id = fn.UserSurveyResponseId and Details.QuestionId = fn.QuestionId
                     Left join (SELECT DISTINCT Mapping.AttachmentId,
                                                Mapping.Firm,
                                                COUNT(Mapping.TaskId) as TaskCount
                                FROM WPM_PhotoTaskMapping Mapping with (nolock)
                                         join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                                         LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId and Mapping.SourceType = 1
                                GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                               on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Response.Firm
            WHERE Files.Type = 3
              and Files.Id = @referenceId
            union all
            SELECT Files.Id                                          AS Id,
                   Files.SecureUrl                                   AS Url,
                   CONCAT(Users.Name, ' ', Users.Surname)            AS UserFullName,
                   Users.UserName                                    AS UserName,
                   Client.Name                                       AS ClientName,
                   Client.Code                                       AS ClientCode,
                   Client.TigerId                                    AS ClientId,
                   Files.CreatedDate                                 AS CreatedDate,
                   Users.Id                                          AS UserId,
                   Files.ReferenceId                                 AS ReferenceId,
                   CONCAT(Survey.Name, ' (', Survey.Code, ')')       AS Detail1,
                   Details.QuestionCode                              AS Detail2,
                   Details.QuestionName                              AS Detail3,
                   Details.QuestionDescription                       AS Detail4,
                   Details.AnswerValue                               AS Detail5,
                   AtachReasonName.Name                              AS Detail6,
                   Comments.Comment                                  AS PhotoComment,
                   Reasons.Name COLLATE SQL_Latin1_General_CP1_CI_AS AS ReasonName,
                   Likes.Status                                      AS LikeStatus,
                   CONCAT(LikeUser.Name, ' ', LikeUser.Surname)      AS LikeDislikeUser,
                   Likes.CreationTime                                AS LikeDislikeTime,
                   ISNULL(Stars.StarCount, 0)                        AS StarCount,
                   ISNULL(TaskCountMain.TaskCount, 0)                AS TaskCount,
                   CAST(1 AS TINYINT)                                AS SourceType
            FROM CHL_Attachment Files with (nolock)
                     JOIN CHL_UserDynamicSurveyResponseDetail Details with (nolock) ON Files.ReferenceId = Details.Id
                     JOIN CHL_UserSurveyResponse Response with (nolock) ON Details.UserSurveyResponseId = Response.Id
                     JOIN CHL_Survey Survey with (nolock) on Response.SurveyId = Survey.Id and Response.Firm = Survey.Firm
                     JOIN MD_Client Client with (nolock) on Client.TigerId = Response.ClientId and Response.Firm = Client.Firm
                     JOIN AbpUsers Users with (nolock) on Users.Id = Response.UserId
                     left join MD_PhotoComment Comments with (nolock) on Files.Id = Comments.ReferenceId and Comments.SourceType = 1
                     left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                     left join CHL_UserSurveyResponseDetailAttachmentReason AtachReas with (nolock)
                               on AtachReas.UserSurveyResponseDetailId = Files.ReferenceId and AtachReas.AttachmentId = Files.Id
                     left join MD_StopReason AtachReasonName with (nolock) on AtachReas.ReasonId = AtachReasonName.Id
                     LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 1
                     LEFT JOIN MD_PhotoStar Stars with (nolock) on files.Id = Stars.ReferenceId and Stars.SourceType = 1
                     LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
                     Left join (SELECT DISTINCT Mapping.AttachmentId,
                                                Mapping.Firm,
                                                COUNT(Mapping.TaskId) as TaskCount
                                FROM WPM_PhotoTaskMapping Mapping with (nolock)
                                         join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                                         LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId and Mapping.SourceType = 1
                                GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                               on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Response.Firm
            WHERE Files.SurveyType = 4
              and Files.Id = @referenceId
        END

    ELSE
        IF @sourceType = 2
            BEGIN
                SELECT Files.Id                                                                   AS Id,
                       Files.SecureUrl                                                            AS Url,
                       CONCAT(Users.Name, ' ', Users.Surname)                                     AS UserFullName,
                       Users.UserName                                                             AS UserName,
                       Client.Name                                                                AS ClientName,
                       Client.Code                                                                AS ClientCode,
                       Client.TigerId                                                             AS ClientId,
                       Files.CreatedDate                                                          AS CreatedDate,
                       Users.Id                                                                   AS UserId,
                       Files.ReferenceId                                                          AS ReferenceId,
                       iif(Task.Type = 1, 'General', 'Route')                                     AS Detail1,
                       CONCAT(Task.Name COLLATE SQL_Latin1_General_CP1_CI_AS, ' (', Task.Id, ')') AS Detail2,
                       Task.Message                                                               AS Detail3,
                       ISNULL(TaskAction.Message, ActType.Name)                                   AS Detail4,
                       TicketActions.Note                                                         AS Detail5,
                       ''                                                                         AS Detail6,
                       Comments.Comment                                                           AS PhotoComment,
                       Reasons.Name COLLATE SQL_Latin1_General_CP1_CI_AS                          AS ReasonName,
                       Likes.Status                                                               AS LikeStatus,
                       CONCAT(LikeUser.Name, ' ', LikeUser.Surname)                               AS LikeDislikeUser,
                       Likes.CreationTime                                                         AS LikeDislikeTime,
                       ISNULL(Stars.StarCount, 0)                                                 AS StarCount,
                       ISNULL(TaskCountMain.TaskCount, 0)                                         AS TaskCount,
                       CAST(2 AS TINYINT)                                                         AS SourceType
                FROM WPM_Attachment Files with (nolock)
                         JOIN WPM_TaskTicketAction TicketActions with (nolock) ON Files.ReferenceId = TicketActions.Id
                         JOIN WPM_TaskAction TaskAction with (nolock) ON TicketActions.ActionId = TaskAction.Id
                         join WPM_TaskActionType ActType with (nolock) on ActType.Id = TaskAction.ActionType
                         JOIN WPM_TaskTicket Tickets with (nolock) ON TicketActions.TaskTicketId = Tickets.Id
                         JOIN WPM_Task Task with (nolock) on Tickets.TaskId = Task.Id
                         JOIN MD_Client Client with (nolock) on Client.TigerId = Tickets.ClientId and Client.Firm = Tickets.Firm
                         JOIN AbpUsers Users with (nolock) on Users.Id = Tickets.UserId
                         LEFT JOIN MD_PhotoComment Comments with (nolock) on Files.Id = Comments.ReferenceId and Comments.SourceType = 2
                         LEFT JOIN MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 2
                         LEFT JOIN MD_PhotoStar Stars with (nolock) on files.Id = Stars.ReferenceId and Stars.SourceType = 2
                         LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
                         LEFT JOIN MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                         Left join (SELECT distinct Mapping.AttachmentId,
                                                    Mapping.Firm,
                                                    COUNT(distinct Mapping.TaskId) as TaskCount
                                    FROM WPM_PhotoTaskMapping Mapping with (nolock)

                                             join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                                             LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId and Mapping.SourceType = 2
                                    GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                                   on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Tickets.Firm
                WHERE TaskAction.ActionType = 1
                  AND Files.Type = 3
                  AND Files.Id = @ReferenceId
            END

        ELSE
            IF @sourceType = 5
                BEGIN
                    select Files.Id                                         as Id,
                           Files.SecureUrl                                  AS Url,
                           concat(Users.Name, ' ', Users.Surname)           as UserFullName,
                           Users.UserName                                   as UserName,
                           Client.Name                                      as ClientName,
                           Client.Code                                      as ClientCode,
                           Client.TigerId                                   as ClientId,
                           Files.FileCreatedDate                            as CreatedDate,
                           Users.Id                                         as UserId,
                           Files.Id                                         as ReferenceId,
                           Reason.Name COLLATE SQL_Latin1_General_CP1_CI_AS as Detail1,
                           Files.Note                                       as Detail2,
                           ''                                               as Detail3,
                           ''                                               as Detail4,
                           ''                                               as Detail5,
                           ''                                               as Detail6,
                           Comments.Comment                                 as PhotoComment,
                           Reasons.Name                                     as ReasonName,
                           Likes.Status                                     as LikeStatus,
                           concat(LikeUser.Name, ' ', LikeUser.Surname)     as LikeDislikeUser,
                           Likes.CreationTime                               as LikeDislikeTime,
                           isnull(Stars.StarCount, 0)                       as StarCount,
                           isnull(TaskCountMain.TaskCount, 0)               as TaskCount,
                           cast(5 as tinyint)                               as SourceType
                    from OP_FileUploadLog Files with (nolock)
                             JOIN MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Client.Firm = Files.Firm
                             JOIN AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
                             LEFT JOIN MD_PhotoLike Likes with (nolock)
                                       on (Files.Id = Likes.ReferenceId and Files.ContentType = 1 and Likes.SourceType = 5) -- Client photos
                             LEFT JOIN MD_PhotoStar Stars with (nolock)
                                       on (Files.Id = Stars.ReferenceId and Files.ContentType = 1 and Stars.SourceType = 5) -- Client photos
                             left join MD_PhotoComment Comments with (nolock)
                                       on (Files.Id = Comments.ReferenceId and Files.ContentType = 1 and Comments.SourceType = 5)
                             left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                             left join MD_StopReason Reason with (nolock) on Reason.Id = Files.ReasonId
                             LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
                             Left join (SELECT DISTINCT Mapping.AttachmentId,
                                                        Mapping.Firm,
                                                        COUNT(distinct Mapping.TaskId) as TaskCount
                                        FROM WPM_PhotoTaskMapping Mapping with (nolock)

                                                 join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                                                 LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId and Mapping.SourceType = 5
                                        GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                                       on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Files.Firm
                    where FileCreatedDate is not null
                      and Files.ContentType = 1
                      and Files.Id = @referenceId

                END

            ELSE
                IF @sourceType = 4
                    begin
                        select Files.Id                                          as Id,
                               Files.SecureUrl                                   AS Url,
                               concat(Users.Name, ' ', Users.Surname)            as UserFullName,
                               Users.UserName                                    as UserName,
                               Client.Name                                       as ClientName,
                               Client.Code                                       as ClientCode,
                               Client.TigerId                                    as ClientId,
                               Files.CreatedDate                                 as CreatedDate,
                               Users.Id                                          as UserId,
                               Files.Id                                          as ReferenceId,
                               Inventory.RegistrationNr                          as Detail1,
                               Reason.Description                                as Detail2,
                               iif(History.IsExists = 1, 'Yes', 'No')            as Detail3,
                               Reason.Name                                       as Detail4,
                               History.Description                               as Detail5,
                               ''                                                as Detail6,
                               Comments.Comment                                  as PhotoComment,
                               Reasons.Name COLLATE SQL_Latin1_General_CP1_CI_AS as ReasonName,
                               Likes.Status                                      as LikeStatus,
                               concat(LikeUser.Name, ' ', LikeUser.Surname)      as LikeDislikeUser,
                               Likes.CreationTime                                as LikeDislikeTime,
                               isnull(Stars.StarCount, 0)                        as StarCount,
                               isnull(TaskCountMain.TaskCount, 0)                as TaskCount,
                               cast(4 as tinyint)                                as SourceType
                        from IM_InventoryStateHistoryImage Files with (nolock)
                                 join IM_InventoryStateHistory History with (nolock) on History.Id = Files.InventoryStateHistoryId
                                 join IM_Inventory Inventory with (nolock) on Inventory.Id = History.InventoryId and Inventory.Firm = History.Firm
                                 join MD_Client Client with (nolock) on Client.TigerId = History.ClientTigerId and History.Firm = Client.Firm
                                 join AbpUsers Users with (nolock) on Users.Id = History.CreatorUserId
                                 left join IM_StaticContent Reason with (nolock) on Reason.Id = History.InventoryStateId and Reason.Type = 3
                                 left join MD_PhotoLike Likes with (nolock) on Likes.ReferenceId = Files.Id and Likes.SourceType = 4
                                 left join MD_PhotoStar Stars with (nolock) on Stars.ReferenceId = Files.Id and Stars.SourceType = 4
                                 left join MD_PhotoComment Comments with (nolock) on Comments.ReferenceId = Files.Id and Comments.SourceType = 4
                                 LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
                                 left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                                 Left join (SELECT DISTINCT Mapping.AttachmentId,
                                                            Mapping.Firm,
                                                            COUNT(distinct Mapping.TaskId) as TaskCount
                                            FROM WPM_PhotoTaskMapping Mapping with (nolock)

                                                     join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                                                     LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId and Mapping.SourceType = 4
                                            GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                                           on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = History.Firm
                        where Files.Id = @referenceId
                    end

                else
                    if @sourceType = 3
                        begin
                            select Files.Id                                         as Id,
                                   Files.SecureUrl                                  AS Url,
                                   concat(Users.Name, ' ', Users.Surname)           as UserFullName,
                                   Users.UserName                                   as UserName,
                                   Client.Name                                      as ClientName,
                                   Client.Code                                      as ClientCode,
                                   Client.TigerId                                   as ClientId,
                                   Visit.CreatedDate                                as CreatedDate,
                                   Users.Id                                         as UserId,
                                   Visit.Id                                         as ReferenceId,
                                   Reason.Name COLLATE SQL_Latin1_General_CP1_CI_AS as Detail1,
                                   Visit.Note                                       as Detail2,
                                   ''                                               as Detail3,
                                   ''                                               as Detail4,
                                   ''                                               as Detail5,
                                   ''                                               as Detail6,
                                   Comments.Comment                                 as PhotoComment,
                                   Reasons.Name                                     as ReasonName,
                                   Likes.Status                                     as LikeStatus,
                                   concat(LikeUser.Name, ' ', LikeUser.Surname)     as LikeDislikeUser,
                                   Likes.CreationTime                               as LikeDislikeTime,
                                   isnull(Stars.StarCount, 0)                       as StarCount,
                                   isnull(TaskCountMain.TaskCount, 0)               as TaskCount,
                                   cast(3 as tinyint)                               as SourceType
                            from OP_FileUploadLog Files with (nolock)
                                     join MD_Client Client with (nolock) on Client.TigerId = Files.ClientId and Files.Firm = Client.Firm
                                     join AbpUsers Users with (nolock) on Users.Id = Files.UploadedUserId
                                     join OP_ClientVisitLog Visit with (nolock) on Visit.DocId = Files.DocId and Files.ContentType = 2
                                     left join MD_PhotoLike Likes with (nolock) on (Files.Id = Likes.ReferenceId and Files.ContentType = 2 and Likes.SourceType = 3) -- Visit
                                     left join MD_PhotoStar Stars with (nolock) on (Files.Id = Stars.ReferenceId and Files.ContentType = 2 and Stars.SourceType = 3) -- Visit
                                     left join MD_PhotoComment Comments with (nolock)
                                               on (Files.Id = Comments.ReferenceId and Files.ContentType = 2 and Comments.SourceType = 3) -- Client photos
                                     left join MD_StopReason Reasons with (nolock) on Reasons.Id = Comments.ReasonId
                                     left join MD_StopReason Reason with (nolock) on Reason.Id = Visit.ReasonId
                                     LEFT JOIN AbpUsers LikeUser with (nolock) on LikeUser.Id = Likes.CreatorUserId
                                     Left join (SELECT DISTINCT Mapping.AttachmentId,
                                                                Mapping.Firm,
                                                                COUNT(distinct Mapping.TaskId) as TaskCount
                                                FROM WPM_PhotoTaskMapping Mapping with (nolock)

                                                         join WPM_Task Task with (nolock) on Mapping.TaskId = TAsk.Id
                                                         LEFT JOIN WPM_TaskTicket TT with (nolock) ON Mapping.TaskId = TT.TaskId and Mapping.SourceType = 3
                                                GROUP BY Mapping.AttachmentId, Mapping.Firm) TaskCountMain
                                               on TaskCountMain.AttachmentId = Files.Id and TaskCountMain.Firm = Files.Firm
                            where Files.FilePath is not null
                              and Files.FilePath != ''
                              and Files.Id = @referenceId
                        end

END


