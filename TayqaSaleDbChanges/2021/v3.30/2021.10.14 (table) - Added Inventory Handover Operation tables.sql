/****** Object:  Table [dbo].[IM_HandoverOperation]    Script Date: 14.10.2021 10:27:41 ******/

CREATE TABLE [dbo].[IM_HandoverOperation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorDescription] [nvarchar](1000) NULL,
	[CreatorReasonId] [int] NULL,
	[DocumentNumber] [nvarchar](50) NOT NULL,
	[DocumentDate] [datetime] NOT NULL,
	[HandingOverPersonId] [int] NOT NULL,
	[ReceivingPersonId] [int] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
	[HandoverPersonType] [tinyint] NOT NULL,
 CONSTRAINT [PK_IM_HandoverOperation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_HandoverOperation] ADD  CONSTRAINT [DF_IM_HandoverOperation_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[IM_HandoverOperation] ADD  CONSTRAINT [DF__IM_Handov__IsDel__5E624E46]  DEFAULT ((0)) FOR [IsDeleted]
GO


CREATE TABLE [dbo].[IM_HandoverOperationLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[HandoverOperationId] [int] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_IM_HandoverOperationLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_HandoverOperationLine] ADD  CONSTRAINT [DF_IM_HandoverOperationLine_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[IM_HandoverOperationLine] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO

