ALTER TABLE OP_OnlineOfferTemplate
ALTER COLUMN OperationsMask nvarchar(36) NOT NULL

GO
INSERT INTO [dbo].SYS_UserActionType
           ([Type]
           ,[Description]
           ,[Status]
           ,[CreatedDate]
		   ,[Id])
VALUES ('WarehouseIn', 'WarehouseIn', 1, GETDATE(),33),
	   ('WarehouseOut', 'WarehouseOut', 1, GETDATE(),34),
	   ('WarehouseTransfer', 'WarehouseTransfer', 1, GETDATE(),35),
	   ('WarehouseStockDemand', 'WarehouseStockDemand', 1, GETDATE(),36); 
GO

UPDATE OP_OnlineOfferTemplate SET OperationsMask = LEFT(OperationsMask + COALESCE(REPLICATE('0', 36 - LEN(OperationsMask)),'') + '1', 36)


GO
