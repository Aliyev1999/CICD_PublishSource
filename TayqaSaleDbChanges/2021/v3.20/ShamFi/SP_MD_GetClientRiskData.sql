USE [TayqaSale]
GO

ALTER PROC [dbo].[SP_MD_GetClientRiskData] @userId INT, @firm SMALLINT = 0, @erpClientId INT = 0
AS
BEGIN

    declare @isSalesPerson bit =0;

-- if salesperson
    select @isSalesPerson = count(*)
    from UIM_UserTypeUserMapping
    where UserId = @userId
      AND UserTypeId = (SELECT Id FROM UIM_UserType where Type = 'SalePerson')

    DECLARE @sql NVARCHAR(MAX);

    if (@isSalesPerson = 1)
        begin
            set @sql = 'select	FinanceData.CLIENTREF as TigerId,
                 992 as  Firm,
                 0 as  AccumulatedRiskLimit,
                 0 as  SelfCheckVoucherRiskLimit,
                 0 as  ClientCheckVoucherRiskLimit,
                 0 as  CheckVoucherCirculationRiskLimit,
                 0 as  DispatchRiskLimit,
                 0 as  DispatchProposalRiskLimit,
                 FinanceData.RISKLIMIT as  OrderRiskLimit,
                 0 as  OrderProposalRiskLimit,
                 FinanceData.RISKLIMIT as  ClosedRisk,
                 0 as  TotalRisk,
                 GETDATE() AS RegisteredDate
	FROM LOGODB_2021.dbo.VW_TS_Spec_GetSalesmanClientRiskLimit_992 FinanceData
	WHERE SALESMANREF = (SELECT TOP 1 EmployeeId FROM TayqaSale.dbo.UIM_UserEmployeeMapping 
			WHERE UserId=@userId AND Status=0 AND Firm=992)'
        end

    else
        begin

            SET @sql = 'SELECT FinanceData.TigerId,
                   FinanceData.Firm,
                   FinanceData.AccumulatedRiskLimit,
                   FinanceData.SelfCheckVoucherRiskLimit,
                   FinanceData.ClientCheckVoucherRiskLimit,
                   FinanceData.CheckVoucherCirculationRiskLimit,
                   FinanceData.DispatchRiskLimit,
                   FinanceData.DispatchProposalRiskLimit,
                   FinanceData.OrderRiskLimit,
                   FinanceData.OrderProposalRiskLimit,
                   FinanceData.ClosedRisk,
                   FinanceData.TotalRisk,
                   (CASE WHEN Client.RegisteredDate >= FinanceData.RegisteredDate 
                          THEN Client.RegisteredDate ELSE FinanceData.RegisteredDate END) AS RegisteredDate
            FROM MD_ClientFinanceData FinanceData WITH (NOLOCK)
                     INNER JOIN (SELECT Firm, ClientId, max(RegisteredDate) AS RegisteredDate
                                 FROM (
                                          SELECT Firm, ClientId, RegisteredDate
                                          FROM F_GetPermittedClientForUserWithRegisteredDate(@userId)
                                          UNION
                                          SELECT Firm, ClientId, RegisteredDate
                                          FROM F_GetAllPermittedClientWithRegisteredDate() pc
                                                   JOIN F_Hybrid_GetPermittedUsers(@userId) pu ON pc.UserId = pu.UserId
                                              AND (SELECT Type FROM F_GetUserRootType(@userId)) = ''Hybrid'')
                                          AS GroupT
                                 GROUP BY Firm, ClientId) 
                                 Client ON (Client.Firm = FinanceData.Firm AND Client.ClientId = FinanceData.TigerId)
            WHERE 1 = 1';

            IF (@firm > 0)
                BEGIN
                    SET @sql = CONCAT(@sql, ' and FinanceData.Firm=@firm');
                END

            IF (@erpClientId > 0)
                BEGIN
                    SET @sql = CONCAT(@sql, ' and FinanceData.TigerId=@erpClientId')
                END
        end
    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT, @erpClientId INT', @userId = @userId, @firm = @firm,
         @erpClientId = @erpClientId
END