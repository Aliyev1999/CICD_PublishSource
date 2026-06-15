declare @parentId int;
declare @maxId int;

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Request.CreateEdit')
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission)
 
-- REQUEST BEGIN

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.Request.CreateEdit.AdditionalConfirm'
           ,'Inventory.Request.CreateEdit.AdditionalConfirm'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+1);

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Request.CreateEdit.AdditionalConfirm')

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.Request.CreateEdit.AdditionalConfirm.Info'
           ,'Inventory.Request.CreateEdit.AdditionalConfirm.Info'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+2);


INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.Request.CreateEdit.AdditionalConfirm.Filter'
           ,'Inventory.Request.CreateEdit.AdditionalConfirm.Filter'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+3);

-- REQUEST END

-- RETURN BEGIN

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Return.CreateEdit')
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission)
 
INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.Return.CreateEdit.AdditionalConfirm'
           ,'Inventory.Return.CreateEdit.AdditionalConfirm'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+1);
 
SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Return.CreateEdit.AdditionalConfirm');

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.Return.CreateEdit.AdditionalConfirm.Info'
           ,'Inventory.Return.CreateEdit.AdditionalConfirm.Info'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+2);
 

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.Return.CreateEdit.AdditionalConfirm.Filter'
           ,'Inventory.Return.CreateEdit.AdditionalConfirm.Filter'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+3);

-- RETURN END

SET @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.ConfirmInventoryDemand')
SET @maxId = (SELECT MAX(Id) FROM UIM_Permission)

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.ConfirmInventoryDemand.Info'
           ,'Inventory.ConfirmInventoryDemand.Info'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+1);


INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'Inventory.ConfirmInventoryDemand.Filter'
           ,'Inventory.ConfirmInventoryDemand.Filter'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,NULL
           ,5
           ,'Inventory'
           ,100
           ,@maxId+2);
GO