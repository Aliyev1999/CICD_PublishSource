INSERT INTO [dbo].[SYS_UserActionType]
           ([Type]
           ,[Description]
           ,[Status]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('Inventory'
           ,'Inventory'
           ,1
           ,GETDATE()
           ,31)
GO

INSERT INTO [dbo].[SYS_UserActionType]
           ([Type]
           ,[Description]
           ,[Status]
           ,[CreatedDate]
           ,[Id])
     VALUES
           ('Workplan'
           ,'Workplan'
           ,1
           ,GETDATE()
           ,32)
GO