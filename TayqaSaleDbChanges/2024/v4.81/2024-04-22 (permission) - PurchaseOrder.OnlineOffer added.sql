
declare @parentId int;
declare @maxId int;

set @parentId = (select Id from UIM_Permission where ObjectName = 'PurchaseOrder');
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
           ,'PurchaseOrder.OnlineOffer'
           ,'TSC-5479'
           ,NULL
           ,2
           ,NULL
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,100
           ,@maxId + 1)
GO
