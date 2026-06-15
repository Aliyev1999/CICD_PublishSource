
/****** Object:  Table [dbo].[CM_CampaignDiscountTermConditionValue]    Script Date: 7/15/2022 11:01:35 AM ******/

CREATE TABLE [dbo].[CM_CampaignDiscountTermConditionValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DiscountTermId] [int] NOT NULL,
	[ReferanceId] [int] NULL,
	[Value] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
