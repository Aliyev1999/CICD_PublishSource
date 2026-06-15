create   procedure [dbo].[SP_PN_GetItemGroupsPlans] @currentUserId int,
                                                   @firm smallint,
                                                   @year smallint,
                                                   @month tinyint,
                                                   @isTargetQuantity bit,
                                                   @considerHierarchyOfHybridUser bit
as

with Plans as (select Users.Id                                     as UserId,
                      Users.Name + ' ' + Users.Surname             as UserFullName,
                      ItemGroupId                                  as GroupId,
                      Groups.Code                                  as GroupCode,
                      Groups.Name                                  as GroupName,
                      Groups.SpecialCode                           as SpecialCode,
                      Groups.SpecialCode2                          as SpecialCode2,
                      Groups.SpecialCode3                          as SpecialCode3,
                      iif(@isTargetQuantity = 0, Amount, Quantity) as PlanAmount
               from MD_ItemGroupPlanForUser Plans with (nolock)
                        join MD_ItemGroup Groups with (nolock) on Groups.Id = Plans.ItemGroupId and Groups.Type = 1
                        left join F_GetPermittedUsers(@currentUserId) PermittedUsers on PermittedUsers.UserId = Plans.UserId
                        left join AbpUsers Users with (nolock)
                                  on (Users.Id = PermittedUsers.UserId and @considerHierarchyOfHybridUser = 1) or (Users.Id = @currentUserId and @considerHierarchyOfHybridUser = 0)
               where Plans.Month = @month
                 and Plans.Year = @year
                 and Plans.Firm = @firm
                 and ((@considerHierarchyOfHybridUser = 1 and PermittedUsers.UserId <> @currentUserId) or
                      (@considerHierarchyOfHybridUser = 0 and Plans.UserId = @currentUserId))),

     Facts as (select UserMapping.UserId                                                                                                                     as UserId,
                      ItemMapping.GroupId                                                                                                                    as ItemGroupId,

                      IIF(@isTargetQuantity = 0, round(sum(iif(Invoice.[Type] = 4, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)) -
                                                       sum(iif(Invoice.[Type] = 2, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)),
                                                       2),
                          round(sum(iif(Invoice.[Type] = 4, Line.Quantity * Convfact2, 0)) - sum(iif(Invoice.[Type] = 2, Line.Quantity * Convfact2, 0)), 2)) AS FactAmount
               from ERP_Invoice Invoice with (nolock)
                        join ERP_InvoiceLine Line with (nolock) ON Line.InvoiceId = Invoice.ERPId
                        join MD_ItemGroupItemMapping ItemMapping with (nolock) on ItemMapping.ItemId = Line.ItemId and ItemMapping.Firm = Invoice.Firm and ItemMapping.GroupType = 1
                        join UIM_UserEmployeeMapping UserMapping with (nolock) on UserMapping.EmployeeId = Invoice.SalesmanId and UserMapping.Firm = Invoice.Firm
                        join MD_ItemUnit Units with (nolock)
                             on Units.Code = Line.ItemUnitCode and Units.TigerItemId = Line.ItemId and Units.Firm = Invoice.Firm and Units.IsDeleted = 0

               where Invoice.IsDeleted = 0
                 and IsCancelled = 0
                 and Line.LineType <> 1
                 and month(Invoice.Date) = @month
                 and year(Invoice.Date) = @year
               group by ItemMapping.GroupId, UserMapping.UserId)

select Plans.UserId               as UserId,
       sum(PlanAmount)            as Target,
       isnull(sum(FactAmount), 0) as Result,
       Plans.GroupCode            as GroupCode,
       Plans.GroupId              as GroupId,
       Plans.GroupName            as GroupName,
       @month                     as Month,
       Plans.UserFullName         as UserFullName,
       Plans.SpecialCode          as SpecialCode,
       Plans.SpecialCode2         as SpecialCode2,
       Plans.SpecialCode3         as SpecialCode3

from Plans
         left join Facts on Plans.UserId = Facts.UserId and Plans.GroupId = Facts.ItemGroupId
group by Plans.UserId, Plans.UserFullName, Plans.GroupId, Plans.GroupCode, Plans.GroupName, Plans.SpecialCode, Plans.SpecialCode2, Plans.SpecialCode3
GO


