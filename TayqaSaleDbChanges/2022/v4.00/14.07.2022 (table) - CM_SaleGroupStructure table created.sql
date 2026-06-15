
/****** Object:  Table [dbo].[CM_SaleGroupStructure]    Script Date: 7/15/2022 11:12:46 AM ******/

CREATE TABLE [dbo].[CM_SaleGroupStructure](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SaleGroupId] [int] NOT NULL,
	[SaleOfficeId] [int] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
