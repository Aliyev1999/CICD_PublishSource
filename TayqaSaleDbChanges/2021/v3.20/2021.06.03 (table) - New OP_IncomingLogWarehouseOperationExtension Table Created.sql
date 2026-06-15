/****** Object:  Table [dbo].[OP_IncomingLogWarehouseOperationExtension]    Script Date: 6/30/2021 12:44:51 PM ******/

CREATE TABLE [dbo].[OP_IncomingLogWarehouseOperationExtension](
	[Id] [int] NOT NULL,
	[FactoryNr] [smallint] NOT NULL,
	[WarehouseIn] [int] NULL,
	[DivisionIn] [smallint] NULL,
	[WarehouseOut] [int] NULL,
	[DivisionOut] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


