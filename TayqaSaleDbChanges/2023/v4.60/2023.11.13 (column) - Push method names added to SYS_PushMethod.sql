DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('ImCreatedRepairDemand', 'Create Repair Demand', null, null, 1, 3, 1, null, null, 2, GETDATE(), @Id + 1)
GO
DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('ImConfirmedOrRejectedRepairDemand', 'Inventory Confirmed Or Rejected Repair Demand', null, null, 1, 3, 1, null,
        null, 2, GETDATE(), @Id + 1)
GO
DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('ImConfirmedOrRejectedRepairExecution', 'Inventory Confirmed Or Rejected Repair Execution', null, null, 1, 3, 1,
        null, null, 2, GETDATE(), @Id + 1)
GO
DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('ImCompletedRepair', 'Inventory Completed Repair', null, null, 1, 3, 1, null, null, 2, GETDATE(), @Id + 1)
GO
DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('IMCreateRepairDemandTask', 'Inventory Create Repair Demand Task', null, null, 1, 3, 1, null, null, 2,
        GETDATE(), @Id + 1)
GO
DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('IMCancelRepairDemand', 'Inventory Cancel Repair Demand', null, null, 1, 3, 1, null, null, 2, GETDATE(),
        @Id + 1)
GO
DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('IMConsumptionConfirmationOrRejection', 'Inventory Consumption Confirmation Or Rejection', null, null, 1, 3, 1,
        null, null, 2, GETDATE(), @Id + 1)