declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'SaleInvoice');
set @maxId = (select Max(Id) from UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
           ([ParentId]
           ,[ObjectName]
           ,[Description]
           ,[ModifiedUserId]
           ,[CreatedUserId]
           ,[ModifiedDate]
           ,[CreatedDate]
           ,[OnlyHybridUser]
           ,[LicenseUserType]
           ,[Module]
           ,[OrderNo]
           ,[Id])
     VALUES
           (@parentId
           ,'SaleInvoice.OnlineItemList'
           ,'TSC-5252. SaleInvoice.OnlineItemList'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)
GO
