declare @parentId int = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Reports.Client.Statements');
declare @maxId int = (SELECT MAX(Id) FROM UIM_Permission);

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
           ,'Reports.Client.Statements.ScanFile'
           ,'Reports.Client.Statements.ScanFile'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,0
           ,@maxId +1)
GO

