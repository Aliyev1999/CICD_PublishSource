CREATE PROCEDURE [dbo].[SP_OP_SerialNumberSyncQueue]
AS
update [dbo].[OP_ItemSerialNumberSyncQueue]
set ProcessingStatus = 1

SELECT Id, UserId, ItemId, WarehouseNr, Firm, Period FROM OP_ItemSerialNumberSyncQueue WITH(NOLOCK) 
WHERE ProcessingStatus = 1
GROUP BY Id, UserId, ItemId, WarehouseNr, Firm, Period
