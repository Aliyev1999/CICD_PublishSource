ALTER PROCEDURE [dbo].[SP_CHL_ComplexClientKPIReport] @minDate DATETIME,
                                                      @maxDate DATETIME,
                                                      @firm SMALLINT,
                                                      @userId INT = null,
                                                      @isAdminUser BIT = 0,
                                                      @salesManCodesStr NVARCHAR(2000) = NULL,
                                                      @clientNameOrCode NVARCHAR(50) = NULL,
                                                      @clientSpecialCodes NVARCHAR(100) = NULL,
                                                      @surveyNameOrCode NVARCHAR(50) = NULL,
                                                      @surveySpecialCodes NVARCHAR(50) = NULL,
                                                      @questionSpecCode NVARCHAR(50) = NULL,
                                                      @surveyContentType INT = NULL,
                                                      @salesmanId INT = NULL,
                                                      @packageMarketingManagerId INT = NULL,
                                                      @deputyMarketingDirectorId INT = NULL,
                                                      @marketingDirectorId INT = NULL,
                                                      @locationManagerId INT = NULL,
                                                      @saleDeputyId INT = NULL,
                                                      @saleDirectorId INT = NULL,
                                                      @marketingMerchandiserId INT = NULL,
                                                      @saleMerchandiserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
            WITH Structure AS (
            SELECT
				*

			FROM F_CHL_GetComplexStructureFullTransposed() Structure
            WHERE	Structure.PersonId IS NOT NULL
                AND Structure.FirmNr = @firm
                AND Structure.Month >= MONTH(@minDate)
                AND Structure.Month <= MONTH(@maxDate)
                AND Structure.Year = YEAR(@minDate)
				'

    IF @surveyContentType IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.PackageType = @surveyContentType')

    IF @marketingDirectorId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.MarketingDirectorId = @marketingDirectorId')

    IF @deputyMarketingDirectorId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.DeputyMarketingDirectorId = @deputyMarketingDirectorId')

    IF @packageMarketingManagerId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.PackageMarketingManagerId = @packageMarketingManagerId')

    IF @marketingMerchandiserId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.MarketingMerchandiserId = @marketingMerchandiserId')

    IF @saleDirectorId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.SaleDirectorId = @saleDirectorId')

    IF @saleDeputyId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.SaleDeputyId = @saleDeputyId')

    IF @locationManagerId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.LocationManagerId = @locationManagerId')

    IF @saleMerchandiserId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.SaleMerchandiserId = @saleMerchandiserId')

    IF @salesmanId IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Structure.SalesmanId = @salesmanId')


    SET @Query = CONCAT(@Query, ')

						SELECT
							DISTINCT
							Response.SavedDate			  as SavedDate,
							Response.Id					  as UserSurveyResponseId,
							Client.TigerId				  as ClientId,
							Client.Name                   as ClientName,
							Client.Code                   as ClientCode,
							Survey.Code					  as SurveyCode,
							Survey.Name                   as SurveyName,
							Survey.Id                     as SurveyId,
							Response.UserId				  as UserId,
							Content.Name                  as SurveyContentType,
							ISNULL(CAST(UserPoint.Point AS FLOAT), 0) CalculatedPoint,
							ISNULL(CAST(MaxPoint.Point AS FLOAT), 0) MaxPoint

						FROM Structure
						JOIN CHL_UserSurveyResponse Response ON Response.ClientId = Structure.ClientId AND MONTH(Response.SavedDate)=Structure.Month
						AND YEAR(Response.SavedDate)=Structure.Year AND Response.Firm = Structure.FirmNr AND
						Response.SavedDate BETWEEN @minDate and @maxDate
						JOIN CHL_UserResponsePoint UserPoint on UserPoint.ReportId = Response.Id and UserPoint.PointType=1
						JOIN CHL_Survey Survey ON Survey.Id = Response.SurveyId AND Survey.Firm = Response.Firm
												 AND Survey.RepresentativeKPI = 1 AND Survey.IsDeleted = 0
												 and Survey.SurveyContentType = Structure.PackageType and ClientKPI=1
												 and Survey.Specode2=''Checklist''
						JOIN CHL_SurveyMaxPoint MaxPoint ON MaxPoint.SurveyId = Survey.Id AND MaxPoint.PointType = 1
						JOIN MD_StopReason Content on Content.Id = Survey.SurveyContentType and Content.Type = 7
						JOIN MD_Client Client ON Response.ClientId = Client.TigerId AND Response.Firm = Client.Firm

						WHERE 1=1 ')


    IF @surveyNameOrCode IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Survey.Code LIKE ''%' + @surveyNameOrCode  + '%''
                                      OR Survey.Name LIKE ''%' + @surveyNameOrCode  + '%''  )')

    IF @surveySpecialCodes IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND (Survey.Specode1 LIKE ''%' + @surveySpecialCodes  + '%''
                                    OR Survey.Specode2 LIKE ''%' + @surveySpecialCodes  + '%''
                                    OR Survey.Specode3 LIKE ''%' + @surveySpecialCodes  + '%''  )')

    IF @questionSpecCode IS NOT NULL
        SET @Query = CONCAT(@Query, ' ')

    IF @clientNameOrCode IS NOT NULL
        SET @Query = CONCAT(@Query, ' AND Client.Code LIKE ''%' + @clientNameOrCode + '%''
                                    OR Client.Name LIKE ''%' + @clientNameOrCode + '%''')
    IF @clientSpecialCodes IS NOT NULL
        SET @Query = CONCAT(@Query, 'and  
									  (Client.SpecialCode LIKE ''%'+  @clientSpecialCodes + '%''
                                    OR Client.SpecialCode2  LIKE ''%' +  @clientSpecialCodes + '%''
                                    OR Client.SpecialCode3  LIKE ''%' +  @clientSpecialCodes + '%''
                                    OR Client.SpecialCode4  LIKE ''%' +  @clientSpecialCodes + '%''
                                    OR Client.SpecialCode5  LIKE ''%' +  @clientSpecialCodes + '%'' )')
print cast(@Query as Ntext);

    EXEC sp_executesql @Query,
         N'@minDate DATETIME,
           @maxDate DATETIME,
           @firm SMALLINT,
           @userId INT ,
           @isAdminUser BIT ,
           @salesManCodesStr NVARCHAR(2000),
           @clientNameOrCode NVARCHAR(50) ,
           @clientSpecialCodes NVARCHAR(100),
           @surveyNameOrCode NVARCHAR(50) ,
           @surveySpecialCodes NVARCHAR(50) ,
           @questionSpecCode NVARCHAR(50) ,
           @surveyContentType INT ,
           @salesmanId INT,
           @packageMarketingManagerId INT = NULL,
           @deputyMarketingDirectorId INT = NULL,
           @marketingDirectorId INT = NULL,
           @locationManagerId INT = NULL,
           @saleDeputyId INT = NULL,
           @saleDirectorId INT = NULL,
           @marketingMerchandiserId INT = NULL,
           @saleMerchandiserId INT = NULL',
         @minDate = @minDate,
         @maxDate = @maxDate,
         @firm = @firm,
         @userId = @userId,
         @isAdminUser = @isAdminUser,
         @salesManCodesStr = @salesManCodesStr,
         @clientNameOrCode = @clientNameOrCode,
         @clientSpecialCodes = @clientSpecialCodes,
         @surveyNameOrCode = @surveyNameOrCode,
         @surveySpecialCodes = @surveySpecialCodes,
         @questionSpecCode = @questionSpecCode,
         @surveyContentType = @surveyContentType,
         @salesmanId = @salesmanId,
         @packageMarketingManagerId = @packageMarketingManagerId,
         @deputyMarketingDirectorId = @deputyMarketingDirectorId,
         @marketingDirectorId = @marketingDirectorId,
         @locationManagerId = @locationManagerId,
         @saleDeputyId = @saleDeputyId,
         @saleDirectorId = @saleDirectorId,
         @marketingMerchandiserId = @marketingMerchandiserId,
         @saleMerchandiserId = @saleMerchandiserId
END