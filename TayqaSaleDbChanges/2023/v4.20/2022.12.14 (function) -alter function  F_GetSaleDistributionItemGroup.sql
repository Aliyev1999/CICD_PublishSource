ALTER FUNCTION [dbo].[F_GetSaleDistributionItemGroup](@year smallint, @month tinyint, @clientGroupType int, @itemGroupType int, @userId int)
    RETURNS TABLE
        AS
        RETURN
            (
                -- Date: 18.04.2022
                -- Author: Xaliq Heyderov
                -- Ticket: TayqaSale Scrum TSC-3887
                -- Description: the query return the distribution plans and results for a user/month/year basis.

                select Groups.SpecialCode              as SpecialCode,
                       Groups.SpecialCode2             as SpecialCode2,
                       Groups.SpecialCode3             as SpecialCode3,
                       Groups.Id                       as ItemGroupId,
                       Groups.Name                     as ItemGroupName,
                       Groups.Code                     as ItemGroupCode,
                       avg(TargetClientPercent)          as Target,
                       avg(cast(isnull(FactClientPercent, 0) as float)) as Result
                from (
				select Target.ItemGroupId, 
				    TargetClientPercent,
					FactClientCount*100/cast((TargetClientPercent*CGCC.ClientCount/100) as int) as FactClientPercent
                      from MD_DistributionItemGroupPlan Target


                               left join (select ClientGroups.GroupId             as ClientGroupId,
                                                 Mapping.GroupId                  as ItemGroupId,
                                                 count(distinct Invoice.ClientId) as FactClientCount
                                          from ERP_Invoice Invoice with (nolock)
                                                   join ERP_InvoiceLine Lines with (nolock) on Invoice.ERPId = Lines.InvoiceId

                                                   join MD_ItemGroupItemMapping Mapping with (nolock)
                                                        on Mapping.ItemId = Lines.ItemId and Mapping.Firm = Invoice.Firm and
                                                           Mapping.GroupType = @itemGroupType

                                                   join UIM_UserEmployeeMapping Employees with (nolock)
                                                        on Employees.Firm = Invoice.Firm and Employees.EmployeeId = Invoice.SalesmanId 

                                                   join MD_ClientGroupData ClientGroups with (nolock)
                                                        on ClientGroups.Firm = Employees.Firm and ClientGroups.GroupType = @clientGroupType and
                                                           ClientGroups.ClientId = Invoice.ClientId

                                          where Lines.LineType <> 1 -- All lines , excluding promo types
                                            and Invoice.IsDeleted = 0
                                            and Invoice.IsCancelled = 0
                                            and month(Invoice.Date) = @month
                                            and year(Invoice.Date) = @year
                                            and Invoice.Type = 4 -- Only sale invoices covered
                                            and UserId = @userId

                                          group by ClientGroups.GroupId, Mapping.GroupId) Facts
                                         on Target.ItemGroupId = Facts.ItemGroupId and Target.ClientGroupId = Facts.ClientGroupId
										inner join (select * from F_GetDistributionPermittedClientCount()) CGCC on CGCC.UserId = @userId and GroupId= Target.ClientGroupId


                      where Target.UserId = @userId
                        and Target.Month = @month
                        and Target.Year = @year
						) Output

                         join MD_ItemGroup Groups with (nolock) on Groups.Id = Output.ItemGroupId and Groups.Type = @itemGroupType
                
                group by Groups.SpecialCode, Groups.SpecialCode2, Groups.SpecialCode3, Groups.Id, Groups.Name, Groups.Code
            )
go