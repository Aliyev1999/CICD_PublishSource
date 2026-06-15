
/****** Object:  Table [dbo].[CM_CampaignStaticContent]    Script Date: 7/22/2022 11:15:02 AM ******/

CREATE TABLE [dbo].[CM_CampaignStaticContent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Type] [tinyint] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_CM_CampaignStaticContent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

