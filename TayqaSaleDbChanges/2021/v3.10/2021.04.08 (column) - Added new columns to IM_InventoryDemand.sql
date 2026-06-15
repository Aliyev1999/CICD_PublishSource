ALTER TABLE IM_InventoryDemand
ADD Reserved bit null

GO

ALTER TABLE IM_InventoryDemand
ADD 
Warehouse int NOT NULL DEFAULT 0,
Division smallint NOT NULL DEFAULT 0

GO

ALTER TABLE IM_InventoryDemand
ADD 
CancelledUserId bigint null,
CancelledDate datetime null,
CancelReason nvarchar(1000) null