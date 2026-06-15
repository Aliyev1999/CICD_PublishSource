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
           (null
           ,'ServiceOrder'
           ,'TSC-3799. Service Order'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.AuthCode'
           ,'TSC-3799. Service Order AuthCode'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO
  
declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.AuthCode')

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
           ,'ServiceOrder.AuthCode.Edit'
           ,'TSC-3799. Service Order AuthCode Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.AuthCode')

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
           ,'ServiceOrder.AuthCode.Select'
           ,'TSC-3799. Service Order AuthCode Select'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Cash'
           ,'TSC-3799. Service Order Cash'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Currency'
           ,'TSC-3799. Service Order Currency'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Currency')

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
           ,'ServiceOrder.Currency.Select'
           ,'TSC-3799. Service Order Currency Select'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Date'
           ,'TSC-3799. Service Order Date'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Date')

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
           ,'ServiceOrder.Date.Edit'
           ,'TSC-3799. Service Order Date Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.DeliveryDate'
           ,'TSC-3799. Service Order DeliveryDate'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.DeliveryDate')

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
           ,'ServiceOrder.DeliveryDate.Edit'
           ,'TSC-3799. Service Order DeliveryDate Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Division'
           ,'TSC-3799. Service Order Division'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Division')

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
           ,'ServiceOrder.Division.Select'
           ,'TSC-3799. Service Order Division Select'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.DocNumber'
           ,'TSC-3799. Service Order DocNumber'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.DocNumber')

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
           ,'ServiceOrder.DocNumber.Edit'
           ,'TSC-3799. Service Order DocNumber Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.DocTrackingNr'
           ,'TSC-3799. Service Order DocTrackingNr'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.DocTrackingNr')

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
           ,'ServiceOrder.DocTrackingNr.Edit'
           ,'TSC-3799. Service Order DocTrackingNr Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.EditDocument'
           ,'TSC-3799. Service Order EditDocument'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Email'
           ,'TSC-3799. Service Order Email'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Email')

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
           ,'ServiceOrder.Email.EmailBeforeErp'
           ,'TSC-3799. Service Order Email EmailBeforeErp'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.GpsRestriction'
           ,'TSC-3799. Service Order GpsRestriction'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.GpsRestriction')

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
           ,'ServiceOrder.GpsRestriction.CreateEdit'
           ,'TSC-3799. Service Order GpsRestriction CreateEdit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.GpsRestriction')

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
           ,'ServiceOrder.GpsRestriction.Edit'
           ,'TSC-3799. Service Order GpsRestriction Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.GpsRestriction')

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
           ,'ServiceOrder.GpsRestriction.IgnoreRouteOutside'
           ,'TSC-3799. Service Order GpsRestriction IgnoreRouteOutside'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Line'
           ,'TSC-3799. Service Order Line'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Line')

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
           ,'ServiceOrder.Line.Specode'
           ,'TSC-3799. Service Order Line Specode'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Line.Specode')

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
           ,'ServiceOrder.Line.Specode.Edit'
           ,'TSC-3799. Service Order Line Specode Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Line.Specode')

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
           ,'ServiceOrder.Line.Specode.Select'
           ,'TSC-3799. Service Order Line Specode Select'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.ManualLineDiscountAmount'
           ,'TSC-3799. Service Order Line ManualLineDiscountAmount'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.ManualLineDiscountPercent'
           ,'TSC-3799. Service Order Line ManualLineDiscountPercent'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.ManualPromo'
           ,'TSC-3799. Service Order Line ManualPromo'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.ManualTotalDiscountAmount'
           ,'TSC-3799. Service Order ManualTotalDiscountAmount'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.ManualTotalDiscountPercent'
           ,'TSC-3799. Service Order ManualTotalDiscountPercent'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Note'
           ,'TSC-3799. Service Order Note'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Note')

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
           ,'ServiceOrder.Note.Edit'
           ,'TSC-3799. Service Order Note Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Print'
           ,'TSC-3799. Service Order Print'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Print')

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
           ,'ServiceOrder.Print.BeforeErp'
           ,'TSC-3799. Service Order Print BeforeErp'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.RouteRestriction'
           ,'TSC-3799. Service Order RouteRestriction'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.RouteRestriction')

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
           ,'ServiceOrder.RouteRestriction.CreateEdit'
           ,'TSC-3799. Service Order RouteRestriction CreateEdit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Salesman'
           ,'TSC-3799. Service Order Salesman'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Salesman')

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
           ,'ServiceOrder.Salesman.Select'
           ,'TSC-3799. Service Order Salesman Select'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.ShareOnWhatsapp'
           ,'TSC-3799. Service Order ShareOnWhatsapp '
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.SpeCode'
           ,'TSC-3799. Service Order SpeCode'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.SpeCode')

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
           ,'ServiceOrder.SpeCode.Edit'
           ,'TSC-3799. Service Order SpeCode Edit'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.SpeCode')

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
           ,'ServiceOrder.SpeCode.Select'
           ,'TSC-3799. Service Order SpeCode Select'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder')

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
           ,'ServiceOrder.Status'
           ,'TSC-3799. Service Order Status'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO

declare @parentId int=(SELECT Id FROM UIM_Permission WHERE ObjectName='ServiceOrder.Status')

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
           ,'ServiceOrder.Status.Select'
           ,'TSC-3799. Service Order Status Select'
           ,null
           ,2
           ,null
           ,GETDATE()
           ,null
           ,5
           ,'Sale'
           ,100
           ,(SELECT MAX(Id)+1 FROM UIM_Permission))
GO