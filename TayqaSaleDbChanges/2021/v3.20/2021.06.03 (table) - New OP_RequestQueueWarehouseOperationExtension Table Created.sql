
CREATE TABLE [dbo].[OP_RequestQueueWarehouseOperationExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[FactoryNr] [smallint] NOT NULL,
	[WarehouseIn] [int] NULL,
	[DivisionIn] [smallint] NULL,
	[WarehouseOut] [int] NULL,
	[DivisionOut] [smallint] NULL,
 CONSTRAINT [PK_OP_RequestQueueWarehouseOperationExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_RequestQueueWarehouseOperationExtension] ADD  CONSTRAINT [DF_OP_RequestQueueWarehouseOperationExtension]  DEFAULT ((0)) FOR [PartNo]
GO


