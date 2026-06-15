declare @parentId int;
declare @maxId int;

set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'Checklist.Survey.Question')
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
           ,'Checklist.Survey.Question.ImageReason'
           ,'Checklist.Survey.Question.ImageReason'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,null
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)
               

