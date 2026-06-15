INSERT INTO [dbo].[SYS_MethodPermission]
           ([MethodId]
           ,[PermissionId]
           ,[PermissionValue]
           ,[Description]
           ,[CreatedDate])
     VALUES
           (1055
           ,67
           ,1
           ,'CheckInventoryOperation'
           ,GETDATE())
GO


INSERT INTO [dbo].[SYS_MethodPermission]
           ([MethodId]
           ,[PermissionId]
           ,[PermissionValue]
           ,[Description]
           ,[CreatedDate])
     VALUES
           (1058
           ,67
           ,1
           ,'GetInventoryCheckOperationList'
           ,GETDATE())
GO

INSERT INTO [dbo].[SYS_MethodPermission]
           ([MethodId]
           ,[PermissionId]
           ,[PermissionValue]
           ,[Description]
           ,[CreatedDate])
     VALUES
           (1059
           ,67
           ,1
           ,'GetInventoryCheckOperationClientList'
           ,GETDATE())
GO