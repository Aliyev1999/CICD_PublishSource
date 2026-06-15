declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.UserMonitoring.Sale')
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
           ,'Management.UserMonitoring.Sale.Operations'
           ,'Management.UserMonitoring.Sale.Operations'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)

