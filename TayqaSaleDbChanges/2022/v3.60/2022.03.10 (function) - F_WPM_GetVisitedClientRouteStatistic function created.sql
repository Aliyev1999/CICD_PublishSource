Create FUNCTION [dbo].[F_WPM_GetVisitedClientRouteStatistics](@minDate DATETIME, @maxDate DATETIME,@minRouteDate DATE, @maxRouteDate DATE, @firm SMALLINT, @users VARCHAR(MAX))
RETURNS TABLE
AS
RETURN(
	SELECT ISNULL(VC.TigerClientId,TT.ClientId)		AS Id, 
		   CAST(ISNULL(VC.UserId,TT.UserId) AS INT) AS UserId, 
		   ISNULL(VC.UserFullName,TT.UserFullName)  AS UserFullName, 
		   MIN(VC.VisitCount)						AS PlannedVisitCount,
		   SUM(CASE WHEN TT.TYPE = 4 AND TT.ManualRouteClientId IS NULL 
					THEN 1 ELSE 0 END)				AS RouteVisitCount,
		   SUM(CASE WHEN TT.TYPE != 4 OR TT.ManualRouteClientId IS NOT NULL 
					THEN 1 ELSE 0 END)				AS NonRouteVisitCount,
		   SUM(DATEDIFF(SECOND, TT.CreatedDate, TT.FinalizedDate)) AS TotalTime
	FROM
		(SELECT R.TigerClientId, 
				R.Firm, 
				COUNT(*)				   AS VisitCount, 
				U.[Name] + ' ' + U.Surname AS UserFullName, 
				U.Id					   AS UserId
		FROM MD_Route R
			JOIN AbpUsers U ON R.UserId = U.Id
			WHERE R.DATE BETWEEN @minRouteDate AND 
								 @maxRouteDate AND 
								 R.Firm = @firm AND 
								 R.UserId IN (SELECT [Value] FROM F_SplitList(@users, ','))
		GROUP BY R.TigerClientId, R.Firm, U.[Name], U.Surname, U.Id, R.[Date]) VC
		FULL JOIN
		(SELECT Ticket.*, 
				(CASE WHEN TR.DATE IS NOT NULL THEN 4 
					  ELSE T.TYPE END)					AS TYPE, 
				U.[Name] + ' ' + U.Surname				AS UserFullName
		FROM WPM_TaskTicket Ticket
			JOIN AbpUsers U ON Ticket.UserId = U.Id
			JOIN WPM_Task T ON Ticket.TaskId = T.Id
			LEFT JOIN MD_Route TR ON Ticket.UserId=TR.UserId AND 
							   Ticket.Firm=TR.Firm AND 
							   Ticket.ClientId=TR.TigerClientId AND 
							   CAST(Ticket.FinalizedDate AS DATE)=TR.DATE
		WHERE Ticket.Firm = @firm AND 
			  Ticket.UserId IN (SELECT [Value] FROM F_SplitList(@users, ',')) AND 
			  Ticket.IsCompleted = 1 AND 
			  Ticket.FinalizedDate >= @minDate AND 
			  Ticket.FinalizedDate <= @maxDate) TT
			ON TT.ClientId = VC.TigerClientId AND VC.Firm = @firm
		GROUP BY VC.TigerClientId,TT.ClientId, ISNULL(VC.UserFullName,TT.UserFullName), ISNULL(VC.UserId,TT.UserId)
);
