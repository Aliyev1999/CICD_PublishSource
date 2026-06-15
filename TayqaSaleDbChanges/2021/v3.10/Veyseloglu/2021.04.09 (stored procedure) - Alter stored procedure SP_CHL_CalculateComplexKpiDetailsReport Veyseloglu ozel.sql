ALTER procedure [dbo].[SP_CHL_CalculateComplexKpiDetailsReport] (@clientCodeOrName nvarchar(50) null,
                                                               @saleChannel nvarchar(500) null,
                                                               @surveyContentType int null,
                                                               @firm smallint null,
                                                               @surveySpecodes123 nvarchar(50) null,
                                                               @savedDateStart datetime null,
                                                               @savedDateEnd datetime null,
                                                               @position tinyint null,
                                                               @salesmanTigerId int null,
                                                               @considerHierarchy bit = 0,-- UnUsed
                                                               @headSalesmanTigerId int null,

															   @saleDirectorId  int null,
														       @saleDeputyId int null,
															   @locationManagerId int null,
															   @saleMerchandiserId int null,
															   @marketingDirectorId int null,
															   @deputyMarketingDirectorId int null,
															   @packageMarketingManagerId int null,
															   @marketingMerchandiserId int null )
AS
BEGIN

DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
            WITH Structure AS (
            SELECT
				*

			FROM F_CHL_GetComplexStructureFullTransposed() Structure
            WHERE	Structure.PersonId = @salesmanTigerId
                AND Structure.FirmNr = @firm
                AND PositionId = @position
                AND Structure.Month >= MONTH(@savedDateStart)
                AND Structure.Month <= MONTH(@savedDateEnd)
                AND Structure.Year = YEAR(@savedDateStart)
				'

    IF @saleChannel				  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SaleChannel LIKE ''%'' + @saleChannel + ''%''')
    IF @surveyContentType		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.PackageType = @surveyContentType')

    IF @marketingDirectorId		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.MarketingDirectorId = @marketingDirectorId')
    IF @deputyMarketingDirectorId IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.DeputyMarketingDirectorId = @deputyMarketingDirectorId')
    IF @packageMarketingManagerId IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.PackageMarketingManagerId = @packageMarketingManagerId')
    IF @marketingMerchandiserId	  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.MarketingMerchandiserId = @marketingMerchandiserId')
    IF @saleDirectorId			  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SaleDirectorId = @saleDirectorId')
    IF @saleDeputyId			  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SaleDeputyId = @saleDeputyId')
    IF @locationManagerId		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.LocationManagerId = @locationManagerId')
    IF @saleMerchandiserId		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SaleMerchandiserId = @saleMerchandiserId')
    IF @headSalesmanTigerId		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SalesmanId = @headSalesmanTigerId')

	SET @Query = CONCAT(@Query, ')

						SELECT
							DISTINCT
							Response.Id					  as UserSurveyResponseId,
							Response.SavedDate			  as SavedDate,
							Client.Code                   as ClientCode,
							Client.Name                   as ClientName,
							Client.TigerId                as ClientId,
							Response.Firm                 as Firm,
							Structure.SaleChannel         as SaleChannel,
							Survey.Id                     as SurveyId,
							Survey.Name                   as SurveyName,
							Survey.SurveyContentType      as SurveyContentType,
							Content.Name                  as SurveyContentTypeName,
							Structure.PersonId			  as SalesmanId,
							ISNULL(CAST(UserPoint.Point AS FLOAT), 0) UserPoint,
							ISNULL(CAST(MaxPoint.Point AS FLOAT), 0) MaxPoint,
							ISNULL(round(iif(CAST(MaxPoint.Point AS FLOAT) = 0, 0,
								CAST(UserPoint.Point AS FLOAT) / CAST(MaxPoint.Point AS FLOAT)) * 100,
								2), 0)					  as  KPI

						FROM Structure
						JOIN CHL_UserSurveyResponse Response ON Response.ClientId = Structure.ClientId AND MONTH(Response.SavedDate)=Structure.Month
						AND YEAR(Response.SavedDate)=Structure.Year AND Response.Firm = Structure.FirmNr AND
						Response.SavedDate BETWEEN @savedDateStart and @savedDateEnd
						JOIN F_CHL_CalculateUserSurveyPointsAll() UserPoint on UserPoint.ReportId = Response.Id and UserPoint.PointType=1
						JOIN CHL_Survey Survey ON Survey.Id = Response.SurveyId AND Survey.Firm = Response.Firm
												 AND Survey.RepresentativeKPI = 1 AND Survey.IsDeleted = 0 and Survey.SurveyContentType = Structure.PackageType
						JOIN F_CHL_CalculateSurveyMaxPointsAll() MaxPoint ON MaxPoint.SurveyId = Survey.Id AND MaxPoint.PointType = 1
						JOIN MD_StopReason Content on Content.Id = Survey.SurveyContentType and Content.Type = 7
						JOIN MD_Client Client ON Response.ClientId = Client.TigerId AND Response.Firm = Client.Firm

						WHERE 1=1 ')

IF @surveySpecodes123	 IS NOT NULL SET @Query = CONCAT(@Query, ' AND (Survey.Specode1=@surveySpecodes123 OR Survey.Specode2=@surveySpecodes123 OR Survey.Specode3=@surveySpecodes123)')
IF @clientCodeOrName IS NOT NULL SET @Query = CONCAT(@Query, ' AND Client.Code LIKE ''%'' + @clientCodeOrName + ''%'' OR Client.Name LIKE ''%'' + @clientCodeOrName + ''%''')


--	print cast(@Query as Ntext)

    EXEC sp_executesql @Query,
       N'@clientCodeOrName NVARCHAR(50),
		 @saleChannel NVARCHAR(500),
		 @surveyContentType INT,
         @firm SMALLINT,
         @surveySpecodes123 NVARCHAR(50),
		 @savedDateStart DATETIME,
         @savedDateEnd DATETIME,
		 @position TINYINT,
         @salesmanTigerId INT,
         @considerHierarchy BIT,
		 @headSalesmanTigerId INT,
         @saleDirectorId INT,
         @saleDeputyId INT,
         @locationManagerId INT,
         @saleMerchandiserId INT,
         @marketingDirectorId INT,
         @deputyMarketingDirectorId INT,
         @packageMarketingManagerId INT,
         @marketingMerchandiserId INT',
         @clientCodeOrName = @clientCodeOrName,
		 @saleChannel = @saleChannel,
		 @surveyContentType =@surveyContentType,
         @firm = @firm,
         @surveySpecodes123 = @surveySpecodes123,
		 @savedDateStart = @savedDateStart,
         @savedDateEnd = @savedDateEnd,
		 @position = @position,
         @salesmanTigerId = @salesmanTigerId,
         @considerHierarchy = @considerHierarchy,
		 @headSalesmanTigerId = @headSalesmanTigerId,
         @saleDirectorId = @saleDirectorId,
         @saleDeputyId = @saleDeputyId,
         @locationManagerId = @locationManagerId,
         @saleMerchandiserId = @saleMerchandiserId,
         @marketingDirectorId = @marketingDirectorId,
         @deputyMarketingDirectorId = @deputyMarketingDirectorId,
         @packageMarketingManagerId = @packageMarketingManagerId,
         @marketingMerchandiserId =@marketingMerchandiserId

END
