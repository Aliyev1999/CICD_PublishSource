DECLARE @bitmask NVARCHAR(MAX) = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'Division')

SET @bitmask = CONCAT(@bitmask, '110')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'Division'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'Department')
SET @bitmask = CONCAT(@bitmask, '000')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'Department'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'Warehouse')
SET @bitmask = CONCAT(@bitmask, '110')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'Warehouse'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'TradingGroup')
SET @bitmask = CONCAT(@bitmask, '000')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'TradingGroup'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'Factory')
SET @bitmask = CONCAT(@bitmask, '111')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'Factory'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'CashCard')
SET @bitmask = CONCAT(@bitmask, '000')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'CashCard'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'PaymentPlan')
SET @bitmask = CONCAT(@bitmask, '000')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'PaymentPlan'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'BankBank')
SET @bitmask = CONCAT(@bitmask, '000')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'BankBank'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'BankAccount')
SET @bitmask = CONCAT(@bitmask, '000')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'BankAccount'

SET @bitmask = (SELECT OperationBitmask FROM SYS_DataOperationMapping WHERE DataType = 'Currency')
SET @bitmask = CONCAT(@bitmask, '000')
UPDATE SYS_DataOperationMapping SET OperationBitmask = @bitmask WHERE DataType = 'Currency'

INSERT INTO SYS_DataOperationMapping(DataType, OperationBitmask, RegisteredDate) VALUES('TransferWarehouse', '000000000000000000000111', GETDATE());
