
CREATE OR ALTER function [dbo].[F_MGM_GetWarehouseOperationDetails](@requestId bigint)
    returns table
        as
        return(
		select ILog.DocType                                 as OperationType,
                      SourceWarehouse.Name                         as SourceWarehouse,
                      DestinationWarehouse.Name                    as DestinationWarehouse,
                      DestinationDivision.Name                     as DestinationDivision,
                      SourceDivision.Name                          as SourceDivision,
                      ILog.Note                                    as Note,
                      row_number() over (order by Item.TigerId)    as [LineNo],
                      Item.Name                                    as Name,
                      Item.Code                                    as ProductCode,
                      Unit.Name                                    as Unit,
                      isnull(RequestQueue.Quantity, Line.Quantity) as Quantity
               from OP_ThirdPartyIncomingLog ILog with (nolock)
                        join OP_ThirdPartyIncomingLogWarehouseOperationLineExtension Extension with (nolock)
                             on Extension.Id = ILog.Id
                        join MD_Item Item with (nolock)
                             on Extension.ItemId = Item.TigerId
                                 and ILog.Firm = Item.Firm
                        join MD_ItemUnit Unit with (nolock)
                             on Unit.TigerItemId = Extension.ItemId and Unit.Firm = ILog.Firm and
                                Extension.ItemUnitCode COLLATE SQL_Latin1_General_CP1_CI_AS = Unit.Code
                        left join OP_ThirdPartyRequestQueueWarehouseOperationLineExtension RequestQueue with (nolock)
                                  on RequestQueue.Id = Extension.Id
                                      and RequestQueue.ItemId = Extension.ItemId
                        left join OP_ThirdPartyWarehouseOperationLineResultLog Line with (nolock)
                                  on Extension.Id = Line.Id
                                      and Extension.ItemId = Line.ItemId
                        left join OP_ThirdPartyIncomingLogWarehouseOperationExtension WhouseExt with (nolock)
                                  on WhouseExt.Id = ILog.Id
                        left join MD_Warehouse SourceWarehouse with (nolock)
                                  on WhouseExt.WarehouseOut = SourceWarehouse.Nr
                                      and SourceWarehouse.Firm = ILog.Firm
                        left join MD_Warehouse DestinationWarehouse with (nolock)
                                  on WhouseExt.WarehouseIn = DestinationWarehouse.Nr
                                      and DestinationWarehouse.Firm = ILog.Firm
                        left join MD_Division DestinationDivision with (nolock)
                                  on WhouseExt.DivisionIn = DestinationDivision.Nr
                                      and ILog.Firm = DestinationDivision.Firm
                        left  join MD_Division SourceDivision with (nolock)
                                  on WhouseExt.DivisionOut = SourceDivision.Nr
                                      and ILog.Firm = SourceDivision.Firm

               where ILog.Id = @requestId)