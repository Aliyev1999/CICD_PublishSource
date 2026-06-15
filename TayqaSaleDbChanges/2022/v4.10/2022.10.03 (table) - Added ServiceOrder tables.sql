CREATE TABLE [dbo].[OP_IncomingLogServiceExtension](
	[Id] [int] NOT NULL,
	[DocTrackingValue] [nvarchar](50) NULL,
	[DeliveryDate] [datetime] NULL,
	[DiscountAmount] [float] NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountPercent3] [float] NULL,
 CONSTRAINT [PK_OP_IncomingLogServiceExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OP_IncomingLogServiceLineExtension](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[Amount] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[ActionSpecode] [nvarchar](255) NULL,
	[AdditionalFields] [nvarchar](max) NULL,
	[IsPromo] [bit] NOT NULL,
	[DiscountAmount] [float] NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountPercent3] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Index [IX_OP_IncomingLogCommonSeviceLineExtension_Id]    Script Date: 03.10.2022 15:56:41 ******/
CREATE NONCLUSTERED INDEX [IX_OP_IncomingLogCommonSeviceLineExtension_Id] ON [dbo].[OP_IncomingLogServiceLineExtension]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_IncomingLogServiceLineExtension] ADD  CONSTRAINT [DF_OP_IncomingLogServiceLineExtension_IsPromo]  DEFAULT ((0)) FOR [IsPromo]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'It is JSON column' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OP_IncomingLogServiceLineExtension', @level2type=N'COLUMN',@level2name=N'AdditionalFields'
GO
 

CREATE TABLE [dbo].[OP_RequestQueueServiceExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[DocTrackingValue] [nvarchar](50) NULL,
	[DeliveryDate] [datetime] NULL,
	[DiscountAmount] [float] NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountPercent3] [float] NULL,
 CONSTRAINT [PK_OP_RequestQueueServiceExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_RequestQueueServiceExtension] ADD  CONSTRAINT [DF_OP_RequestQueueServiceExtension_PartNo]  DEFAULT ((0)) FOR [PartNo]
GO
 

CREATE TABLE [dbo].[OP_RequestQueueServiceLineExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[Amount] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[ActionSpecode] [nvarchar](255) NULL,
	[AdditionalFields] [nvarchar](max) NULL,
	[DiscountAmount] [float] NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountPercent3] [float] NULL,
	[IsPromo] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Index [IX_OP_RequestQueueCommonServiceLineExtension_Id]    Script Date: 03.10.2022 15:58:25 ******/
CREATE NONCLUSTERED INDEX [IX_OP_RequestQueueCommonServiceLineExtension_Id] ON [dbo].[OP_RequestQueueServiceLineExtension]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_RequestQueueServiceLineExtension] ADD  CONSTRAINT [DF_OP_RequestQueueCommonServiceLineExtension_PartNo]  DEFAULT ((0)) FOR [PartNo]
GO

ALTER TABLE [dbo].[OP_RequestQueueServiceLineExtension] ADD  CONSTRAINT [DF_OP_RequestQueueServiceLineExtension_IsPromo]  DEFAULT ((0)) FOR [IsPromo]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'It is JSON column' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OP_RequestQueueServiceLineExtension', @level2type=N'COLUMN',@level2name=N'AdditionalFields'
GO

