declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName='WorkPlan')
set @maxId = (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'WorkPlan.Clients'
           ,'WorkPlan Clients'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,4
           ,'Workplan'
           ,100
           ,@maxId+1)
GO

