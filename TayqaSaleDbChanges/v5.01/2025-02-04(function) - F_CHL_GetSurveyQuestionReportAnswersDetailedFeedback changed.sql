CREATE OR ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionReportAnswersDetailedFeedback](
    @beginDate DATETIME,
    @endDate DATETIME,
    @answersInSeparatedLines BIT,
    @reasonsInSeparatedLines BIT,
    @reasonTypes NVARCHAR(MAX),
    @reasonIds NVARCHAR(MAX)
)
    RETURNS @T TABLE
               (
                   UserSurveyResponseId int,
                   QuestionId           int,
                   Answers              nvarchar(max),
                   Reasons              nvarchar(max),
                   ReasonType           nvarchar(1000),
                   AnswerId             nvarchar(1000)
               )
AS
begin

    set @reasonIds = nullif(@reasonIds, '')
    set @reasonTypes = nullif(@reasonTypes, '')

    declare @Data table
                  (
                      UserSurveyResponseId int,
                      QuestionId           int,
                      AnswerId             int,
                      Answer               nvarchar(max),
                      ReasonType           tinyint,
                      ReasonId             int,
                      Reason               nvarchar(max)
                  );

    with AllReasons as (select Response.Id                               as UserSurveyResponseId,
                               Detail.QuestionId                         as QuestionId,
                               Answer.Id                                 as AnswerId,
                               coalesce(Answer.Text, Detail.AnswerValue) as Answer,
                               coalesce(NewReason.Value,
                                        Detail.ReasonValue,
                                        OldContent.Name collate SQL_Latin1_General_CP1_CI_AS,
                                        NewContent.Name collate SQL_Latin1_General_CP1_CI_AS
										--,'NoReason'
										)                      as Reason,

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

    insert
    into @Data (UserSurveyResponseId, QuestionId, AnswerId, Answer, ReasonType, Reason)
    select UserSurveyResponseId, QuestionId, AnswerId, Answer, ReasonType, Reason
    from AllReasons
    where (@reasonTypes is null or ReasonType in (select value from string_split(@reasonTypes, ',')))
      and (@reasonIds is null or ReasonId in (select value from string_split(@reasonIds, ',')))


-- case 1: @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 1 -> simple select
    if @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 1
        insert into @T (UserSurveyResponseId, QuestionId, Answers, Reasons, ReasonType, AnswerId)
        select UserSurveyResponseId, QuestionId, Answer as Answers, isnull(Reason , '') as Reasons, ReasonType, AnswerId
        from @Data

-- case 2: @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 0 -> Reasons grouped
    if @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 0
        insert into @T (UserSurveyResponseId, QuestionId, Answers, Reasons, ReasonType, AnswerId)
        select UserSurveyResponseId,
               QuestionId,
               Answer                                  as Answers,
               isnull(string_agg(Reason, ' / '), '') as Reasons,
               string_agg(ReasonType, '|')             as ReasonType,
               AnswerId
        from @Data
        group by UserSurveyResponseId, QuestionId, Answer, AnswerId

-- case 3: @answersInSeparatedLines = 0 and @reasonsInSeparatedLines = 0
    if @answersInSeparatedLines = 0 --and @reasonsInSeparatedLines = 0
        insert into @T (UserSurveyResponseId, QuestionId, Answers, Reasons, ReasonType, AnswerId)
select UserSurveyResponseId,
               QuestionId,
               (select  string_agg(Answers, ' | ') 
            from (select distinct Answer as Answers 
                  from @Data D 
                  where D.UserSurveyResponseId = T.UserSurveyResponseId 
                    and D.QuestionId = T.QuestionId) SubQuery) as Answers,
               isnull(string_agg(Reasons, ' | '), '') as Reasons,
               string_agg(ReasonType, '|')                                  as ReasonType,
                 string_agg(AnswerId, ' | ') 
             as AnswerId
        from (select UserSurveyResponseId,
                     QuestionId,
                     Answer                                          as Answers,
                     string_agg(Reason, ' / ') as Reasons,
                     ReasonType                                      as ReasonType,
                     AnswerId
              from @Data
              group by UserSurveyResponseId, QuestionId, Answer, AnswerId, ReasonType) T
        group by UserSurveyResponseId, QuestionId
-- case 4: @answersInSeparatedLines = 0 and @reasonsInSeparatedLines = 1 -> not possible


    return
end