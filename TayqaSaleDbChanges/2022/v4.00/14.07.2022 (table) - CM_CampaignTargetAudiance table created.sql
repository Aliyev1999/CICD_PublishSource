
/****** Object:  Table [dbo].[CM_CampaignTargetAudiance]    Script Date: 7/15/2022 11:09:47 AM ******/

CREATE TABLE [dbo].[CM_CampaignTargetAudiance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[AudianceType] [tinyint] NOT NULL,
	[SelectionType] [tinyint] NOT NULL,
 CONSTRAINT [PKC_CM_CampaignTargetAudiance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
