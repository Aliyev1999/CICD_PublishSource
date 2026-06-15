CREATE OR ALTER FUNCTION [dbo].[F_CHL_GetSurveyDetailedFeedback]
(
    @pointType tinyint,
    @startDate datetime,
    @endDate datetime,
    @answersInSeperatedLines bit,
    @reasonsInSeparatedLines bit,
    @reasonTypes nvarchar(max),
    @reasonIds nvarchar(max),
    @currentUserId bigint,
    @userIds nvarchar(max),
    @questionStatus bit,
    @searchForStaticAnswers bit,
    @staticAnswers nvarchar(max),
    @answerTxt nvarchar(200)
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT USR.Id ReportId,
           USR.UserId,
           USR.ClientId,
           S.Id SurveyId,
           S.Name SurveyName,
           Q.Id QuestionId,
           Q.AnswerTypeId QuestionAnswerTypeId,
           Q.Name QuestionName,
           SQ.IsAnswerRequired,
           USR.SavedDate,
           ANS.Answers,
           ANS.Reasons,
           ANS.AnswerId,
           P.Point,
           SQ.Status,
           ANS.ReasonType
    FROM CHL_UserSurveyResponse USR
    JOIN CHL_Survey S ON S.Id = USR.SurveyId
    JOIN CHL_SurveyQuestion SQ ON SQ.SurveyId = S.Id
	JOIN F_GetPermittedUsers(@currentUserId) PermittedUsers ON PermittedUsers.UserId = USR.UserId
    JOIN CHL_Question Q ON SQ.QuestionId = Q.Id
    JOIN [dbo].[F_CHL_GetSurveyQuestionReportAnswersDetailedFeedback](
        @startDate, @endDate, @answersInSeperatedLines, @reasonsInSeparatedLines, @reasonTypes, @reasonIds
    ) ANS ON ANS.UserSurveyResponseId = USR.Id AND ANS.QuestionId = Q.Id
    LEFT JOIN dbo.F_CHL_CalculateUserQuestionPointsAllNewWithDate(@startDate, @endDate) P ON P.ReportId = USR.Id
        AND P.QuestionId = Q.Id
    WHERE (P.PointType IS NULL OR P.PointType = @pointType)
          AND USR.SavedDate >= @startDate
          AND USR.SavedDate <= @endDate
          AND (@userIds IS NULL OR USR.UserId IN (SELECT LTRIM(Value) COLLATE SQL_Latin1_General_CP1_CI_AS FROM F_SplitList(@userIds, ',')))
          AND (@questionStatus IS NULL OR SQ.Status = @questionStatus)
          AND (
              (@staticAnswers IS NULL AND ANS.Answers IS NULL) 
    OR (@searchForStaticAnswers = 1 
        AND (@staticAnswers IS NOT NULL 
             AND ANS.Answers COLLATE SQL_Latin1_General_CP1_CI_AS IN 
                (SELECT Value COLLATE SQL_Latin1_General_CP1_CI_AS FROM F_SplitList(@staticAnswers, ','))))
    OR (@searchForStaticAnswers = 0 
        AND (@answerTxt IS NULL 
             OR ANS.Answers COLLATE SQL_Latin1_General_CP1_CI_AS LIKE '%' + @answerTxt + '%')))
);
