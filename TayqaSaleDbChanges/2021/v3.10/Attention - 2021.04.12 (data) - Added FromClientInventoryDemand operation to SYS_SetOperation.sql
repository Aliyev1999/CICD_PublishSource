INSERT INTO [dbo].[SYS_SetOperation]
           ([Id]
           ,[Name]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate])
     VALUES
           (21
           ,'FromClientInventoryDemand'
           ,'From client inventory demand'
           ,NULL
           ,1
           ,NULL
           ,GETDATE())
GO

UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') + '1' WHERE DataType = 'Division'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') + '1' WHERE DataType = 'Warehouse'

UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'Department'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'TradingGroup'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'Factory'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'CashCard'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'PaymentPlan'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'Bank'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'BankAccount'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 21 - LEN(OperationBitmask)),'') WHERE DataType = 'Currency'

GO