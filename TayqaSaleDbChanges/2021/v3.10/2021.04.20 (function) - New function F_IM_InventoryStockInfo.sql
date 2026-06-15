CREATE OR ALTER FUNCTION [dbo].[F_IM_InventoryStockInfo](@userId INT, @firm SMALLINT)
    Returns Table
        AS
        RETURN
            (
                SELECT INV.TigerId,
                       INV.Firm,
                       INV.WarehouseNr,
                       PW.UserId,
                       (SELECT COUNT(*)
                        FROM IM_Inventory
                        WHERE Status = 1
                          AND TigerId = INV.TigerId
                          AND Firm = INV.Firm
                          AND WarehouseNr = INV.WarehouseNr) AS ActualAmount,
                       ((SELECT COUNT(*)
                         FROM IM_Inventory
                         WHERE Status = 1
                           AND TigerId = INV.TigerId
                           AND Firm = INV.Firm
                           AND WarehouseNr = INV.WarehouseNr) -
                        (SELECT COUNT(*)
                         from IM_InventoryDemand
                         where Warehouse = INV.WarehouseNr
                           AND ItemTigerId = INV.TigerId
                           AND Firm = INV.Firm
                           AND DemandStatus IN (0, 1)
                           AND Reserved = 1))                AS RealAmount
                FROM IM_Inventory INV
                         JOIN F_GetAllPermittedInventories() [PI] ON INV.TigerId = [PI].InventoryTigerId
                         JOIN MD_PermittedWarehouse PW
                              ON PW.TigerWarehouseNr = INV.WarehouseNr AND PW.Firm = INV.Firm AND
                                 INV.DivisionNr = PW.DivisionNr
                WHERE PW.OperationId IN (20, 21)
                  AND PW.UserId = @userId
                  AND [PI].UserId = @userId
                  AND (@firm IS NULL OR @firm = 0 OR INV.Firm = @firm)
                GROUP BY INV.TigerId, INV.Firm, INV.WarehouseNr, PW.UserId
            )