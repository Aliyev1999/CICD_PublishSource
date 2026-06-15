
/****** Object:  Table [dbo].[CM_CampaignPromoConfiguration]    Script Date: 7/15/2022 11:04:43 AM ******/

CREATE TABLE [dbo].[CM_CampaignPromoConfiguration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PromoLineId] [int] NOT NULL,
	[MinConditionValue] [float] NOT NULL,
	[MaxConditionValue] [float] NULL,
	[PromoValue] [float] NOT NULL,
 CONSTRAINT [PKC_CM_CampaignPromoConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
