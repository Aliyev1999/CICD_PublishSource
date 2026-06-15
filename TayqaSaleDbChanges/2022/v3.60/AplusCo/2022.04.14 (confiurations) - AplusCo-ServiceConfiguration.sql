--AplusCo

declare @maxId int
set @maxId=(select max(Id) from SYS_AppConfiurations)+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AplusCoSetDocProcessDate'
           ,3
           ,0)



set @maxId=(select max(Id) from SYS_AppConfiurations)+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AplusCoDocLastProcessDate'
           ,1
           ,0)


set @maxId=(select max(Id) from SYS_AppConfiurations)+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.CheckRiskLimit'
           ,3
           ,0)
GO


declare @maxId int
declare @configId int

set @maxId=(select max(Id) from SYS_ServiceConfigMapping)+1
set @configId= (select Id from SYS_AppConfiurations where [Key]='AdditionalParameters.AplusCoSetDocProcessDate')


INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxId
           ,7
           ,@configId
           ,4)


set @maxId=(select max(Id) from SYS_ServiceConfigMapping)+1
set @configId= (select Id from SYS_AppConfiurations where [Key]='AdditionalParameters.AplusCoDocLastProcessDate')


INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxId
           ,7
           ,@configId
           ,4)

set @maxId=(select max(Id) from SYS_ServiceConfigMapping)+1
set @configId= (select Id from SYS_AppConfiurations where [Key]='AdditionalParameters.CheckRiskLimit')


INSERT INTO [dbo].[SYS_ServiceConfigMapping]
           ([Id]
           ,[ServiceId]
           ,[ConfigId]
           ,[VersionId])
     VALUES
           (@maxId
           ,7
           ,@configId
           ,4)
GO
