declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'AuditVisit');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'AuditVisit.ClientGroup'
           ,'TSC-5565'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,0
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)
GO


declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'AuditVisit.ClientGroup');
set @maxId = (select Max(Id) from UIM_Permission);

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
           ,'AuditVisit.ClientGroup.Create'
           ,'TSC-5565'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,0
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)
GO