alter PROCEDURE [dbo].[SP_CHL_GetQuestionAnswerReasonsReport](
    @firm SMALLINT ,
    @startDate DATETIME ,
    @endDate DATETIME ,
    @clientNameCodeOrGroupCode NVARCHAR(500) ,
    @clientSpecialCodes NVARCHAR(500) ,
    @surveyNameOrCode NVARCHAR(500) ,
    @surveySpecialCodes NVARCHAR(50) ,
    @userIds NVARCHAR(MAX) ,
    @reasonIds NVARCHAR(MAX) ,
    @forExceleExporting BIT ,
    @localizedOthersTxt NVARCHAR(30),
    @reasonTypes NVARCHAR(MAX) = NULL )
AS
BEGIN
    DECLARE @Query NVARCHAR(MAX);
    DECLARE @collation NVARCHAR(128) = 'SQL_Latin1_General_CP1_CI_AS'; -- specify your target collation

    SET @Query =
        '
        SELECT
             CASE 
                WHEN responseDetail.ReasonValue IS NOT NULL THEN @localizedOthersTxt 
                ELSE reason.Name COLLATE ' + @collation + ' 
            END AS ReasonName,
            IIF(reason.Id IS NOT NULL, reason.Id, 0) AS ReasonId,
            responseDetail.ReasonValue COLLATE ' + @collation + ' AS ResponseDetailValue,
            firm.Name COLLATE ' + @collation + ' AS FirmName,
            firm.Nr AS FirmNr,
            client.Name COLLATE ' + @collation + ' AS ClientName,
            client.Code COLLATE ' + @collation + ' AS ClientCode,
            client.Edino COLLATE ' + @collation + ' AS ClientGroupCode,
            case when responseDetail.ReasonValue is not null then cast(3 as tinyint)
            else cast(1 as tinyint)
            end as ReasonType
        FROM CHL_UserSurveyResponse response with(nolock)
        JOIN CHL_UserSurveyResponseDetail responseDetail with(nolock) ON response.Id = responseDetail.UserSurveyResponseId
        JOIN AbpUsers usr with(nolock) ON response.UserId = usr.Id
        JOIN MD_Client client with(nolock) ON response.ClientId = client.TigerId and response.Firm = client.Firm
        LEFT JOIN MD_StopReason reason with(nolock) ON responseDetail.ReasonId = reason.Id and reason.Type=3
        JOIN CHL_Survey survey with(nolock) ON response.Firm = survey.Firm and response.SurveyId = survey.Id
        JOIN MD_Firm firm with(nolock) ON client.Firm = firm.Nr
        WHERE responseDetail.Id < 15502 and
        (survey.IsDeleted IS NULL OR survey.IsDeleted = 0) AND
        (reason.Type IS NULL OR reason.Type = 3) AND
        (client.Status = 0) AND
        (client.IsDeleted IS NULL OR client.IsDeleted = 0) AND
        (responseDetail.ReasonValue IS NOT NULL OR responseDetail.ReasonId IS NOT NULL)';

    IF @reasonTypes IS NOT NULL AND @reasonTypes<>''
        SET @Query += ' AND (case when responseDetail.ReasonValue is not null then cast(3 as tinyint)
            else cast(1 as tinyint)
            end ) IN (SELECT value FROM F_SplitList(@reasonTypes, '',''))';

    IF @firm IS NOT NULL AND @firm<>''
        SET @Query = CONCAT(@Query, ' and firm.Nr = @firm');



    IF @startDate IS NOT NULL AND @endDate IS NOT NULL AND @startDate<>'' AND @endDate<>''
        SET @Query = CONCAT(@Query, ' AND (response.RegisteredDate between @startDate AND @endDate)');

    IF @clientNameCodeOrGroupCode IS NOT NULL AND @clientNameCodeOrGroupCode<>''
        SET @Query = CONCAT(@Query,
                            ' AND (client.Name LIKE ''%' + @clientNameCodeOrGroupCode + '%'' OR client.Code LIKE ''%' +
                            @clientNameCodeOrGroupCode + '%'' OR client.Edino LIKE ''%' + @clientNameCodeOrGroupCode +
                            '%'')');

    IF @clientSpecialCodes IS NOT NULL and @clientSpecialCodes<>''
        SET @Query = CONCAT(@Query, ' AND (client.SpecialCode LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode2 LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode3 LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode4 LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode5 LIKE ''%' + @clientSpecialCodes + '%'')');

    IF @surveyNameOrCode IS NOT NULL AND @surveyNameOrCode<>''
        SET @Query = CONCAT(@Query, ' AND (survey.Name LIKE ''%' + @surveyNameOrCode + '%'' OR survey.Code LIKE ''%' +
                                    @surveyNameOrCode + '%'')');

    IF @surveySpecialCodes IS NOT NULL AND @surveySpecialCodes<>''
        SET @Query = CONCAT(@Query,
                            ' AND (survey.Specode1 LIKE ''%' + @surveySpecialCodes + '%'' OR survey.Specode2 LIKE ''%' +
                            @surveySpecialCodes + '%'' OR survey.Specode3 LIKE ''%' + @surveySpecialCodes + '%'')');

    IF @userIds IS NOT NULL and @userIds<>''
        SET @Query = CONCAT(@Query, ' AND (usr.Id IN (SELECT * FROM F_SplitList(@userIds, '','')))');



    SET @Query = CONCAT(@Query, ' union

    SELECT
        CASE 
            WHEN reason.Value IS NOT NULL OR responseDetail.ReasonValue IS NOT NULL THEN @localizedOthersTxt 
            ELSE coalesce(ReasonNames.Name COLLATE ' + @collation + ', reason.Value COLLATE ' + @collation + ', '''') 
        END AS ReasonName,'

		+
		 'IIF(reason.Id IS NOT NULL and reason.Type <> 3, reason.Id, 0) AS ReasonId,
		'+
        'coalesce(reason.Value, responseDetail.ReasonValue,ReasonNames.Name) COLLATE ' + @collation  + ' AS ResponseDetailValue,
        firm.Name COLLATE ' + @collation + ' AS FirmName,
        firm.Nr AS FirmNr,
        client.Name COLLATE ' + @collation + ' AS ClientName,
        client.Code COLLATE ' + @collation + ' AS ClientCode,
        client.Edino COLLATE ' + @collation + ' AS ClientGroupCode,
        case when reason.Type = 1 then cast(1 as tinyint)
        when reason.Type = 2 then cast(2 as tinyint)
        when reason.Type in (3, 4) then cast(3 as tinyint)
		else  cast(1 as tinyint)
        end
        as ReasonType
    FROM CHL_UserSurveyResponse response with(nolock)
    JOIN CHL_UserSurveyResponseDetail responseDetail with(nolock) ON response.Id = responseDetail.UserSurveyResponseId
    JOIN AbpUsers usr with(nolock) ON response.UserId = usr.Id
    JOIN MD_Client client with(nolock) ON response.ClientId = client.TigerId and response.Firm = client.Firm
     JOIN CHL_UserSurveyResponseDetailReason reason with(nolock) ON responseDetail.Id = reason.UserSurveyResponseDetailId --and reason.AnswerId = responseDetail.AnswerId
    JOIN CHL_Survey survey with(nolock) ON response.Firm = survey.Firm and response.SurveyId = survey.Id
    JOIN MD_Firm firm with(nolock) ON client.Firm = firm.Nr
	left join MD_StopReason ReasonNames with(nolock) on ReasonNames.Id=reason.ReasonId  and reason.Type in (1,2)

    WHERE responseDetail.Id >= 15502 and
    (survey.IsDeleted IS NULL OR survey.IsDeleted = 0) AND
    (client.Status = 0) AND
    (client.IsDeleted IS NULL OR client.IsDeleted = 0)');

    IF @reasonTypes IS NOT NULL AND @reasonTypes<>''
        SET @Query += ' AND (case when reason.Type = 1 then cast(1 as tinyint)
        when reason.Type = 2 then cast(2 as tinyint)
        when reason.Type in (3, 4) then cast(3 as tinyint)
		else cast(1 as tinyint)
        end) IN (SELECT value FROM F_SplitList(@reasonTypes, '',''))';

    IF @firm IS NOT NULL AND @firm<>''
        SET @Query = CONCAT(@Query, ' and firm.Nr = @firm');


    IF @startDate IS NOT NULL AND @endDate IS NOT NULL AND @startDate<>'' AND @endDate<>''
        SET @Query = CONCAT(@Query, ' AND (response.RegisteredDate between @startDate AND @endDate)');

    IF @clientNameCodeOrGroupCode IS NOT NULL AND @clientNameCodeOrGroupCode<>''
        SET @Query = CONCAT(@Query,
                            ' AND (client.Name LIKE ''%' + @clientNameCodeOrGroupCode + '%'' OR client.Code LIKE ''%' +
                            @clientNameCodeOrGroupCode + '%'' OR client.Edino LIKE ''%' + @clientNameCodeOrGroupCode +
                            '%'')');

    IF @clientSpecialCodes IS NOT NULL and @clientSpecialCodes<>''
        SET @Query = CONCAT(@Query, ' AND (client.SpecialCode LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode2 LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode3 LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode4 LIKE ''%' + @clientSpecialCodes +
                                    '%'' OR client.SpecialCode5 LIKE ''%' + @clientSpecialCodes + '%'')');

    IF @surveyNameOrCode IS NOT NULL AND @surveyNameOrCode<>''
        SET @Query = CONCAT(@Query, ' AND (survey.Name LIKE ''%' + @surveyNameOrCode + '%'' OR survey.Code LIKE ''%' +
                                    @surveyNameOrCode + '%'')');

    IF @surveySpecialCodes IS NOT NULL AND @surveySpecialCodes<>''
        SET @Query = CONCAT(@Query,
                            ' AND (survey.Specode1 LIKE ''%' + @surveySpecialCodes + '%'' OR survey.Specode2 LIKE ''%' +
                            @surveySpecialCodes + '%'' OR survey.Specode3 LIKE ''%' + @surveySpecialCodes + '%'')');

    IF @userIds IS NOT NULL and @userIds<>''
        SET @Query = CONCAT(@Query, ' AND (usr.Id IN (SELECT * FROM F_SplitList(@userIds, '','')))');


    DECLARE @BeginningOfQuery AS NVARCHAR(MAX) = '';

    IF @forExceleExporting = 1
    BEGIN
        SET @BeginningOfQuery = 'SELECT 
            IIF(answerReason.ReasonId = 0, answerReason.ResponseDetailValue, answerReason.ReasonName) AS ReasonName,
            answerReason.ReasonId AS ReasonId,
            answerReason.ClientCode AS ClientCode,
            answerReason.ClientName AS ClientName,
            answerReason.ClientGroupCode AS ClientGroupCode,
            answerReason.FirmName AS FirmName,
            answerReason.FirmNr AS FirmNr,
            answerReason.ResponseDetailValue AS ResponseDetailValue,
            answerReason.ReasonType
            FROM (';
    END
    ELSE
    BEGIN
        SET @BeginningOfQuery = 'SELECT 
            IIF(answerReason.ReasonId = 0 , @localizedOthersTxt, answerReason.ReasonName) AS ReasonName,
            answerReason.ReasonId AS ReasonId,
            answerReason.ClientCode AS ClientCode,
            answerReason.ClientName AS ClientName,
            answerReason.ClientGroupCode AS ClientGroupCode,
            answerReason.FirmName AS FirmName,
            answerReason.FirmNr AS FirmNr,
            answerReason.ReasonType,
            answerReason.ResponseDetailValue AS ResponseDetailValue FROM (';
    END

    SET @Query = CONCAT(@BeginningOfQuery, @Query);
    SET @Query = CONCAT(@Query, ') answerReason');

    IF @reasonIds IS NOT NULL
        SET @Query = CONCAT(@Query, ' WHERE (answerReason.ReasonId IN (SELECT * FROM F_SplitList(@reasonIds, '','')))');

    DECLARE @BeginningOfGroupedQuery AS NVARCHAR(MAX) = 'SELECT  grouped.ReasonName,
        grouped.ReasonId,
        grouped.FirmName,
        grouped.FirmNr,
        grouped.ClientName,
        grouped.ClientCode,
        grouped.ClientGroupCode,
        COUNT(*) AS ReasonCountByClient,
        ReasonType FROM (';

    SET @Query = CONCAT(@BeginningOfGroupedQuery, @Query);
    SET @Query = CONCAT(@Query,
        ') grouped GROUP BY grouped.ReasonName, grouped.ReasonId, grouped.FirmName, grouped.FirmNr, grouped.ClientName, grouped.ClientCode, grouped.ClientGroupCode, grouped.ReasonType');

    PRINT CAST(@Query as NTEXT);

    EXEC sp_executesql @Query, N'@firm SMALLINT,
        @startDate DATETIME,
        @endDate DATETIME,
        @clientNameCodeOrGroupCode NVARCHAR(500),
        @clientSpecialCodes NVARCHAR(500),
        @surveyNameOrCode NVARCHAR(500),
        @surveySpecialCodes NVARCHAR(50),
        @userIds NVARCHAR(MAX),
        @reasonIds NVARCHAR(MAX),
        @forExceleExporting BIT,
        @localizedOthersTxt NVARCHAR(30),
        @reasonTypes NVARCHAR(MAX)',
        @firm=@firm,
        @startDate=@startDate,
        @endDate=@endDate,
        @clientNameCodeOrGroupCode=@clientNameCodeOrGroupCode,
        @clientSpecialCodes=@clientSpecialCodes,
        @surveyNameOrCode=@surveyNameOrCode,
        @surveySpecialCodes=@surveySpecialCodes,
        @userIds=@userIds,
        @reasonIds=@reasonIds,
        @forExceleExporting=@forExceleExporting,
        @localizedOthersTxt=@localizedOthersTxt,
        @reasonTypes=@reasonTypes
END