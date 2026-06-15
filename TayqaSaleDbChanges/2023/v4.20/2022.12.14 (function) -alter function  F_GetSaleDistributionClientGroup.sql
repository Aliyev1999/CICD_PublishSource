
ALTER FUNCTION [dbo].[F_GetSaleDistributionClientGroup](@year smallint, @month tinyint, @clientGroupType int,@itemGroupType int, @itemGroupId int, @userId int)
    RETURNS TABLE
        AS
        RETURN
            (
                -- Date: 18.04.2022
                -- Author: Xaliq Heyderov
                -- Ticket: TayqaSale Scrum TSC-3887
                -- Description: the query return the distribution plans and results based on a user, month, year and item group combined .

                select Groups.GroupId                  as ClientGroupId,
                       Groups.GroupName                as ClientGroupName,
                       Groups.GroupCode                as ClientGroupCode,
                       sum(TargetClientPercent)          as Target,
                       sum(cast(isnull(FactClientPercent, 0) as float)) as Result

                from (select Target.ClientGroupId,
				      TargetClientPercent,
					  FactClientCount*100/cast((TargetClientPercent*CGCC.ClientCount/100) as int) as FactClientPercent
                      from MD_DistributionItemGroupPlan Target


                               left join (select ClientGroups.GroupId             as ClientGroupId,
                                                 count(distinct Invoice.ClientId) as FactClientCount
                                          from ERP_Invoice Invoice with (nolock)

                                                   join ERP_InvoiceLine Lines with (nolock) on Invoice.ERPId = Lines.InvoiceId

                                                   join MD_ItemGroupItemMapping Mapping with (nolock)
                                                        on Mapping.ItemId = Lines.ItemId and Mapping.Firm = Invoice.Firm and
                                                           Mapping.GroupType = @itemGroupType

                                                   join UIM_UserEmployeeMapping Employees with (nolock)
                                                        on Employees.Firm = Invoice.Firm and Employees.EmployeeId = Invoice.SalesmanId and
                                                           Employees.Status = 0

                                                   join MD_ClientGroupData ClientGroups with (nolock)
                                                        on ClientGroups.Firm = Employees.Firm and ClientGroups.GroupType = @clientGroupType and
                                                           ClientGroups.ClientId = Invoice.ClientId

                                          where Lines.LineType <> 1 -- All lines , excluding promo types
                                            and Invoice.IsDeleted = 0
                                            and Invoice.IsCancelled = 0
                                            and month(Invoice.Date) = @month
                                            and year(Invoice.Date) = @year
                                            and Invoice.Type = 4    -- Only sale invoices covered
                                            and UserId = @userId
                                            and Mapping.GroupId = @ItemGroupId

                                          group by ClientGroups.GroupId)
										  Facts on Target.ClientGroupId = Facts.ClientGroupId
									inner join (select GroupId, Count(ClientId) As ClientCount from MD_ClientGroupData group by GroupId) CGCC on CGCC.GroupId = Target.ClientGroupId

                      where UserId = @userId
                        and Month = @month
                        and Year = @year
                        and Target.ItemGroupId = @ItemGroupId) Output

                         join MD_ClientGroupInfo Groups with (nolock)
                              on Groups.GroupId = Output.ClientGroupId and Groups.GroupType = @clientGroupType

                group by Groups.GroupId, Groups.GroupCode, Groups.GroupName
            )
go