
/****** Object:  UserDefinedFunction [dbo].[F_WPM_GetClientRouteStatistics]    Script Date: 2/24/2022 11:50:55 AM ******/

ALTER FUNCTION [dbo].[F_WPM_GetClientRouteStatistics](@minDate datetime, @maxDate datetime,@minRouteDate date, @maxRouteDate date, @firm smallint, @users varchar(Max))
Returns Table
AS
RETURN(
SELECT ISNULL(VC.TigerClientId,TT.ClientId) AS Id, CAST(ISNULL(VC.UserId,TT.UserId) as INT) AS UserId, ISNULL(VC.UserFullName,TT.UserFullName) AS UserFullName, ISNULL(VC.[Date],TT.[Date]) AS [Date], MIN(VC.VisitCount) AS PlannedVisitCount,
SUM(CASE
WHEN TT.Type = 4 AND TT.ManualRouteClientId IS NULL THEN 1
ELSE 0
END) AS RouteVisitCount,
SUM(CASE
WHEN TT.Type != 4 or TT.ManualRouteClientId is not null THEN 1
ELSE 0
END) AS NonRouteVisitCount,
SUM(DATEDIFF(SECOND, TT.CreatedDate, TT.FinalizedDate)) AS TotalTime
FROM
(SELECT R.TigerClientId, R.Firm, count(*) AS VisitCount, U.[Name] + ' ' + U.Surname AS UserFullName, U.Id AS UserId, R.[Date] AS [Date]
FROM MD_Route R
JOIN AbpUsers U ON R.UserId = U.Id
WHERE R.Date BETWEEN @minRouteDate AND @maxRouteDate AND R.Firm = @firm AND R.UserId IN (select [Value] from F_SplitList(@users, ','))
GROUP BY R.TigerClientId, R.Firm, U.[Name], U.Surname, U.Id, R.[Date]) VC
FULL JOIN
(SELECT Ticket.*, (CASE WHEN TR.Date is not null then 4 else T.Type end) as Type, U.[Name] + ' ' + U.Surname AS UserFullName, CAST(Ticket.FinalizedDate AS DATE) AS [Date]
FROM WPM_TaskTicket Ticket
JOIN AbpUsers U ON Ticket.UserId = U.Id
JOIN WPM_Task T ON Ticket.TaskId = T.Id
LEFT JOIN MD_Route TR on Ticket.UserId=TR.UserId and Ticket.Firm=TR.Firm and Ticket.ClientId=TR.TigerClientId and CAST(Ticket.FinalizedDate as date)=TR.Date
WHERE Ticket.Firm = @firm
AND Ticket.UserId IN (select [Value] from F_SplitList(@users, ','))
AND Ticket.IsCompleted = 1
AND Ticket.FinalizedDate >= @minDate AND Ticket.FinalizedDate <= @maxDate) TT
ON TT.ClientId = VC.TigerClientId and VC.Firm = @firm
GROUP BY VC.TigerClientId,TT.ClientId, ISNULL(VC.UserFullName,TT.UserFullName), ISNULL(VC.UserId,TT.UserId), ISNULL(VC.[Date],TT.[Date])
)
