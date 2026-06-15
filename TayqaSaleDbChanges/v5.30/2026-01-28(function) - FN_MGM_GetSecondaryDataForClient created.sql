CREATE OR ALTER function [dbo].[FN_MGM_GetSecondaryDataForClient](@UserId bigint, @Firm smallint, @Id int)
    returns table as
        return
        select Telephone                                                       as PhoneNumber,
               Telephone                                                       as WhatsappNumber,
               Latitude                                                        as Latitude,
               Longitude                                                       as Longitude,
               AccumulatedRiskLimit                                            as Limit,
               round(iif(OrderNo = 1, DebtData.Debit - DebtData.Credit, 0), 2) as Debt,
               round(iif(OrderNo = 2, DebtData.Debit - DebtData.Credit, 0), 2) as Overdue,
               cast(case
                        when AccumulatedRiskLimit = 0 then 0
                        else iif(OrderNo = 1, DebtData.Debit - DebtData.Credit, 0) / AccumulatedRiskLimit * 100
                   end as int)                                                 as LimitUsagePercent,
               cast(case
                        when iif(OrderNo = 1, DebtData.Debit - DebtData.Credit, 0) = 0 then 0
                        else iif(OrderNo = 2, DebtData.Debit - DebtData.Credit, 0) /
                             iif(OrderNo = 1, DebtData.Debit - DebtData.Credit, 0) * 100
                   end as int)                                                 as OverduePercent,
               isnull(currency.Code, 'AZN')                                    AS Currency
        from MD_Client Client with (nolock)
                 join F_GetPermittedClientForUserWithRegisteredDate(@UserId) Permitted
                      on Permitted.ClientId = Client.TigerId
                 join MD_Firm firm on firm.Id = client.Firm
                 left join MD_ClientFinanceData FinanceData with (nolock)
                           on FinanceData.TigerId = Client.TigerId and FinanceData.Firm = Client.Firm
                 left join OP_ClientDebt DebtData with (nolock)
                           on DebtData.TigerClientId = Client.TigerId and DebtData.Firm = Client.Firm
                 left join MD_Currency currency with (nolock) on firm.Id = currency.Firm and firm.LocalCurrencyTypeId = currency.Type and currency.IsDeleted = 0
        where Client.Firm = @Firm
          and Client.TigerId = @Id
          and Client.IsDeleted = 0
