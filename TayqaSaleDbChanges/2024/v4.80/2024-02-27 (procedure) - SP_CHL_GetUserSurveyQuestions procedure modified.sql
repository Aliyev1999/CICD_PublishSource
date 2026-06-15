ALTER PROCEDURE [SP_CHL_GetUserSurveyQuestions] @surveyId int, @clientId int
AS
BEGIN
    SELECT sq.IsAnswerRequired,
           sq.Type              QuestionType,
           sq.OrderNumber       QuestionOrderNumber,
           q.Id                 QuestionId,
           q.Name               QuestionName,
           q.Code               QuestionCode,
           q.Description        QuestionDescription,
           q.ReasonConditionType,
           q.ReasonConditionValue,
           q.ReasonInputType,
           Cast(
                   Case q.Status When 0 Then sq.Status Else q.Status End as tinyint
               )          as    QuestionStatus,
           q.WeightingType,
           q.AnswerMinValue,
           q.AnswerMaxValue,
           q.ItemId,
           q.ItemGroupId,
           q.PhotoUploadOption,
           q.ReasonSelectOption QuestionReasonSelectOption,
           q.AnswerInputType,
           qg.Code              QuestionGroupCode,
           qg.Name              QuestionGroupName,
           qg.Description       QuestionGroupDescription,
           a.Id                 AnswerId,
           a.[Text]             AnswerText,
           a.ReasonSelectOption AnswerReasonSelectOption,
           a.ReasonInputType    AnswerReasonInputType,
           a.PhotoUploadOption  AnswerPhotoUploadOption,
           a.IsCorrect          IsCorrect,
           anst.Id              AnswerTypeId,
           anst.Name            AnswerTypeName,
           anst.IsAnswerFree    IsAnswerFree,
           qath.Id              QuestionAttachmentId,
           qath.Url             QuestionAttachmentUrl,
           qath.SecureUrl as    QuestionSecureUrl,
           t.Id                 QuestionTagId,
           t.Name               QuestionTag,
           qasr.ReasonId        AnswerSelectReasonId,
           qasr.Name            AnswerSelectReasonName,
           qasr.Description     AnswerSelectReasonDescription,
           qasr.Type            AnswerSelectReasonType
    from CHL_SurveyQuestion sq with (nolock)
             join CHL_Survey s with (nolock) on sq.SurveyId = s.Id
             join CHL_Question q with (nolock) on q.Id = sq.QuestionId
             join CHL_AnswerType anst with (nolock) on anst.Id = q.AnswerTypeId
             left join CHL_QuestionGroup qg with (nolock) on q.QuestionGroupId = qg.Id
             left join CHL_Answer a with (nolock) on a.QuestionId = q.Id
             left join CHL_Attachment qath with (nolock) on qath.Type = 1 and qath.ReferenceId = q.Id
             left join CHL_QuestionTag qt with (nolock) on qt.QuestionId = q.Id
             left join CHL_Tag t with (nolock) on t.Id = qt.TagId
             left join (select qasr.QuestionId, qasr.ReasonId, asr.Name, asr.Description, asr.Type
                        from CHL_QuestionAnswerSelectReason qasr with (nolock)
                                 join MD_StopReason asr with (nolock) on asr.Type = 3 and asr.IsDeleted = 0
                            and asr.Id = qasr.ReasonId) qasr on qasr.QuestionId = q.Id
    where S.Id = @surveyId and sq.Status = 0
END
GO

