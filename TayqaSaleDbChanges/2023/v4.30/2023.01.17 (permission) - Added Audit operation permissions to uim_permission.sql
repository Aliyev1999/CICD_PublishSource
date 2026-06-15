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
           ,'AuditVisit'
           ,'TSC-3871.AuditVisit'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit')
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
           ,'AuditVisit.ActNo'
           ,'TSC-3871.AuditVisit.ActNo'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)


set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit.ActNo')
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
           ,'AuditVisit.ActNo.IgnoreMandatoryText'
           ,'TSC-3871.AuditVisit.ActNo.IgnoreMandatoryText'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)





set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit')
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
           ,'AuditVisit.DateEdit'
           ,'TSC-3871.AuditVisit.DateEdit'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)




set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit')
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
           ,'AuditVisit.GpsRestriction'
           ,'TSC-3871.AuditVisit.GpsRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit.GpsRestriction')
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
           ,'AuditVisit.GpsRestriction.CreateEdit'
           ,'TSC-3871.AuditVisit.GpsRestriction.CreateEdit'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit.GpsRestriction')
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
           ,'AuditVisit.GpsRestriction.IgnoreRouteOutside'
           ,'TSC-3871.AuditVisit.GpsRestriction.IgnoreRouteOutside'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)




set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit')
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
           ,'AuditVisit.IgnoreMandatoryPhoto'
           ,'TSC-3871.AuditVisit.IgnoreMandatoryPhoto'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit')
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
           ,'AuditVisit.Main'
           ,'TSC-3872.AuditVisit.Main'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit')
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
           ,'AuditVisit.RouteRestriction'
           ,'TSC-3871.AuditVisit.RouteRestriction'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit')
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
           ,'AuditVisit.Statements'
           ,'TSC-3871.AuditVisit.Statements'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)



set @parentId = (SELECT Id FROM UIM_Permission WHERE ObjectName = 'AuditVisit.RouteRestriction')
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
           ,'AuditVisit.RouteRestriction.CreateEdit'
           ,'TSC-3871.AuditVisit.RouteRestriction.CreateEdit'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,6
           ,'Sale'
           ,100
           ,@maxId + 1)