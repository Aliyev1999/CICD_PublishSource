
/****** Object:  Table [dbo].[CM_CampaignConsumptionCalculatedData]    Script Date: 7/22/2022 11:16:39 AM ******/

CREATE TABLE [dbo].[CM_CampaignConsumptionCalculatedData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[AudienceType] [tinyint] NOT NULL,
	[Consumption] [float] NOT NULL,
	[LastUpdateTime] [datetime] NULL,
	[ReferenceId] [int] NULL,
	[Value] [nvarchar](100) NULL,
 CONSTRAINT [PK_CM_CampaignConsumptionCalculatedData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CM_CampaignConsumptionCalculatedData] ADD  CONSTRAINT [DF_CM_CampaignConsumptionCalculatedData_LastUpdateTime]  DEFAULT (getdate()) FOR [LastUpdateTime]
GO

