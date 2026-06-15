/****** Object:  Table [dbo].[OP_IncomingLogWarehouseOperationLineExtension]    Script Date: 7/2/2021 7:11:57 PM ******/

CREATE TABLE [dbo].[OP_IncomingLogWarehouseOperationLineExtension](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[Quantity] [float] NOT NULL
) ON [PRIMARY]
GO
