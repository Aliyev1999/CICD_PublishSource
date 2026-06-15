ALTER PROCEDURE [dbo].[SP_CHL_ClientKPIReport] @minDate DATETIME, @maxDate DATETIME, @firm SMALLINT, @userId INT, @isAdminUser BIT = 0,
                                        @pointType TINYINT = 1,
                                        @salesManCodesStr NVARCHAR(2000) = NULL, @surveyCreatorUsers NVARCHAR(100) = NULL,
                                        @clientNameOrCode NVARCHAR(50) = NULL,
                                        @clientSpecode1 NVARCHAR(50) = NULL, @clientSpecode2 NVARCHAR(50) = NULL, @clientSpecode3 NVARCHAR(50) = NULL,
                                        @surveyNameOrCode NVARCHAR(50) = NULL,
                                        @surveySpecode1 NVARCHAR(50) = NULL, @surveySpecode2 NVARCHAR(50) = NULL, @surveySpecode3 NVARCHAR(50) = NULL,
                                        @questionGroupsStr NVARCHAR(500) = NULL, @questionType INT = NULL, @questionSpecCode NVARCHAR(50) = NULL,
                                        @surveyContentType INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#ClientKPIPermittedUserIds') IS NOT NULL
        DROP TABLE #ClientKPIPermittedUserIds;

    CREATE TABLE #ClientKPIPermittedUserIds
    (
        UserId INT NOT NULL PRIMARY KEY
    );

    DECLARE @userIdsSql NVARCHAR(200);

    IF (@isAdminUser = 0)
        BEGIN
            SET @userIdsSql = 'SELECT UserId FROM F_UIM_GetOrganizationTreeAllUsers(@userId)'
        END
    ELSE
        BEGIN
            SET @userIdsSql = 'SELECT Id as UserId FROM AbpUsers WHERE IsDeleted = 0 AND IsActive = 1'
        END

    INSERT INTO #ClientKPIPermittedUserIds
        EXEC sp_executesql @userIdsSql, N'@userId INT', @userId = @userId

    IF OBJECT_ID('tempdb..#ClientKPIUniqueClientIds') IS NOT NULL
        DROP TABLE #ClientKPIUniqueClientIds;

    CREATE TABLE #ClientKPIUniqueClientIds
    (
        ClientId INT NOT NULL PRIMARY KEY
    );

    INSERT INTO #ClientKPIUniqueClientIds
	SELECT DISTINCT C.TigerId FROM MD_Client C
	JOIN F_GetAllPermittedClient() PC ON PC.Firm = C.Firm AND PC.ClientId = C.TigerId
	JOIN #ClientKPIPermittedUserIds PU ON PU.UserId = PC.UserId

    DECLARE @sql NVARCHAR(MAX) =
        'SELECT USR.SavedDate,
               USR.Id AS UserSurveyResponseId,
               C.TigerId AS ClientId,
               C.Name AS ClientName,
               C.Code AS ClientCode,
               SRV.Code AS SurveyCode,
               SRV.Name AS SurveyName,
               SRV.Id AS SurveyId,
               USR.UserId,
               SR.Name AS SurveyContentType,
               USP.Point AS CalculatedPoint,
               SMP.Point AS MaxPoint
            FROM MD_Client C
                     JOIN CHL_UserSurveyResponse USR ON C.Firm = USR.Firm AND C.TigerId = USR.ClientId
                     JOIN CHL_Survey SRV ON USR.SurveyId = SRV.Id
                     JOIN F_CHL_CalculateSurveyMaxPoints(@pointType) SMP ON SMP.SurveyId = SRV.Id
                     JOIN F_CHL_CalculateUserSurveyPoints(@pointType) USP ON USP.ReportId = USR.ID
                     LEFT JOIN MD_StopReason SR on SR.Id = SRV.SurveyContentType and SR.Type = 7
            WHERE USR.Status IN (1, 2, 4)
              AND C.Firm = @firm
              AND C.TigerId in (select ClientId from #ClientKPIUniqueClientIds)
              AND SRV.Firm = @firm
              AND SRV.ClientKPI = 1
              AND USR.SavedDate > @minDate
              AND USR.SavedDate < @maxDate'

    IF (@surveyCreatorUsers IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' AND USR.UserId in (select Value from F_SplitList(@surveyCreatorUsers, '',''))');
        END


    IF (@clientNameOrCode IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and (C.Code like ''%' + @clientNameOrCode + '%'' OR C.Name like ''%' + @clientNameOrCode + '%'')');
        END

    IF (@clientSpecode1 IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and C.SpecialCode = @clientSpecode1');
        END

    IF (@clientSpecode2 IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and C.SpecialCode2 = @clientSpecode2');
        END

    IF (@clientSpecode3 IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and C.SpecialCode3 = @clientSpecode3');
        END

    IF (@surveyNameOrCode IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and (SRV.Code like ''%' + @surveyNameOrCode + '%'' OR SRV.Name like ''%' + @surveyNameOrCode + '%'')');
        END

    IF (@surveySpecode1 IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and SRV.Specode1 = @surveySpecode1');
        END

    IF (@surveySpecode2 IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and SRV.Specode2 = @surveySpecode2');
        END

    IF (@surveySpecode3 IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and SRV.Specode3 = @surveySpecode3');
        END

    IF (@questionGroupsStr IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' AND (SELECT Count(*) from CHL_SurveyQuestion SQ
                                            JOIN CHL_Question Q ON SQ.QuestionId = Q.Id and SQ.SurveyId = SRV.Id
                                            WHERE q.QuestionGroupId in (select * from F_SplitList(@questionGroupsStr, '',''))) > 0');
        END

    IF (@questionType IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' AND (SELECT Count(*) from CHL_SurveyQuestion SQ
                                        JOIN CHL_Question Q ON SQ.QuestionId = Q.Id and SQ.SurveyId = SRV.Id
                                        WHERE q.Type=@questionType) > 0');
        END

    IF (@questionSpecCode IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' AND (SELECT Count(*) from CHL_SurveyQuestion SQ
                                        JOIN CHL_Question Q ON SQ.QuestionId = Q.Id and SQ.SurveyId = SRV.Id
                                        WHERE q.Specode1=@questionSpecCode OR q.Specode2=@questionSpecCode OR q.Specode3=@questionSpecCode) > 0');
        END

    IF (@surveyContentType IS NOT NULL)
        BEGIN
            SET @sql = CONCAT(@sql, ' and SRV.SurveyContentType = @surveyContentType');
        END

    EXEC sp_executesql @sql,
         N'@userId            INT, @pointType INT, @firm SMALLINT,
         @minDate           DATETIME , @maxDate DATETIME ,
         @salesManCodesStr  NVARCHAR(MAX) , @surveyCreatorUsers NVARCHAR(30) ,
         @clientNameOrCode  NVARCHAR(30) , @clientSpecode1 NVARCHAR(30) , @clientSpecode2 NVARCHAR(30) , @clientSpecode3 NVARCHAR(30) ,
         @surveyNameOrCode  NVARCHAR(30) , @surveySpecode1 NVARCHAR(30) , @surveySpecode2 NVARCHAR(30) , @surveySpecode3 NVARCHAR(30) ,
         @questionGroupsStr NVARCHAR(30) , @questionType INT , @questionSpecCode NVARCHAR(30), @surveyContentType INT',
         @userId = @userId, @pointType = @pointType, @firm = @firm,
         @minDate = @minDate, @maxDate = @maxDate,
         @salesManCodesStr = @salesManCodesStr, @surveyCreatorUsers = @surveyCreatorUsers,
         @clientNameOrCode = @clientNameOrCode, @clientSpecode1 = @clientSpecode1, @clientSpecode2 = @clientSpecode2, @clientSpecode3 = @clientSpecode3,
         @surveyNameOrCode = @surveyNameOrCode, @surveySpecode1 = @surveySpecode1, @surveySpecode2 = @surveySpecode2, @surveySpecode3 = @surveySpecode3,
         @questionGroupsStr = @questionGroupsStr, @questionType = @questionType, @questionSpecCode = @questionSpecCode, @surveyContentType = @surveyContentType
END

