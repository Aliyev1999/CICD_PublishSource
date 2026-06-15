CREATE FUNCTION [dbo].[F_GetAllPermittedUsersPermittedClients](@userId INT)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT DISTINCT clientFunc.ClientId, clientFunc.Firm
                FROM F_GetAllPermittedClient() clientFunc
                         JOIN F_UIM_GetOrganizationTreeAllUsers(@userId) au ON clientFunc.UserId = au.UserId
            )
GO