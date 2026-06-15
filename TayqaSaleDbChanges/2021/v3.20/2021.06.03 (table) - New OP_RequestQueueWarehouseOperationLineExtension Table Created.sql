/****** Object:  Table [dbo].[OP_RequestQueueWarehouseOperationLineExtension]    Script Date: 7/2/2021 7:12:40 PM ******/

CREATE TABLE [dbo].[OP_RequestQueueWarehouseOperationLineExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[Quantity] [float] NOT NULL
) ON [PRIMARY]
GO
