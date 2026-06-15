declare @maxId int
set @maxId = (select max(Id) from SYS_PushMethod)
print @maxId
 
INSERT INTO [SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'UpdatePrintTemplates', N'Update Print Templates', NULL, NULL, '1', '1', '1', NULL, NULL, '2', GETDATE(), @maxId + 1)