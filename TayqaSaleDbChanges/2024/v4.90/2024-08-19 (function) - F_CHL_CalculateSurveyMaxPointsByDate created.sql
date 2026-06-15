
CREATE   FUNCTION [dbo].[F_CHL_CalculateSurveyMaxPointsByDate](@Date datetime, @pointType tinyint)
    Returns Table
        AS
        RETURN
        select SurveyId, Point
        from F_CHL_CalculateSurveyMaxPointsAllByDate(@Date)
        where PointType = @pointType