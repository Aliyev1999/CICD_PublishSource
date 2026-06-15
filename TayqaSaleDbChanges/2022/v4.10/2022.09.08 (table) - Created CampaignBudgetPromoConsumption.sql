
CREATE TABLE [dbo].[CM_CampaignBudgetPromoConsumption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[PromoId] [int] NOT NULL,
	[RequestId] [int] NOT NULL,
	[Consumption] [float] NOT NULL,
	[PromoValue] [float] NULL,
	[PromoItemQuantity] [float] NULL,
	[CreationDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CM_CampaignBudgetPromoConsumption] ADD  CONSTRAINT [DF_CM_CampaignBudgetPromoConsumption_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO


