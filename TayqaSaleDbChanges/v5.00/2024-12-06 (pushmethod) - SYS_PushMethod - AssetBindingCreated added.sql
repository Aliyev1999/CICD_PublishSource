DECLARE  @id SMALLINT = (select max(Id) from SYS_PushMethod)
insert into SYS_PushMethod (Name, Description, ExtraInfo, Url, DataTypeId, PushTypeId, Status, CreatedUserId, CreatedDate, Id)
values('AssetBindingCreated', 'Asset binding created', null, null, 1, 3, 1, 2, GETDATE(), @id + 1)

go