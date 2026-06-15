CREATE OR ALTER FUNCTION [dbo].[F_CHL_GetSurveyDetailedFeedback](
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
        RETURN(SELECT UserResponse.Id                  AS ReportId,
                      UserResponse.UserId              AS UserId,
                      UserResponse.ClientId            AS ClientId,
                      Survey.Id                        AS SurveyId,
                      Survey.Name                      AS SurveyName,
                      Question.Id                      AS QuestionId,
                      Question.AnswerTypeId            AS QuestionAnswerTypeId,
                      Question.Name                    AS QuestionName,
                      SurveyQuestion.IsAnswerRequired  AS IsAnswerRequired,
                      UserResponse.SavedDate           AS SavedDate,
                      detail.Answers                   AS Answers,
                      detail.Reasons                   AS Reasons,
                      detail.AnswerId                  AS AnswerId,
                      Point.Point                      AS Point,
                      SurveyQuestion.Status            AS Status,
                      detail.ReasonType                AS ReasonType,
                      Question.RatingAnswerSymbolType  AS RatingAnswerSymbolType,
                      Question.RatingAnswerSymbolCount As RatingAnswerSymbolCount

               FROM CHL_UserSurveyResponse UserResponse with (nolock)
                        JOIN CHL_Survey Survey with (nolock) ON Survey.Id = UserResponse.SurveyId
                        JOIN CHL_SurveyQuestion SurveyQuestion with (nolock) ON SurveyQuestion.SurveyId = Survey.Id
                        JOIN F_GetPermittedUsers(@currentUserId) PermittedUsers
                             ON PermittedUsers.UserId = UserResponse.UserId
                        JOIN CHL_Question Question with (nolock) ON SurveyQuestion.QuestionId = Question.Id
                        JOIN [dbo].[F_CHL_GetSurveyQuestionReportAnswersDetailedFeedback](
                       @startDate, @endDate, @answersInSeperatedLines, @reasonsInSeparatedLines, @reasonTypes,
                       @reasonIds) detail
                             ON detail.UserSurveyResponseId = UserResponse.Id AND detail.QuestionId = Question.Id
                        LEFT JOIN dbo.F_CHL_CalculateUserQuestionPointsAllNewWithDate(@startDate, @endDate) Point ON Point.ReportId = UserResponse.Id
                   AND Point.QuestionId = Question.Id

               WHERE (Point.PointType IS NULL OR Point.PointType = @pointType)
                 AND UserResponse.SavedDate BETWEEN @startDate and @endDate
                 AND (nullif(@userIds, '') IS NULL OR UserResponse.UserId IN
                                                      (SELECT LTRIM(Value) COLLATE SQL_Latin1_General_CP1_CI_AS
                                                       FROM F_SplitList(@userIds, ',')))
                 AND (@questionStatus IS NULL OR SurveyQuestion.Status = @questionStatus)
                 AND (@searchForStaticAnswers = 1 and
                      (@staticAnswers = '0' AND detail.Answers = 'No')
                   OR (@staticAnswers = '1' AND detail.Answers = 'Yes')
                   OR (@staticAnswers = '0,1' AND detail.Answers IN ('Yes', 'No'))
                   OR (@staticAnswers IS NULL AND detail.Answers IS NULL)
                   OR (@staticAnswers = '' AND detail.Answers IN ('Yes', 'No'))
                   OR @searchForStaticAnswers = 0
                   )
                 and (@searchForStaticAnswers = 0 AND (nullif(@answerTxt, '') IS NULL OR
                                                       detail.Answers COLLATE SQL_Latin1_General_CP1_CI_AS LIKE
                                                       '%' + @answerTxt + '%')
                   OR @searchForStaticAnswers = 1))