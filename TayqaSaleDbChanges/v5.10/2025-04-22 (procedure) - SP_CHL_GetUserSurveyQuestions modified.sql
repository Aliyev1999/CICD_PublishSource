ALTER procedure [dbo].[SP_CHL_GetUserSurveyQuestions] @surveyId int, @clientId int, @userId bigint=null
as
begin
    select distinct sq.IsAnswerRequired,
                    sq.Type                                                    QuestionType,
                    sq.OrderNumber                                             QuestionOrderNumber,
                    q.Id                                                       QuestionId,
                    q.Name                                                     QuestionName,
                    q.Code                                                     QuestionCode,
                    q.Description                                              QuestionDescription,
                    q.ReasonConditionType,
                    q.ReasonConditionValue,
                    isnull(q.ReasonInputType, 1)                            as ReasonInputType,
                    Cast(IIF(q.Status = 0, sq.Status, q.Status) as tinyint) as QuestionStatus,
                    q.WeightingType,
                    q.AnswerMinValue,
                    q.AnswerMaxValue,
                    q.ItemId,
                    q.ItemGroupId,
                    q.PhotoUploadOption,
                    q.ReasonSelectOption                                       QuestionReasonSelectOption,
                    q.AnswerInputType,
                    qg.Code                                                    QuestionGroupCode,
                    qg.Name                                                    QuestionGroupName,
                    qg.Description                                             QuestionGroupDescription,
                    a.Id                                                       AnswerId,
                    a.[Text]                                                   AnswerText,
                    a.ReasonSelectOption                                       AnswerReasonSelectOption,
                    isnull(a.ReasonInputType, 1)                               AnswerReasonInputType,
                    a.PhotoUploadOption                                        AnswerPhotoUploadOption,
                    isnull(a.IsCorrect, 0)                                     IsCorrect,
                    a.OrderNumber                                              AnswerOrderNumber,
                    aqr.ChildQuestionId                                        ChildQuestionId,
                    anst.Id                                                    AnswerTypeId,
                    anst.Name                                                  AnswerTypeName,
                    anst.IsAnswerFree                                          IsAnswerFree,
                    qath.Id                                                    QuestionAttachmentId,
                    qath.Url                                                   QuestionAttachmentUrl,
                    qath.SecureUrl                                          as QuestionSecureUrl,
                    t.Id                                                       QuestionTagId,
                    t.Name                                                     QuestionTag,
                    qasr.ReasonId                                              AnswerSelectReasonId,
                    qasr.Name                                                  AnswerSelectReasonName,
                    qasr.Description                                           AnswerSelectReasonDescription,
                    qasr.Type                                                  AnswerSelectReasonType,
                    qasr.SelectionType                                         AnswerSelectSelectionType,
                    qasr.MandatoryType                                         AnswerSelectMandatoryType,
                    r.Id                                                    as ReasonId,
                    r.CustomReasonInputType                                 as CustomReasonInputType,
                    r.MandatoryType                                         as MandatoryType,
                    r.ReasonType                                            as ReasonType,
                    r.ReasonValue                                           as ReasonValue,
                    r.SelectionType                                         as SelectionType,
                    q.ReasonLabel                                           as ReasonLabel,
                    q.IsManualReasonAllowed                                 as isManualReasonAllowed,
                    s.QuestionGroupView                                     as QuestionGroupView,
                    q.RatingAnswerSymbolType,
                    q.RatingAnswerSymbolCount
    from CHL_SurveyQuestion sq with (nolock)
             join CHL_Survey s with (nolock) on sq.SurveyId = s.Id
             join CHL_Question q with (nolock) on q.Id = sq.QuestionId
             join CHL_AnswerType anst with (nolock) on anst.Id = q.AnswerTypeId
             left join CHL_QuestionGroup qg with (nolock) on q.QuestionGroupId = qg.Id
             left join CHL_Answer a with (nolock) on a.QuestionId = q.Id and a.ViewType = 1
             left join CHL_AnswerQuestionRelation aqr with (nolock)
                       on aqr.ParentQuestionId = q.Id and aqr.SurveyId = s.Id and aqr.AnswerId = a.Id
             left join CHL_Attachment qath with (nolock) on qath.Type = 1 and qath.ReferenceId = q.Id
             left join CHL_QuestionTag qt with (nolock) on qt.QuestionId = q.Id
             left join CHL_Tag t with (nolock) on t.Id = qt.TagId
             left join (select qasr.QuestionId,
                               qasr.ReasonId,
                               asr.Name,
                               asr.Description,
                               asr.Type,
                               qasr.SelectionType,
                               qasr.MandatoryType,
                               qasr.ReasonViewState
                        from CHL_QuestionAnswerSelectReason qasr with (nolock)
                                 join MD_StopReason asr with (nolock) on asr.Type = 3 and asr.IsDeleted = 0
                            and asr.Id = qasr.ReasonId) qasr on qasr.QuestionId = q.Id and qasr.ReasonViewState = 1
             left join CHL_Reasons r with (nolock) on a.Id = r.AnswerId and r.ReasonViewState = 1
    where S.Id = @surveyId
      and sq.Status = 0
end
go