CREATE TABLE [dbo].[IM_AssetStatusUpdateHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssetId] [int] NOT NULL,
	[IsAvailable] [bit] NOT NULL,
	[StateId] [int] NULL,
	[LocationType] [int] NULL,
	[IsRepairNeeded] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_AssetStatusUpdateHistory] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO

ALTER TABLE [dbo].[IM_AssetStatusUpdateHistory]  WITH CHECK ADD FOREIGN KEY([CreatorUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO

ALTER TABLE [dbo].[IM_AssetStatusUpdateHistory]  WITH CHECK ADD FOREIGN KEY([LocationType])
REFERENCES [dbo].[IM_StaticContent] ([Id])
GO

ALTER TABLE [dbo].[IM_AssetStatusUpdateHistory]  WITH CHECK ADD FOREIGN KEY([StateId])
REFERENCES [dbo].[IM_StaticContent] ([Id])