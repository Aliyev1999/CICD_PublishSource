UPDATE SYS_DataOperationMapping SET OperationBitmask = '1111111111100000000111100111' WHERE DataType = 'Division'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1111111111100000000000000000' WHERE DataType = 'Department'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1111111111100000000111101111' WHERE DataType = 'Warehouse'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1111111111100000000000000000' WHERE DataType = 'TradingGroup'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1111100000100000000001111000' WHERE DataType = 'Factory'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '0000011000000000000000000000' WHERE DataType = 'CashCard'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1111100000100000000000000000' WHERE DataType = 'PaymentPlan'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1000000000000000000000000000' WHERE DataType = 'Bank'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1000000000000000000000000000' WHERE DataType = 'BankAccount'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '1111111111100000000000000010' WHERE DataType = 'Currency'
GO
UPDATE SYS_DataOperationMapping SET OperationBitmask = '0000000000000000000000010000' WHERE DataType = 'TransferWarehouse'
