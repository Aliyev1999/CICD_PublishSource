ALTER TABLE OP_IncomingLogWarehouseOperationExtension
ADD InputType nvarchar(50)
go
ALTER TABLE OP_IncomingLogWarehouseOperationExtension
ADD OutputType nvarchar(50)
go
ALTER TABLE OP_RequestQueueWarehouseOperationExtension
ADD InputType nvarchar(50)
go
ALTER TABLE OP_RequestQueueWarehouseOperationExtension
ADD OutputType nvarchar(50)