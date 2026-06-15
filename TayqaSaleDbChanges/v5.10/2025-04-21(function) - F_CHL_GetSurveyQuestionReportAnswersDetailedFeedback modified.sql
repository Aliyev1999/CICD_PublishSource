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




-- case 1: @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 1 -> simple select
        if @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 1
            insert into @T (UserSurveyResponseId, QuestionId, Answers, Reasons, ReasonType, AnswerId)
            select UserSurveyResponseId, QuestionId, Answer as Answers, isnull(Reason, '') as Reasons, ReasonType, AnswerId
            from F_CHL_GetSurveyQuestionReasonsAnswer(   @beginDate , @endDate , @reasonTypes ,@reasonIds)

-- case 2: @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 0 -> Reasons grouped
        if @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 0
            insert into @T (UserSurveyResponseId, QuestionId, Answers, Reasons, ReasonType, AnswerId)
            select UserSurveyResponseId,
                   QuestionId,
                   Answer                                as Answers,
                   isnull(string_agg(Reason, ' / '), '') as Reasons,
                   string_agg(ReasonType, '|')           as ReasonType,
                   AnswerId
            from F_CHL_GetSurveyQuestionReasonsAnswer(   @beginDate , @endDate , @reasonTypes ,@reasonIds)
            group by UserSurveyResponseId, QuestionId, Answer, AnswerId

-- case 3: @answersInSeparatedLines = 0 and @reasonsInSeparatedLines = 0
        if @answersInSeparatedLines = 0 --and @reasonsInSeparatedLines = 0
            with AggAnswers as (select UserSurveyResponseId,
                                       QuestionId,
                                       AnswerId                      AS AnswerId,
                                       Answer                        as Answer,
                                       string_agg(Reason, ' / ')     as Reasons,
                                       string_agg(ReasonType, ' / ') as ReasonType
                                from F_CHL_GetSurveyQuestionReasonsAnswer(   @beginDate , @endDate , @reasonTypes ,@reasonIds)
                                group by UserSurveyResponseId, QuestionId, AnswerId, Answer)
            insert
            into @T (UserSurveyResponseId, QuestionId, Answers, Reasons, ReasonType, AnswerId)
            select UserSurveyResponseId                   AS UserSurveyResponseId,
                   QuestionId                             AS QuestionId,
                   string_agg(Answer, ' | ')              as Answers,
                   isnull(string_agg(Reasons, ' | '), '') as Reasons,
                   string_agg(ReasonType, '|')            as ReasonType,
                   string_agg(AnswerId, ' | ')            as AnswerId

            from AggAnswers
            group by UserSurveyResponseId, QuestionId

-- case 4: @answersInSeparatedLines = 0 and @reasonsInSeparatedLines = 1 -> not possible


        return
    end

