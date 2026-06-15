ALTER FUNCTION [dbo].[FN_WPM_UserClientVisitHistory]
    (
        @startDate DATE,
        @endDate DATE,
        @currentUserId INT
        )
    RETURNS TABLE
        AS
        RETURN(SELECT Client.Name                                                                   AS ClientName,
                      Client.Code                                                                   AS ClientCode,                 
                      TaskTicket.CreatedDate                                                        AS StartTime,
					  TaskTicket.FinalizedDate                                                      AS EndTime,

                      ISNULL(DATEDIFF(MINUTE, TaskTicket.CreatedDate, TaskTicket.FinalizedDate), 0) AS TimeOnClient,

                      -- VisitStatus hesabı
                      
                              cast ((CASE
                                  WHEN TaskTicket.CreatedDate IS NULL AND TaskSchedule.StartDate < GETDATE() THEN 1
                                  WHEN TaskTicket.CreatedDate IS NULL AND TaskSchedule.StartDate >= GETDATE() THEN 2
                                  WHEN TaskTicket.CreatedDate IS NOT NULL AND TaskTicket.FinalizedDate IS NULL THEN 3
                                  WHEN TaskTicket.CreatedDate IS NOT NULL AND TaskTicket.FinalizedDate IS NOT NULL
                                      AND TaskTicket.StopReasonId IS NOT NULL THEN 5
                                  WHEN TaskTicket.CreatedDate IS NOT NULL AND TaskTicket.FinalizedDate IS NOT NULL
                                      AND TaskTicket.StopReasonId IS NULL THEN 4
                                  END) as tinyint) 
                                                                                                  AS VisitStatus,

                      
                      
                              Cast((CASE WHEN Route.UserId IS NOT NULL THEN 1 ELSE 0 END) as bit) 
                                                                                                    AS OnRoute,

                      TaskTicket.TicketActionCount                                                  AS AllOperationsCount,

                      COUNT(DISTINCT CASE
                                         WHEN TaskTicketAction.FinalizedDate IS NOT NULL THEN TaskTicketAction.Id
                          END)                                                                      AS CompletedOperationsCount,
                          TaskTicket.Id                                                             AS TaskTicketId

               FROM WPM_TaskTicket TaskTicket WITH (NOLOCK)

                        LEFT JOIN WPM_TaskTicketAction TaskTicketAction WITH (NOLOCK)
                                  ON TaskTicketAction.TaskTicketId = TaskTicket.Id

                        LEFT JOIN MD_Route Route WITH (NOLOCK)
                                  ON Route.UserId = TaskTicket.UserId
                                      AND Route.TigerClientId = TaskTicket.ClientId
                                      AND Route.Date = CAST(TaskTicket.CreatedDate AS DATE)
                                      AND Route.Status = 0
                                      AND Route.Firm = TaskTicket.Firm
						join  WPM_Task Task with (nolock)   on TaskTicket.TaskId=Task.Id and TaskTicket.Firm=Task.Firm

                        JOIN WPM_TaskSchedule TaskSchedule
                             ON TaskTicket.ScheduleId = TaskSchedule.Id

                        JOIN MD_Client Client
                             ON Client.TigerId = TaskTicket.ClientId

                        --JOIN F_GetPermittedUsers(@currentUserId) Users
                        --     ON Users.UserId = TaskTicket.UserId

               WHERE cast(TaskTicket.CreatedDate AS date) BETWEEN @startDate AND @endDate
			   and TaskTicket.UserId=@currentUserId
			   and Task.Type=4

               GROUP BY TaskTicket.Id,
                        TaskTicket.UserId,
                        TaskTicket.ClientId,
                        TaskTicket.CreatedDate,
                        TaskTicket.FinalizedDate,
                        TaskSchedule.StartDate,
                        TaskTicket.StopReasonId,
                        TaskTicket.TicketActionCount,
                        TaskTicket.Firm,
                        Route.UserId,
                        Client.Name,
                        Client.Code);
