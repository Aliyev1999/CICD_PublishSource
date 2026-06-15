
/****** Object:  Table [dbo].[SYS_NonGridRelatedAction]    Script Date: 12/15/2022 4:12:00 PM ******/

CREATE TABLE [dbo].[SYS_NonGridRelatedAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScreenId] [int] NOT NULL,
	[ButtonText] [nvarchar](30) NOT NULL,
	[IconCssClass] [nvarchar](20) NOT NULL,
	[ButtonCssClass] [nvarchar](20) NOT NULL,
	[SqlQuery] [nvarchar](max) NOT NULL,
	[TenantId] [int] NOT NULL,
 CONSTRAINT [PK__SYS_NonG__3214EC07610CEEB7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
