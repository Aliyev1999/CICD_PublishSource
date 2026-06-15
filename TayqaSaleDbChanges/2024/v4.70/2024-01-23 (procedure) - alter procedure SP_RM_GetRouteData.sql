ALTER   PROCEDURE [dbo].[SP_RM_GetRouteData] (
    @userId INT,
    @firm SMALLINT,
    @beginDate DATETIME,
    @endDate DATETIME,
    @viewMode TINYINT = 1
)
AS
BEGIN
    CREATE TABLE #RouteDataTemp (
        UserId INT,
        ClientId INT,
        Date DATETIME
    );

    INSERT INTO #RouteDataTemp (UserId, ClientId, Date)
    SELECT
        R.UserId,
        R.TigerClientId AS ClientId,
        Date
    FROM MD_Route R WITH (NOLOCK)
    LEFT JOIN F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers ON TreeUsers.UserId = R.UserId
    WHERE (
        ((@viewMode IS NULL OR @viewMode = 1) AND R.UserId = @userId)
        OR (@viewMode = 2 AND TreeUsers.UserId IS NOT NULL)
    )
    AND R.Firm = @firm
    AND R.Status = 0
    AND R.Date BETWEEN CAST(@beginDate AS DATE) AND CAST(@endDate AS DATE);

    CREATE TABLE #ActionsTemp (
        UserId INT,
        ClientId INT,
        Date DATETIME
    );

    INSERT INTO #ActionsTemp (UserId, ClientId, Date)
    SELECT DISTINCT
        IL.UserId,
        ClientId,
        ProcessDate AS Date
    FROM OP_IncomingLog IL WITH (NOLOCK)
    JOIN OP_GeneralLog GLog WITH (NOLOCK) ON GLog.RequestId = IL.Id AND GLog.ImportResult = 0
    LEFT JOIN F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers ON TreeUsers.UserId = IL.UserId
    WHERE (
        ((@viewMode IS NULL OR @viewMode = 1) AND IL.UserId = @userId)
        OR (@viewMode = 2 AND TreeUsers.UserId IS NOT NULL)
    )
    AND IL.Firm = @firm
    AND IL.DocType < 20
    AND IL.ProcessDate BETWEEN CAST(@beginDate AS DATE) AND CAST(@endDate AS DATE)

    UNION

	 SELECT  DISTINCT
	    Ticket.UserId,
        Ticket.ClientId,
        CAST(Ticket.CreatedDate AS DATE) AS Date
    FROM  WPM_TaskTicket Ticket WITH (NOLOCK)
    LEFT JOIN F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers ON TreeUsers.UserId = Ticket.UserId
    WHERE (
        ((@viewMode IS NULL OR @viewMode = 1) AND Ticket.UserId = @userId)
        OR (@viewMode = 2 AND TreeUsers.UserId IS NOT NULL)
    )
    AND Ticket.Firm = @firm
    AND CAST(Ticket.CreatedDate AS DATE) BETWEEN CAST(@beginDate AS DATE) AND CAST(@endDate AS DATE)

	UNION
    SELECT DISTINCT
        V.CreatedUserId AS UserId,
        ClientId,
        CAST(CreatedDate AS DATE) AS Date
    FROM OP_ClientVisitLog V WITH (NOLOCK)
    LEFT JOIN F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers ON TreeUsers.UserId = V.CreatedUserId
    WHERE (
        ((@viewMode IS NULL OR @viewMode = 1) AND V.CreatedUserId = @userId)
        OR (@viewMode = 2 AND TreeUsers.UserId IS NOT NULL)
    )
    AND V.Firm = @firm
    AND CAST(V.CreatedDate AS DATE) BETWEEN CAST(@beginDate AS DATE) AND CAST(@endDate AS DATE);

    SELECT
        COUNT(R.ClientId) AS Routes,
        SUM(CASE WHEN R.ClientId IS NOT NULL AND A.ClientId IS NOT NULL THEN 1 ELSE 0 END) AS InRoute,
        SUM(CASE WHEN R.ClientId IS NULL AND A.ClientId IS NOT NULL THEN 1 ELSE 0 END) AS OutRoute
    FROM #RouteDataTemp R
    FULL JOIN #ActionsTemp A ON R.Date = A.Date AND R.ClientId = A.ClientId AND R.UserId = A.UserId;

    DROP TABLE #RouteDataTemp;
    DROP TABLE #ActionsTemp;
END;
