create procedure [dbo].[SP_PN_GetItemGroupsPlanDetails] @currentUserId int,
                                                        @firm smallint,
                                                        @year smallint,
                                                        @month tinyint,
                                                        @groupId int,
                                                        @selectedUserId int = null
as
-- Created by: TayqaTech for TayqaSale (Kanan Mammadov)
-- Date: 01.01.2022
-- Description: Returns the report data of sales plan-fact details for selected user

select Invoice.Firm                                                                                                                                  as Firm,
       Item.TigerId                                                                                                                                  as ItemId,
       Item.Name                                                                                                                                     as ItemName,
       Item.Code                                                                                                                                     as ItemCode,
       round(sum(iif(Invoice.[Type] = 4, Line.Quantity * Units.Convfact2, 0)) - sum(iif(Invoice.[Type] = 2, Line.Quantity * Units.Convfact2, 0)), 2) as Quantity,
       round(sum(iif(Invoice.[Type] = 4, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)) -
             sum(iif(Invoice.[Type] = 2, (Line.Quantity * Line.Price) - Line.DiscountAmount, 0)),
             2)                                                                                                                                      as Amount,
       Invoice.Date                                                                                                                                  as Date,
       MainUnit.TigerId                                                                                                                              as ItemUnitId,
       MainUnit.Name                                                                                                                                 as ItemUnitName,
       162                                                                                                                                           as CurrencyType,
       'AZN'                                                                                                                                         as CurrencyCode
from ERP_Invoice Invoice with (nolock)
         join ERP_InvoiceLine Line with (nolock) ON Line.InvoiceId = Invoice.ERPId
         join MD_Item Item with (nolock) on Item.TigerId = Line.ItemId and Item.Firm = Invoice.Firm and Item.IsDeleted = 0
         join MD_ItemGroupItemMapping ItemMapping with (nolock) on ItemMapping.ItemId = Line.ItemId and ItemMapping.Firm = Invoice.Firm and ItemMapping.GroupType = 1
         join MD_ItemUnit Units with (nolock)
              on Units.Code = Line.ItemUnitCode and Units.TigerItemId = Item.TigerId and Units.Firm = Item.Firm and Units.IsDeleted = 0
         join MD_ItemUnit MainUnit with (nolock) on MainUnit.TigerItemId = Units.TigerItemId and MainUnit.IsMainUnit = 1 and MainUnit.Firm = Units.Firm

where Invoice.IsDeleted = 0
  and IsCancelled = 0
  and Line.LineType <> 1
  and month(Invoice.Date) = @month
  and year(Invoice.Date) = @year
  and ItemMapping.GroupId = @groupId
  and Invoice.SalesmanId in (select EmployeeId from UIM_UserEmployeeMapping with (nolock) where UserId = @selectedUserId and Firm = @firm)
group by Invoice.Firm, Item.TigerId, Item.Name, Item.Code, Invoice.Date, MainUnit.TigerId, MainUnit.Name