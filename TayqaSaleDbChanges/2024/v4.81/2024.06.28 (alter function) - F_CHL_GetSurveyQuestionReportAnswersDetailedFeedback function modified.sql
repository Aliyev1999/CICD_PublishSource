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
        RETURN(

-- Case 4: Both @answersInSeparatedLines and @reasonsInSeparatedLines are 0

        with Answers as (SELECT distinct USRD1.UserSurveyResponseId,
                                         USRD1.QuestionId,
                                         ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS AS Answers,
                                         CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                    AS AnswerId
                         FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                                  JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                                  LEFT JOIN CHL_Answer A WITH (NOLOCK)
                                            ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                         WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                           AND USRD1.Id < 15502

                         UNION ALL

                         SELECT distinct USRD1.UserSurveyResponseId,
                                         USRD1.QuestionId,
                                         ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS AS Answers,
                                         CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                    AS AnswerId
                         FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                                  JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                                  LEFT JOIN CHL_Answer A WITH (NOLOCK)
                                            ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                         WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                           AND USRD1.Id >= 15502),
             AnswersAgg as (
-- Case 4: Both @answersInSeparatedLines and @reasonsInSeparatedLines are 0
                 SELECT UserSurveyResponseId,
                        QuestionId,
                        STRING_AGG(Answers, ' | ')  AS Answers,
                        STRING_AGG(AnswerId, ' | ') AS AnswerId
                 FROM Answers
                 GROUP BY UserSurveyResponseId, QuestionId
                 HAVING @answersInSeparatedLines = 0
                    AND @reasonsInSeparatedLines = 0),

             Reasons as (SELECT distinct USRD1.UserSurveyResponseId,
                                         USRD1.QuestionId,
                                         ISNULL(USRD1.ReasonValue, SR.[Name]) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                                         CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END             AS ReasonType
                         FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                                  JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                                  LEFT JOIN MD_StopReason SR WITH (NOLOCK)
                                            ON USRD1.ReasonId IS NOT NULL AND USRD1.ReasonId = SR.Id AND SR.Type = 3
                         WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                           AND USRD1.Id < 15502
                           AND (@reasonTypes IS NULL OR
                                (CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END) IN
                                (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                           AND (@reasonIds IS NULL OR SR.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))

                         UNION ALL

                         SELECT distinct USRD1.UserSurveyResponseId,
                                         USRD1.QuestionId,
                                         COALESCE(reason.Value, USRD1.ReasonValue, Reason2.Name) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                                         CASE
                                             WHEN reason.Type = 1 THEN '1'
                                             WHEN reason.Type = 2 THEN '2'
                                             WHEN reason.Type IN (3, 4) THEN '3'
                                             END                                                                                      AS ReasonType
                         FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                                  JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                                  LEFT JOIN CHL_Answer A WITH (NOLOCK)
                                            ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                                  LEFT JOIN CHL_UserSurveyResponseDetailReason reason WITH (NOLOCK)
                                            ON USRD1.Id = reason.UserSurveyResponseDetailId AND
                                               USRD1.AnswerId = reason.AnswerId
                                  LEFT JOIN MD_StopReason Reason2 WITH (NOLOCK)
                                            ON reason.Type IN (1, 2) AND reason.ReasonId = Reason2.Id
                         WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                           AND USRD1.Id >= 15502
                           AND (@reasonTypes IS NULL OR (CASE
                                                             WHEN reason.Type = 1 THEN '1'
                                                             WHEN reason.Type = 2 THEN '2'
                                                             WHEN reason.Type IN (3, 4) THEN '3' END) IN
                                                        (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                           AND (@reasonIds IS NULL OR reason.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))),
             ReasonsAgg as (SELECT UserSurveyResponseId,
                                   QuestionId,
                                   STRING_AGG(Reasons, ' | ')    AS Reasons,
                                   STRING_AGG(ReasonType, ' | ') AS ReasonType
                            FROM Reasons
                            GROUP BY UserSurveyResponseId, QuestionId
                            HAVING @answersInSeparatedLines = 0
                               AND @reasonsInSeparatedLines = 0)


        select AnswersAgg.UserSurveyResponseId, AnswersAgg.QuestionId, AnswerId, Answers, Reasons, ReasonType
        from AnswersAgg
                 left join ReasonsAgg on AnswersAgg.UserSurveyResponseId = ReasonsAgg.UserSurveyResponseId and
                                         AnswersAgg.QuestionId = ReasonsAgg.QuestionId
        where (@reasonTypes IS NULL OR
               (SELECT COUNT(1) FROM F_SplitList(@reasonTypes, ',') WHERE CHARINDEX(value, ReasonType) > 0) > 0)
        union all


-- Case 1: Both @answersInSeparatedLines and @reasonsInSeparatedLines are 1
        SELECT distinct UserSurveyResponseId,
                        QuestionId,
                        Answers    AS Answers,
                        Reasons    AS Reasons,
                        ReasonType AS ReasonType,
                        AnswerId   AS AnswerId
        FROM (SELECT distinct USRD1.UserSurveyResponseId,
                              USRD1.QuestionId,
                              ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS  AS Answers,
                              ISNULL(USRD1.ReasonValue, SR.[Name]) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                              CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END             AS ReasonType,
                              CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                     AS AnswerId
              FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                       JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                       LEFT JOIN CHL_Answer A WITH (NOLOCK) ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                       LEFT JOIN MD_StopReason SR WITH (NOLOCK)
                                 ON USRD1.ReasonId IS NOT NULL AND USRD1.ReasonId = SR.Id AND SR.Type = 3
              WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                AND USRD1.Id < 15502
                AND (@reasonTypes IS NULL OR (CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END) IN
                                             (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                AND (@reasonIds IS NULL OR SR.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))

              UNION ALL

              SELECT distinct USRD1.UserSurveyResponseId,
                              USRD1.QuestionId,
                              ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS                     AS Answers,
                              COALESCE(reason.Value, USRD1.ReasonValue, Reason2.Name) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                              CASE
                                  WHEN reason.Type = 1 THEN '1'
                                  WHEN reason.Type = 2 THEN '2'
                                  WHEN reason.Type IN (3, 4) THEN '3'
                                  END                                                                                      AS ReasonType,
                              CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                                        AS AnswerId
              FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                       JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                       LEFT JOIN CHL_Answer A WITH (NOLOCK) ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                       LEFT JOIN CHL_UserSurveyResponseDetailReason reason WITH (NOLOCK)
                                 ON USRD1.Id = reason.UserSurveyResponseDetailId AND USRD1.AnswerId = reason.AnswerId
                       LEFT JOIN MD_StopReason Reason2 WITH (NOLOCK)
                                 ON reason.Type IN (1, 2) AND reason.ReasonId = Reason2.Id
              WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                AND USRD1.Id >= 15502
                AND (@reasonTypes IS NULL OR (CASE
                                                  WHEN reason.Type = 1 THEN '1'
                                                  WHEN reason.Type = 2 THEN '2'
                                                  WHEN reason.Type IN (3, 4) THEN '3' END) IN
                                             (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                AND (@reasonIds IS NULL OR reason.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))) AS Responses
        GROUP BY UserSurveyResponseId, QuestionId, Answers, Reasons, ReasonType, AnswerId
        HAVING @answersInSeparatedLines = 1
           AND @reasonsInSeparatedLines = 1
        UNION all
-- Case 2: @answersInSeparatedLines = 1 and @reasonsInSeparatedLines = 0
        SELECT UserSurveyResponseId,
               QuestionId,
               Answers                       AS Answers,
               STRING_AGG(Reasons, ' | ')    AS Reasons,
               STRING_AGG(ReasonType, ' | ') AS ReasonType,
               AnswerId                      AS AnswerId
        FROM (SELECT USRD1.UserSurveyResponseId,
                     USRD1.QuestionId,
                     ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS  AS Answers,
                     ISNULL(USRD1.ReasonValue, SR.[Name]) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                     CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END             AS ReasonType,
                     CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                     AS AnswerId
              FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                       JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                       LEFT JOIN CHL_Answer A WITH (NOLOCK) ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                       LEFT JOIN MD_StopReason SR WITH (NOLOCK)
                                 ON USRD1.ReasonId IS NOT NULL AND USRD1.ReasonId = SR.Id AND SR.Type = 3
              WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                AND USRD1.Id < 15502
                AND (@reasonTypes IS NULL OR (CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END) IN
                                             (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                AND (@reasonIds IS NULL OR SR.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))

              UNION ALL

              SELECT USRD1.UserSurveyResponseId,
                     USRD1.QuestionId,
                     ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS                     AS Answers,
                     COALESCE(reason.Value, USRD1.ReasonValue, Reason2.Name) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                     CASE
                         WHEN reason.Type = 1 THEN '1'
                         WHEN reason.Type = 2 THEN '2'
                         WHEN reason.Type IN (3, 4) THEN '3'
                         END                                                                                      AS ReasonType,
                     CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                                        AS AnswerId
              FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                       JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                       LEFT JOIN CHL_Answer A WITH (NOLOCK) ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                       LEFT JOIN CHL_UserSurveyResponseDetailReason reason WITH (NOLOCK)
                                 ON USRD1.Id = reason.UserSurveyResponseDetailId AND USRD1.AnswerId = reason.AnswerId
                       LEFT JOIN MD_StopReason Reason2 WITH (NOLOCK)
                                 ON reason.Type IN (1, 2) AND reason.ReasonId = Reason2.Id
              WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                AND USRD1.Id >= 15502
                AND (@reasonTypes IS NULL OR (CASE
                                                  WHEN reason.Type = 1 THEN '1'
                                                  WHEN reason.Type = 2 THEN '2'
                                                  WHEN reason.Type IN (3, 4) THEN '3' END) IN
                                             (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                AND (@reasonIds IS NULL OR reason.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))) AS Responses

        GROUP BY UserSurveyResponseId, QuestionId, Answers, AnswerId
        HAVING @answersInSeparatedLines = 1
           AND @reasonsInSeparatedLines = 0

        UNION ALL

-- Case 3: @answersInSeparatedLines = 0 and @reasonsInSeparatedLines = 1
        SELECT UserSurveyResponseId,
               QuestionId,
               STRING_AGG(Answers, ' | ')  AS Answers,
               Reasons                     AS Reasons,
               ReasonType                  AS ReasonType,
               STRING_AGG(AnswerId, ' | ') AS AnswerId
        FROM (SELECT USRD1.UserSurveyResponseId,
                     USRD1.QuestionId,
                     ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS  AS Answers,
                     ISNULL(USRD1.ReasonValue, SR.[Name]) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                     CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END             AS ReasonType,
                     CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                     AS AnswerId
              FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                       JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                       LEFT JOIN CHL_Answer A WITH (NOLOCK) ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                       LEFT JOIN MD_StopReason SR WITH (NOLOCK)
                                 ON USRD1.ReasonId IS NOT NULL AND USRD1.ReasonId = SR.Id AND SR.Type = 3
              WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                AND USRD1.Id < 15502
                AND (@reasonTypes IS NULL OR (CASE WHEN USRD1.ReasonValue IS NOT NULL THEN '3' ELSE '1' END) IN
                                             (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                AND (@reasonIds IS NULL OR SR.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))

              UNION ALL

              SELECT USRD1.UserSurveyResponseId,
                     USRD1.QuestionId,
                     ISNULL(USRD1.AnswerValue, A.[Text]) COLLATE SQL_Latin1_General_CP1_CI_AS                     AS Answers,
                     COALESCE(reason.Value, USRD1.ReasonValue, Reason2.Name) COLLATE SQL_Latin1_General_CP1_CI_AS AS Reasons,
                     CASE
                         WHEN reason.Type = 1 THEN '1'
                         WHEN reason.Type = 2 THEN '2'
                         WHEN reason.Type IN (3, 4) THEN '3'
                         END                                                                                      AS ReasonType,
                     CAST(USRD1.AnswerId AS NVARCHAR(MAX))                                                        AS AnswerId
              FROM CHL_UserSurveyResponseDetail USRD1 WITH (NOLOCK)
                       JOIN CHL_UserSurveyResponse USR WITH (NOLOCK) ON USRD1.UserSurveyResponseId = USR.Id
                       LEFT JOIN CHL_Answer A WITH (NOLOCK) ON USRD1.AnswerId IS NOT NULL AND USRD1.AnswerId = A.Id
                       LEFT JOIN CHL_UserSurveyResponseDetailReason reason WITH (NOLOCK)
                                 ON USRD1.Id = reason.UserSurveyResponseDetailId AND USRD1.AnswerId = reason.AnswerId
                       LEFT JOIN MD_StopReason Reason2 WITH (NOLOCK)
                                 ON reason.Type IN (1, 2) AND reason.ReasonId = Reason2.Id
              WHERE USR.SavedDate BETWEEN @beginDate AND @endDate
                AND USRD1.Id >= 15502
                AND (@reasonTypes IS NULL OR (CASE
                                                  WHEN reason.Type = 1 THEN '1'
                                                  WHEN reason.Type = 2 THEN '2'
                                                  WHEN reason.Type IN (3, 4) THEN '3' END) IN
                                             (SELECT value FROM F_SplitList(@reasonTypes, ',')))
                AND (@reasonIds IS NULL OR reason.Id IN (SELECT value FROM F_SplitList(@reasonIds, ',')))) AS Responses
        GROUP BY UserSurveyResponseId, QuestionId, Reasons, ReasonType
        HAVING @answersInSeparatedLines = 0
           AND @reasonsInSeparatedLines = 1)
go