create index IX_IM_InventoryStateHistory_InventoryId
	on IM_InventoryStateHistory (InventoryId)
go

create index IX_IM_InventoryStateHistory_CreatedDate
	on IM_InventoryStateHistory (CreatedDate)
go

CREATE NONCLUSTERED INDEX [IX_MD_Client_Firm_TagerParentId]
ON [dbo].[MD_Client] ([Firm],[TigerParentId])

GO

CREATE NONCLUSTERED INDEX [IX_Im_Inventory_Firm_ClientTigerId]
ON [dbo].[IM_Inventory] ([Firm],[ClientTigerId])
GO

CREATE NONCLUSTERED INDEX [IX_IM_Inventory_Firm_TigerId]
ON [dbo].[IM_Inventory] ([Firm],[TigerId])
GO