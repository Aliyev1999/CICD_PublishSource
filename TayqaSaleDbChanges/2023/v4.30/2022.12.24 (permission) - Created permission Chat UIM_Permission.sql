declare @parentId int;
declare @maxId int;

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
           (null
           ,'Chat'
           ,'Chat'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)
go

