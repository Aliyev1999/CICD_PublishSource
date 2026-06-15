IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyRequestQueueWarehouseOperationLineExtension]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[OP_ThirdPartyRequestQueueWarehouseOperationLineExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[Quantity] [float] NOT NULL
) ON [PRIMARY]
END
GO