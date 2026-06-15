declare @parentId int;
declare @maxId int;

set @parentId = (select Id
                 from UIM_Permission
                 where ObjectName = 'Delivery');
set @maxId = (select Max(Id)
              from UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
( [ParentId]
, [ObjectName]
, [Description]
, [ModifiedUserId]
, [CreatedUserId]
, [ModifiedDate]
, [CreatedDate]
, [OnlyHybridUser]
, [LicenseUserType]
, [Module]
, [OrderNo]
, [Id])
VALUES ( @parentId
       , 'Delivery.Main'
       , 'TSC-4275'
       , null
       , 2
       , null
       , GETDATE()
       , null
       , 5
       , 'Delivery'
       , 23
       , @maxId + 1)
GO

declare @parentId int;
declare @maxId int;

set @parentId = (select Id
                 from UIM_Permission
                 where ObjectName = 'WarehouseOperation');
set @maxId = (select Max(Id)
              from UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
( [ParentId]
, [ObjectName]
, [Description]
, [ModifiedUserId]
, [CreatedUserId]
, [ModifiedDate]
, [CreatedDate]
, [OnlyHybridUser]
, [LicenseUserType]
, [Module]
, [OrderNo]
, [Id])
VALUES ( @parentId
       , 'WarehouseOperation.TransferPrint'
       , 'TSC-4236'
       , null
       , 2
       , null
       , GETDATE()
       , null
       , 3
       , 'Sale'
       , 0
       , @maxId + 1)
GO

declare @parentId int;
declare @maxId int;

set @parentId = (select Id
                 from UIM_Permission
                 where ObjectName = 'Reports.Management');
set @maxId = (select Max(Id)
              from UIM_Permission);

INSERT INTO [dbo].[UIM_Permission]
( [ParentId]
, [ObjectName]
, [Description]
, [ModifiedUserId]
, [CreatedUserId]
, [ModifiedDate]
, [CreatedDate]
, [OnlyHybridUser]
, [LicenseUserType]
, [Module]
, [OrderNo]
, [Id])
VALUES ( @parentId
       , 'Reports.Management.DebtControl'
       , 'TSC-4295'
       , null
       , 2
       , null
       , GETDATE()
       , null
       , 5
       , 'Sale'
       , 100
       , @maxId + 1)
GO