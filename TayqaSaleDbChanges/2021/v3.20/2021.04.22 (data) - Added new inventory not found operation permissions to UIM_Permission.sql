
declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation'
           ,'Inventory Operation'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)
GO


declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.NotFound'
           ,'Inventory Operation NotFound' 
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)
GO

declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation.NotFound')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.NotFound.CreateEdit'
           ,'Inventory Operation NotFound CreateEdit' 
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@maxId+1)
GO

declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation.NotFound')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.NotFound.Audit'
           ,'Inventory.Operation.NotFound.Audit' 
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Inventory'
           ,100
           ,@maxId+1)
GO

declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation.NotFound.Audit')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.NotFound.Audit.CreateEdit'
           ,'Inventory.Operation.NotFound.Audit.CreateEdit' 
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Inventory'
           ,100
           ,@maxId+1)        
GO

declare @parentId int =(SELECT Id FROM UIM_Permission WHERE ObjectName='Inventory.Operation.NotFound.Audit')
declare @maxId int = (SELECT Max(Id) FROM UIM_Permission)

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
           ,'Inventory.Operation.NotFound.Audit.AllowToFinishWithoutPhoto'
           ,'Inventory.Operation.NotFound.Audit.AllowToFinishWithoutPhoto' 
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,3
           ,'Inventory'
           ,100
           ,@maxId+1)
GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.Operation.NotFound')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.Operation.NotFound.Requester', N'', 2, getdate(), 6, N'Inventory', 0, @maxId+1);

SET @parentId = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Inventory.Operation.NotFound.Requester')

insert into dbo.UIM_Permission (ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module, OrderNo, Id)
values (@parentId, N'Inventory.Operation.NotFound.Requester.CreateEdit', N'', 2, getdate(), 6, N'Inventory', 0, @maxId+2);
GO

delete from UIM_Permission where ObjectName ='Inventory.Operation.NotFound.CreateEdit';

GO