
CREATE TABLE [dbo].[OP_RequestQueueCampaignExtension](
	[Id] [int] IDENTITY(1,1) NOT NULL primary key,
	[CampaignId] [int] NOT NULL,
	[CampaignForceCheck] [bit] NOT NULL,
	[CampaignIsChecked] [bit] NOT NULL,
	[PromoId] [int] NOT NULL,
	[PromoForceCheck] [bit] NOT NULL,
	[PromoIsChecked] [bit] NOT NULL,
	[RequestId] [int] NOT NULL
) ON [PRIMARY]
GO


