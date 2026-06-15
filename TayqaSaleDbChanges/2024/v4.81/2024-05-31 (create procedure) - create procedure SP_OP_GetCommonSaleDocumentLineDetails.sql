
create procedure [dbo].[SP_OP_GetCommonSaleDocumentLineDetails](@requestId int)
as
begin
    select distinct Line.IsPromo                                                                                   as LineType,
                    Item.Code                                                                                      as ItemCode,
                    Item.Name                                                                                      as ItemName,
                    isnull(RequestQueue.Amount, Result.Amount)                                                     as Quantity,
                    Unit.Name                                                                                      as Unit,
                    round(Line.Price,2)                                                                                     as Price,
                    round(Line.DiscountAmount,2)                                                                            as DiscountPrice,--?
                    round(Line.VatAmount,2)                                                                        as Vat,
                    case
					when Line.IsPromo=0 then round(CAST((isnull(RequestQueue.Amount, Result.Amount) * Line.Price) - Line.DiscountAmount as FLOAT),2)
					when Line.IsPromo=1 then 0
					end as NetAmount
    from OP_ThirdPartyIncomingLogCommonLineExtension Line with (nolock)
             join MD_Item Item with (nolock) on Line.ItemId = Item.TigerId
             join MD_ItemUnit Unit with (nolock)
                  on Line.ItemUnitCode COLLATE SQL_Latin1_General_CP1_CI_AS = Unit.Code and
                     Unit.TigerItemId = Line.ItemId
             join OP_ThirdPartyIncomingLog ILog with (nolock) on ILog.Id = Line.Id and Item.Firm = ILog.Firm
             left join OP_ThirdPartyRequestQueueCommonLineExtension RequestQueue with (nolock) on Line.Id = RequestQueue.Id
        and Line.ItemId = RequestQueue.ItemId and Line.ItemUnitCode = RequestQueue.ItemUnitCode  and RequestQueue.IsPromo=Line.IsPromo
             left join OP_ThirdPartyCommonLineResultLog Result with (nolock)
                       on Result.Id = Line.Id and Result.ItemId = Line.ItemId and Line.IsPromo = Result.IsPromo
    where ILog.DocType in (0, 1, 2, 3, 4)
      and @requestId = Line.Id
end