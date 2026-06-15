CREATE OR ALTER FUNCTION [dbo].[FN_MGM_GetClientVisitsDetailSummary](
    @currentUserId int,
    @beginDate datetime,
    @endDate datetime
)
    returns table
        as
        return(	
WITH Logs AS (
    SELECT
        VisitLog.CreatedUserId,
        VisitLog.ClientId,

        CASE
            WHEN DATEDIFF(SECOND, VisitLog.Date, VisitLog.CreatedDate) < 0 THEN 0
            ELSE DATEDIFF(SECOND, VisitLog.Date, VisitLog.CreatedDate)
        END AS VisitTimeSeconds,

        ROW_NUMBER() OVER (
            PARTITION BY VisitLog.CreatedUserId, VisitLog.ClientId
            ORDER BY VisitLog.Date
        ) AS rn,
        ROW_NUMBER() OVER (
            PARTITION BY VisitLog.Id
            ORDER BY VisitLog.Date DESC
        ) AS RowNum,
        FileUploadLog.FileName,
        VisitLog.Id
    FROM OP_ClientVisitLog VisitLog WITH (NOLOCK)
    LEFT JOIN OP_FileUploadLog FileUploadLog
        ON FileUploadLog.DocId = VisitLog.DocId
       AND FileUploadLog.ContentType = 2
    WHERE VisitLog.Date BETWEEN @beginDate AND @endDate
      AND VisitLog.CreatedUserId = @currentUserId
)

SELECT
    CreatedUserId                                   AS UserId,
    COUNT(CASE WHEN rn = 1 THEN 1 END)              AS ClientCount,
    COUNT(CASE WHEN RowNum = 1 THEN 1 END)          AS VisitCount,
    COUNT(FileName)                                 AS PhotoCount,
    CAST(SUM(VisitTimeSeconds) / 60 AS BIGINT)      AS Time
FROM Logs
GROUP BY CreatedUserId
)