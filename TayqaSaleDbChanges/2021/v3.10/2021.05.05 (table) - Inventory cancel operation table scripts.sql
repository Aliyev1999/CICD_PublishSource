/****** Object:  Table [dbo].[IM_InventoryCancelOperation]    Script Date: 05.05.2021 16:47:02 ******/
CREATE TABLE [dbo].[IM_InventoryCancelOperation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryId] [int] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[ActNumber] [nvarchar](100) NOT NULL,
	[Amount] [float] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
	[ClientTigerId] [int] NULL,
	[StateId] [int] NULL,
	[ReasonId] [int] NOT NULL,
 CONSTRAINT [PK_IM_InventoryCancelOperation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[IM_InventoryCancelOperationAttachment]    Script Date: 05.05.2021 16:47:38 ******/
CREATE TABLE [dbo].[IM_InventoryCancelOperationAttachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryCancelOperationId] [int] NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[Extension] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_IM_InventoryCancelOperationAttachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
