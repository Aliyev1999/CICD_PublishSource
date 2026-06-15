DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.InternalThirdParty.ConfirmOrReject');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Management.InternalThirdParty.ConfirmOrReject.Reject', 'TSC-5975', NULL, 2, NULL, GETDATE(), 1, 6, 'Sale', 100, @maxId + 1);

GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.InternalThirdParty.ConfirmOrReject.Reject');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Management.InternalThirdParty.ConfirmOrReject.Reject.SelectReason', 'TSC-5975', NULL, 2, NULL, GETDATE(), 1, 6, 'Sale', 100, @maxId + 1);
		   
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.InternalThirdParty.ConfirmOrReject.Reject.SelectReason');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Management.InternalThirdParty.ConfirmOrReject.Reject.SelectReason.Mandatory', 'TSC-5975', NULL, 2, NULL, GETDATE(), 1, 6, 'Sale', 100, @maxId + 1);
		   
GO


DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.InternalThirdParty.ConfirmOrReject');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Management.InternalThirdParty.ConfirmOrReject.Cancel', 'TSC-5975', NULL, 2, NULL, GETDATE(), 1, 6, 'Sale', 100, @maxId + 1);

GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.InternalThirdParty.ConfirmOrReject.Cancel');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Management.InternalThirdParty.ConfirmOrReject.Cancel.SelectReason', 'TSC-5975', NULL, 2, NULL, GETDATE(), 1, 6, 'Sale', 100, @maxId + 1);
		   
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.InternalThirdParty.ConfirmOrReject.Cancel.SelectReason');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Management.InternalThirdParty.ConfirmOrReject.Cancel.SelectReason.Mandatory', 'TSC-5975', NULL, 2, NULL, GETDATE(), 1, 6, 'Sale', 100, @maxId + 1);
		   
GO

DECLARE @parentId INT;
DECLARE @maxId INT;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Cash');
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate],
		    [CreatedDate], [OnlyHybridUser], [LicenseUserType], [Module], [OrderNo], [Id])
     VALUES
           (@parentId, 'Cash.BarcodeInput', 'TSC-5961', NULL, 2, NULL, GETDATE(), NULL, 5, 'Sale', 100, @maxId + 1);