
/****** Object:  Table [dbo].[CM_AppliedCampaign]    Script Date: 7/15/2022 11:20:11 AM ******/

CREATE TABLE [dbo].[CM_AppliedCampaign](
	[RequestId] [int] NOT NULL,
	[CampaignId] [int] NOT NULL,
	[PromoId] [int] NOT NULL,
	[PromoType] [tinyint] NOT NULL,
	[PromoValue] [float] NOT NULL,
	[PromoItemQuantity] [float] NULL,
	[PromoItemUnitCode] [nvarchar](100) NULL,
	[PromoItemCode] [nvarchar](100) NULL,
 CONSTRAINT [PK_dbo.CM_AppliedCampaign] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC,
	[PromoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
