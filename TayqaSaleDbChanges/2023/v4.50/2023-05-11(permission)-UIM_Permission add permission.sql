
declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Management.Reports')
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
           ,'Management.Reports.FieldOperations'
           ,'Management.Reports.FieldOperations'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,1
           ,3
           ,'WorkPlan'
           ,100
       ,@maxId+1)