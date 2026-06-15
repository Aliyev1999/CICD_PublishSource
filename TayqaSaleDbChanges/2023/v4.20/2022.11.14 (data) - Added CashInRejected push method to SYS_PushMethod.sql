DECLARE @maxId INT = (SELECT MAX(Id) FROM SYS_PushMethod)

INSERT INTO SYS_PushMethod ([Name], 
							[Description], 
							DataTypeId, 
							PushTypeId, 
							[Status], 
							CreatedUserId, 
							CreatedDate, 
							Id)
VALUES ('CashInRejected', 
		'CashIn Rejected', 
		1, 
		3, 
		1, 
		2, 
		GETDATE(), 
		@maxId + 1);