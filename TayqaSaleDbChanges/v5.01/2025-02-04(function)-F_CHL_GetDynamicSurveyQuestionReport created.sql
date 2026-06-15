CREATE OR ALTER function [dbo].[F_CHL_GetDynamicSurveyQuestionReport]
    (
        @userSurveyResponseId int,
        @questionCodeName nvarchar(200),
        @answered bit,
        @currentUserId int
        )
    returns table
        as
        return
            (

			with UniqueAttachments as (select ReferenceId,
                                  string_agg(SecureUrl,',') as Files
                           from CHL_Attachment attachment with (nolock)
                                     join CHL_UserDynamicSurveyResponseDetail detail with (nolock)
                                              on detail.Id = attachment.ReferenceId and Type=3
                          where Detail.UserSurveyResponseId = @userSurveyResponseId
                           group by ReferenceId)


select distinct isnull(SurveyQuestion.OrderNumber,'')     as OrderNumber,
       isnull(Detail.QuestionCode ,'')                    as QuestionCode,
       isnull(QuestionName ,'' )                          as QuestionName,
       isnull(QuestionDescription ,'')                    as QuestionDescription,
       isnull(detail.Answer,Detail.AnswerValue)           as Answer,
       string_agg( coalesce(NewReason.Value, Reason.Name collate SQL_Latin1_General_CP1_CI_AS) ,'|')           as Reason,
       isnull(SurveyQuestion.CreatedDate ,'')             as CreatedDate,
       isnull(attachments.Files, '')                      as Attachment 
from CHL_UserSurveyResponse Response with (nolock)
         join CHL_UserDynamicSurveyResponseDetail Detail with (nolock) on Detail.UserSurveyResponseId = Response.Id
         left join CHL_SurveyQuestion SurveyQuestion with (nolock) on SurveyQuestion.SurveyId = Response.SurveyId
		 left join CHL_UserDynamicSurveyResponseDetailReason NewReason with (nolock) on NewReason.UserDynamicSurveyResponseDetailId = Detail.Id
         left join MD_StopReason Reason with (nolock) on Reason.Id = NewReason.ReasonId
         left join UniqueAttachments attachments on attachments.ReferenceId = Detail.Id
where Response.Id = @userSurveyResponseId
  and (@questionCodeName is null or Detail.QuestionCode like '%' + @questionCodeName + '%' or QuestionName like '%' + @questionCodeName + '%')
  and (@answered is null
    or (@answered = 0 and Detail.Answer is not null)
    or (@answered = 1 and Detail.Answer is null))
	group by SurveyQuestion.OrderNumber,Detail.QuestionCode ,QuestionName,QuestionDescription,detail.Answer,Detail.AnswerValue,SurveyQuestion.CreatedDate,attachments.Files


            );