
ALTER FUNCTION [dbo].[F_CHL_GetSurveyQuestionGroupedReport](@reportId int, @surveyId int, @pointType tinyint) 
RETURNS TABLE
AS
RETURN(
SELECT
    QuestionId, 
    QuestionName,
    QuestionCode,
    ResponseRegisteredDate,
    QuestionDescription, 
    Specode1,
    Specode2,
    Specode3,
    QuestionType,
    CreatedDate,
    SUBSTRING(p3.Answers, 0, LEN(p3.Answers)) AS Answer,
    CASE SUBSTRING(p3.Reasons, 0, LEN(p3.Reasons))
        WHEN 'NoReason' THEN ''
        ELSE SUBSTRING(p3.Reasons, 0, LEN(p3.Reasons))
    END AS Reason,
    SUBSTRING(p3.QuestionReportIds, 0, LEN(p3.QuestionReportIds)) AS QuestionReportIds,
    IsAnswerRequired,
    Status,
    OrderNumber,
    GroupName,
    CASE p3.WeightingType
        WHEN 2 THEN SUM(UserPoint)
        ELSE MAX(UserPoint)
    END AS UserPoint, 
    MAX(MaxPoint) AS MaxPoint
FROM (
    SELECT *, 
        (SELECT DISTINCT Answer + ' | '
         FROM (
            SELECT DISTINCT Answer
            FROM F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p2
            WHERE p2.QuestionId = p1.QuestionId
        ) AS DistinctAnswers
         FOR XML PATH('')) AS Answers,
        (SELECT DISTINCT ISNULL(Reason, 'NoReason') + ' | '
         FROM (
            SELECT DISTINCT ISNULL(Reason, 'NoReason') AS Reason
            FROM F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p2
            WHERE p2.QuestionId = p1.QuestionId
        ) AS DistinctReasons
         FOR XML PATH('')) AS Reasons,
        (SELECT DISTINCT CAST(QuestionReportId AS VARCHAR(20)) + ','
         FROM (
            SELECT DISTINCT QuestionReportId
            FROM F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p2
            WHERE p2.QuestionId = p1.QuestionId
        ) AS DistinctQuestionReportIds
         FOR XML PATH('')) AS QuestionReportIds
    FROM F_CHL_GetSurveyQuestionReport(@reportId, @surveyId, @pointType) p1
) p3
GROUP BY 
    QuestionId,
    QuestionName,
    QuestionCode,
    ResponseRegisteredDate,
    QuestionDescription, 
    IsAnswerRequired,
    Status, 
    OrderNumber,
    GroupName, 
    WeightingType,
    Answers,
    Reasons, 
    QuestionReportIds,
    Specode1,
    Specode2,
    Specode3,
    QuestionType,
    CreatedDate
)
