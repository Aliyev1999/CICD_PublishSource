DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Reports.General');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Reports.General.PhotoGallery', '', 2, GETDATE(), 6, 'Sale', null);

go

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Reports.General.PhotoGallery');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Reports.General.PhotoGallery.ListView', '', 2, GETDATE(), 6, 'Sale', null);

go

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Reports.General.PhotoGallery');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Reports.General.PhotoGallery.GridView', '', 2, GETDATE(), 6, 'Sale', null);

go

