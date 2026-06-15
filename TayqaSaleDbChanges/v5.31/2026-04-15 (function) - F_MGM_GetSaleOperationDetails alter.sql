create or ALTER FUNCTION [dbo].[F_MGM_GetSaleOperationDetails]( @firm smallint,@requestId bigint)
    RETURNS TABLE
        AS
        RETURN(
		       select DocType                                                           as OperationType,
                      Division.Name                                                     as Workplace,
                      Warehouse.Name                                                    as Warehouse,
                      Salesman.Name                                                     as Representative,
                      Salesman.Code                                                     as RepresentativeCode,
                      ILog.Note                                                         as Note,
                      row_number() over (order by Line.ItemId)                          as [LineNo],
                      Item.Name                                                         as Name,
                      Item.Code                                                         as ProductCode,
                      Unit.Name                                                         as Unit,
                      isnull(RequestQueue.Amount, Result.Amount)                        as Quantity,
                      round(Line.Price, 2)                                              as UnitPrice,
                      round(Line.DiscountAmount, 2)                                     as Discount,
                      Line.IsPromo                                                      as IsPromo,
                      round(isnull(RequestQueue.Amount, Result.Amount) * Line.Price, 2) as Total,
                      Currency.Code                                                     as Currency,
                      sum(round(isnull(RequestQueue.Amount, Result.Amount) * Line.Price, 2))
                          over (partition by ILog.Id)                                   as SummaryTotal,

                      sum(round(Line.DiscountAmount, 2))
                          over (partition by ILog.Id)                                   as SummaryDiscount,

                      sum(case
                              when Line.IsPromo = 1
                                  then round(isnull(RequestQueue.Amount, Result.Amount) * Line.Price, 2)
                              else 0 end)
                          over (partition by ILog.Id)                                   as SummaryPromo,


                      sum(round(isnull(RequestQueue.Amount, Result.Amount) * Line.Price, 2))
                          over (partition by ILog.Id)
                          - sum(case
                                    when Line.IsPromo = 1
                                        then round(isnull(RequestQueue.Amount, Result.Amount) * Line.Price, 2)
                                    else 0 end)
                                over (partition by ILog.Id)                             as SummaryFinal,
                      max(Currency.Code) over (partition by ILog.Id)                    as SummaryCurrency


               from OP_ThirdPartyIncomingLog ILog with (nolock)

                        join OP_ThirdPartyIncomingLogCommonLineExtension Line with (nolock) on ILog.Id = Line.Id
                        join MD_Item Item with (nolock) on Line.ItemId = Item.TigerId and ILog.Firm = Item.Firm
                        join MD_ItemUnit Unit with (nolock) on Unit.TigerItemId = Line.ItemId and Unit.Firm=ILog.Firm and  line.ItemUnitCode COLLATE SQL_Latin1_General_CP1_CI_AS = Unit.Code
                        left join OP_ThirdPartyRequestQueueCommonLineExtension RequestQueue with (nolock)
                                  on Line.Id = RequestQueue.Id and Line.ItemId = RequestQueue.ItemId and Line.ItemUnitCode = RequestQueue.ItemUnitCode and
                                     RequestQueue.IsPromo = Line.IsPromo
                        left join OP_ThirdPartyCommonLineResultLog Result with (nolock) on Result.Id = Line.Id and Result.ItemId = Line.ItemId and Line.IsPromo = Result.IsPromo
                        left join MD_Division Division with (nolock) on ILog.Division = Division.Nr and ILog.Firm = Division.Firm
                        left join MD_Salesman Salesman with (nolock) on ILog.SalesmanRef = Salesman.TigerId and ILog.Firm = Salesman.Firm
                        left join OP_ThirdPartyIncomingLogCommonExtension WarehouseId with (nolock) on WarehouseId.Id = ILog.Id
                        left join MD_Warehouse Warehouse with (nolock) on WarehouseId.WhouseNr = Warehouse.Nr and Warehouse.Firm = ILog.Firm
                        left join MD_Currency Currency with (nolock) on ILog.CurrencyType = Currency.Type and Currency.Firm=ILog.Firm
               where ILog.Id = @requestId and ILog.Firm=@firm)