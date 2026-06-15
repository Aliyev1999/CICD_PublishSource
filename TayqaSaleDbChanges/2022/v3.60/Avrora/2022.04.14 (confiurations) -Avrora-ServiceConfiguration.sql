--Avrora

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
           ,'AdditionalParameters.AvroraOverrideOrderStatus'
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
---------------------------------------------------------------------------------------
set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AvroraOrderPriceTypeForResmi'
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
           ,2
           ,@maxId
           ,4)
---------------------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AvroraPreventNonLegalClientOrders'
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
           ,2
           ,@maxId
           ,4)
---------------------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AvroraSeperateLegalFacturaIntoPieces'
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
           ,2
           ,@maxId
           ,4)
---------------------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AvroraOrderMarkedForSeperationYashGuru'
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
           ,2
           ,@maxId
           ,4)
---------------------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AvroraLinesInLegalFactura'
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
           ,2
           ,@maxId
           ,4)

---------------------------------------------------------------------------------------

set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AvroraOrderPriceTypeForNonResmi'
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
           ,2
           ,@maxId
           ,4)
---------------------------------------------------------------------------------------
set @maxId=@maxId+1

INSERT INTO [dbo].[SYS_AppConfiurations]
           ([Id]
           ,[Key]
           ,[Type]
           ,[IsCombo])
     VALUES
           (@maxId
           ,'AdditionalParameters.AvroraTradingGroupForNoVat'
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
           ,2
           ,@maxId
           ,4)
---------------------------------------------------------------------------------------
GO

