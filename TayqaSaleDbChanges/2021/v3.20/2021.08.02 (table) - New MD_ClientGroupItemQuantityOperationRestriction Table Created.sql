/****** Object:  Table [dbo].[MD_ClientGroupItemQuantityOperationRestriction]    Script Date: 8/2/2021 6:01:09 PM ******/
CREATE TABLE [dbo].[MD_ClientGroupItemQuantityOperationRestriction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientGroupId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[MaxQuantity] [float] NOT NULL,
	[Status] [bit] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
 CONSTRAINT [PK_MD_ClientGroupItemQuantityOperationRestriction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_ClientGroupItemQuantityOperationRestriction] ADD  CONSTRAINT [DF_MD_ClientGroupItemQuantityOperationRestriction_Status]  DEFAULT ((0)) FOR [Status]
GO

ALTER TABLE [dbo].[MD_ClientGroupItemQuantityOperationRestriction] ADD  CONSTRAINT [DF_MD_ClientGroupItemQuantityOperationRestriction_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
