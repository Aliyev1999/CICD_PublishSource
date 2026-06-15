INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImCreatedTransferDemand'
           ,'Created Transfer Demand'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImTransferDemandConfirmed'
           ,'Transfer Demand Confirmed'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImTransferDemandPlanned'
           ,'Transfer Demand Planned'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImTransferDemandRestored'
           ,'Transfer Demand Restored'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImTransferDemandCancelled'
           ,'Transfer Demand Cancelled'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImTakenTransferTransportPackageFromClient'
           ,'Transfer Transport Package Taken FromClient'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO 

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImGivenTransportPackageToClient'
           ,'Transport Package To Client'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO

INSERT INTO [dbo].[SYS_PushMethod]
           ([Name]
           ,[Description]
           ,[ExtraInfo]
           ,[Url]
           ,[DataTypeId]
           ,[PushTypeId]
           ,[Status]
           ,[ModifiedUserId]
           ,[ModifiedDate]
           ,[CreatedUserId]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('ImTransferDemandRejected'
           ,'Inventory Transfer Demand Rejected'
           ,NULL
           ,NULL
           ,1
           ,3
           ,1
           ,NULL
           ,NULL
           ,2
           ,GETDATE()
           ,(SELECT MAX(ID)+1 FROM SYS_PushMethod))
GO