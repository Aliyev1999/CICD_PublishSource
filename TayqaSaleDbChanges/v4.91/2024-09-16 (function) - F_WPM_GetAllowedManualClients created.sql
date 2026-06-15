CREATE FUNCTION [dbo].[F_WPM_GetAllowedManualClients](@firm SMALLINT,
                                                      @userId INT,
                                                      @taskId INT)
    RETURNS TABLE
        AS
        RETURN(select distinct ClientId as ClientId
               from F_GetPermittedClientForUserWithRegisteredDate(@userId)
               where Firm = @firm)
go