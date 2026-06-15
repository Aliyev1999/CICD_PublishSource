CREATE PROCEDURE [dbo].[SP_MIP_GetMipDashboardOperationCount](
    @date Datetime,
    @actions nvarchar(5), -- vergulle ayrilmis sekilde 2 action gele biler. meselen sifaris, qaytarma fakturasi ve.s. OP_IncomingLogdaki DocType-lardir
    @UserId bigint)
AS
BEGIN
    CREATE TABLE #TempDocTypes
    (
        RowNum  INT IDENTITY (1,1),
        DocType INT
    );

    -- Insert values into the temporary table
    INSERT INTO #TempDocTypes (DocType)
    SELECT value
    FROM F_SplitList(@actions, ',')
    ORDER BY (SELECT NULL);

    DECLARE @sql nvarchar(max);
    SET @sql = '
WITH RouteData AS (
    SELECT
        TigerClientId,
        Firm,
        Routes.UserId,
        Date
    FROM MD_Route Routes WITH (NOLOCK)'

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu on Routes.UserId = otu.UserId')
        END
    set @sql = concat(@sql, ' WHERE Date = CAST(GETDATE() AS DATE)  AND Status = 0),

AllVisits AS (
    SELECT
        Ticket.Firm,
        Ticket.ClientId,
        Ticket.UserId,
        CAST(Ticket.CreatedDate AS DATE) AS Date
    FROM  WPM_TaskTicket Ticket WITH (NOLOCK)')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ticket.UserId = otu.UserId');
        END

    set @sql = concat(@sql, ' WHERE CAST(Ticket.CreatedDate AS DATE) > CAST(@date AS DATE)

    UNION

    SELECT
        Firm,
        ClientId,
        CreatedUserId AS UserId,
        CAST(CreatedDate AS DATE) AS Date
    FROM OP_ClientVisitLog Visit WITH(NOLOCK)')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Visit.CreatedUserId = otu.UserId')
        END
    set @sql = concat(@sql, '
     WHERE CAST(Date AS DATE) > CAST(@Date AS DATE)

    UNION

    SELECT
        Firm,
        ClientId,
        Ilog.UserId,
        CAST(DocCreatedTime AS DATE) AS Date
    FROM OP_IncomingLog Ilog WITH (NOLOCK)')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ilog.UserId = otu.UserId');
        END
    set @sql = concat(@sql, '

WHERE cast(DocCreatedTime as date) > cast(@date as date)
),

     Operations AS (SELECT Firm,
                           ClientId,
                           Ilog.UserId,
                           DocType,
                           CAST(DocCreatedTime AS DATE) AS Date,
                           DocCreatedTime
                    FROM OP_IncomingLog Ilog WITH (NOLOCK)
                             JOIN OP_GeneralLog Glog WITH (NOLOCK) ON Ilog.Id = Glog.RequestId AND Glog.ImportResult = 0')
    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ilog.UserId = otu.UserId');
        END
    set @sql = concat(@sql, '
   WHERE cast(DocCreatedTime as date) > cast(@date as date)
),
     Grid as (select COUNT(DISTINCT Operations.ClientId)                                                         AS TotalCount,
                     COUNT(DISTINCT AllVisits.ClientId)                                                          AS VisitCount,
                     COUNT(DISTINCT CASE WHEN RowNum=1  THEN Operations.DocCreatedTime END) AS FirstActionCount,
                     COUNT(DISTINCT CASE WHEN RowNum=2 THEN Operations.DocCreatedTime END) AS SecondActionCount
              from AllVisits
                       left join Operations on AllVisits.UserId = Operations.UserId
					   left join  #TempDocTypes temp on Operations.DocType=temp.DocType),

     Grouped as (select cast(Operations.Date as nvarchar(max))                                                                              as SalesSummaryPeriod,
                        COUNT(DISTINCT CASE WHEN RowNum=1 THEN Operations.DocCreatedTime END) as SalesSummaryCount1,
                        COUNT(DISTINCT CASE WHEN RowNum=2 THEN Operations.DocCreatedTime END) as SalesSummaryCount2
                 from Operations 
				 join #TempDocTypes temp on Operations.DocType=temp.DocType
     group by  cast(Operations.Date as nvarchar(max)))

SELECT 
    isnull(Grid.TotalCount,0) as TotalCount,
   isnull( Grid.VisitCount,0) as VisitCount,
   isnull( Grid.FirstActionCount,0) as FirstActionCount,
   isnull( Grid.SecondActionCount,0) as SecondActionCount,
    Grouped.SalesSummaryPeriod as SalesSummaryPeriod,
   isnull( Grouped.SalesSummaryCount1,0) as SalesSummaryCount1,
   isnull( Grouped.SalesSummaryCount2,0) as SalesSummaryCount2
FROM 
    Grid, Grouped')

	print @sql
    execute sp_executesql @sql,
            N' @userId bigint,
			   @date Datetime,
               @actions nvarchar(5)',
            @userId=@userId,
            @date=@date,
            @actions=@actions

END