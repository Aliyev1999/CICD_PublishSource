ALTER PROCEDURE [dbo].[SP_CHL_CalculateComplexKpiMasterReport](@clientCodeOrName NVARCHAR(50) NULL,
                                                             @position TINYINT NULL,
                                                             @saleChannel NVARCHAR(500) NULL,
                                                             @fin NVARCHAR(50) NULL,
                                                             @surveyContentType INT NULL,
                                                             @firm SMALLINT NULL,
                                                             @surveySpecodes123 NVARCHAR(50) NULL,
                                                             @savedDateStart DATETIME NULL,
                                                             @savedDateEnd DATETIME NULL,
                                                             @salesmanTigerId INT NULL,
                                                             @considerHierarchy BIT = 0,
                                                             @saleDirectorId INT NULL,
                                                             @saleDeputyId INT NULL,
                                                             @locationManagerId INT NULL,
                                                             @saleMerchandiserId INT NULL,
                                                             @marketingDirectorId INT NULL,
                                                             @deputyMarketingDirectorId INT NULL,
                                                             @packageMarketingManagerId INT NULL,
                                                             @marketingMerchandiserId INT NULL)
AS
BEGIN

    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
            WITH Structure AS (
            SELECT * FROM F_CHL_GetComplexStructureFullTransposed() Structure
            WHERE Structure.PersonId IS NOT NULL
                AND Structure.FirmNr = @firm
                AND PositionId = @position
                AND Structure.Month >= MONTH(@savedDateStart)
                AND Structure.Month <= MONTH(@savedDateEnd)
                AND Structure.Year = YEAR(@savedDateStart)'

    IF @saleChannel				  IS NOT NULL SET @Query = CONCAT(@Query, ' and Structure.SaleChannel LIKE ''%'' + @saleChannel + ''%''')
    IF @surveyContentType		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.PackageType = @surveyContentType')

    IF @marketingDirectorId		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.MarketingDirectorId = @marketingDirectorId')
    IF @deputyMarketingDirectorId IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.DeputyMarketingDirectorId = @deputyMarketingDirectorId')
    IF @packageMarketingManagerId IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.PackageMarketingManagerId = @packageMarketingManagerId')
    IF @marketingMerchandiserId	  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.MarketingMerchandiserId = @marketingMerchandiserId')
    IF @saleDirectorId			  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SaleDirectorId = @saleDirectorId')
    IF @saleDeputyId			  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SaleDeputyId = @saleDeputyId')
    IF @locationManagerId		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.LocationManagerId = @locationManagerId')
    IF @saleMerchandiserId		  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SaleMerchandiserId = @saleMerchandiserId')
    IF @salesmanTigerId			  IS NOT NULL SET @Query = CONCAT(@Query, ' AND Structure.SalesmanId = @salesmanTigerId')


    SET @Query = CONCAT(@Query, '),
					Result AS (
					SELECT

					Structure.*,
					Salesmans.OfficialName,
					Salesmans.FinCode,
					Points.UserPoint,
					Points.MaxPoint,
					Points.Ratio

					FROM Structure INNER JOIN MD_Salesman Salesmans
                                     ON Structure.PersonId=Salesmans.TigerId AND Structure.FirmNr = Salesmans.Firm
                          INNER JOIN (SELECT datepart(MONTH, Response.SavedDate) Month,
                                             datepart(YEAR, Response.SavedDate) Year,
                                             Response.ClientId ClientId,
                                             Response.Firm Firm,
                                             sur.SurveyContentType SurveyContentType,
                                             ISNULL(CAST(UserPoints.Point AS FLOAT), 0) UserPoint,
                                             ISNULL(CAST(Mp.Point AS FLOAT), 0) MaxPoint,
                                             ISNULL(round(iif(CAST(Mp.Point AS FLOAT)=0, 0, CAST(UserPoints.Point AS FLOAT) / CAST(Mp.Point AS FLOAT)) * 100, 2), 0) Ratio
                                          FROM CHL_UserSurveyResponse Response
                                                   LEFT JOIN CHL_UserResponsePoint UserPoints ON UserPoints.ReportId=Response.Id AND UserPoints.PointType=1
                                                   INNER JOIN CHL_Survey sur   ON sur.Id=Response.SurveyId AND sur.Firm=Response.Firm
															AND sur.RepresentativeKPI=1 AND sur.IsDeleted=0
                                                   LEFT JOIN CHL_SurveyMaxPoint Mp ON Mp.SurveyId=sur.Id AND Mp.PointType=1
                                                   INNER JOIN MD_Client client ON Response.ClientId=client.TigerId AND Response.Firm=client.Firm
                                                   WHERE 1=1')

    IF @surveySpecodes123	 IS NOT NULL SET @Query = CONCAT(@Query, ' AND (sur.Specode1=@surveySpecodes123 OR sur.Specode2=@surveySpecodes123 OR sur.Specode3=@surveySpecodes123)')
    IF @clientCodeOrName IS NOT NULL SET @Query = CONCAT(@Query, ' AND client.Code LIKE ''%'' + @clientCodeOrName + ''%'' OR client.Name LIKE ''%'' + @clientCodeOrName + ''%''')

    SET @Query = CONCAT(@Query,
                        ') Points on
                        Points.Month = Structure.Month AND
                        Points.Year = Structure.Year AND
                        Points.Firm = Structure.FirmNr AND
                        Points.SurveyContentType = Structure.PackageType AND
                        Points.ClientId = Structure.ClientId

                        WHERE 1=1')

    IF @fin IS NOT NULL SET @Query = CONCAT(@Query, ' AND Salesmans.FinCode like ''%'' + @fin + ''%''')

    SET @Query = CONCAT(@Query, ')

SELECT
	OfficialName as PersonName,
	FinCode as Fin,
	Position as Position,
	PersonId as SalesmanId,
	FirmNr as Firm,
	ROUND(SUM(UserPoint), 2) as UserPointSum,
	ROUND(SUM(MaxPoint), 2) as MaxPointSum,
	ROUND(SUM(CAST(Ratio AS FLOAT)) / COUNT(PersonId), 2) as KPI
FROM Result
GROUP BY OfficialName, FinCode, Position, PersonId, FirmNr')


--  PRINT CAST(@Query AS NTEXT)

    EXEC sp_executesql @Query,
         N'@clientCodeOrName NVARCHAR(50),
         @position TINYINT,
         @saleChannel NVARCHAR(500),
         @fin NVARCHAR(50)=NULL,
         @surveyContentType INT,
         @firm SMALLINT,
         @surveySpecodes123 NVARCHAR(50),
         @savedDateStart DATETIME,
         @savedDateEnd DATETIME,
         @salesmanTigerId INT,
         @considerHierarchy BIT,
         @saleDirectorId INT,
         @saleDeputyId INT,
         @locationManagerId INT,
         @saleMerchandiserId INT,
         @marketingDirectorId INT,
         @deputyMarketingDirectorId INT,
         @packageMarketingManagerId INT,
         @marketingMerchandiserId INT',
         @clientCodeOrName=@clientCodeOrName,
         @position=@position,
         @saleChannel=@saleChannel,
         @fin=@fin,
         @surveyContentType=@surveyContentType,
         @firm=@firm,
         @surveySpecodes123=@surveySpecodes123,
         @savedDateStart=@savedDateStart,
         @savedDateEnd=@savedDateEnd,
         @salesmanTigerId=@salesmanTigerId,
         @considerHierarchy=@considerHierarchy,
         @saleDirectorId=@saleDirectorId,
         @saleDeputyId=@saleDeputyId,
         @locationManagerId=@locationManagerId,
         @saleMerchandiserId=@saleMerchandiserId,
         @marketingDirectorId=@marketingDirectorId,
         @deputyMarketingDirectorId=@deputyMarketingDirectorId,
         @packageMarketingManagerId=@packageMarketingManagerId,
         @marketingMerchandiserId=@marketingMerchandiserId

END
