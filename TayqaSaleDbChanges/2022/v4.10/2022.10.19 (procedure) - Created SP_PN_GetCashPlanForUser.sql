CREATE   procedure [dbo].[SP_PN_GetCashPlanForUser] @currentUserId int,
                                                           @firm smallint =null,
                                                           @year smallint,
                                                           @month tinyint,
                                                           @isTargetQuantity bit,
                                                           @considerHierarchyOfHybridUser bit
as

select Users.Id                as UserId,
       Plans.Firm              as Firm,
       Plans.Amount            as PlanAmount,
       isnull(Facts.Amount, 0) as FactAmount,
       Currency.Code           as CurrencyCode,
       Currency.Type           as CurrencyType,
       Users.UserName          as UserName

from MD_CashPlanForUser Plans with (nolock)
         join AbpUsers Users with (nolock) on Users.Id = Plans.UserId and Users.IsDeleted = 0
         join MD_Currency Currency with (nolock) on Currency.Type = Plans.CurrencyType and Currency.Firm = Plans.Firm
         left join F_Hybrid_GetPermittedUsers(@currentUserId) TreeUsers on TreeUsers.UserId = Users.Id
         left join (select UserId, sum(Amount) as Amount
                    from ERP_FinanceOperation Ops with (nolock)
                             join UIM_UserEmployeeMapping Mapping with (nolock)
                                  on Mapping.EmployeeId = Ops.SalesmanId and Mapping.Firm = Ops.Firm and Mapping.Status = 0
                    where IsCancelled = 0
                      and Sign = 1
                      and (@firm is null or Ops.Firm = @firm)
                      and datepart(month, Date) = @month
                      and datepart(year, Date) = @year
                    group by UserId, Ops.Firm) Facts on Facts.UserId = Plans.UserId

where Plans.Month = @month
  and Plans.Year = @year
  and (@firm is null or Plans.Firm = @firm)
  and ((@considerHierarchyOfHybridUser = 1 and TreeUsers.UserId <> @currentUserId) or
       (@considerHierarchyOfHybridUser = 0 and Plans.UserId = @currentUserId))
GO


