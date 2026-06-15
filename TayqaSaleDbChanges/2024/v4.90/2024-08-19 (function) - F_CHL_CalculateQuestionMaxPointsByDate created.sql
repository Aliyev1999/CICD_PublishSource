
CREATE FUNCTION [dbo].[F_CHL_CalculateQuestionMaxPointsByDate](@surveyId int, @pointType tinyint, @Date datetime)
    Returns Table
        AS
        RETURN(select QuestionId, Point
               from F_CHL_CalculateQuestionMaxPointsAllByDate(@Date)
               where SurveyId = @surveyId
                 and PointType = @pointType)