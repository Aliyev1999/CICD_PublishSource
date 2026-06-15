CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetRiskLimitRequestDetails](@requestId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        RiskLimitRequest.Id                                      AS RequestId,
        RiskLimitRequest.CreatedDate AS [Date],
        RiskLimitRequest.CreatedNote                             AS [Note],
        Client.Name                                              AS ClientName,
        Client.Code                                              AS ClientCode,
        RiskLimitClient.CurrentLimit                             AS CurrentLimit,
        RiskLimitClient.RequestedLimit                           AS RequestAmount,
        CASE
            WHEN RiskLimitClient.CurrentLimit < RiskLimitClient.RequestedLimit THEN 0  -- artırmaq
            WHEN RiskLimitClient.CurrentLimit > RiskLimitClient.RequestedLimit THEN 1  -- azaltmaq
            ELSE NULL
        END AS ChangeType
    FROM 
        OP_RiskLimitClient AS RiskLimitClient WITH (NOLOCK)
        INNER JOIN OP_RiskLimitRequest AS RiskLimitRequest WITH (NOLOCK)
            ON RiskLimitClient.RequestId = RiskLimitRequest.Id
            AND RiskLimitRequest.Id = @requestId
        INNER JOIN MD_Client AS Client WITH (NOLOCK)
            ON Client.TigerId = RiskLimitClient.ClientId
            AND Client.Firm = RiskLimitRequest.Firm
);
