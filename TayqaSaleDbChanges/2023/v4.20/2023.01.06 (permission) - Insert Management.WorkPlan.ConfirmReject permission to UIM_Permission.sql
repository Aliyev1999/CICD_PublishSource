--Management.WorkPlan.ConfirmReject
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'Management.WorkPlan'

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
           ,'Management.WorkPlan.ConfirmReject'
           ,'Management WorkPlan ConfirmReject'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,1
           ,6
           ,'Sale'
           ,100
           ,@newPermissionId)
GO