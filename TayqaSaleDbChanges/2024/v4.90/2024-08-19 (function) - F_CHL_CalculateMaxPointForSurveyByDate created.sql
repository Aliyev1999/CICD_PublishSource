
CREATE FUNCTION [dbo].[F_CHL_CalculateMaxPointForSurveyByDate](@SurveyId int, @Date datetime, @pointType tinyint)
    Returns float
as
begin
    declare @Point float = (select Point
                            from F_CHL_CalculateSurveyMaxPointsAllByDate(@Date)
                            where PointType = @pointType
                              and SurveyId = @SurveyId)
    return @Point
end