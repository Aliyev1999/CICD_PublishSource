ALTER FUNCTION [dbo].[F_CHL_GetUserSurveys](
    @userId int, @notConsiderPassiveSurveysDate datetime
    )
    Returns Table AS RETURN
            (
                SELECT su.Id                     AS SurveyUserId,
                       srv.Id                    AS SurveyId,
                       srv.Code                  AS SurveyCode,
                       srv.Name                  AS SurveyName,
                       srv.Description           AS SurveyDescription,
                       CASE
                           WHEN srv.Status = 0 THEN su.Status
                           ELSE srv.Status
                           END                   AS Status,
                       srv.Type                  AS SurveyType,
                       srv.StartDate,
                       srv.EndDate,
                       srv.StartTime,
                       srv.EndTime,
                       srv.SalesmanCode,
                       srv.MerchandiserCode,
                       srv.Firm,
                       srv.PeriodicalType,
                       srv.CreatedDate,
                       srv.ModifiedDate,
                       sq.IsAnswerRequired,
                       sq.Type                   AS QuestionType,
                       sq.OrderNumber            AS QuestionOrderNumber,
                       qstn.Id                   AS QuestionId,
                       qstn.Name                 AS QuestionName,
                       qstn.Code                 AS QuestionCode,
                       qstn.Description          AS QuestionDescription,
                       qstn.ReasonConditionType,
                       qstn.ReasonConditionValue,
                       qstn.ReasonInputType,
                       CASE
                           WHEN qstn.Status = 0 THEN sq.Status
                           ELSE qstn.Status
                           END                   AS QuestionStatus,
                       qstn.WeightingType,
                       qstn.AnswerMinValue,
                       qstn.AnswerMaxValue,
                       qstn.ItemId,
                       qstn.ItemGroupId,
                       qstn.PhotoUploadOption,
                       qstn.ReasonSelectOption   AS QuestionReasonSelectOption,
                       qstn.AnswerInputType,
                       qg.Code                   AS QuestionGroupCode,
                       qg.Name                   AS QuestionGroupName,
                       qg.Description            AS QuestionGroupDescription,
                       answer.Id                 AS AnswerId,
                       answer.[Text]             AS AnswerText,
                       answer.ReasonSelectOption AS AnswerReasonSelectOption,
                       answer.ReasonInputType    AS AnswerReasonInputType,
                       answer.PhotoUploadOption  AS AnswerPhotoUploadOption,
                       anst.Id                   AS AnswerTypeId,
                       anst.Name                 AS AnswerTypeName,
                       anst.IsAnswerFree,
                       qath.Id                   AS QuestionAttachmentId,
                       qath.Url                  AS QuestionAttachmentUrl,
                       qath.SecureUrl            AS QuestionSecureUrl,
                       sath.Id                   AS SurveyAttachmentId,
                       sath.Url                  AS SurveyAttachmentUrl,
                       sath.SecureUrl            AS SurveySecureUrl,
                       t1.Id                     AS QuestionTagId,
                       t1.Name                   AS QuestionTag,
                       t2.Id                     AS SurveyTagId,
                       t2.Name                   AS SurveyTag,
                       qasr.ReasonId             AS AnswerSelectReasonId
                FROM CHL_SurveyUser su with (nolock)
                         JOIN CHL_Survey srv with (nolock) ON su.SurveyId = srv.Id
                    AND su.UserId = @userId
                    AND srv.EndDate > DATEADD(DAY, -30, GETDATE())
                         JOIN CHL_SurveyQuestion sq with (nolock) ON sq.SurveyId = srv.Id
                         JOIN CHL_Question qstn with (nolock) ON qstn.Id = sq.QuestionId
                         JOIN CHL_AnswerType anst with (nolock) ON anst.Id = qstn.AnswerTypeId
                         LEFT JOIN CHL_QuestionGroup qg with (nolock) ON qstn.QuestionGroupId = qg.Id
                         LEFT JOIN CHL_Answer answer with (nolock) ON answer.QuestionId = qstn.Id
                         LEFT JOIN CHL_Attachment qath with (nolock) ON qath.Type = 1
                    AND qath.ReferenceId = qstn.Id
                         LEFT JOIN CHL_Attachment sath with (nolock) ON sath.Type = 0
                    AND sath.ReferenceId = srv.Id
                         LEFT JOIN CHL_QuestionTag qt with (nolock) ON qt.QuestionId = qstn.Id
                         LEFT JOIN CHL_Tag t1 with (nolock) ON t1.Id = qt.TagId
                         LEFT JOIN CHL_SurveyTag st with (nolock) ON st.SurveyId = srv.Id
                         LEFT JOIN CHL_Tag t2 with (nolock) ON t2.Id = st.TagId
                         LEFT JOIN (SELECT qasr.QuestionId, qasr.ReasonId
                                    FROM CHL_QuestionAnswerSelectReason qasr with (nolock)
                                             JOIN MD_StopReason asr with (nolock) ON asr.Type = 3
                                        AND asr.IsDeleted = 0
                                        AND asr.Id = qasr.ReasonId) qasr ON qasr.QuestionId = qstn.Id
                WHERE NOT (srv.Status = 1 AND srv.ModifiedDate < @notConsiderPassiveSurveysDate)
            )