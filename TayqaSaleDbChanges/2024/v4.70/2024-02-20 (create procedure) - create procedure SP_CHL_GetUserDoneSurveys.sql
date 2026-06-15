CREATE   PROCEDURE [dbo].[SP_CHL_GetUserDoneSurveys]
    @fromDate DATETIME,
    @feedbackId INT,
    @permittedUsers NVARCHAR(MAX),
    @surveyIds NVARCHAR(MAX),
    @registeredDate DATETIME,
    @startDate DATETIME,
    @endDate DATETIME,
    @clientId INT,
    @firm SMALLINT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = '
    SELECT Response.Id                   AS FeedbackId,
           Response.SurveyId,
           survey.Name                   AS SurveyName,
           users.Name + '' '' + users.Surname AS [User],
           users.UserName,
           Response.CreatedDate
    FROM CHL_UserSurveyResponse Response with (nolock)
             JOIN CHL_Survey survey with (nolock) ON Response.SurveyId = survey.Id
             JOIN AbpUsers users with (nolock) ON Response.UserId = users.Id
    WHERE Response.CreatedDate >= @fromDate '

    if @feedbackId is not null
        set @sql = concat(@sql, ' AND (Response.Id = @feedbackId)')

    if @permittedUsers is not null
        set @sql = concat(@sql, ' AND EXISTS(SELECT 1 FROM F_SplitList(@permittedUsers, '','') AS SplitList WHERE SplitList.Value = CAST(Response.UserId AS NVARCHAR(MAX)))')

    if @surveyIds is not null
        set @sql = concat(@sql, ' AND EXISTS(SELECT 1 FROM F_SplitList(@surveyIds, '','') AS SplitList WHERE SplitList.Value = CAST(Response.SurveyId AS NVARCHAR(MAX)))')

    if @registeredDate is not null 
        set @sql = concat(@sql, ' AND (Response.RegisteredDate >= @registeredDate)')

    if @startDate is not null and @endDate is not null
        set @sql = concat(@sql, ' AND (Response.RegisteredDate BETWEEN @startDate AND @endDate)')

    if @firm is not null
        set @sql = concat(@sql, ' AND (Response.Firm = @firm)')

    if @clientId is not null
        set @sql = concat(@sql, ' AND (Response.ClientId = @clientId)');

   print @sql
    EXEC sp_executesql @sql, N'@fromDate DATETIME, 
                               @feedbackId INT, 
                               @permittedUsers NVARCHAR(MAX), 
                               @surveyIds NVARCHAR(MAX), 
                               @registeredDate DATETIME, 
                               @startDate DATETIME, 
                               @endDate DATETIME, 
                               @clientId INT, 
                               @firm SMALLINT', 
        @fromDate=@fromDate, 
        @feedbackId=@feedbackId, 
        @permittedUsers=@permittedUsers, 
        @surveyIds=@surveyIds, 
        @registeredDate=@registeredDate, 
        @startDate=@startDate, 
        @endDate=@endDate, 
        @clientId=@clientId, 
        @firm=@firm
END;
