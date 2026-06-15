EXEC sp_rename 'OP_OrderCompletionStatus', 'OP_OperationCompletionStatus';

ALTER TABLE OP_OperationCompletionStatus
ADD RequestId int not null default 0;

GO

ALTER TABLE OP_OperationCompletionStatus
ADD DocType tinyint;

GO

UPDATE 
operationCompletionStatus
SET
operationCompletionStatus.RequestId = generalLog.RequestId,
DocType = 0

FROM
OP_OperationCompletionStatus operationCompletionStatus 
JOIN OP_GeneralLog generalLog  ON operationCompletionStatus.ErpId = generalLog.TigerId;
 