GO

/****** Object:  Table [dbo].[IM_InventoryNotFoundOperation]    Script Date: 11.06.2021 12:48:04 ******/

CREATE TABLE [dbo].[IM_InventoryNotFoundOperation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[CreatorUserId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientTigerId] [int] NOT NULL,
	[CreatorReasonId] [int] NOT NULL,
	[CreatorNote] [nvarchar](1000) NULL,
	[AuditorUserId] [int] NULL,
	[AuditorReasonId] [int] NULL,
	[AuditorNote] [nvarchar](1000) NULL,
	[AuditorUpdateDate] [datetime] NULL,
	[FinancerUserId] [int] NULL,
	[FinancerReasonId] [int] NULL,
	[FinancerNote] [nvarchar](1000) NULL,
	[FinancerUpdateDate] [datetime] NULL,
	[PenaltyAmount] [float] NULL,
	[ActNumber] [nvarchar](100) NULL,
 CONSTRAINT [PK_IM_InventoryNotFoundOperation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_IM_OperationInventoryNotFound_UId] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_InventoryNotFoundOperation] ADD  CONSTRAINT [DF_IM_InventoryNotFoundOperation_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[IM_InventoryNotFoundOperation]  WITH CHECK ADD  CONSTRAINT [FK_IM_InventoryNotFoundOperation_InventoryId] FOREIGN KEY([InventoryId])
REFERENCES [dbo].[IM_Inventory] ([Id])
GO

ALTER TABLE [dbo].[IM_InventoryNotFoundOperation] CHECK CONSTRAINT [FK_IM_InventoryNotFoundOperation_InventoryId]
GO



GO

/****** Object:  Table [dbo].[IM_InventoryNotFoundOperationImage]    Script Date: 11.06.2021 12:48:37 ******/

CREATE TABLE [dbo].[IM_InventoryNotFoundOperationImage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImagePath] [nvarchar](max) NOT NULL,
	[InventoryNotFoundOperationId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatorUserId] [int] NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_IM_OperationInventoryNotFoundImage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_InventoryNotFoundOperationImage] ADD  CONSTRAINT [DF_IM_InventoryNotFoundOperationImage_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[IM_InventoryNotFoundOperationImage] ADD  CONSTRAINT [DF_IM_InventoryNotFoundOperationImage_Status]  DEFAULT ((0)) FOR [Status]
GO

ALTER TABLE [dbo].[IM_InventoryNotFoundOperationImage]  WITH CHECK ADD  CONSTRAINT [FK_IM_InventoryNotFoundOperation_InventoryNotFoundOperationId] FOREIGN KEY([InventoryNotFoundOperationId])
REFERENCES [dbo].[IM_InventoryNotFoundOperation] ([Id])
GO

ALTER TABLE [dbo].[IM_InventoryNotFoundOperationImage] CHECK CONSTRAINT [FK_IM_InventoryNotFoundOperation_InventoryNotFoundOperationId]
GO
