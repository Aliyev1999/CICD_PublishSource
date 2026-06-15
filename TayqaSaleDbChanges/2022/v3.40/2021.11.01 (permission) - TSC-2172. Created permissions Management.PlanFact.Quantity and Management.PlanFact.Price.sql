declare @parentId int;
declare @maxId int;
set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.PlanFact')
set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Management.PlanFact.Quantity'
           ,'Management.PlanFact.Quantity'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,3
           ,'Sale'
           ,100
           ,@maxId + 1)

set @maxId= (SELECT MAX(Id) FROM UIM_Permission)

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
           ,'Management.PlanFact.Amount'
           ,'Management.PlanFact.Amount'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,3
           ,'Sale'
           ,100
           ,@maxId + 1)




