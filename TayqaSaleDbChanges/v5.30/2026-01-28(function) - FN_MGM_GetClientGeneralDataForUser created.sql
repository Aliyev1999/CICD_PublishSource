
CREATE OR ALTER function [dbo].[FN_MGM_GetClientGeneralDataForUser](
    @UserId bigint, @Firm smallint)
    returns table as
        return
        with PermittedUsers as (
            -- 1. User - Client
            select Firm,
                   UserId,
                   TigerClientId as ClientId
            from MD_PermittedClient with (nolock)

            union

            -- 2. User - Salesman - Client
            select usermapping.Firm,
                   usermapping.UserId,
                   mapping.ClientId
            from MD_SalesmanClientMapping mapping with (nolock)
                     join UIM_UserEmployeeMapping usermapping with (nolock)
                          on usermapping.EmployeeId = mapping.SalesmanId
                              and usermapping.Firm = mapping.Firm
            where usermapping.Status = 0

            union

            -- 3. UserGroup - Client
            select permittedclient.Firm,
                   mapping.UserId,
                   permittedclient.TigerClientId as ClientId
            from MD_UserGroupPermittedClient permittedclient with (nolock)
                     join MD_UserGroupMapping mapping with (nolock)
                          on mapping.GroupId = permittedclient.UserGroupId
                              and mapping.Firm = permittedclient.Firm
            where mapping.IsActive = 1

            union

            -- 4. UserGroup - Salesman - Client
            select usermapping.Firm,
                   usermapping.UserId,
                   mapping.ClientId
            from MD_SalesmanClientMapping mapping with (nolock)
                     join UIM_UserGroupEmployeeMapping employeemapping with (nolock)
                          on employeemapping.EmployeeId = mapping.SalesmanId
                              and employeemapping.Firm = mapping.Firm
                     join MD_UserGroupMapping usermapping with (nolock)
                          on usermapping.GroupId = employeemapping.UserGroupId
                              and usermapping.Firm = employeemapping.Firm
            where usermapping.IsActive = 1
              and employeemapping.Status = 0),
             PermittedUsersAgg as (select Firm,
                                          ClientId,
                                          string_agg(cast(UserId as varchar(20)), ',') as PermittedUserIds
                                   from PermittedUsers
                                   group by Firm, ClientId),

             ClientDebt as (select TigerClientId,
                                   Firm,
                                   CurrencyType,
                                   sum(iif(OrderNo = 1, Debit - Credit, 0)) as Debt,
                                   sum(iif(OrderNo = 2, Debit - Credit, 0)) as DelayedDebt
                            from OP_ClientDebt with (nolock)
                            where Firm = @Firm
                            group by TigerClientId, Firm, CurrencyType)

        select Client.TigerId                           as Id,
               Client.Name                              as Name,
               Client.Code                              as Code,
               Client.Edino                             as Edino,
               round(isnull(ClientDebt.Debt, 0), 2)     as Debt,
               round(isnull(ClientDebt.DelayedDebt, 0), 2) as DelayedDebt,
               Isnull(Currency.Code, 'AZN'   )          as Currency,
               Client.Latitude                          as Latitude,
               Client.Longitude                         as Longitude,
               permitteduser.PermittedUserIds           as PermittedUserIds
        from MD_Client Client with (nolock)
                 join F_GetPermittedClientForUserWithRegisteredDate(@UserId) pclient on pclient.ClientId = Client.TigerId and pclient.Firm = Client.Firm
                 left join PermittedUsersAgg permitteduser on permitteduser.ClientId = Client.TigerId and permitteduser.Firm = Client.Firm
                 left join ClientDebt on ClientDebt.TigerClientId = Client.TigerId and ClientDebt.Firm = Client.Firm
                 left join Md_Currency Currency with (nolock) on ClientDebt.CurrencyType = Currency.Type and ClientDebt.Firm = Currency.Firm
        where Client.Firm = @Firm