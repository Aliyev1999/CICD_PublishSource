CREATE OR ALTER function [dbo].[FN_GetClientChildDebtData]
    (
        @clientId int,
        @firmId smallint,
        @userId int
        )
    returns table
        as
        return
            (
                
                with ParentClient as (select case
                                                 when exists(
                                                         select 1
                                                         from MD_Client child with (nolock)
                                                         where child.TigerParentId = client.TigerId
                                                           and child.IsDeleted = 0
                                                     )
                                                     then client.TigerId -- Əgər child varsa → bu client özü parent sayılır
                                                 else coalesce(nullif(client.TigerParentId, 0), client.TigerId)
                                                 end as ResolvedId --child yoxdursa:
																   --      - Parent varsa → parent götür
																   --      - Parent yoxdursa (0 və ya null) → özünü götür
                                      from MD_Client client with (nolock)
                                      where client.TigerId = @clientId
                                        and client.IsDeleted = 0)
                        ,

                     --  ClientDebtData: həm parent-in subclient-ları, həm də daxil olan client
                     ClientDebtData as (select client.TigerId                   as ClientId,
                                               client.Code                      as ClientCode,
                                               client.Name                      as ClientName,
                                               isnull(debt.ClientTotalDebt, 0)  as CurrentDebt,
                                               isnull(debt.ClientUnPaidDebt, 0) as MinDebt
                                        from MD_Client client with (nolock)
                                                 cross join ParentClient parentClient
                                                 left join TestTigerEnt_db..FN_TS_Report_GetSalesmanUnPaidBillDebt_009(getdate()) debt
                                                           on debt.ClientId = client.TigerId
                                        where client.TigerParentId = parentClient.ResolvedId
                                          and (select top 1 CardType
                                               from MD_Client
                                               where TigerId = parentClient.ResolvedId) = 4
                                          and client.Firm = @firmId

                                        union

                                        -- b) Əlavə olaraq daxil olan client (həmişə daxil edilir)
                                        select client.TigerId                   as ClientId,
                                               client.Code                      as ClientCode,
                                               client.Name                      as ClientName,
                                               isnull(debt.ClientTotalDebt, 0)  as CurrentDebt,
                                               isnull(debt.ClientUnPaidDebt, 0) as MinDebt
                                        from MD_Client client with (nolock)
                                                 cross join ParentClient parentClient
                                                 left join TestTigerEnt_db..FN_TS_Report_GetSalesmanUnPaidBillDebt_009(getdate()) debt
                                                           on debt.ClientId = client.TigerId
                                        where client.TigerId = @clientId
                                          and client.Firm = @firmId)

                     --  Final result
                select debt.ClientId,
                       debt.ClientName,
                       debt.ClientCode,
                       debt.CurrentDebt,
                       debt.MinDebt
                from ClientDebtData debt
                         join F_GetPermittedClientForUser(@userId) permittedClient
                              on permittedClient.ClientId = debt.ClientId
            );
