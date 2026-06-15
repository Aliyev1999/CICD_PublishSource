/****** Object:  Table [dbo].[MD_UserItemGroupQuantityOperationRestriction]    Script Date: 10/24/2021 5:55:38 PM ******/

CREATE TABLE [dbo].[MD_UserItemGroupQuantityOperationRestriction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[ItemGroupId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[MaxQuantity] [float] NOT NULL,
	[Status] [bit] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
 CONSTRAINT [PK_MD_ClientItemGroupQuantityOperationRestriction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


