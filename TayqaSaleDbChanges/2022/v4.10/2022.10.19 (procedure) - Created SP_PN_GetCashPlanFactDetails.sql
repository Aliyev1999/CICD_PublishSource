create procedure [dbo].[SP_PN_GetCashPlanFactDetails] @currentUserId int,
                                                     @selectedUserId int,
                                                     @firm smallint,
                                                     @year smallint,
                                                     @month tinyint,
                                                     @currencyType smallint
as

-- Created by: TayqaTech for TayqaSale (Ramil ALiyev)
-- Date: 01.01.2022
-- Description: Returns the report data of cash plan-fact details for selected user

    IF EXISTS(SELECT COUNT(*)
              FROM F_GetUserRootType(@currentUserId)
              WHERE Type = 'Hybrid')
        BEGIN
            SELECT salesman.Name AS ClientName,
                   salesman.Code AS ClientCode,
                   fact.Amount   AS Amount,
                   fact.Date     AS Date
            FROM OP_FactCashForSalesman fact with (nolock)
                     JOIN MD_Salesman salesman with (nolock) on fact.Firm = salesman.Firm AND fact.SalesmanId = salesman.TigerId
                     JOIN UIM_UserEmployeeMapping userEmployeeMapping with (nolock)
                          on userEmployeeMapping.EmployeeId = salesman.TigerId AND userEmployeeMapping.Firm = salesman.Firm
            WHERE userEmployeeMapping.UserId = @selectedUserId
              AND salesman.Firm = @firm
              AND YEAR(fact.Date) = @year
              and Month(fact.Date) = @month
        END
    ELSE
        BEGIN
            SELECT TOP 0 ''        CLientName,
                         ''        ClientCode,
                         0         Amount,
                         GETDATE() Date
        END