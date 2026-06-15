CREATE TABLE [dbo].[IM_WarehouseTransfer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[FromDivision] [smallint] NOT NULL,
	[ToDivision] [smallint] NOT NULL,
	[FromWarehouse] [int] NOT NULL,
	[ToWarehouse] [int] NOT NULL,
	[ReceiverUserId] [int] NOT NULL,
	[ActNumber] [nvarchar](250) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[CompletedDate] [datetime] NULL,
	[CompletedUserId] [bigint] NULL,
	[Status] [tinyint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK_IM_WarehouseTransfer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_IM_WarehouseTransfer_ActNumber] UNIQUE NONCLUSTERED 
(
	[ActNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_WarehouseTransfer] ADD  CONSTRAINT [DF_IM_WarehouseTransfer_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[IM_WarehouseTransfer] ADD  CONSTRAINT [DF_IM_WarehouseTransfer_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[IM_WarehouseTransfer] ADD  CONSTRAINT [DF_IM_WarehouseTransfer_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

----------------

CREATE TABLE [dbo].[IM_WarehouseTransferLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseTransferId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[SelectedCount] [int] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
 CONSTRAINT [PK_IM_WarehouseTransferLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Index [IX_IM_WarehouseTransferLine_ItemId_WarehouseTransferId]    Script Date: 23.12.2022 11:32:11 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IM_WarehouseTransferLine_ItemId_WarehouseTransferId] ON [dbo].[IM_WarehouseTransferLine]
(
	[ItemId] ASC,
	[WarehouseTransferId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_WarehouseTransferLine] ADD  CONSTRAINT [DF_IM_WarehouseTransferLine_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO


----------------



CREATE TABLE [dbo].[IM_WarehouseTransferLineInventory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NOT NULL,
	[WarehouseTransferId] [int] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_IM_WarehouseTransferLineInventory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Index [IX_IM_WarehouseTransferLineInventory_ItemId_InventoryId_WarehouseTransferId]    Script Date: 23.12.2022 11:34:58 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IM_WarehouseTransferLineInventory_ItemId_InventoryId_WarehouseTransferId] ON [dbo].[IM_WarehouseTransferLineInventory]
(
	[ItemId] ASC,
	[InventoryId] ASC,
	[WarehouseTransferId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_WarehouseTransferLineInventory] ADD  CONSTRAINT [DF_IM_WarehouseTransferLineInventory_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

