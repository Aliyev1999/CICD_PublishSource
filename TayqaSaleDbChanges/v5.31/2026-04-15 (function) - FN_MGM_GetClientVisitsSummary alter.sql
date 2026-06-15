Create or ALTER FUNCTION [dbo].[FN_MGM_GetClientVisitsSummary](	@firm Smallint,
    @currentUserId int,
    @beginDate datetime,
    @endDate datetime

    )
    returns table
        as
        return(
        WITH Logs AS (
            SELECT
                CreatedUserId,
                ClientId,
                DATEDIFF(SECOND, Date, CreatedDate) AS VisitTimeSeconds,
                ROW_NUMBER() OVER (PARTITION BY CreatedUserId, ClientId ORDER BY Date) AS rn
            FROM OP_ClientVisitLog WITH (nolock)
                     JOIN F_GetPermittedUsers(@currentUserId) PermittedUsers
                          ON PermittedUsers.UserId = OP_ClientVisitLog.CreatedUserId
            WHERE Date BETWEEN @beginDate AND @endDate and Firm=@firm
        ),
             VisitCounts AS (
                 SELECT
                     CreatedUserId AS UserId,
                     COUNT(CASE WHEN rn = 1 THEN 1 END) AS ClientCount,
                     SUM(VisitTimeSeconds) AS VisitTimeSeconds
                 FROM Logs
                 GROUP BY CreatedUserId
             )
        SELECT SUM(ClientCount) AS ClientCount,
               COUNT(UserId)    AS UserCount,
               CASE
                   WHEN SUM(VisitTimeSeconds) < 0 THEN '00:00:00'
                   ELSE
                       RIGHT('0' + CAST(SUM(VisitTimeSeconds) / 3600 AS VARCHAR), 2) + ':' +
                       RIGHT('0' + CAST((SUM(VisitTimeSeconds) % 3600) / 60 AS VARCHAR), 2) + ':' +
                       RIGHT('0' + CAST(SUM(VisitTimeSeconds) % 60 AS VARCHAR), 2)
                   END          AS Time
        FROM VisitCounts
        )