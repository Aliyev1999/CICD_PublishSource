CREATE FUNCTION [dbo].[F_MGM_GetReferanceIdforOperations](
    @operationId INT,
    @operationType INT
)
    RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @result NVARCHAR(MAX);

    select @result = survey.Id
    from CHL_UserSurveyResponse survey
    where survey.Id = @operationId
      and @operationType = 9

    RETURN @result;
END;

go