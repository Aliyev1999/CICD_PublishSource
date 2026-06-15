drop function F_IM_InventoryStockInfo
go
create FUNCTION [dbo].[F_IM_InventoryStockInfo](@userId INT, @firm SMALLINT)
    RETURNS @Result Table
                    (
                        TigerId      int,
                        Firm         smallint,
                        WarehouseNr  int,
                        UserId       int,
                        ActualAmount int,
                        RealAmount   int
                    )
    AS
    BEGIN

	-- Last modified by Kanan Mammadov to subtract warehouse transfers

        declare @secondConfirmEnabled bit;

        SELECT @secondConfirmEnabled = CASE WHEN Value = 'true' then 1 else 0 END
        FROM SYS_GlobalConfigParameter
        WHERE Name = 'InventoryDemandSecondConfirmEnabled'
          AND Status = 1;

        INSERT INTO @Result
        SELECT *
        FROM (SELECT INV.TigerId,
                     INV.Firm,
                     INV.WarehouseNr,
                     PW.UserId,

                     (SELECT COUNT(*)
                      FROM IM_Inventory
                      WHERE Status = 1
                        AND TigerId = INV.TigerId
                        AND Firm = INV.Firm
                        AND WarehouseNr = INV.WarehouseNr)        AS ActualAmount,

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
                         AND Reserved = 1
                         AND (@secondConfirmEnabled = 0 OR Step != 2)) -
                      isnull((select sum(Lines.SelectedCount)
                              from IM_WarehouseTransfer Package with (nolock)
                                       join IM_WarehouseTransferLine Lines with (nolock) on Lines.WarehouseTransferId = Package.Id
                              where -- Package.IsActive = 1 and 
									Package.IsDeleted = 0
                                and Package.Status = 0
                                and Package.FromWarehouse = INV.WarehouseNr
                                and Lines.ItemId = INV.TigerId
                                and Package.Firm = INV.Firm),0)) AS RealAmount --Step = 2 is rejected

              FROM IM_Inventory INV
                       JOIN F_GetAllPermittedInventories() [PI] ON INV.TigerId = [PI].InventoryTigerId
                       JOIN MD_PermittedWarehouse PW
                            ON PW.TigerWarehouseNr = INV.WarehouseNr AND PW.Firm = INV.Firm AND
                               INV.DivisionNr = PW.DivisionNr
              WHERE PW.OperationId IN (20, 21)
                AND PW.UserId = @userId
                AND [PI].UserId = @userId
                AND (@firm IS NULL OR @firm = 0 OR INV.Firm = @firm)
              GROUP BY INV.TigerId, INV.Firm, INV.WarehouseNr, PW.UserId) AS Info;
        RETURN;
    END