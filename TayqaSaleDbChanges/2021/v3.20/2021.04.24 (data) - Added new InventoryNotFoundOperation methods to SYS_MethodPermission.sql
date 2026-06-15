
INSERT INTO [dbo].[SYS_MethodPermission]
           ([MethodId]
           ,[PermissionId]
           ,[PermissionValue]
           ,[Description]
           ,[CreatedDate])
     VALUES
           (1052
           ,67
           ,1
           ,'CreateInventoryNotFoundOperation'
           ,GETDATE())
GO

INSERT INTO [dbo].[SYS_MethodPermission]
           ([MethodId]
           ,[PermissionId]
           ,[PermissionValue]
           ,[Description]
           ,[CreatedDate])
     VALUES
           (1053
           ,67
           ,1
           ,'UpdateInventoryNotFoundOperationByAuditor'
           ,GETDATE())
GO

INSERT INTO [dbo].[SYS_MethodPermission]
           ([MethodId]
           ,[PermissionId]
           ,[PermissionValue]
           ,[Description]
           ,[CreatedDate])
     VALUES
           (1054
           ,67
           ,1
           ,'GetInventoryNotFoundOperationList'
           ,GETDATE())
GO
