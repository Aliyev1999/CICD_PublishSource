
ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionReportAnswersDetailedFeedback]
    (
        @beginDate DATETIME,
        @endDate DATETIME,
        @answersInSeparatedLines BIT,
        @reasonsInSeparatedLines BIT,
        @reasonTypes NVARCHAR(MAX),
        @reasonIds NVARCHAR(MAX)
        )
    RETURNS TABLE
        AS
        RETURN
            (


                with Answers as (SELECT USRD1.UserSurveyResponseId,
                                        USRD1.QuestionId,
                                        ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS AS Answers,
                                        CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                    AS AnswerId
                                 FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                                          JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                                          LEFT JOIN CHL_Answer A WITH (NOLOCK) ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                                 WHERE USR.SavedDate BETWEEN @beginDate AND @endDate),
                     AnswersAgg as (SELECT UserSurveyResponseId,
                                           QuestionId,
                                           STRING_AGG(Answers, ' | ')  AS Answers,
                                           STRING_AGG(AnswerId, ' | ') AS AnswerId
                                    FROM Answers
                                    GROUP BY UserSurveyResponseId, QuestionId),

                     Reasons as (SELECT USRD1.UserSurveyResponseId,
                                        USRD1.QuestionId,
                                        coalesce(USRD1.ReasonValue, SR.[Name], 'NoReason') COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                                        CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END                           AS ReasonType,
                                        CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                                   AS AnswerId
                                 FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                                          JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                                          LEFT JOIN MD_StopReason SR WITH (NOLOCK)
                                                    ON USRD1.ReasonId IS NOT NULL AND USRD1.ReasonId = SR.Id AND SR.Type = 3
                                 WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                                   AND USRD1.Id < 15502
                                   AND (@reasonTypes IS NULL OR (CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END) IN
                                                                (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                                   AND (@reasonIds IS NULL OR SR.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))

                                 UNION ALL

                                 SELECT Detail.UserSurveyResponseId,
                                        Detail.QuestionId,
                                        coalesce(NewReason.Value, Reason.Name collate SQL_Latin1_General_CP1_CI_AS, NewReason.Value,
                                                 'NoReason')                   as Reasons,
                                        CASE
                                            WHEN NewReason.Type = 1 THEN '1'
                                            WHEN NewReason.Type = 2 THEN '2'
                                            WHEN NewReason.Type IN (3, 4) THEN '3'
                                            END                                AS ReasonType,
                                        CAST(Detail.AnswerId AS NVARCHAR(MAX)) AS AnswerId
                                 from CHL_UserSurveyResponseDetail Detail with (nolock)
                                          join CHL_UserSurveyResponse USR WITH (NOLOCK) ON Detail.UserSurveyResponseId = USR.Id
                                          left join CHL_Answer Answer with (nolock) on Answer.Id = Detail.AnswerId
                                          left join CHL_UserSurveyResponseDetailReason NewReason with (nolock)
                                                    on NewReason.UserSurveyResponseDetailId = Detail.Id
                                          left join MD_StopReason Reason with (nolock) on Reason.Id = NewReason.ReasonId
                                 WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                                   AND Detail.Id >= 15502
                                   AND (@reasonTypes IS NULL OR
                                        (CASE WHEN NewReason.Type = 1 THEN '1' WHEN NewReason.Type = 2 THEN '2' WHEN NewReason.Type IN (3, 4) THEN '3' END) IN
                                        (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                                   AND (@reasonIds IS NULL OR reason.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))),
                     ReasonBeforeAgg as (select UserSurveyResponseId,
                                                QuestionId,
                                                isnull(string_agg(Reasons, ' / '), 'NoReason') as Reasons,
                                                STRING_AGG(ReasonType, ' / ')                  AS ReasonType,
                                                AnswerId
                                         from Reasons
                                         group by UserSurveyResponseId, QuestionId, AnswerId),

                     ReasonsAgg as (SELECT UserSurveyResponseId,
                                           QuestionId,
                                           string_agg(AnswerId, ' | ')                    as Answer,
                                           isnull(STRING_AGG(Reasons, ' | '), 'NoReason') AS Reasons,
                                           STRING_AGG(ReasonType, ' | ')                  AS ReasonType
                                    FROM ReasonBeforeAgg
                                    GROUP BY UserSurveyResponseId, QuestionId)

-- Case 1: Both @answersInSeparatedLines and @reasonsInSeparatedLines are 0
                select AnswersAgg.UserSurveyResponseId, AnswersAgg.QuestionId, Answers, Reasons, ReasonType, AnswerId
                from AnswersAgg
                         left join ReasonsAgg on AnswersAgg.UserSurveyResponseId = ReasonsAgg.UserSurveyResponseId and
                                                 AnswersAgg.QuestionId = ReasonsAgg.QuestionId
                where (@reasonTypes IS NULL OR (SELECT COUNT(1) FROM F_SplitList(@reasonTypes, ',') WHERE CHARINDEX(value, ReasonType) > 0) > 0)
                  and (@answersInSeparatedLines = 0
                    AND @reasonsInSeparatedLines = 0)
                union all


-- Case 2: Both @answersInSeparatedLines and @reasonsInSeparatedLines are 1
                SELECT distinct Answers.UserSurveyResponseId,
                                Answers.QuestionId,
                                Answers          AS Answers,
                                Reasons          AS Reasons,
                                ReasonType       AS ReasonType,
                                Answers.AnswerId AS AnswerId
                from Answers
                         left join Reasons on Answers.UserSurveyResponseId = Reasons.UserSurveyResponseId and Answers.QuestionId = Reasons.QuestionId
                where (@reasonTypes IS NULL OR (SELECT COUNT(1) FROM F_SplitList(@reasonTypes, ',') WHERE CHARINDEX(value, ReasonType) > 0) > 0)

                  and (@answersInSeparatedLines = 1
                    AND @reasonsInSeparatedLines = 1)
                UNION all
-- Case 3: @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 0
                select Answers.UserSurveyResponseId,
                       Answers.QuestionId,
                       Answers          AS Answers,
                       Reasons          AS Reasons,
                       ReasonType       AS ReasonType,
                       Answers.AnswerId AS AnswerId
                from Answers
                         left join ReasonsAgg
                                   on Answers.UserSurveyResponseId = ReasonsAgg.UserSurveyResponseId and Answers.QuestionId = ReasonsAgg.QuestionId
                where (@reasonTypes IS NULL OR (SELECT COUNT(1) FROM F_SplitList(@reasonTypes, ',') WHERE CHARINDEX(value, ReasonType) > 0) > 0)

                  and (@answersInSeparatedLines = 1
                    AND @reasonsInSeparatedLines = 0)

                UNION ALL

-- Case 4: @answersInSeparatedLines = 0 and @reasonsInSeparatedLines = 1
                SELECT AnswersAgg.UserSurveyResponseId,
                       AnswersAgg.QuestionId,
                       Answers,
                       Reasons             AS Reasons,
                       ReasonType          AS ReasonType,
                       AnswersAgg.AnswerId AS AnswerId
                from AnswersAgg
                         left join Reasons
                                   on AnswersAgg.UserSurveyResponseId = Reasons.UserSurveyResponseId and AnswersAgg.QuestionId = Reasons.QuestionId
                where (@reasonTypes IS NULL OR (SELECT COUNT(1) FROM F_SplitList(@reasonTypes, ',') WHERE CHARINDEX(value, ReasonType) > 0) > 0)


                  and (@answersInSeparatedLines = 0
                    AND @reasonsInSeparatedLines = 1)


            )