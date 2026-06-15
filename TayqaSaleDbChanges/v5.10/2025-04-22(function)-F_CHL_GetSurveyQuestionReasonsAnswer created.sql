CREATE OR ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionReasonsAnswer](
    @beginDate DATETIME,
    @endDate DATETIME,
    @reasonTypes NVARCHAR(MAX),
    @reasonIds NVARCHAR(MAX)
    )
      RETURNS TABLE
        AS
        RETURN

        with AllReasons as (select Response.Id                               as UserSurveyResponseId,
                                   Detail.QuestionId                         as QuestionId,
                                   Answer.Id                                 as AnswerId,
                                   coalesce(Answer.Text, Detail.AnswerValue) as Answer,
                                   coalesce(NewReason.Value,
                                            Detail.ReasonValue,
                                            OldContent.Name collate SQL_Latin1_General_CP1_CI_AS,
                                            NewContent.Name collate SQL_Latin1_General_CP1_CI_AS
                                       --,'NoReason'
                                   )                                         as Reason,

                                   --coalesce(NewReason. Type, 1)               as ReasonType,
                                   case
                                       when NewReason.Type is not null then NewReason.Type
                                       when NewReason.Type is null and (Detail.ReasonId is not null or Detail.ReasonValue is not null) then 1
                                       end                                   as ReasonType,
                                   case
                                       when coalesce(NewReason.Value collate SQL_Latin1_General_CP1_CI_AS, Detail.ReasonValue) is not null then 0
                                       else
                                           coalesce(Detail.ReasonId, NewReason.ReasonId)
                                       end                                   as ReasonId
                            from CHL_UserSurveyResponseDetail Detail with (nolock)
                                     join CHL_UserSurveyResponse Response with (nolock) on Response.Id = Detail.UserSurveyResponseId
                                     left join CHL_Answer Answer with (nolock) on Answer.Id = Detail.AnswerId
                                     left join CHL_UserSurveyResponseDetailReason NewReason with (nolock) on NewReason.UserSurveyResponseDetailId = Detail.Id
                                     left join MD_StopReason OldContent with (nolock) on OldContent.Id = NewReason.ReasonId
                                     left join MD_StopReason NewContent with (nolock) on NewContent.Id = Detail.ReasonId

                            where Response.SavedDate between @beginDate and @endDate)


        select UserSurveyResponseId, QuestionId, AnswerId, Answer, ReasonType, Reason
        from AllReasons
        where (@reasonTypes is null or ReasonType in (select value from string_split(@reasonTypes, ',')))
          and (@reasonIds is null or ReasonId in (select value from string_split(@reasonIds, ',')))