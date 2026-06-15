/****** Object:  Table [dbo].[IM_InventoryCheckOnClientOperation]    Script Date: 17.05.2021 19:39:40 ******/

CREATE TABLE [dbo].[IM_InventoryCheckOnClientOperation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientTigerId] [int] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[Longitude] [float] NOT NULL,
	[Latitude] [float] NOT NULL,
	[CreatorUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ResultType] [tinyint] NOT NULL,
	[InventoryClientTigerId] [int] NULL,
	[InventoryStatus] [tinyint] NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_IM_InventoryCheckOnClientOperation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_IM_InventoryCheckOnClientOperation_UId] UNIQUE NONCLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_InventoryCheckOnClientOperation] ADD  CONSTRAINT [DF_IM_InventoryCheckOnClientOperation_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
