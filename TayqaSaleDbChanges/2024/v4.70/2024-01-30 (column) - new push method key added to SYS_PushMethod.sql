DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('ImConfirmedOrRejectedWarehouseRepairExecution', 'Inventory Confirmed Or Rejected Warehouse Repair Execution',
        null, null, 1, 3, 1, null, null, 2, GETDATE(), @Id + 1)
GO
DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('ImCompletedWarehouseRepair', 'Inventory Completed Warehouse Repair',
        null, null, 1, 3, 1, null, null, 2, GETDATE(), @Id + 1)