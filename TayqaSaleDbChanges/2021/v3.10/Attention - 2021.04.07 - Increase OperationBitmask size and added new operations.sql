ALTER TABLE SYS_DataOperationMapping
ALTER COLUMN OperationBitmask varchar(30) NOT NULL

GO
INSERT INTO [dbo].[SYS_SetOperation]
           ([Id]
           ,[Name]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate])
     VALUES
           (20
           ,'ToClientInventoryDemand'
           ,'To client inventory demand'
           ,NULL
           ,1
           ,NULL
           ,GETDATE())
GO

UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 19 - LEN(OperationBitmask)),'') + '1' WHERE DataType = 'Division'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 19 - LEN(OperationBitmask)),'') + '1' WHERE DataType = 'Warehouse'

UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'Department'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'TradingGroup'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'Factory'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'CashCard'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'PaymentPlan'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'Bank'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'BankAccount'
UPDATE SYS_DataOperationMapping Set OperationBitmask = OperationBitmask + COALESCE(REPLICATE('0', 20 - LEN(OperationBitmask)),'') WHERE DataType = 'Currency'

GO