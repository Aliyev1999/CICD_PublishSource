ALTER TABLE MD_ItemUnit
ADD IsForWarehouseOperation BIT NOT NULL DEFAULT(0)
GO
ALTER TABLE MD_ItemUnit
ADD PriorityForWarehouseOperation smallint NOT NULL Default(0)