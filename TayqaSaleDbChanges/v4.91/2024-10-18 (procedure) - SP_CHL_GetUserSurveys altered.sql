alter procedure [dbo].[SP_CHL_GetUserSurveys](
    @userId int,
    @notConsiderPassiveSurveysDate datetime
)
As
Begin

    with UserSurveys as (select Id as SurveyUserId, Status, List.SurveyId
                         from CHL_SurveyUser List with (nolock)
                         where UserId = @userId
                         union
                         select Id as SurveyUserId, 0 as Status, List.SurveyId
                         from CHL_SurveyUserGroups List with (nolock)
                         where UserGroupId in (select Mapping.GroupId
                                               from MD_UserGroupMapping Mapping with (nolock)
                                                        join MD_UserGroupInfo Info with (nolock) on Info.Id = Mapping.GroupId
                                               where Mapping.UserId = @userId
                                                 and Info.IsDeleted = 0
                                                 and Info.IsActive = 1))

    select UserSurveys.SurveyUserId                                                          as SurveyUserId,
           Survey.Id                                                                         as SurveyId,
           Survey.Code                                                                       as SurveyCode,
           Survey.Name                                                                       as SurveyName,
           Survey.Description                                                                as SurveyDescription,
           Cast(IIF(Survey.Status = 0, UserSurveys.Status, Survey.Status) as tinyint)        as Status,
           Survey.Type                                                                       as SurveyType,
           Survey.StartDate                                                                  as StartDate,
           Survey.EndDate                                                                    as EndDate,
           Survey.StartTime                                                                  as StartTime,
           Survey.EndTime                                                                    as EndTime,
           Survey.SalesmanCode                                                               as SalesmanCode,
           Survey.MerchandiserCode                                                           as MerchandiserCode,
           Survey.Firm                                                                       as Firm,
           Survey.PeriodicalType                                                             as PeriodicalType,
           Survey.CreatedDate                                                                as CreatedDate,
           Survey.ModifiedDate                                                               as ModifiedDate,

           -- survey details
           SurveyQuestion.IsAnswerRequired,
           SurveyQuestion.Type                                                               as QuestionType,
           SurveyQuestion.OrderNumber                                                        as QuestionOrderNumber,
           Question.Id                                                                       as QuestionId,
           Question.Name                                                                     as QuestionName,
           Question.Code                                                                     as QuestionCode,
           Question.Description                                                              as QuestionDescription,
           Question.ReasonConditionType                                                      as ReasonConditionType,
           Question.ReasonConditionValue                                                     as ReasonConditionValue,
           Question.ReasonInputType                                                          as ReasonInputType,
           Cast(IIF(Question.Status = 0, SurveyQuestion.Status, Question.Status) as tinyint) as QuestionStatus,
           Question.WeightingType                                                            as WeightingType,
           Question.AnswerMinValue                                                           as AnswerMinValue,
           Question.AnswerMaxValue                                                           as AnswerMaxValue,
           Question.ItemId                                                                   as ItemId,
           Question.ItemGroupId                                                              as ItemGroupId,
           Question.PhotoUploadOption                                                        as PhotoUploadOption,
           Question.ReasonSelectOption                                                       as QuestionReasonSelectOption,
           Question.AnswerInputType                                                          as AnswerInputType,
           QuestionGroup.Code                                                                as QuestionGroupCode,
           QuestionGroup.Name                                                                as QuestionGroupName,
           QuestionGroup.Description                                                         as QuestionGroupDescription,

           --surveyquestion Params
           Answer.Id                                                                         as AnswerId,
           Answer.[Text]                                                                     as AnswerText,
           Answer.ReasonSelectOption                                                         as AnswerReasonSelectOption,
           Answer.ReasonInputType                                                            as AnswerReasonInputType,
           Answer.PhotoUploadOption                                                          as AnswerPhotoUploadOption,
           Answer.OrderNumber                                                                as AnswerOrderNumber,

           -- question answer params
           AnswerType.Id                                                                     as AnswerTypeId,
           AnswerType.Name                                                                   as AnswerTypeName,
           AnswerType.IsAnswerFree                                                           as IsAnswerFree,

           -- question answertype params
           QuestionFile.Id                                                                   as QuestionAttachmentId,
           QuestionFile.Url                                                                  as QuestionAttachmentUrl,
           QuestionFile.SecureUrl                                                            as QuestionSecureUrl,
           SurveyFile.Id                                                                     as SurveyAttachmentId,
           SurveyFile.Url                                                                    as SurveyAttachmentUrl,
           SurveyFile.SecureUrl                                                              as SurveySecureUrl,
           null                                                                              as QuestionTagId,
           null                                                                              as QuestionTag,
           null                                                                              as SurveyTagId,
           null                                                                              as SurveyTag,
           Reason.ReasonId                                                                   as AnswerSelectReasonId
    from UserSurveys
             join CHL_Survey Survey with (nolock) on UserSurveys.SurveyId = Survey.Id
             join CHL_SurveyQuestion SurveyQuestion with (nolock) on SurveyQuestion.SurveyId = Survey.Id
             join CHL_Question Question with (nolock) on Question.Id = SurveyQuestion.QuestionId
             join CHL_AnswerType AnswerType with (nolock) on AnswerType.Id = Question.AnswerTypeId

             left join CHL_QuestionGroup QuestionGroup with (nolock) on Question.QuestionGroupId = QuestionGroup.Id
             left join CHL_Answer Answer with (nolock) on Answer.QuestionId = Question.Id and ViewType = 1
             left join CHL_Attachment QuestionFile with (nolock) on QuestionFile.Type = 1 and QuestionFile.ReferenceId = Question.Id
             left join CHL_Attachment SurveyFile with (nolock) on SurveyFile.Type = 0 and SurveyFile.ReferenceId = Survey.Id

             left join (select Reason.QuestionId, Reason.ReasonId
                        from CHL_QuestionAnswerSelectReason Reason with (nolock)
                                 join MD_StopReason Definition on Definition.Type = 3
                            and Definition.IsDeleted = 0
                            and Definition.Id = Reason.ReasonId) Reason on Reason.QuestionId = Question.Id
    where Survey.EndDate > DATEADD(DAY, -30, GETDATE())
      and NOT (Survey.Status = 1 and Survey.ModifiedDate < @notConsiderPassiveSurveysDate)
    order by SurveyId, QuestionId, AnswerId
End
go