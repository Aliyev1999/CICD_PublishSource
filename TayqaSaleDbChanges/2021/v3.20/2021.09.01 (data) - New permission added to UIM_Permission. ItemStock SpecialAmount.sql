declare @parentId int;
declare @maxId int;

SET @parentId=(SELECT Id FROM UIM_Permission WHERE ObjectName='Reports.General.ItemStock');
SET @maxId=(SELECT MAX(Id) FROM UIM_Permission);

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
           ,'Reports.General.ItemStock.SpecialStock'
           ,'Reports.General.ItemStock.SpecialStock'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@maxId+1)
GO

