--Sale.Filter.Specode
--Sale.Filter.AuthCode

declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Sale')
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
           ,'Sale.Filter'
           ,'Sale Filter'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Sale.Filter')
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
           ,'Sale.Filter.Specode'
           ,'Sale Filter Specode'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)

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
           ,'Sale.Filter.AuthCode'
           ,'Sale Filter AuthCode'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)