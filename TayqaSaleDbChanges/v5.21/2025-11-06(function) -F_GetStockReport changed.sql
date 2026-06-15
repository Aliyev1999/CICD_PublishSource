CREATE OR ALTER FUNCTION [dbo].[F_GetStockReport](@firm smallint, @itemId int, @userId bigint)
    Returns Table
        AS
        RETURN
       SELECT DISTINCT warehouse.Nr AS WarehouseNr, warehouse.NAME AS WarehouseName, itemstock.RealAmount, itemstock.ActualAmount, itemstock.SpecialAmount
        FROM MD_PermittedWarehouse permittedwarehouse WITH (NOLOCK)
                 INNER JOIN MD_Warehouse warehouse WITH (NOLOCK) ON warehouse.nr = permittedwarehouse.tigerwarehousenr AND warehouse.firm = permittedwarehouse.firm AND permittedwarehouse.UserId = @userId
                 INNER JOIN OP_ItemStock itemstock WITH (NOLOCK) ON permittedwarehouse.tigerwarehousenr = itemstock.WarehouseNr AND permittedwarehouse.firm = itemstock.firm AND TigerItemId = @itemId
        WHERE permittedwarehouse.Firm = @firm
          and permittedwarehouse.UserId = @userId