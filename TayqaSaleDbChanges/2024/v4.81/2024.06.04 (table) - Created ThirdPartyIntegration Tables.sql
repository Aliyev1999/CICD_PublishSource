IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyIncomingLogWarehouseOperationExtension]') AND type in (N'U'))

BEGIN

CREATE TABLE [dbo].[OP_ThirdPartyIncomingLogWarehouseOperationExtension](
	[Id] [int] NOT NULL,
	[FactoryNr] [smallint] NOT NULL,
	[WarehouseIn] [int] NULL,
	[DivisionIn] [smallint] NULL,
	[WarehouseOut] [int] NULL,
	[DivisionOut] [smallint] NULL,
	[WarehouseType] [tinyint] NULL,
	[InputType] [nvarchar](50) NULL,
	[OutputType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

END
GO

