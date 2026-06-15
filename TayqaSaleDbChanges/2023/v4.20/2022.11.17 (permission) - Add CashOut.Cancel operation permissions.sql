--Cash.Cancel.MandatoryReason
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'Cash.Cancel'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'Cash.Cancel.MandatoryReason'
           ,'TSC-4115.Cash.Cancel.MandatoryReason'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@newPermissionId)
GO


--CashOut.Cancel.MandatoryReason
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'CashOut.Cancel'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'CashOut.Cancel.MandatoryReason'
           ,'TSC-4115.CashOut.Cancel.MandatoryReason'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@newPermissionId)
GO

--Order.Cancel.MandatoryReason
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'Order.Cancel'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'Order.Cancel.MandatoryReason'
           ,'TSC-4115.Order.Cancel.MandatoryReason'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@newPermissionId)
GO

--ReturnDispatch.Cancel.MandatoryReason
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'ReturnDispatch.Cancel'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'ReturnDispatch.Cancel.MandatoryReason'
           ,'TSC-4115.Order.ReturnDispatch.Cancel.MandatoryReason'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@newPermissionId)
GO

--ReturnInvoice.Cancel.MandatoryReason
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'ReturnInvoice.Cancel'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'ReturnInvoice.Cancel.MandatoryReason'
           ,'TSC-4115.Order.ReturnInvoice.Cancel.MandatoryReason'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@newPermissionId)
GO

--SaleDispatch.Cancel.MandatoryReason
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'SaleDispatch.Cancel'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'SaleDispatch.Cancel.MandatoryReason'
           ,'TSC-4115.Order.SaleDispatch.Cancel.MandatoryReason'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@newPermissionId)
GO

--SaleInvoice.Cancel.MandatoryReason
--Parent id declaration
declare @parentId as smallint
select @parentId=Id
from [UIM_Permission] where ObjectName = 'SaleInvoice.Cancel'

--Permisson id declartion
declare @newPermissionId as smallint
select @newPermissionId= max(Id)+1
from [UIM_Permission]


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
           ,'SaleInvoice.Cancel.MandatoryReason'
           ,'TSC-4115.Order.SaleInvoice.Cancel.MandatoryReason'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,NULL
           ,5
           ,'Sale'
           ,2
           ,@newPermissionId)
GO