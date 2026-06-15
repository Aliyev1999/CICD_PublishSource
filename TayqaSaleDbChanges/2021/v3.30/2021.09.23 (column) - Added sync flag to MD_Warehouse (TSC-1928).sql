ALTER TABLE MD_Warehouse 
ADD SyncFlag bit

GO 

UPDATE MD_Warehouse SET SyncFlag = 1;

ALTER TABLE MD_Warehouse 
ALTER COLUMN SyncFlag bit NOT NULL