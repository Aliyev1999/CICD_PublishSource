ALTER proc [dbo].[SP_Spec_YesterdayOrdersTotal] @ClientId bigint, @CatalogIds nvarchar(100) = null, @OperationId tinyint = null, @Date date = NULL, @UserId int = null
as
begin
    select STOCKREF                               as ItemId,
           'KQ'                                   as UnitCode,
           sum(round(AMOUNT * Unit.CONVFACT2, 2)) as Quantity,
           min(VATMATRAH)                         as Price,
           1                                      as CanRemove,
           1                                      as CanDecrease,
           cast(1 as bit)                         as IsCampaignItem,
           cast(0 as bit)                         as IsSpecialItem,
           cast(0 as bit)                         as IsRecommendedItem,
           cast(0 as bit)                         as IsBestSellingItem,
           ''                                     as Note
    from LOGODB..LG_001_01_ORFLINE Line with (nolock)
             left JOIN LOGODB..LG_001_ITMUNITA Unit with (nolock) on Unit.ITEMREF = Line.STOCKREF and Unit.LINENR = 2
    where cast(DATE_ as date) = cast(dateadd(day, iif(datepart(dw, getdate()) = 2, -2, -1), getdate()) as date) -- only yesterday's sales except Monday
      and LINETYPE <> 1                                                                                         -- non-promo lines
      and CLIENTREF = @ClientId                                                                                 -- selected client
    group by STOCKREF
end