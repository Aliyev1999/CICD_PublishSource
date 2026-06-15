
/****** Object:  Table [dbo].[SYS_DynamicMobileScreen]    Script Date: 12/15/2022 3:57:20 PM ******/

CREATE TABLE [dbo].[SYS_DynamicMobileScreen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Code] [nvarchar](100) NULL,
	[Description] [nvarchar](200) NULL,
	[SqlQuery] [varchar](max) NOT NULL,
	[IconUnicode] [nvarchar](100) NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[IsCreateable] [bit] NOT NULL,
	[IsEditable] [bit] NOT NULL,
	[EditQuery] [nvarchar](max) NULL,
	[CreateQuery] [nvarchar](max) NULL,
	[TenantId] [int] NOT NULL,
	[IconId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SYS_DynamicMobileScreen] ADD  DEFAULT ((0)) FOR [IsCreateable]
GO

ALTER TABLE [dbo].[SYS_DynamicMobileScreen] ADD  DEFAULT ((0)) FOR [IsEditable]
GO
