create procedure [dbo].[SP_OP_GetWarehouseDocumentLineDetails](@requestId int)
As
Begin
    select Item.Code                                 as ItemCode,
           Item.Name                                 as ItemName,
           sum(isnull(RequestQueue.Quantity, Line.Quantity)) as Quantity,
           Unit.Name                                 as Unit
    from OP_ThirdPartyIncomingLogWarehouseOperationLineExtension Extension with (nolock)
             join MD_Item Item with (nolock) on Extension.ItemId = Item.TigerId
			 join OP_ThirdPartyIncomingLog ILog with(nolock) on Extension.Id=ILog.Id
             join MD_ItemUnit Unit with (nolock) on Extension.ItemUnitCode COLLATE SQL_Latin1_General_CP1_CI_AS = Unit.Code and Unit.TigerItemId=Extension.ItemId
			 left join OP_ThirdPartyRequestQueueWarehouseOperationLineExtension RequestQueue with(nolock) on RequestQueue.Id=Extension.Id and RequestQueue.ItemId=Extension.ItemId
			 and RequestQueue.ItemUnitCode=Extension.ItemUnitCode
             left join OP_ThirdPartyWarehouseOperationLineResultLog Line with (nolock) on Extension.Id = Line.Id and Extension.ItemId=Line.ItemId
				
    where Extension.Id = @requestId and ILog.DocType in (21, 22, 23, 24)
	 group by Item.Code,Item.Name,Unit.Name
End
