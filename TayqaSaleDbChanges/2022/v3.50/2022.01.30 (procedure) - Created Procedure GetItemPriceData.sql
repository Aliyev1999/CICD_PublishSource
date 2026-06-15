
CREATE PROC [dbo].[SP_MD_GetItemPriceData] @userId INT, @firm SMALLINT, @date DATETIME
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT distinct Item.TigerId AS ItemId, Item.code AS ItemCode, Item.Name As ItemName, Barcode.Barcode As Barcode, Price.Price AS Price, Curr.Code AS Currency
                                FROM MD_Item Item WITH (NOLOCK)
                                INNER JOIN MD_CatalogItemMapping IMapping WITH (NOLOCK) ON (IMapping.TigerItemId=Item.TigerId)
                                INNER JOIN MD_Catalog Cat WITH (NOLOCK) ON (Cat.Id=IMapping.CatalogId AND Cat.Firm=Item.Firm)
                                INNER JOIN MD_PermittedCatalog PCatalog WITH (NOLOCK) ON (PCatalog.UserId=@userId AND PCatalog.CatalogId=IMapping.CatalogId)
                                INNER JOIN MD_ItemUnit IUnit WITH (NOLOCK) ON (IUnit.TigerItemId=Item.TigerId AND IUnit.Firm=Item.Firm AND IUnit.IsMainUnit=1)
                                LEFT JOIN MD_ItemBarcode Barcode WITH (NOLOCK) ON (Barcode.Firm=Item.Firm AND Barcode.TigerItemId=Item.TigerId AND Barcode.TigerItemUnitId=IUnit.TigerId)
                                LEFT JOIN MD_ItemPrice Price WITH (NOLOCK) ON (Price.Firm=Item.Firm AND Price.TigerItemId=Item.TigerId AND Price.TigerItemUnitId=IUnit.TigerId AND Price.BeginDate<=@date AND Price.EndDate>=@date)
                                INNER JOIN MD_ItemPriceDivisionMapping PriceMapping WITH (NOLOCK) ON (PriceMapping.TigerId=Price.TigerId AND PriceMapping.Firm=Price.Firm AND PriceMapping.DivisionNr=-1)
                                LEFT JOIN MD_Currency Curr WITH (NOLOCK) ON (Curr.Firm=Price.Firm AND Curr.Type=Price.CurrencyTypeId)
                                WHERE 1=1';

    IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and Item.Firm=@firm');
        END

    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT , @date DATETIME', @userId = @userId, @firm = @firm ,@date = @date 
END
GO


