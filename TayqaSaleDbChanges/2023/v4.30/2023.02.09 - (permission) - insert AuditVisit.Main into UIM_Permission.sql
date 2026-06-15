delete from [UIM_Permission] where ObjectName = 'AuditVisit.Main'
GO

--AuditVisit.Main
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'AuditVisit'

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
           ,'AuditVisit.Main'
           ,'TSC-3872.AuditVisit.Main'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,100
           ,@newPermissionId)
GO