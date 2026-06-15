CREATE OR ALTER   PROC [dbo].[SP_MD_GetClientRiskData] @userId INT, @firm SMALLINT = 0, @erpClientId INT = 0
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT FinanceData.TigerId,
                   FinanceData.Firm,
                   FinanceData.AccumulatedRiskLimit,
                   FinanceData.SelfCheckVoucherRiskLimit,
                   FinanceData.ClientCheckVoucherRiskLimit,
                   FinanceData.CheckVoucherCirculationRiskLimit,
                   FinanceData.DispatchRiskLimit,
                   FinanceData.DispatchProposalRiskLimit,
                   FinanceData.AccumulatedRiskLimit - (select isnull(sum(Debit - Credit), 0) from OP_ClientDebt where TigerClientId = FinanceData.TigerId AND Firm = FinanceData.Firm) as OrderRiskLimit,
                   FinanceData.OrderProposalRiskLimit,
                   FinanceData.ClosedRisk,
                   FinanceData.TotalRisk,
                   (CASE WHEN Client.RegisteredDate >= FinanceData.RegisteredDate THEN Client.RegisteredDate ELSE FinanceData.RegisteredDate END) AS RegisteredDate
            FROM MD_ClientFinanceData FinanceData WITH (NOLOCK)
                     LEFT JOIN (SELECT Firm, ClientId, max(RegisteredDate) AS RegisteredDate
                                 FROM (
                                          SELECT Firm, ClientId, RegisteredDate
                                          FROM F_GetPermittedClientForUserWithRegisteredDate(@userId)
                                          UNION
                                          SELECT Firm, ClientId, RegisteredDate
                                          FROM F_GetAllPermittedClientWithRegisteredDate() pc
                                                   JOIN F_Hybrid_GetPermittedUsers(@userId) pu ON pc.UserId = pu.UserId
                                              AND (SELECT Type FROM F_GetUserRootType(@userId)) = ''Hybrid'')
                                          AS GroupT
                                 GROUP BY Firm, ClientId) Client ON (Client.Firm = FinanceData.Firm AND Client.ClientId = FinanceData.TigerId)
            WHERE 1 = 1';

    IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and FinanceData.Firm=@firm');
        END

    IF (@erpClientId > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and FinanceData.TigerId=@erpClientId')
        END

    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT, @erpClientId INT', @userId = @userId, @firm = @firm,
         @erpClientId = @erpClientId
END


 