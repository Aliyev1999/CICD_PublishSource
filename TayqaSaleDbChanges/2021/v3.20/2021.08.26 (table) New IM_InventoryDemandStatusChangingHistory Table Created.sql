/****** Object:  Table [dbo].[IM_InventoryDemandStatusChangingHistory]    Script Date: 8/26/2021 10:03:46 AM ******/

CREATE TABLE [dbo].[IM_InventoryDemandStatusChangingHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[DemandId] [int] NOT NULL,
	[InventoryId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_InventoryDemandStatusChangingHistory] ADD  DEFAULT (getdate()) FOR [Date]
GO
