go
begin
DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Checklist.Survey.DirectSend');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Checklist.Survey.DirectSend.TemporarySave', 'TSC-6476', 2, GETDATE(), 4, 'Checklist', 100, @maxId + 1);
end

go
begin
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);
INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (null, 'RecordScreenLog', 'RecordScreenLog', 2, GETDATE(), 6, 'Sale', 100, @maxId + 1);
end

go

begin
DECLARE @parentId INT = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Inventory.UpdateStatus.CreateEdit');
DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO UIM_Permission(ParentId, ObjectName, [Description], CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
VALUES (@parentId, 'Inventory.UpdateStatus.CreateEdit.BarcodeExistence', 'TSC-6543', 2, GETDATE(), 6, 'Inventory', 100, @maxId + 1);
end
GO

