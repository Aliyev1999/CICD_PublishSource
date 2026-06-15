ALTER proc [dbo].[SP_Spec_LastThreeDaysReturnDispatch] @ClientId bigint, @CatalogIds nvarchar(100) = null, @OperationId tinyint=null, @Date date, @UserId int
as
begin
    Select LINE.STOCKREF                                                          AS ItemId,
           'KQ'                                                                   as UnitCode,
           sum(round(AMOUNT * iif(LineUnit.CONVFACT2 = 1, 1, Unit.CONVFACT2), 3)) AS Quantity,
           min(LINE.PRICE)                                                        AS Price,
           cast(1 as bit)                                                         as CanRemove,
           cast(1 as bit)                                                         as CanDecrease,
           cast(1 as bit)                                                         as IsCampaignItem,
           cast(0 as bit)                                                         as IsSpecialItem,
           cast(0 as bit)                                                         as IsRecommendedItem,
           cast(0 as bit)                                                         as IsBestSellingItem,
           ''                                                                     as Note
    FROM LOGODB..LG_001_01_STLINE LINE WITH (NOLOCK)
             JOIN LOGODB..LG_001_01_STFICHE FICHE WITH (NOLOCK) ON FICHE.LOGICALREF = LINE.STFICHEREF
             left join LOGODB..LG_001_ITMUNITA LineUnit with (nolock) on LineUnit.UNITLINEREF = Line.UOMREF AND LineUnit.ITEMREF = Line.STOCKREF
             left JOIN LOGODB..LG_001_ITMUNITA Unit with (nolock) on Unit.ITEMREF = LineUnit.ITEMREF and Unit.LINENR = 2

    WHERE (LINE.LINETYPE in (0, 1, 6) OR (LINE.LINETYPE IN (2) AND LINE.GLOBTRANS = 1))
      and FICHE.TRCODE = 3
      and LINE.DATE_ >= cast(dateadd(day, -2, getdate()) as date)
      and LINE.CLIENTREF = @ClientId
      and LINE.INVOICEREF = 0
    GROUP BY LINE.STOCKREF
end