
/****** Object:  Table [dbo].[CM_CampaignBudgetConsumption]    Script Date: 7/15/2022 10:56:51 AM ******/

CREATE TABLE [dbo].[CM_CampaignBudgetConsumption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[Consumption] [float] NOT NULL,
	[RequestId] [int] NOT NULL,
	[AudienceType] [tinyint] NOT NULL,
	[ReferenceId] [int] NULL,
	[Value] [nvarchar](50) NULL,
	[CreationTime] [datetime] NULL,
 CONSTRAINT [PK_CM_CampaignBudgetConsuption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CM_CampaignBudgetConsumption] ADD  CONSTRAINT [DF_CM_CampaignBudgetConsuption_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

