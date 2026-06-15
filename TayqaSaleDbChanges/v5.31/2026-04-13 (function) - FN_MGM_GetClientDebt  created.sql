
create or alter function [dbo].[FN_MGM_GetClientDebt] ( @Firm     smallint,
                                                        @ClientId bigint )
returns table as return
(
    with Debt as (
        select
            ClientDebt.Firm,
            ClientDebt.TigerClientId,
            ClientDebt.CurrencyType,
            PaymentPlan.Name                                                                           as PaymentPlanName,
            PaymentPlan.Code                                                                           as PaymentPlanCode,
            sum(ClientDebt.Debit)                                                                      as Debt,
            sum(ClientDebt.Credit)                                                                     as Credit,
            sum(ClientDebt.Debit - ClientDebt.Credit)                                                  as TotalDebt,
            sum(case when ClientDebt.OrderNo = 2 then ClientDebt.Debit - ClientDebt.Credit else 0 end) as UnpaidDebt
        from MD_Client Client with (nolock)
            left join OP_ClientDebt ClientDebt with (nolock) 
                on  ClientDebt.TigerClientId = Client.TigerId 
                and ClientDebt.Firm          = Client.Firm
            left join MD_PaymentPlan PaymentPlan with (nolock) 
                on  PaymentPlan.Firm    = Client.Firm 
                and PaymentPlan.TigerId = Client.PaymentPlanId
        where ClientDebt.Firm          = @Firm
          and ClientDebt.TigerClientId = @ClientId
        group by
            ClientDebt.Firm,
            ClientDebt.TigerClientId,
            ClientDebt.CurrencyType,
            PaymentPlan.Name,
            PaymentPlan.Code
    )
    select
        Currency.Code                                                                    as CurrencyCode,
        cast(DebtData.TotalDebt as nvarchar(50)) + ',  ' +
        cast(case 
                 when DebtData.UnpaidDebt > 0 then DebtData.UnpaidDebt 
                 else 0 
             end as nvarchar(50))                                                        as RemainingDebt,
        DebtData.Debt                                                                    as Debt,
        DebtData.Credit                                                                  as Credit,
        DebtData.PaymentPlanName                                                         as PaymentPlanName,
        DebtData.PaymentPlanCode                                                         as PaymentPlanCode
    from Debt DebtData
        left join MD_Currency Currency with (nolock) 
            on  Currency.Type = DebtData.CurrencyType 
            and Currency.Firm = DebtData.Firm
)