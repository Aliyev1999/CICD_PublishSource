ALTER FUNCTION [dbo].[F_CHL_GetUserSurveys](
    @userId int, @notConsiderPassiveSurveysDate datetime
)
    Returns Table AS RETURN
            (
                select su.Id                SurveyUserId,
                       s.Id                 SurveyId,
                       s.Code               SurveyCode,
                       s.Name               SurveyName,
                       s.Description        SurveyDescription,
                       Cast(
                               Case s.Status When 0 Then su.Status Else s.Status End as tinyint
                           )          as    Status,
                       s.Type               SurveyType,
                       s.StartDate,
                       s.EndDate,
                       s.StartTime,
                       s.EndTime,
                       s.SalesmanCode,
                       s.MerchandiserCode,
                       s.Firm,
                       s.PeriodicalType,
                       s.CreatedDate,
                       s.ModifiedDate,
                       -- survey details
                       sq.IsAnswerRequired,
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
                       --surveyquestion Params
                       a.Id                 AnswerId,
                       a.[Text]             AnswerText,
                       a.ReasonSelectOption AnswerReasonSelectOption,
                       a.ReasonInputType    AnswerReasonInputType,
                       a.PhotoUploadOption  AnswerPhotoUploadOption,
                       -- question answer params
                       anst.Id              AnswerTypeId,
                       anst.Name            AnswerTypeName,
                       anst.IsAnswerFree,
                       -- question answertype params
                       qath.Id              QuestionAttachmentId,
                       qath.Url             QuestionAttachmentUrl,
                       qath.SecureUrl as    QuestionSecureUrl,
                       sath.Id              SurveyAttachmentId,
                       sath.Url             SurveyAttachmentUrl,
                       sath.SecureUrl       SurveySecureUrl,
                       t1.Id                QuestionTagId,
                       t1.Name              QuestionTag,
                       t2.Id                SurveyTagId,
                       t2.Name              SurveyTag,
                       qasr.ReasonId        AnswerSelectReasonId
                from CHL_SurveyUser su
                         join CHL_Survey s on su.SurveyId = s.Id
                    and su.UserId = @userId
                         join CHL_SurveyQuestion sq on sq.SurveyId = s.Id
                         join CHL_Question q on q.Id = sq.QuestionId
                         join CHL_AnswerType anst on anst.Id = q.AnswerTypeId
                         left join CHL_QuestionGroup qg on q.QuestionGroupId = qg.Id
                         left join CHL_Answer a on a.QuestionId = q.Id
                         left join CHL_Attachment qath on qath.Type = 1
                    and qath.ReferenceId = q.Id
                         left join CHL_Attachment sath on sath.Type = 0
                    and sath.ReferenceId = s.Id
                         left join CHL_QuestionTag qt on qt.QuestionId = q.Id
                         left join CHL_Tag t1 on t1.Id = qt.TagId
                         left join CHL_SurveyTag st on st.SurveyId = s.Id
                         left join CHL_Tag t2 on t2.Id = st.TagId
                         left join (select qasr.QuestionId,
                                           qasr.ReasonId
                                    from CHL_QuestionAnswerSelectReason qasr
                                             join MD_StopReason asr on asr.Type = 3
                                        and asr.IsDeleted = 0
                                        and asr.Id = qasr.ReasonId) qasr on qasr.QuestionId = q.Id
                where s.EndDate > DATEADD(
                        DAY,
                        -30,
                        GETDATE()
                    )
                  and NOT (
                            s.Status = 1
                        and s.ModifiedDate < @notConsiderPassiveSurveysDate
                    )
            )