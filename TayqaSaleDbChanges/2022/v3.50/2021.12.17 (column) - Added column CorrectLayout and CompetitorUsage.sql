ALTER TABLE IM_InventoryStateHistory 
ADD CompetitorUsage  bit  NOT NULL
CONSTRAINT DF_CompetitorUsage DEFAULT 0
WITH VALUES

ALTER TABLE IM_InventoryStateHistory 
ADD CorrectLayout  bit  NOT NULL
CONSTRAINT DF_CorrectLayout DEFAULT 0
WITH VALUES