CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetClientDebtDashboardData](@currentUserId bigint)
    returns @Result table
                    (
                        Currency           nvarchar(10),
                        TotalDebtAmount    decimal(18, 2),
                        TotalClientCount   int,
                        OverdueDebtAmount  decimal(18, 2),
                        OverdueClientCount int
                    )
    as
    begin
        declare @Date date = cast(getdate() as date)
        declare @CurrencyCode nvarchar(10) = 'AZN';

        with PermittedClients as (select Distinct ClientList.ClientId
                                  from dbo.F_GetAllPermittedClient() ClientList
                                           join F_GetPermittedUsers(@currentUserId) Tree on Tree.UserId = ClientList.UserId)

        insert
        into @Result (Currency, TotalDebtAmount, TotalClientCount, OverdueDebtAmount, OverdueClientCount)
        select @CurrencyCode                                   as Currencu,
               round(sum(ClientTotalDebt), 2)                  as TotalDebtAmount,
               round(sum(iif(ClientTotalDebt <> 0, 1, 0)), 2)  as TotalClientCount,
               round(sum(ClientUnPaidDebt), 2)                 as TotalDebtAmount,
               round(sum(iif(ClientUnPaidDebt <> 0, 1, 0)), 2) as TotalClientCount
        from TestTigerEnt_db..FN_TS_Report_GetSalesmanUnPaidBillDebt_009(@Date) Debt
                 join PermittedClients on PermittedClients.ClientId = Debt.ClientId
        return
    end