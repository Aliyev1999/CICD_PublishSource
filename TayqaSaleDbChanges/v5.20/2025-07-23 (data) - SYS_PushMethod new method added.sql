DECLARE @maxId INT;
SET @maxId = (SELECT MAX(Id) FROM SYS_PushMethod);

INSERT INTO SYS_PushMethod (Name, Description, ExtraInfo, Url, DataTypeId, PushTypeId, Status, ModifiedUserId, ModifiedDate, CreatedUserId, CreatedDate, Id) VALUES (N'MsgClientNotificationCreated', N'MessagingWS Client Notification Created', null, null, 1, 3, 1, null, null, 2, getdate(), @maxId+1);

