ALTER TABLE OP_ErpSmartExceptionHandlerLog
ADD 
ServiceName nvarchar(max),
RequestId int;

GO

UPDATE OP_ErpSmartExceptionHandlerLog Set ServiceName = 'UnNamed';

GO

ALTER TABLE OP_ErpSmartExceptionHandlerLog
ALTER COLUMN 
ServiceName nvarchar(max) not null;