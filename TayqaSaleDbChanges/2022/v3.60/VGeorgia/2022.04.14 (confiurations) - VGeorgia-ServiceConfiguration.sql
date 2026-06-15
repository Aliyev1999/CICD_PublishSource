--VGeoriga

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
           ,'AdditionalParameters.SetSpecialReturnPrice'
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
           ,'AdditionalParameters.VeyselogluIgnoreDocNumberSetting'
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
           ,11
           ,@maxId
           ,4)

