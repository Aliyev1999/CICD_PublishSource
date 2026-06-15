ALTER PROC [dbo].[SP_MD_GetClientRiskData] @userId INT, @firm SMALLINT = 0, @ClientId INT = 0
AS
BEGIN

    declare @isSalesPerson bit =0, @isAudit bit = 0, @ishybrid bit = 0

-- if salesperson
    select @isSalesPerson = count(*)
    from UIM_UserTypeUserMapping
    where UserId = @userId
      AND UserTypeId = (SELECT Id FROM UIM_UserType where Type = 'SalePerson')

-- if audit
    select @isAudit = count(*)
    from UIM_UserTypeUserMapping
    where UserId = @userId
      AND UserTypeId = (SELECT Id FROM UIM_UserType where Type = 'Audit' and ParentId = 1)

-- if hybrid
    select @ishybrid = count(*)
    from UIM_UserTypeUserMapping
    where UserId = @userId
      AND UserTypeId = (SELECT Id FROM UIM_UserType where Type = 'SalesPersonHead' and ParentId = 9)


    DECLARE @sql NVARCHAR(MAX);
    -- app istifadecisine bagli olan musterilerin risk melumatlari bu hissede hesablanir
    if (@isSalesPerson = 1)
        begin
            set @sql = '
select FinanceData.CLIENTREF as TigerId,
       @firm                 as Firm,
       0                     as AccumulatedRiskLimit,
       0                     as SelfCheckVoucherRiskLimit,
       0                     as ClientCheckVoucherRiskLimit,
       0                     as CheckVoucherCirculationRiskLimit,
       0                     as DispatchRiskLimit,
       0                     as DispatchProposalRiskLimit,
       FinanceData.RISKLIMIT as OrderRiskLimit,
       0                     as OrderProposalRiskLimit,
       FinanceData.RISKLIMIT as ClosedRisk,
       0                     as TotalRisk,
       GETDATE()             AS RegisteredDate
FROM LOGODB_2026..VW_TS_Spec_GetSalesmanClientRiskLimit_987 FinanceData
WHERE SALESMANREF = (SELECT TOP 1 EmployeeId
                     FROM TayqaSale.dbo.UIM_UserEmployeeMapping
                     WHERE UserId = @userId
                       AND Status = 0
                       AND Firm = @firm)
'
        end

    else
        if (@isAudit = 1)
            begin
                -- audit emekdaslarina bagli olan musterilerin risk melumatlari bu hissede hesablanir
                SET @sql = ' select
			TigerId,
			Firm,
			sum(AccumulatedRiskLimit) as AccumulatedRiskLimit,
			sum(SelfCheckVoucherRiskLimit) as SelfCheckVoucherRiskLimit,
			sum(ClientCheckVoucherRiskLimit) as ClientCheckVoucherRiskLimit,
			sum(CheckVoucherCirculationRiskLimit) as CheckVoucherCirculationRiskLimit,
			sum(DispatchRiskLimit) as DispatchRiskLimit,
			sum(DispatchProposalRiskLimit) as DispatchProposalRiskLimit,
			sum(OrderRiskLimit) as OrderRiskLimit,
			sum(OrderProposalRiskLimit) as OrderProposalRiskLimit,
			sum(ClosedRisk) as ClosedRisk,
			sum(TotalRisk) as TotalRisk,
			RegisteredDate
			from (
select distinct
                 pc.TigerClientId as TigerId,
                 @firm as  Firm,
                 0 as  AccumulatedRiskLimit,
                 0 as  SelfCheckVoucherRiskLimit,
                 0 as  ClientCheckVoucherRiskLimit,
                 0 as  CheckVoucherCirculationRiskLimit,
                 0 as  DispatchRiskLimit,
                 0 as  DispatchProposalRiskLimit,
                 wv.RISKLIMIT as  OrderRiskLimit,
                 0 as  OrderProposalRiskLimit,
                 wv.RISKLIMIT as  ClosedRisk,
                 0 as  TotalRisk,
                 GETDATE() AS RegisteredDate
                       from MD_PermittedClient pc with (nolock)
                         join LOGODB_2026.dbo.VW_TS_Spec_GetSalesmanClientRiskLimit_987 wv with (nolock) on pc.TigerClientId = wv.CLIENTREF
						 --join UIM_UserEmployeeMapping map on map.UserId = @UserId and map.EmployeeId = wv.SALESMANREF
					      where pc.Firm = @firm
						 union
						 select distinct
						    sc.ClientId as TigerId,
                 @firm as  Firm,
                 0 as  AccumulatedRiskLimit,
                 0 as  SelfCheckVoucherRiskLimit,
                 0 as  ClientCheckVoucherRiskLimit,
                 0 as  CheckVoucherCirculationRiskLimit,
                 0 as  DispatchRiskLimit,
                 0 as  DispatchProposalRiskLimit,
                 vw.RISKLIMIT as  OrderRiskLimit,
                 0 as  OrderProposalRiskLimit,
                 vw.RISKLIMIT as  ClosedRisk,
                 0 as  TotalRisk,
                 GETDATE() AS RegisteredDate
						 from MD_SalesmanClientMapping sc with (nolock)
			            join UIM_UserEmployeeMapping ue with (nolock) on sc.SalesmanId = ue.EmployeeId and sc.Firm = ue.Firm 
			            join LOGODB_2026.dbo.VW_TS_Spec_GetSalesmanClientRiskLimit_987 vw with (nolock) on sc.ClientId = vw.CLIENTREF and ue.EmployeeId = vw.SALESMANREF
			          where ue.UserId = @userId and sc.Firm = @firm) t
					  group by TigerId,Firm,RegisteredDate'
            end
        else
            if (@ishybrid = 1)
                begin
                    -- Hibrid istifadecilere bagli olan musterilerin risk limiti bu hissede hesablanir. Burada ilk once musterinin birlesmis cari olub olmadigi yoxlanir.
--Birlesmis caridirse: hemin musterilerin baglantisi olan temsilcilerden hansina yetkisi varsa, onlarin toplam risk limitini gosteririk.
--Birlesmemis caridirse: musterinin umumi risk limitini gosteririk.
                    SET @sql = 'declare @IsCombinedClient bit = 0
           select @IsCombinedClient = LOGODB_2026.dbo.FN_TS_SpecSaleFunctionality_IsCombinedClient_987(@ClientId)

             if (@IsCombinedClient = 1)
    begin
			    select 
	   TigerId,
	   Firm,
	   sum(AccumulatedRiskLimit) as AccumulatedRiskLimit,
	   sum(SelfCheckVoucherRiskLimit) as SelfCheckVoucherRiskLimit,
	   sum(ClientCheckVoucherRiskLimit) as ClientCheckVoucherRiskLimit,
	   sum(CheckVoucherCirculationRiskLimit) as CheckVoucherCirculationRiskLimit,
	   sum(DispatchRiskLimit) as DispatchRiskLimit,
	   sum(DispatchProposalRiskLimit) as DispatchProposalRiskLimit,
	   sum(OrderRiskLimit) as OrderRiskLimit,
	   sum(OrderProposalRiskLimit) as OrderProposalRiskLimit,
	   sum(ClosedRisk) as ClosedRisk,
	   sum(TotalRisk) as TotalRisk,
	   RegisteredDate
	   from
	   (select vw.CLIENTREF as TigerId,
               @firm          as Firm,
               0            as AccumulatedRiskLimit,
               0            as SelfCheckVoucherRiskLimit,
               0            as ClientCheckVoucherRiskLimit,
               0            as CheckVoucherCirculationRiskLimit,
               0            as DispatchRiskLimit,
               0            as DispatchProposalRiskLimit,
               vw.RISKLIMIT as OrderRiskLimit,
               0            as OrderProposalRiskLimit,
               vw.RISKLIMIT as ClosedRisk,
               0            as TotalRisk,
               GETDATE()    AS RegisteredDate
        from MD_SalesmanClientMapping sc with (nolock)
                 join UIM_UserEmployeeMapping ue with (nolock) on sc.SalesmanId = ue.EmployeeId and sc.Firm = ue.Firm and ue.UserId = @UserId
                 join LOGODB_2026.dbo.VW_TS_Spec_GetSalesmanClientRiskLimit_987 vw with (nolock) on sc.ClientId = vw.CLIENTREF and ue.EmployeeId = vw.SALESMANREF
        where 
          sc.Firm = @firm
		  ) b
		  group by TigerId,Firm,RegisteredDate
    end
else
    begin
		    select 
	   TigerId,
	   Firm,
	   sum(AccumulatedRiskLimit) as AccumulatedRiskLimit,
	   sum(SelfCheckVoucherRiskLimit) as SelfCheckVoucherRiskLimit,
	   sum(ClientCheckVoucherRiskLimit) as ClientCheckVoucherRiskLimit,
	   sum(CheckVoucherCirculationRiskLimit) as CheckVoucherCirculationRiskLimit,
	   sum(DispatchRiskLimit) as DispatchRiskLimit,
	   sum(DispatchProposalRiskLimit) as DispatchProposalRiskLimit,
	   sum(OrderRiskLimit) as OrderRiskLimit,
	   sum(OrderProposalRiskLimit) as OrderProposalRiskLimit,
	   sum(ClosedRisk) as ClosedRisk,
	   sum(TotalRisk) as TotalRisk,
	   RegisteredDate
	   from(
        select vw.CLIENTREF       as TigerId,
               @firm                  as Firm,
               0                    as AccumulatedRiskLimit,
               0                    as SelfCheckVoucherRiskLimit,
               0                    as ClientCheckVoucherRiskLimit,
               0                    as CheckVoucherCirculationRiskLimit,
               0                    as DispatchRiskLimit,
               0                    as DispatchProposalRiskLimit,
               vw.RISKLIMIT as OrderRiskLimit,
               0                    as OrderProposalRiskLimit,
               vw.RISKLIMIT  as ClosedRisk,
               0                    as TotalRisk,
               GETDATE()            AS RegisteredDate
              from LOGODB_2026.dbo.VW_TS_Spec_GetSalesmanClientRiskLimit_987 vw with (nolock)
			  join MD_SalesmanClientMapping map with (nolock) on map.ClientId = vw.CLIENTREF and map.SalesmanId = vw.SALESMANREF
			  join UIM_UserEmployeeMapping emp with (nolock) on emp.EmployeeId = vw.SALESMANREF and emp.UserId = @userId
              INNER JOIN (SELECT Firm, ClientId, max(RegisteredDate) AS RegisteredDate
                                 FROM (
                                          SELECT Firm, ClientId, RegisteredDate
                                          FROM F_GetPermittedClientForUserWithRegisteredDate(@userId)
                                          UNION
                                          SELECT Firm, ClientId, RegisteredDate
                                          FROM F_GetAllPermittedClientWithRegisteredDate() pc
                                                   JOIN F_Hybrid_GetPermittedUsers(@userId) pu ON pc.UserId = pu.UserId
                                              AND (SELECT Type FROM F_GetUserRootType(@userId)) = ''Hybrid'')
                                          AS GroupT
                                 GROUP BY Firm, ClientId) 
                                 Client ON (Client.Firm = @firm AND Client.ClientId = vw.CLIENTREF)
          ) a
		   group by TigerId,Firm,RegisteredDate
                             

    end'
                end
            else
                Select TOP 0 0         as TigerId,
                             @firm     as Firm,
                             0         as AccumulatedRiskLimit,
                             0         as SelfCheckVoucherRiskLimit,
                             0         as ClientCheckVoucherRiskLimit,
                             0         as CheckVoucherCirculationRiskLimit,
                             0         as DispatchRiskLimit,
                             0         as DispatchProposalRiskLimit,
                             0         as OrderRiskLimit,
                             0         as OrderProposalRiskLimit,
                             0         as ClosedRisk,
                             0         as TotalRisk,
                             GETDATE() AS RegisteredDate


    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT, @ClientId INT', @userId = @userId, @firm = @firm,
         @ClientId = @ClientId

end