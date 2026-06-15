INSERT INTO [dbo].[SYS_SetOperation]
           ([Id]
           ,[Name]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate])
     VALUES
           (26
           ,'InventoryTransfer'
           ,'Inventory Transfer'
           ,NULL
           ,2
           ,NULL
           ,GETDATE())
GO

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'1' WHERE DataType='Division'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'1' WHERE DataType='Warehouse'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='Department'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='TradingGroup'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='Factory'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='CashCard'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='PaymentPlan'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='Bank'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='BankAccount'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='Currency'

UPDATE SYS_DataOperationMapping SET OperationBitmask=OperationBitmask + COALESCE(REPLICATE('0', 25 - LEN(OperationBitmask)),'')+'0' WHERE DataType='TransferWarehouse'