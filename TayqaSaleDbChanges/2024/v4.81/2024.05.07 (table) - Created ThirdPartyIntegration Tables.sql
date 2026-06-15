IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyRequestQueueWarehouseOperationExtension]') AND type in (N'U'))

BEGIN

CREATE TABLE [dbo].[OP_ThirdPartyRequestQueueWarehouseOperationExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[FactoryNr] [smallint] NOT NULL,
	[WarehouseIn] [int] NULL,
	[DivisionIn] [smallint] NULL,
	[WarehouseOut] [int] NULL,
	[DivisionOut] [smallint] NULL,
	[WarehouseType] [tinyint] NULL,
	[InputType] [nvarchar](50) NULL,
	[OutputType] [nvarchar](50) NULL,
 CONSTRAINT [PK_OP_ThirdPartyRequestQueueWarehouseOperationExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
))

ALTER TABLE [dbo].[OP_ThirdPartyRequestQueueWarehouseOperationExtension] ADD  CONSTRAINT [DF_OP_ThirdPartyRequestQueueWarehouseOperationExtension]  DEFAULT ((0)) FOR [PartNo]

END

GO