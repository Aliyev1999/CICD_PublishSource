
CREATE PROCEDURE [dbo].[SP_RM_GetItemStockData] 
	@userId int,
    @firm smallint,
    @warehouseNr int,
	@lineNr tinyint 
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
			SET @sql = 'SELECT DISTINCT Item.TigerId                                                                   AS ItemId,
						Item.Code                                                                      AS ItemCode,
						Item.Name                                                                      AS ItemName,
						IPrice.Price                                                                   AS ItemPrice,

						(SELECT TOP 1 Barcode.Barcode
						 FROM MD_ItemBarcode Barcode
						 WHERE Barcode.TigerItemId = Stock.TigerItemId
						   AND Barcode.Firm = Stock.Firm
						   AND Barcode.TigerItemUnitId = IUnit.TigerId
						   AND Barcode.IsDeleted = 0)                                                  As Barcode,
						Stock.ActualAmount                                                             AS ActualAmount,
						Stock.RealAmount                                                               AS RealAmount,
						Stock.SpecialAmount                                                            AS SpecialAmount,
						IUnit.Name                                                                     AS UnitName,
						ROUND(Stock.ActualAmount / (CASE
														WHEN IUnitSecond.Convfact2 is null OR IUnitSecond.Convfact2 = 0 THEN 1
														ELSE IUnitSecond.Convfact2 END),
							  2)                                                                       AS ActualAmountWithSecondUnit,
						ROUND(Stock.RealAmount / (CASE
													  WHEN IUnitSecond.Convfact2 is null OR IUnitSecond.Convfact2 = 0 THEN 1
													  ELSE IUnitSecond.Convfact2 END),
							  2)                                                                       AS RealAmountWithSecondUnit,
						ROUND(Stock.SpecialAmount / (CASE
														 WHEN IUnitSecond.Convfact2 is null OR IUnitSecond.Convfact2 = 0 THEN 1
														 ELSE IUnitSecond.Convfact2 END),
							  2)                                                                       AS SpecialAmountWithSecondUnit,
						(CASE WHEN IUnitSecond.Name is null THEN IUnit.Name ELSE IUnitSecond.Name END) AS SecondUnitName
		FROM OP_ItemStock Stock WITH (NOLOCK)
				 INNER JOIN MD_CatalogItemMapping ItemMapping WITH (NOLOCK) ON (ItemMapping.TigerItemId = Stock.TigerItemId)
				 INNER JOIN MD_PermittedCatalog PCatalog WITH (NOLOCK)
							ON (PCatalog.UserId = @userId AND PCatalog.CatalogId = ItemMapping.CatalogId)
				 INNER JOIN MD_Item Item WITH (NOLOCK) ON Item.TigerId = Stock.TigerItemId AND Item.Firm = Stock.Firm
				 INNER JOIN MD_ItemUnit IUnit WITH (NOLOCK)
							ON (IUnit.Firm = Stock.Firm AND IUnit.TigerItemId = Stock.TigerItemId AND IUnit.LineNr = 1)
				 INNER JOIN MD_ItemPrice IPrice WITH (NOLOCK)
							ON (IPrice.TigerItemId = Item.TigerId AND IPrice.Firm = Item.Firm AND
								IPrice.OperationMask LIKE ''1%'' AND
								IPrice.TigerItemUnitId = IUnit.TigerId and EndDate > GETDATE() and IPrice.Status = 0 and
								IPrice.IsDeleted = 0)
				 LEFT JOIN MD_ItemUnit IUnitSecond WITH (NOLOCK)
						   ON (IUnitSecond.Firm = Stock.Firm AND IUnitSecond.TigerItemId = Stock.TigerItemId AND
							   IUnitSecond.LineNr = @lineNr)
		WHERE Stock.WarehouseNr = @warehouseNr
		  AND Stock.Firm = @firm
		  AND IPrice.IsDeleted = 0
		  AND IPrice.Status = 0
		  AND Stock.WarehouseNr IN (SELECT WarehouseNr
									FROM MD_PermittedWarehouse PWhouse
									WHERE Firm = Stock.Firm
									  AND PWhouse.TigerWarehouseNr = Stock.WarehouseNr
									  AND PWhouse.UserId = @userId)
		order by ItemName';
    

    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT, @warehouseNr INT, @lineNr TINYINT', @userId = @userId, @firm = @firm, @warehouseNr = @warehouseNr, @lineNr = @lineNr

END
	