
/****** Object:  Table [dbo].[CM_CampaignDiscountTermPromo]    Script Date: 7/15/2022 11:02:30 AM ******/

CREATE TABLE [dbo].[CM_CampaignDiscountTermPromo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[PromoType] [tinyint] NOT NULL,
	[PromoApplyType] [tinyint] NOT NULL,
	[PromoValue] [float] NULL,
	[BySelection] [bit] NOT NULL,
	[PromoItemUnitCode] [nvarchar](10) NULL,
	[PromoItemQuantity] [float] NULL,
	[ApplyRounding] [bit] NULL,
	[RoundingType] [tinyint] NULL,
	[DecimalsCount] [tinyint] NULL,
	[DiscountTermId] [int] NULL,
 CONSTRAINT [PKC_CM_CampaignDiscountTermPromo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
