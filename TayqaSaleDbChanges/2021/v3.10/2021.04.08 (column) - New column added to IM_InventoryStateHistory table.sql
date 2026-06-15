ALTER TABLE IM_InventoryStateHistory ADD IsScanned BIT NULL
GO

UPDATE IM_InventoryStateHistory SET IsScanned = 0
GO

ALTER TABLE IM_InventoryStateHistory ALTER COLUMN IsScanned BIT NOT NULL
ALTER TABLE IM_InventoryStateHistory ADD CONSTRAINT default_IsScanned DEFAULT 0 FOR IsScanned;
