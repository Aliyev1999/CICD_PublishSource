CREATE OR ALTER FUNCTION [dbo].[FN_MGM_GetClientSalesmanMapping](@userId bigint, @firm smallint)
    RETURNS TABLE
        AS
        return
        select Salesman.Name  as Name,
               Salesman.Code  as Code,
               SalesmanClientMapping.ClientId as ClientId
        from MD_Salesman Salesman
                 join MD_SalesmanClientMapping SalesmanClientMapping WITH (NOLOCK)
                      on SalesmanClientMapping.SalesmanId = Salesman.TigerId
                 join F_GetPermittedClientForUser(@userId) PermittedClientForUser
                      on (PermittedClientForUser.Firm = SalesmanClientMapping.Firm and
                          PermittedClientForUser.ClientId = SalesmanClientMapping.ClientId)
        where SalesmanClientMapping.Firm = @firm


