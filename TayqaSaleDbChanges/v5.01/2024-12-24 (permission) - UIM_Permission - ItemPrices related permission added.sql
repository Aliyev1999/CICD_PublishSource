DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Reports.General.ItemPrices');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Reports.General.ItemPrices.Download', 'TSC-5888', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Reports.General.ItemPrices');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Reports.General.ItemPrices.Share', 'TSC-5888', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Reports.General.ItemPrices.Share');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Reports.General.ItemPrices.Share.Email', 'TSC-5888', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);
GO
DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Reports.General.ItemPrices.Share');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Reports.General.ItemPrices.Share.Whatsapp', 'TSC-5888', 2, GETDATE(), 5, 'Sale', 100, @maxId + 1);
GO