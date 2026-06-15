INSERT INTO [dbo].[SYS_ModuleConfigObject]
           (Id,
			[ModuleName]
           ,[Name]
           ,[Description]
           ,[ValueFromTable]
           ,[AppRelevant]
           ,[ModifiedUserId]
           ,[ModifiedDate])
     VALUES
           (14
		   ,'Inventory'
           ,'NegativeControl'
           ,'Check Negative Control'
           ,0
           ,0
           ,NULL
           ,NULL)
GO

INSERT INTO [dbo].[SYS_ModuleConfigObject]
           (Id,
		    [ModuleName]
           ,[Name]
           ,[Description]
           ,[ValueFromTable]
           ,[AppRelevant]
           ,[ModifiedUserId]
           ,[ModifiedDate])
     VALUES
           (15
		   ,'Inventory'
           ,'CanReserve'
           ,'Can Reserve Inventory'
           ,0
           ,0
           ,NULL
           ,NULL)
GO