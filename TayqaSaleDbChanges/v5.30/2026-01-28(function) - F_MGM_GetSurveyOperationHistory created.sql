CREATE OR  ALTER FUNCTION [dbo].[F_MGM_GetSurveyOperationHistory](
    @UserId bigint,
    @ClientId bigint,
    @SurveyId int
)
RETURNS TABLE
AS
RETURN
(
with Reasons as (select distinct Detail.Id                                                                                    as DetailId,
                                 Detail.QuestionId                                                                            as QuestionId,
                                 Answer.Id                                                                                    as AnswerId,
                                 coalesce(Answer.Text, Detail.AnswerValue) collate SQL_Latin1_General_CP1_CI_AS               as Answer,
                                 coalesce(NewReason.Value, Reason.Name collate SQL_Latin1_General_CP1_CI_AS, NewReason.Value) as Reason,
                                 NewReason.Type as NewReasonType
                 from CHL_UserSurveyResponseDetail Detail with (nolock)
                          left join CHL_Answer Answer with (nolock) on Answer.Id = Detail.AnswerId
                          left join CHL_UserSurveyResponseDetailReason NewReason with (nolock) on NewReason.UserSurveyResponseDetailId = Detail.Id
                          left join CHL_Reasons reasons with (nolock) on NewReason.ReasonId = reasons.ReasonId
                          left join MD_StopReason Reason with (nolock) on Reason.Id = NewReason.ReasonId
                 where Detail.UserSurveyResponseId = @SurveyId 

                 union all

                 select distinct Detail.Id                                                                                    as DetailId,
                                 Detail.Id                                                                                    as QuestionId,
                                 null                                                                                         as AnswerId,
                                 Detail.AnswerValue                                                                           as Answer,
                                 coalesce(NewReason.Value, Reason.Name, NewReason.Value) collate SQL_Latin1_General_CP1_CI_AS as Reason,
                                 NewReason.Type as NewReasonType
                 from CHL_UserDynamicSurveyResponseDetail Detail with (nolock)
                          left join CHL_UserDynamicSurveyResponseDetailReason NewReason with (nolock) on NewReason.UserDynamicSurveyResponseDetailId = Detail.Id
                          left join CHL_Reasons reasons with (nolock) on NewReason.ReasonId = reasons.ReasonId
                          left join MD_StopReason Reason with (nolock) on Reason.Id = NewReason.ReasonId
                 where Detail.UserSurveyResponseId = @SurveyId),

     attachments as (       SELECT 
            attachment.DetailId,
            attachment.AnswerId,
			attachment.AnswerValue,
            STRING_AGG(attachment.Url, ',') AS AnswerAttachmentURL,
            attachment.AttachmentId AS AnswerAttachmentId
        FROM (
            SELECT DISTINCT 
                detail.Id AS DetailId,
                detail.AnswerId,
				detail.AnswerValue,
                attachment.Url,
                attachment.Id AS AttachmentId
            FROM CHL_UserSurveyResponseDetail detail WITH (NOLOCK)
            JOIN CHL_Attachment attachment WITH (NOLOCK)
                ON attachment.ReferenceId = detail.Id AND attachment.Type = 3
            WHERE detail.UserSurveyResponseId = @SurveyId
        ) attachment
        GROUP BY attachment.DetailId, attachment.AnswerId,attachment.AnswerValue,attachment.AttachmentId)

select distinct survey.Name                      as SurveyName,
                questiongroupe.Name              as GroupName,
                questiongroupe.Code              as GroupCode,
                questiongroupe.Description       as GroupDescription,
                detail.QuestionId                as QuestionId,
                question.AnswerTypeId            as QuestionType,
                question.Name                    as QuestionName,
                question.Code                    as QuestionCode,
                question.Description             as QuestionDescription,
                normative.Text                   as NormativeText,
				attach.AnswerAttachmentId as AnswerAttachmentId, 
                attach.AnswerAttachmentURL as AnswerAttachmentUrl,
                reason.AnswerId                  as AnswerId,
                reason.Answer                    as AnswerValue,
                iif(reason.Answer is null, 0, 1) as IsSelected,
                question.ReasonLabel             as ReasonLabel,
                reason.Reason                    as ReasonName,
                case
                    when  NewReasonType is not null and reason.Reason is null then 0
                    when NewReasonType is not null and reason.Reason is not null then 1
                    else null
                    end                          as ReasonIsSelected,
                case
                    when NewReasonType = 1 then 2
                    when NewReasonType = 2 then 1
                    else 3
                    end                          as SelectionType,
				question.RatingAnswerSymbolCount as RatingAnswerSymbolCount,
				case when 
				question.AnswerTypeId=5 and reason.Answer='Yes' then 1 
				when question.AnswerTypeId=5 and reason.Answer='No' then 2
				else
				question.RatingAnswerSymbolType end as ReactionType 
from CHL_UserSurveyResponseDetail detail with (nolock)
         join CHL_UserSurveyResponse response with (nolock) on detail.UserSurveyResponseId = response.Id
         join CHL_Survey survey with (nolock) on response.SurveyId = survey.Id
         join CHL_SurveyQuestion squestion with (nolock) on squestion.QuestionId = detail.QuestionId
         join CHL_Question question with (nolock) on question.Id = squestion.QuestionId
         left join CHL_QuestionGroup questiongroupe with (nolock) on questiongroupe.Id = question.QuestionGroupId
         left join Reasons reason with (nolock) on detail.Id = reason.DetailId
         left join CHL_QuestionNormativeMapping mapping with (nolock) on mapping.QuestionId = question.Id
         left join CHL_Normative normative with (nolock) on normative.Id = mapping.NormativeId
         left join attachments attach on attach.AnswerId = detail.AnswerId or (attach.AnswerId is null and attach.AnswerValue=detail.AnswerValue)
where detail.UserSurveyResponseId = @SurveyId
  and response.UserId = @UserId
  and response.ClientId = @ClientId
  and reason.Answer  is not null);


