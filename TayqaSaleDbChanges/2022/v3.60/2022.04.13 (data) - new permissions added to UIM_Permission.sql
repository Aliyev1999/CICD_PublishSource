DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.Reports.SalesTotal');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Management.Reports.SalesTotal.Division', '', 2, GETDATE(), 3, 'Sale', 1);

go

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Management.Reports.SalesmenFinalizedItemCirculation');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Management.Reports.SalesmenFinalizedItemCirculation.Division', '', 2, GETDATE(), 3, 'Sale', 1);

go

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Reports.General.DailySaleRelatedActions');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Reports.General.DailySaleRelatedActions.Division', '', 2, GETDATE(), 3, 'Sale', 0);

go

DECLARE @maxId INT = (SELECT MAX(Id) FROM UIM_Permission);

DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Reports.General.SaleActions');

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OnlyHybridUser)
VALUES (@maxId + 1, @parentId, N'Reports.General.SaleActions.Division', '', 2, GETDATE(), 3, 'Sale', 0);

go
