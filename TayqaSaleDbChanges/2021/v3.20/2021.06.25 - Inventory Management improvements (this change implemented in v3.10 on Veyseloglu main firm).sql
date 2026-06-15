CREATE FUNCTION [dbo].[F_IM_GetPermittedClientsIncludedChildClients](@userId INT)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT @userId AS UserId,
                       parentClient.Firm AS Firm,
                       parentClient.TigerId AS ParentClientId,
                       IIF(parentClient.CardType != 4 OR childClient.TigerId IS NULL, parentClient.TigerId,
                           IIF(childClient.TigerId IS NULL, parentClient.TigerId, childClient.TigerId)) AS ClientId
                FROM F_GetPermittedClientForUser(51876) pc
                         JOIN MD_Client parentClient ON pc.Firm = parentClient.Firm AND pc.ClientId = parentClient.TigerId
                         LEFT JOIN MD_Client childClient ON childClient.TigerParentId = parentClient.TigerId AND
                                                            childClient.Firm = parentClient.Firm AND
                                                            parentClient.CardType = 4
            );