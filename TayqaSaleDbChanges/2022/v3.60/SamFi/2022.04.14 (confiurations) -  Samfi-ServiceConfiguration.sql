--SamFi

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
           ,'AdditionalParameters.CheckDebtLimit'
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
           ,'AdditionalParameters.SmafiOrderSpecode'
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
           ,'AdditionalParameters.SamfiReturnDispatchSpecode'
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
           ,'AdditionalParameters.CheckUnPaidBillControl'
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
           ,'AdditionalParameters.SetProcessDateToTheNextDayIfWorkHourIsOver'
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