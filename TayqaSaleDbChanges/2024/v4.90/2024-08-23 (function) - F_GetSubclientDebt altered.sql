Create FUNCTION [dbo].[F_GetSubclientDebt](
    @firm int,
    @date date,
    @clientId int
)
RETURNS TABLE 
AS
RETURN
(
    SELECT 
        Client.TigerId AS ClientId,
        Client.Code AS ClientCode,
        Client.Name AS ClientName,
        CAST(ISNULL(ROUND(SUM(AMOUNT * (CASE WHEN Debt.SIGN = 0 THEN 1 ELSE -1 END)), 4), 0) AS FLOAT) AS Debt
    FROM 
        MD_Client Client WITH (NOLOCK)
    LEFT JOIN 
        TestTigerEnt_db..LG_009_06_CLFLINE Debt WITH (NOLOCK)  ON Client.TigerId = Debt.CLIENTREF AND Debt.DATE_ <= @date and Debt.CANCELLED=0 and  Debt.STATUS = 0
    WHERE 

        (( Client.TigerParentId = @ClientId) AND 
         (SELECT TOP 1 CardType FROM MD_Client WHERE TigerId = @ClientId) = 4)

        OR (Client.TigerParentId = (SELECT TOP 1 TigerParentId FROM MD_Client WHERE TigerId = @ClientId) AND 
		    ( Client.TigerParentId <> 0) and
            (SELECT TOP 1 CardType FROM MD_Client WHERE TigerId = @ClientId ) = 3)
        
        OR (Client.TigerId = @ClientId AND 
            (Client.TigerParentId IS NULL OR Client.TigerParentId = 0) AND 
            (SELECT COUNT(*) FROM MD_Client WHERE TigerParentId = Client.TigerId) = 0)
    AND 
        Client.Firm = @firm
    GROUP BY 
        Client.TigerId, Client.Code, Client.Name
)
