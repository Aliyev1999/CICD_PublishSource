ALTER Procedure [dbo].[SP_RM_GetKPIOverallPointData](@userId int,
                                                     @firm smallint,
                                                     @month smallint,
                                                     @year smallint,
                                                     @viewMode tinyint = 1)
AS
BEGIN

    with PlanAmount as (select sum(Amount) as PlanAmount, Firm, Plans.UserId
                        from MD_CashPlanForUser Plans
                                 left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Plans.UserId
                        where Month = @Month
                          AND Year = @Year
                          ANd Firm = @Firm
                          and ((@viewMode is null or @viewMode = 1 and Plans.UserId = @userId)
                            or (@viewMode = 2 and TreeUsers.UserId is not null))
                        group by firm, Plans.UserId),

         FactAmount as (SELECT sum(FinOps.Amount) as FactAmount, employee.UserId as UserId, employee.Firm
                        FROM ERP_FinanceOperation FinOps WITH (NOLOCK)
                                 join UIM_UserEmployeeMapping employee WITH (NOLOCK)
                                      on employee.EmployeeId = FinOps.SalesmanId
                        WHERE FinOps.[Type] IN (5, 21)
                          AND FinOps.[Sign] = 1
                          AND FinOps.IsCancelled = 0
                          AND month(FinOps.Date) = @Month
                          AND year(FinOps.Date) = @Year

                        group by employee.UserId, employee.Firm)
    select Criteria,
           Value,
           case
               when Criteria = 'CurrentMonth' then '#070662'
               when Criteria = 'LastMonth' then '#c38200'
               when Criteria = 'CompanyOverall' then '#744780' end as
               Color
    from (Select (select isnull(max(iif(FactAmount is null or UserPlan.Amount is null or UserPlan.Amount = 0, 0,
                                        round(FactAmount * 100 / UserPlan.Amount, 2))), 0) as CurrentCashPlan
                  from MD_CashPlanForUser UserPlan WITH (NOLOCK),
                       (SELECT SUM(FinOps.Amount) AS FactAmount
                        FROM ERP_FinanceOperation FinOps WITH (NOLOCK)
                        WHERE FinOps.[Type] IN (5, 21)
                          AND FinOps.[Sign] = 1
                          AND FinOps.IsCancelled = 0
                          AND month(FinOps.Date) = @Month
                          AND year(FinOps.Date) = @Year
                          AND SalesmanId in (select EmployeeId
                                             from UIM_UserEmployeeMapping Mapping with (nolock)
                                                      left join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on Mapping.UserId = TreeUsers.UserId
                                             where ((@viewMode is null or @viewMode = 1 and Mapping.UserId = @userId)
                                                 or (@viewMode = 2 and TreeUsers.UserId is not null))
                                               and Firm = @firm)) T
                  where UserId = @userId
                    and Month = @Month
                    and Year = @Year)                                                    as CurrentMonth,
                 (select isnull(max(iif(FactAmount is null or UserPlan.Amount is null or UserPlan.Amount = 0, 0,
                                        round(FactAmount * 100 / UserPlan.Amount, 2))), 0) as LastCashPlan
                  from MD_CashPlanForUser UserPlan WITH (NOLOCK),
                       (SELECT SUM(FinOps.Amount) AS FactAmount
                        FROM ERP_FinanceOperation FinOps WITH (NOLOCK)
                        WHERE FinOps.[Type] IN (5, 21)
                          AND FinOps.[Sign] = 1
                          AND FinOps.IsCancelled = 0
                          AND month(FinOps.Date) = @Month - 1
                          AND year(FinOps.Date) = @Year
                          AND SalesmanId in (select EmployeeId
                                             from UIM_UserEmployeeMapping WITH (NOLOCK)
                                             where UserId = @userId
                                               and UIM_UserEmployeeMapping.Firm = @firm)) T
                  where UserId = @userId
                    and Month = @Month - 1
                    and Year = @Year)                                                    as LastMonth,
                 (select round(sum(FactAmount) * 100 / sum(PlanAmount), 2) as Overall
                  from PlanAmount p WITH (NOLOCK)
                           join FactAmount f on p.UserId = f.UserId and p.Firm = f.firm) as CompanyOverall)
             as pvt UNPIVOT ( Value for Criteria in (CurrentMonth,LastMonth,CompanyOverall) ) as Unpvt


END;