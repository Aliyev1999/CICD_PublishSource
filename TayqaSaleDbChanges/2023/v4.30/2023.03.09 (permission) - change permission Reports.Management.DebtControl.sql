--delete old permission
delete from [UIM_Permission] where ObjectName='Reports.Management.DebtControl'
--Management.Reports.DebtControl
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'Management.Reports'

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
           ,'Management.Reports.DebtControl'
           ,'TSC-4295'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,1
           ,5
           ,'WorkPlan'
           ,100
           ,@newPermissionId)
GO