--Superfon

declare @maxId int
declare @maxMapId int

set @maxId=(select max(Id) from SYS_AppConfiurations)+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.EnableThirdPartyApiControlReturnOperation'
           ,3
           ,0)

set @maxMapId=(select max(Id) from SYS_ServiceConfigMapping)+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyApiControlReturnOperationGetControlDataApiUrl'
           ,1
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyApiControlReturnOperationPostResultApiUrl'
           ,1
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)


-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyApiControlReturnOperationSpecodeFilter'
           ,1
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyApiControlLogHttpRequest'
           ,3
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyApiControlLogHttpResponse'
           ,3
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)


-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyApiControlHttpClientTimeout'
           ,2
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyIntegrationSpecodeFilter'
           ,1
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ThirdPartyIntegrationCashOutSpecodeFilter'
           ,1
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)


-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.OrderByFilterForReturnInvoice'
           ,1
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.DisableReturnOperationBySpecode'
           ,3
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.ConfirmReturnOperationSpecode'
           ,3
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

-----------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.BrokenReturnOperationSpecode'
           ,3
           ,0)

set @maxMapId=@maxMapId+1

INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxMapId
           ,7
           ,@maxId
           ,4)

