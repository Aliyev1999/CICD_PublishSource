CREATE OR  ALTER   FUNCTION [dbo].[F_MGM_GetTrackingTotalPercentages]
(
    @userId BIGINT,
    @begin DATETIME2,
    @end DATETIME2
)
RETURNS TABLE
AS
RETURN
(

    WITH TreeUsers AS (
        SELECT UserId
        FROM F_GetPermittedUsers(@userId)
    ),
    Routes AS (
        SELECT Routes.UserId, Routes.TigerClientId AS ClientId, Routes.Date
        FROM MD_Route Routes WITH (NOLOCK)
        JOIN TreeUsers Permitted ON Permitted.UserId = Routes.UserId
        WHERE Routes.Date BETWEEN @begin AND @end AND Routes.Status = 0
    ),
    Actions AS (
        SELECT Logs.UserId, Logs.ClientId, Logs.ProcessDate AS Date
        FROM OP_IncomingLog Logs WITH (NOLOCK)
        JOIN TreeUsers Permitted ON Permitted.UserId = Logs.UserId
        WHERE Logs.ProcessDate BETWEEN @begin AND @end

        UNION
        SELECT Logs.CreatedUserId, Logs.ClientId, CAST(Logs.CreatedDate AS DATE)
        FROM OP_ClientVisitLog Logs WITH (NOLOCK)
        JOIN TreeUsers Permitted ON Permitted.UserId = Logs.CreatedUserId
        WHERE CAST(Logs.CreatedDate AS DATE) BETWEEN @begin AND @end

        UNION
        SELECT Logs.CreatorUserId, Logs.ClientTigerId, CAST(Logs.CreatedDate AS DATE)
        FROM IM_InventoryStateHistory Logs WITH (NOLOCK)
        JOIN TreeUsers Permitted ON Permitted.UserId = Logs.CreatorUserId
        WHERE CAST(Logs.CreatedDate AS DATE) BETWEEN @begin AND @end

        UNION
        SELECT Logs.UserId, Logs.ClientId, CAST(Logs.CreatedDate AS DATE)
        FROM WPM_TaskTicket Logs WITH (NOLOCK)
        JOIN TreeUsers Permitted ON Permitted.UserId = Logs.UserId
        WHERE CAST(Logs.CreatedDate AS DATE) BETWEEN @begin AND @end

        UNION
        SELECT Logs.UserId, Logs.ClientId, CAST(Logs.CreatedDate AS DATE)
        FROM CHL_UserSurveyResponse Logs WITH (NOLOCK)
        JOIN TreeUsers Permitted ON Permitted.UserId = Logs.UserId
        WHERE CAST(Logs.CreatedDate AS DATE) BETWEEN @begin AND @end
    ),
    Combined AS (
        SELECT
            COALESCE(Routes.UserId, Actions.UserId) AS UserId,
            COALESCE(Routes.ClientId, Actions.ClientId) AS ClientId,
            COALESCE(Routes.Date, Actions.Date) AS Date,
            IIF(Routes.UserId IS NOT NULL, 1, 0) AS IsRoute,
            IIF(Actions.UserId IS NOT NULL, 1, 0) AS IsVisited
        FROM Routes
        FULL OUTER JOIN Actions
            ON Routes.ClientId = Actions.ClientId
            AND Routes.UserId = Actions.UserId
            AND Routes.Date = Actions.Date
    ),
    VisitTotal AS (
        SELECT
            SUM(IsRoute) AS Planned,
            SUM(IIF(IsRoute = 1 AND IsVisited = 1, 1, 0)) AS InRouteVisit,
            SUM(IIF(IsRoute = 0 AND IsVisited = 1, 1, 0)) AS NonRouteVisit
        FROM Combined
    )
    SELECT 
        round(CAST(
            CASE 
                WHEN Planned = 0 THEN 0
                ELSE (CAST(InRouteVisit AS FLOAT) / Planned) * 100 
            END AS FLOAT
        ) ,2)AS PlanCompletionPercentage,

       round( CAST(
            CASE 
                WHEN Planned = 0 THEN 0
                ELSE ((CAST(InRouteVisit + NonRouteVisit AS FLOAT)) / Planned) * 100 
            END AS FLOAT
        ),2) AS TotalCompletionPercentage
    FROM VisitTotal
);


