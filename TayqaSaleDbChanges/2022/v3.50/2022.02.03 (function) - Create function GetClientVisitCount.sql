
CREATE     FUNCTION [dbo].[F_WPM_GetClientVisitCount](@firm SMALLINT, @userId BIGINT, @startDate datetime, @endDate datetime) 
Returns Table
AS
RETURN(
    SELECT ClientId, COUNT(ClientId) AS VisitCount
		FROM WPM_TaskTicket tt
		join WPM_Task t on t.Id=tt.TaskId
		WHERE tt.UserId=@userId and tt.Firm=@firm and tt.FinalizedDate >= @startDate and tt.FinalizedDate<= @endDate and t.Type=4
		GROUP BY ClientId
)
GO


