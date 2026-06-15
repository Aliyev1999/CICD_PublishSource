declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName='Reports.General');
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
           ,'Reports.General.DebtControl'
           ,'TSC-3882'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)
GO


