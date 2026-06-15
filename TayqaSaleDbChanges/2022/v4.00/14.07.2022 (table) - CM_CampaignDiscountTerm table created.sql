
/****** Object:  Table [dbo].[CM_CampaignDiscountTerm]    Script Date: 7/15/2022 11:00:12 AM ******/

CREATE TABLE [dbo].[CM_CampaignDiscountTerm](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[ConditionField] [tinyint] NOT NULL,
	[ConditionFormat] [tinyint] NOT NULL,
	[ApplyMultiplication] [bit] NOT NULL,
	[AmountOrQuantity] [tinyint] NULL,
	[SalesItemUnitCode] [nvarchar](10) NULL,
	[SalesItemAmountOrQuantity] [float] NULL,
	[LineCode] [nvarchar](5) NOT NULL,
 CONSTRAINT [PKC_CM_CampaignDiscountTerm] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

