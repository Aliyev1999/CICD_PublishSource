
/****** Object:  Table [dbo].[CM_CampaignTargetAudianceLine]    Script Date: 7/15/2022 11:10:41 AM ******/

CREATE TABLE [dbo].[CM_CampaignTargetAudianceLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TargetAudianceId] [int] NOT NULL,
	[ReferanceId] [int] NULL,
	[Value] [nvarchar](50) NULL,
	[Budget] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
