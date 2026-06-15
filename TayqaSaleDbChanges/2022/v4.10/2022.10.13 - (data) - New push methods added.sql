
DECLARE @maxId INT = (SELECT MAX(Id) FROM SYS_PushMethod)

INSERT INTO SYS_PushMethod ([Name], [Description], DataTypeId, PushTypeId, [Status], CreatedUserId, CreatedDate, Id)
VALUES ('WorkExecutionConfirmed', 'Work Execution Confirmed', 1, 3, 1, 2, GETDATE(), @maxId + 1);

INSERT INTO SYS_PushMethod ([Name], [Description], DataTypeId, PushTypeId, [Status], CreatedUserId, CreatedDate, Id)
VALUES ('WorkExecutionRejected', 'Work Execution Rejected', 1, 3, 1, 2, GETDATE(), @maxId + 2);


IF NOT EXISTS (SELECT * FROM SYS_PushMethod WHERE [Name] = 'OrderRejected')
BEGIN

INSERT INTO SYS_PushMethod ([Name], [Description], DataTypeId, PushTypeId, [Status], CreatedUserId, CreatedDate, Id)
VALUES ('OrderRejected', 'Order Rejected', 1, 3, 1, 2, GETDATE(), @maxId + 3);

END
