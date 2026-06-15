alter PROCEDURE [dbo].[SP_CM_GetPromoDataList] @promoIds nvarchar(max)
AS
BEGIN
	select
	cm.Priority,
	cm.BudgetType,

	term.LineCode,
	term.ConditionFormat,
	tcv.ReferanceId TermItemId,
	tcv.Value TermStartWithText,
	term.ConditionField ConditionField,

	unit.TigerId as UnitId,
	unit.Convfact1,
	unit.Convfact2,
	unit.Widht,
	unit.Height,
	unit.Area,
	unit.Volume,
	unit.GrossWeight,
	unit.Length,
	unit.Code as ItemUnitCode,

	item.SellPRVat,
	item.SellVat,
	item.ReturnPRVat,
	item.ReturnVat,
	item.Code as ItemCode,
	item.CardType,

	promo.*
	from CM_CampaignDiscountTermPromo promo with(nolock)
	join CM_Campaign cm  with(nolock) on cm.Id= promo.CampaignId
	left join MD_Item item with(nolock) on item.TigerId=promo.PromoValue and item.Firm=cm.Firm
	left join CM_CampaignDiscountTerm term with(nolock) on term.Id=promo.DiscountTermId
	left join CM_CampaignDiscountTermConditionValue tcv with(nolock) on term.Id=tcv.DiscountTermId and ((term.ConditionFormat=5 and term.ConditionField=1) or  term.ConditionField=2 or ConditionField=1)
	left join MD_ItemUnit unit with(nolock) on unit.Code=promo.PromoItemUnitCode and unit.TigerItemId=promo.PromoValue and promo.PromoType=1
	where promo.Id IN (SELECT LTRIM(Value) FROM F_SplitList(@promoIds,','))
	order by  cm.Priority desc
end
go