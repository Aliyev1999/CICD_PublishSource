
 ALTER procedure [dbo].[SP_CM_GetAlternativeItemStocks] @codes nvarchar(100), @firm smallint, @requestId int ,@warehouseNr int
as
begin 
select
alternative.PromoLineId,
alternativeItem.Code as PromoItemCode,
alternative.ItemUnitCode as ItemUnitCode,
alternative.ItemTigerId as ItemId, 
alternative.Priority as Priority,
alternative.ItemQuantity as Amount,
line.ItemId as PreviousItemId,
line.Amount as PreviousItemAmount,
promo.PromoItemQuantity as PromoItemAmount,
promo.DecimalsCount,
promo.ApplyRounding,
promo.RoundingType,
exitItem.Code  as PreviousItemCode,
stock.ActualAmount as ItemStock,
itemUnit.TigerId as ItemUnitId,
itemUnit.Convfact1,
itemUnit.Convfact2
from OP_IncomingLogCommonLineExtension line with (nolock) 
join CM_AlternativeItem alternative with (nolock)  on alternative.PromoLineId=line.PromoId 
join CM_CampaignDiscountTermPromo promo with (nolock)  on  promo.Id= alternative.PromoLineId 
join MD_Item exitItem  with (nolock) on exitItem.TigerId=line.ItemId and exitItem.Firm=@firm
join MD_Item alternativeItem with (nolock)  on alternativeItem.TigerId=alternative.ItemTigerId and alternativeItem.Firm=@firm
join OP_ItemStock stock with (nolock)  on stock.TigerItemId=alternative.ItemTigerId   and stock.WarehouseNr=@warehouseNr and stock.Firm=@firm
join MD_ItemUnit itemUnit with (nolock) on itemUnit.Code=alternative.ItemUnitCode and itemUnit.TigerItemId=alternativeItem.TigerId and itemUnit.Firm=@firm
where line.Id=@requestId  and exitItem.Code IN (SELECT LTRIM(Value) FROM F_SplitList(@codes,','))
end
