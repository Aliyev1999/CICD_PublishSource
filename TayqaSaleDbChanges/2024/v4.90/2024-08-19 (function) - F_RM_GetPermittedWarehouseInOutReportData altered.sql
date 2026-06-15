
ALTER FUNCTION [dbo].[F_RM_GetPermittedWarehouseInOutReportData](@firm SMALLINT, @userId bigint)
    RETURNS TABLE
        AS
        RETURN(with PriceList as (select distinct Price.TigerItemId as ItemId,
                                                  first_value(Price.Price)
                                                              over (partition by Price.Firm, Price.TigerItemId order by Price.Priority asc, Price.RegisteredDate desc) *
                                                  Unit.Convfact2    as Price

                                  from MD_ItemPrice Price with (nolock)
                                           join MD_ItemUnit Unit with (nolock)
                                                on Unit.TigerId = Price.TigerItemUnitId and Unit.TigerItemId = Price.TigerItemId and Unit.Firm = Price.Firm
                                  where getdate() between BeginDate and EndDate
                                    and Price.IsDeleted = 0
                                    and Unit.IsDeleted = 0
                                    and OperationMask like '11111%'
                                    and Price.Firm = @firm
                                    and IsMainUnit = 1),

                    ItemStock as (select WarehouseNr, stock.TigerItemId as ItemId, RealAmount as Stock
                                  from OP_ItemStock stock with (nolock)
								  join F_GetAllPermittedItems() pm on pm.Firm = stock.Firm and pm.TigerItemId = stock.TigerItemId 
								  where pm.UserId = @userId),

                    Total as (select ItemStock.WarehouseNr, round(SUM(Stock * Price), 2) as Balance
                              from ItemStock
                                       left join PriceList on PriceList.ItemId = ItemStock.ItemId
                              group by WarehouseNr)


               select distinct w.Nr,
                               w.Name,
                               Total.Balance as Balance,
                               'AZN'            CurrencyCode
               from MD_PermittedWarehouse pw with (nolock)

                        join MD_Warehouse w with (nolock) on w.Nr = pw.TigerWarehouseNr and w.Firm = pw.Firm and w.DivisionNr = pw.DivisionNr
                        left join Total on Total.WarehouseNr = pw.TigerWarehouseNr
               where pw.Firm = @firm
                 and UserId = @userId)


		
