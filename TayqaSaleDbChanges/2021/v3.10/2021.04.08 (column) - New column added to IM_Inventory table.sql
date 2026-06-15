ALTER TABLE IM_Inventory ADD FirstInputCostPrice FLOAT NULL

GO

UPDATE IM_Inventory SET FirstInputCostPrice = 0

GO

ALTER TABLE IM_Inventory Add Constraint  DF_IM_Inventory_FirstInputCostPrice DEFAULT 0 For FirstInputCostPrice

GO

ALTER TABLE IM_Inventory ALTER COLUMN FirstInputCostPrice FLOAT NOT NULL;

GO

