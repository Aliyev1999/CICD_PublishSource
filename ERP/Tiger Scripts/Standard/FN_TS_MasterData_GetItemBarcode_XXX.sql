CREATE Function [dbo].[FN_TS_MasterData_GetItemBarcode_XXX](@beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
SELECT BARCODE.ITEMREF AS ItemId, BARCODE.ITMUNITAREF AS ItemUnitId, BARCODE.LINENR AS LineNr, BARCODE.BARCODE AS Barcode
FROM LG_XXX_UNITBARCODE BARCODE WITH (NOLOCK)
INNER JOIN FN_TS_MasterData_GetAllItem_XXX() ITEM ON (BARCODE.ITEMREF=ITEM.ItemId AND ((ITEM.CreatedDate >=@beginDate AND ITEM.CreatedDate<=@endDate) OR (ITEM.ModifiedDate>=@beginDate AND ITEM.ModifiedDate<=@endDate)))

);

GO
