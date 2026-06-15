
/****** Object:  Table [dbo].[SYS_DynamicWebScreen]    Script Date: 12/15/2022 4:04:12 PM ******/

CREATE TABLE [dbo].[SYS_DynamicWebScreen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Code] [nvarchar](100) NULL,
	[Description] [nvarchar](200) NULL,
	[Module] [tinyint] NULL,
	[SqlQuery] [varchar](max) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[GridStateJson] [nvarchar](max) NULL,
	[TenantId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SYS_DynamicWebScreen] ADD  CONSTRAINT [DF_SYS_DynamicWebScreen_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO
