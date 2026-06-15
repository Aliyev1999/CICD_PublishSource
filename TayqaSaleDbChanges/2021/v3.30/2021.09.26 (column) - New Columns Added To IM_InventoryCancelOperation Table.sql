ALTER TABLE IM_InventoryCancelOperation ADD DestroyTime DATE NULL;

GO

UPDATE IM_InventoryCancelOperation SET DestroyTime = CreationTime

ALTER TABLE IM_InventoryCancelOperation ALTER COLUMN DestroyTime DATE NOT NULL;

ALTER TABLE IM_InventoryCancelOperation ADD InventoryStatus TINYINT NULL;
