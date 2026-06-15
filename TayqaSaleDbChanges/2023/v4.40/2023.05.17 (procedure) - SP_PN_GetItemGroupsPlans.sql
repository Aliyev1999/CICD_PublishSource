ALTER procedure [dbo].[SP_PN_GetItemGroupsPlans] @currentUserId int,
                                                 @firm smallint,
                                                 @year smallint,
                                                 @month tinyint,
                                                 @isTargetQuantity bit,
                                                 @considerHierarchyOfHybridUser bit
as
begin
    SET NOCOUNT ON;
       with Plans as (select Plans.UserId                                 as UserId,
                         Plans.ItemGroupId                            as GroupId,
                         iif(@isTargetQuantity = 0, Amount, Quantity) as PlanAmount,
						 Extension.LineNr
                   from MD_ItemGroupPlanForUser Plans with (nolock)
				   join MD_ItemGroupPlanExtension Extension with(nolock) on Plans.ItemGroupId=Extension.ItemGroupId
                   where Plans.Month = @month
                     and Plans.Year = @year
                     and Plans.Firm = @firm),
         Facts as (select UserMapping.UserId  as UserId,
                          ItemMapping.GroupId as ItemGroupId,
                          (IIF(@isTargetQuantity = 0, round(sum(iif(Invoice.[Type] = 4, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)) -
                                                       sum(iif(Invoice.[Type] = 2, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)),2),
                          round(sum(iif(Invoice.[Type] = 4, Line.Quantity* (Units.Convfact2/Units.Convfact1) / MainUnit.Convfact2, 0)) -
                                sum(iif(Invoice.[Type] = 2, Line.Quantity* (Units.Convfact2/Units.Convfact1) /MainUnit.Convfact2, 0)), 2))) AS FactAmount
                   from ERP_Invoice Invoice with (nolock)
                            join ERP_InvoiceLine Line with (nolock) on Line.InvoiceId = Invoice.ERPId
                            join MD_ItemGroupItemMapping ItemMapping with (nolock)
                                 on ItemMapping.ItemId = Line.ItemId and ItemMapping.Firm = Invoice.Firm and ItemMapping.GroupType = 1
                            join UIM_UserEmployeeMapping UserMapping with (nolock)
                                 on UserMapping.EmployeeId = Invoice.SalesmanId and UserMapping.Firm = Invoice.Firm
                            join MD_ItemUnit Units with (nolock)
                                 on Units.Code = Line.ItemUnitCode and Units.TigerItemId = Line.ItemId and Units.Firm = Invoice.Firm and
                                    Units.IsDeleted = 0
							join MD_ItemGroupPlanExtension Extension on Extension.ItemGroupId = ItemMapping.GroupId 
							join MD_ItemUnit MainUnit with (nolock) on MainUnit.TigerItemId = Units.TigerItemId and MainUnit.Firm = Units.Firm 
									and MainUnit.LineNr = Extension.LineNr
                   where Invoice.IsDeleted = 0
                     and IsCancelled = 0
                     and Line.LineType <> 1
                     and month(Invoice.Date) = @month
                     and year(Invoice.Date) = @year
                   group by ItemMapping.GroupId, UserMapping.UserId),
         Result as (select Plans.UserId               as UserId,
                           sum(PlanAmount)            as Target,
                           isnull(sum(FactAmount), 0) as Result,
                           Plans.GroupId              as GroupId
                    from Plans with (nolock)
                             left join Facts with (nolock) on Plans.UserId = Facts.UserId and Plans.GroupId = Facts.ItemGroupId 
                    group by Plans.UserId, Plans.GroupId)
    select Result.UserId,
           Target,
           Result,
           Groups.Code                      as GroupCode,
           GroupId,
           Groups.Name                      as GroupName,
           @month                           as Month,
           Users.Name + ' ' + Users.Surname as UserFullName,
           Groups.SpecialCode,
           Groups.SpecialCode2,
           Groups.SpecialCode3
    from Result
             join MD_ItemGroup Groups with (nolock) on Groups.Id = Result.GroupId and Groups.Type = 1
             left join F_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.UserId = Result.UserId
             left join AbpUsers Users with (nolock)
                       on (Users.Id = PermittedUsers.UserId and @considerHierarchyOfHybridUser = 1) or
                          (Users.Id = @currentUserId and @considerHierarchyOfHybridUser = 0)
    where ((@considerHierarchyOfHybridUser = 1 and PermittedUsers.UserId <> @currentUserId) or
           (@considerHierarchyOfHybridUser = 0 and Result.UserId = @currentUserId))


end
