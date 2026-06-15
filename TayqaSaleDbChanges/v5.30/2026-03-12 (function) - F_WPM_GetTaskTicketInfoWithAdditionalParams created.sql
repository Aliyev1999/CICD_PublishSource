
create or ALTER FUNCTION [dbo].[F_WPM_GetTaskTicketInfoWithAdditionalParams](@taskIds nvarchar(max),@fromDate Date,@registeredDate Date,@userId int)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT t.Id TaskId, t.Firm, tt.UserId,
                       c.TigerId ClientId, tt.Id TicketId,
                       tt.CreatedNote, tt.CreatedDate, tt.CreatedLatitude, tt.CreatedLongitude, tt.RegisteredDate,
                       tt.FinalizedNote, tt.FinalizedDate, tt.FinalizedLatitude, tt.FinalizedLongitude, tt.IsCompleted,
                       tt.CycleNo, tt.ScheduleId, tt.StopReasonId,
                       tta.ActionId ActionId,
                       tta.CreatedDate ActionCreatedDate, tta.CreatedLatitude ActionCreatedLatitude, tta.CreatedLongitude ActionCreatedLongitude,
                       tta.FinalizedDate ActionFinalizedDate, tta.FinalizedLatitude ActionFinalizedLatitude, tta.FinalizedLongitude ActionFinalizedLongitude,
                       tta.Note ActionNote, tta.RegisteredDate ActionRegisteredDate, tta.ActionParams,
                       rc.UId AddedClientUId, rc.Id AddedClientRemoteId, rc.Date AddedClientCreationDate
                    FROM WPM_TaskTicket tt
					-- join WPM_TaskSchedule ts on tt.TaskId = ts.TaskId and ts.Status=0
                             JOIN WPM_Task t ON t.Id = tt.TaskId
                             JOIN MD_Client c ON c.TigerId = tt.ClientId AND c.Firm = tt.Firm
                             LEFT JOIN WPM_RouteClient rc ON tt.ManualRouteClientId = rc.Id
                             LEFT JOIN WPM_TaskTicketAction tta ON tt.Id = tta.TaskTicketId
                    WHERE tt.CreatedDate > DATEADD(DAY, -7, GETDATE()) and tt.TaskId in (select Value FROM F_SplitList(@taskIds, ',')) and tt.UserId = @userId)
