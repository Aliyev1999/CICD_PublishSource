
create or alter function [dbo].[FN_MGM_GetClientRiskLimit] ( @Firm     smallint,
                                                             @ClientId bigint
                                                           )
returns table as return


    with ClientDebt as (
        select
            TigerClientId,
            Firm,
            isnull(sum(Debit - Credit), 0) as TotalDebt
        from OP_ClientDebt
        group by TigerClientId, Firm
    )
    select
        FinanceData.AccumulatedRiskLimit                                   as AccumulatedRiskLimit,
        FinanceData.SelfCheckVoucherRiskLimit                              as SelfCheckVoucherRiskLimit,
        FinanceData.ClientCheckVoucherRiskLimit                            as ClientCheckRiskLimit,
        FinanceData.CheckVoucherCirculationRiskLimit                       as CheckVoucherRiskLimit,
        FinanceData.DispatchRiskLimit                                      as DispatchRiskLimit,
        FinanceData.DispatchProposalRiskLimit                              as DispatchProposalRiskLimit,
        FinanceData.AccumulatedRiskLimit - isnull(Debt.TotalDebt, 0)       as [Order],
        FinanceData.OrderProposalRiskLimit                                 as OrderProposal,
        FinanceData.ClosedRisk                                             as ClosedRisk,
        FinanceData.TotalRisk                                              as TotalRisk
    from MD_ClientFinanceData FinanceData with (nolock)
        left join ClientDebt Debt
            on  Debt.TigerClientId=FinanceData.TigerId and Debt.Firm=FinanceData.Firm
    where FinanceData.Firm=@Firm
      and FinanceData.TigerId=@ClientId
;