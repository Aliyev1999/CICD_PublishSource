ALTER FUNCTION [dbo].[F_GetSaleDistributionUser](
    @year smallint,
    @month tinyint,
    @userId int,
    @clientGroupType smallint,
    @itemGroupType smallint
    ) RETURNS TABLE AS RETURN
              (
                  -- Date: 18.04.2022
                  -- Author: Xaliq Heyderov
                  -- Ticket: TayqaSale Scrum TSC-3899
                  -- Description: the query return the distribution plans and results for a hybrid user/month/year basis.
                  select Users.Id                                         as UserId,
                         Users.UserName                                   as UserName,
                         concat(Users.Name, ' ', Users.Surname)           as UserFullName,
                         --TargetClientPercent as Target,
                         --cast(ISNULL(FactClientPercent, 0) as float) as Result
                         avg(TargetClientPercent)                         as Target,
                         avg(cast(isnull(FactClientPercent, 0) as float)) as Result
                  from (select Target.UserId,
                               Target.ItemGroupId,
                               TargetClientPercent,
                               Month,
                               Year,
                               FactClientCount * 100 /cast((TargetClientPercent * CGCC.ClientCount / 100) as int) as FactClientPercent
                        from MD_DistributionItemGroupPlan Target
                                 left join (select Employees.UserId                            as UserId,
                                                   ClientGroups.GroupId                        as ClientGroupId,
                                                   Mapping.GroupId                             as ItemGroupId,
                                                   isnulL(count(distinct Invoice.ClientId), 0) as FactClientCount
                                            from ERP_Invoice Invoice with (nolock)
                                                     join ERP_InvoiceLine Lines with (nolock) on Invoice.ERPId = Lines.InvoiceId
                                                     join MD_ItemGroupItemMapping Mapping with (nolock)
                                                          on Mapping.ItemId = Lines.ItemId
                                                              and Mapping.Firm = Invoice.Firm
                                                              and Mapping.GroupType = @itemGroupType
                                                     join UIM_UserEmployeeMapping Employees with (nolock)
                                                          on Employees.Firm = Invoice.Firm
                                                              and Employees.EmployeeId = Invoice.SalesmanId
                                                     join MD_ClientGroupData ClientGroups with (nolock)
                                                          on ClientGroups.Firm = Employees.Firm
                                                              and ClientGroups.GroupType = @clientGroupType
                                                              and ClientGroups.ClientId = Invoice.ClientId
                                            where Lines.LineType <> 1 -- All lines , excluding promo types
                                              and Invoice.IsDeleted = 0
                                              and Invoice.IsCancelled = 0
                                              and month(Invoice.Date) = @month
                                              and year(Invoice.Date) = @year
                                              and Invoice.Type = 4    -- Only sale invoices covered
                                            group by Employees.UserId,
                                                     ClientGroups.GroupId,
                                                     Mapping.GroupId) Facts on Target.ItemGroupId = Facts.ItemGroupId
                            and Target.ClientGroupId = Facts.ClientGroupId
                            and Target.UserId = Facts.UserId
                            and Target.Month = @month
                            and Target.Year = @year
                                 inner join (select  f.ClientCount, f.GroupId from F_GetDistributionPermittedClientCount() f
											join MD_ClientGroupData t on f.GroupId=t.GroupId and f.Firm= t.Firm
                                             where GroupType = @clientGroupType group by ClientCount,f.GroupId) CGCC on CGCC.GroupId = Target.ClientGroupId) Output

										--	 inner join (select * from F_GetDistributionPermittedClientCount()) CGCC on CGCC.UserId = @userId and GroupId= Target.ClientGroupId
                           join AbpUsers Users with (nolock) on Users.Id = Output.UserId
                      and Users.IsDeleted = 0
                           join F_UIM_GetOrganizationTreeUsers(@userId) TreeUsers on TreeUsers.UserId = Users.Id
                      where Output.Month=@month and Output.Year=@year
                  group by Users.Id,
                           Users.UserName,
                           concat(Users.Name, ' ', Users.Surname)
              )
go