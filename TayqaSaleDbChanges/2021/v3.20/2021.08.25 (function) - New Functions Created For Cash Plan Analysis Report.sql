CREATE FUNCTION [dbo].[F_GetPermittedUsers](@userId INT = NULL)
RETURNS
@T TABLE (UserId int)
AS
BEGIN

    DECLARE @count int;    
    set @count = (SELECT COUNT(*) FROM AbpUserRoles UR
	 									JOIN AbpRoles R ON R.Id = UR.RoleId
	 									WHERE R.Name = 'Admin' AND R.IsDeleted = 0 AND UR.UserId = @userId);


	IF @count > 0
		BEGIN
            insert into @T (UserId)
			SELECT U.Id AS UserId FROM AbpUsers U
		WHERE U.IsDeleted = 0 AND U.IsActive = 1 AND Id > 1 AND UserName <> 'service_user'
		END
	ELSE
		BEGIN
            insert into @T (UserId)
			SELECT * FROM F_Hybrid_GetPermittedUsers(@userId)
		END
    RETURN
END

GO

CREATE  FUNCTION [dbo].[F_GetCashPlanForSalesmanReportMasterData](@users NVARCHAR(MAX) = NULL,
                                                                 @years NVARCHAR(MAX) = NULL,
                                                                 @months NVARCHAR(MAX) = NULL,
                                                                 @clients NVARCHAR(MAX) = NULL, @firm SMALLINT = NULL,
                                                                 @currentUserId INT = NULL)
    RETURNS TABLE
        AS
        RETURN
            (
                WITH FactQuery AS (
                    SELECT FinOps.Firm,
                           FinOps.SalesmanId,
                           YEAR(FinOps.[Date])  AS [Year],
                           MONTH(FinOps.[Date]) AS [Month],
                           FinOps.CurrencyType,
                           SUM(FinOps.Amount)   AS Amount-- ,
                           -- UEMapping.UserId
                    FROM ERP_FinanceOperation FinOps WITH (NOLOCK)
                             JOIN MD_Client Client ON Client.Firm = FinOps.Firm AND Client.TigerId = FinOps.ClientId
                         -- JOIN UIM_UserEmployeeMapping UEMapping ON FinOps.SalesmanId = UEMapping.EmployeeId AND FinOps.Firm = UEMapping.Firm
                    WHERE FinOps.[Type] IN (5, 21)
                      AND FinOps.[Sign] = 1
                      AND SalesmanId > 0
                      AND (@clients IS NULL OR Client.[Code] IN (SELECT [Value] FROM F_SplitList(@clients, ',')))
                      AND FinOps.SalesmanId IN (SELECT EmployeeId
                                                FROM UIM_UserEmployeeMapping
                                                WHERE UserId IN (SELECT UserId FROM F_GetPermittedUsers(@currentUserId)))
                    GROUP BY FinOps.SalesmanId,
                             FinOps.Firm,
                             YEAR(FinOps.[Date]),
                             MONTH(FinOps.[Date]),
                             FinOps.CurrencyType)

                SELECT ISNULL(PlanFirm.Nr, FactFirm.Nr)                   AS Firm,
                       ISNULL(PlanFirm.Name, FactFirm.Name)               AS FirmName,
                       ISNULL(PlanSalesman.TigerId, FactSalesman.TigerId) AS SalesmanId,
                       ISNULL(PlanSalesman.Name, FactSalesman.Name)       AS SalesmanName,
					   U.Id												  AS UserId,
					   U.Name + ' ' + U.Surname							  AS UserFullName,
                       ISNULL(CashPlan.[Year], FactQuery.Year)            AS Year,
                       ISNULL(CashPlan.[Month], FactQuery.Month)          AS Month,
                       ISNULL(PlanCurrency.Type, FactCurrency.Type)       AS CurrencyType,
                       ROUND(SUM(CashPlan.Amount), 2)                     AS PlanAmount,
                       FactQuery.Amount                                   AS FactAmount,
                       ISNULL(PlanCurrency.Code, FactCurrency.Code)       AS CurrencyName
                FROM MD_CashPlanForUser CashPlan WITH (NOLOCK)

						JOIN AbpUsers U ON CashPlan.UserId = U.Id
                         -- Joined with CashPlan
                         JOIN MD_Firm PlanFirm WITH (NOLOCK) ON CashPlan.Firm = PlanFirm.Nr
                         JOIN MD_Currency PlanCurrency WITH (NOLOCK) ON
                            CashPlan.CurrencyType = PlanCurrency.Type AND CashPlan.Firm = PlanCurrency.Firm
                         JOIN UIM_UserEmployeeMapping UserEmployee WITH (NOLOCK)
                              ON CashPlan.UserId = UserEmployee.UserId AND CashPlan.Firm = UserEmployee.Firm
                         JOIN MD_Salesman PlanSalesman WITH (NOLOCK)
                              ON PlanSalesman.Firm = PlanFirm.Nr AND PlanSalesman.TigerId = UserEmployee.EmployeeId

                         FULL OUTER JOIN FactQuery
                                         ON FactQuery.Firm = UserEmployee.Firm AND
                                            FactQuery.SalesmanId = UserEmployee.EmployeeId AND
                                            FactQuery.[Month] = CashPlan.[Month] AND
                                            FactQuery.[Year] = CashPlan.[Year] AND
                                            FactQuery.CurrencyType = CashPlan.CurrencyType AND
                                            FactQuery.CurrencyType = PlanFirm.LocalCurrencyTypeId
                    -- Joined with FactQuery
                         FULL OUTER JOIN MD_Currency FactCurrency WITH (NOLOCK) ON
                            FactQuery.CurrencyType = FactCurrency.Type AND
                            FactQuery.Firm = FactCurrency.Firm
                         FULL OUTER JOIN MD_Salesman FactSalesman WITH (NOLOCK)
                              ON FactSalesman.Firm = FactQuery.Firm AND FactSalesman.TigerId = FactQuery.SalesmanId
                         FULL OUTER JOIN MD_Firm FactFirm WITH (NOLOCK)
                              ON FactQuery.Firm = FactFirm.Nr AND FactFirm.LocalCurrencyTypeId = FactQuery.CurrencyType

                WHERE
				-- (@users IS NULL OR CashPlan.UserId IN (SELECT [Value] FROM F_SplitList(@users, ',')))
				(@users IS NULL OR U.Id IN (SELECT [Value] FROM F_SplitList(@users, ',')))
                  AND (CashPlan.UserId IN (SELECT UserId FROM F_GetPermittedUsers(@currentUserId)))
                  AND (@years IS NULL OR
                       ISNULL(CashPlan.[Year], FactQuery.Year) IN (SELECT [Value] FROM F_SplitList(@years, ',')))
                  AND (@months IS NULL OR ISNULL(CashPlan.[Month], FactQuery.[Month]) IN
                                          (SELECT [Value] FROM F_SplitList(@months, ',')))
                  AND (@firm IS NULL OR ISNULL(PlanFirm.Nr, FactFirm.Nr) = @firm)
                GROUP BY ISNULL(PlanSalesman.TigerId, FactSalesman.TigerId),
                         ISNULL(PlanFirm.Nr, FactFirm.Nr),
                         ISNULL(CashPlan.[Year], FactQuery.Year),
                         ISNULL(CashPlan.[Month], FactQuery.Month),
                         ISNULL(PlanCurrency.Type, FactCurrency.Type),
                         ISNULL(PlanCurrency.Code, FactCurrency.Code),
                         ISNULL(PlanFirm.Name, FactFirm.Name),
                         ISNULL(PlanSalesman.Name, FactSalesman.Name),
                         FactQuery.Amount,                --Amount is not grouped as we need it once. Every mapping doubles, triples etc.
						 U.Name + ' ' + U.Surname,
						 U.Id

            )

GO


CREATE FUNCTION [dbo].[F_GetCashPlanForSalesmanReportDetailsData](@salesmanId INT = NULL, @firm SMALLINT = NULL, @year INT = NULL, @months NVARCHAR(MAX) = NULL, @currencyType INT = NULL,
@clients NVARCHAR(MAX) = NULL, @currentUserId INT = NULL)
RETURNS TABLE
AS
RETURN(
	WITH FACTQUERY AS (
    SELECT
        FOD.Firm,
        YEAR(FOD.[Date]) AS [Year],
        MONTH(FOD.[Date]) AS [Month],
        SUM(FOD.Amount) AS Amount,
        CurrencyType,
        ClientId
    FROM ERP_FinanceOperation FOD
    WHERE
        FOD.[Type] IN (5, 21) AND
        FOD.[Sign] = 1 AND
        FOD.SalesmanId = @salesmanId AND
        (@firm IS NULL OR FOD.Firm = @firm) AND
        (@currencyType is NULL OR FOD.CurrencyType = @currencyType) AND
		FOD.SalesmanId IN (SELECT EmployeeId FROM UIM_UserEmployeeMapping WHERE UserId IN (SELECT UserId FROM F_GetPermittedUsers(@currentUserId)))
    GROUP BY
        FOD.Firm,
        FOD.ClientId,
        YEAR(FOD.[Date]),
        MONTH(FOD.[Date]),
        FOD.CurrencyType)
        
    SELECT
        C.Name AS ClientName,
        C.Code AS ClientCode,
        FQ.[Year],
        FQ.[Month],
        FQ.CurrencyType,
        FQ.Amount AS FactAmount
    FROM FACTQUERY FQ
	JOIN MD_Firm F ON FQ.Firm = F.Nr AND FQ.CurrencyType = F.LocalCurrencyTypeId
    JOIN MD_Client C ON FQ.Firm = C.Firm
    AND FQ.ClientId = C.TigerId
    WHERE
    (@year IS NULL OR FQ.[Year] = @year) AND
    (@months IS NULL OR FQ.[Month] IN (SELECT [Value] FROM F_SplitList(@months, ','))) AND
    (@clients IS NULL OR C.Code IN (SELECT [Value] FROM F_SplitList(@clients, ',')))
)
