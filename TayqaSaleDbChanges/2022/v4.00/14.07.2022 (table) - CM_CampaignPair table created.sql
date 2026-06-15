
/****** Object:  Table [dbo].[CM_CampaignPair]    Script Date: 7/15/2022 11:03:26 AM ******/

CREATE TABLE [dbo].[CM_CampaignPair](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstCampaignId] [int] NOT NULL,
	[SecondCampaignId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
