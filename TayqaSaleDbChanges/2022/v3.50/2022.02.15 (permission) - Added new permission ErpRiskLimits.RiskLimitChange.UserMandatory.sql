declare @parentId int;
declare @maxId int;
set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'ErpRiskLimits.RiskLimitChange')
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
           ,'ErpRiskLimits.RiskLimitChange.UserMandatory'
           ,'ErpRiskLimits.RiskLimitChange.UserMandatory'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'ErpRiskLimits'
           ,100
           ,@maxId + 1)




