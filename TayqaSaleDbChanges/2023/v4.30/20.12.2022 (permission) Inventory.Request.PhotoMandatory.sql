--Inventory.Return.CreateEdit.PhotoMandatory
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'Inventory.Return.CreateEdit'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'Inventory.Return.CreateEdit.PhotoMandatory'
           ,'TSC-4008.Inventory.Return.CreateEdit.PhotoMandatory'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@newPermissionId)
GO

--Inventory.Request.CreateEdit.PhotoMandatory
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'Inventory.Request.CreateEdit'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'Inventory.Request.CreateEdit.PhotoMandatory'
           ,'TSC-4008.Inventory.Request.CreateEdit.PhotoMandatory'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,6
           ,'Inventory'
           ,100
           ,@newPermissionId)
GO