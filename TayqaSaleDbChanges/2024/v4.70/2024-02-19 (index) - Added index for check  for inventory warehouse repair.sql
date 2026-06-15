

CREATE NONCLUSTERED INDEX [IX_IM_WarehouseRepairDemand_Status_InventoryId_Firm] ON [dbo].[IM_WarehouseRepairDemand]
(
	[Firm] ASC,
	[InventoryId] ASC,
	[Status] ASC
)

CREATE NONCLUSTERED INDEX [IX_IM_Inventory_Status] ON [dbo].[IM_Inventory]
(
	[Status] ASC
)


-- Index on IM_WarehouseTransfer table
CREATE NONCLUSTERED INDEX IX_IM_WarehouseTransfer_Status
ON IM_WarehouseTransfer (IsDeleted, IsActive, Status, Firm);

-- Index on IM_WarehouseTransferLineInventory table
CREATE NONCLUSTERED INDEX IX_IM_WarehouseTransferLineInventory_WarehouseTransferId
ON IM_WarehouseTransferLineInventory (WarehouseTransferId);

-- Index on IM_WarehouseTransferLineInventory table (covering the Status and Id columns)
CREATE NONCLUSTERED INDEX IX_IM_WarehouseTransferLineInventory_Status_Id
ON IM_WarehouseTransferLineInventory (Status, Id);


-- Index on IM_InventoryDemand table
CREATE NONCLUSTERED INDEX IX_IM_InventoryDemand_DemandStatus_Firm
ON IM_InventoryDemand (DemandStatus, Firm);

-- Index on IM_InventoryDemandInventoryMapping table
CREATE NONCLUSTERED INDEX IX_IM_InventoryDemandInventoryMapping_InventoryDemandId_InventoryId
ON IM_InventoryDemandInventoryMapping (InventoryDemandId, InventoryId);