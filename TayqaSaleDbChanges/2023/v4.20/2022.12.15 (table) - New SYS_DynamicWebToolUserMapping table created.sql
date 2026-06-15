
/****** Object:  Table [dbo].[SYS_DynamicWebToolUserMapping]    Script Date: 12/15/2022 3:11:01 PM ******/

CREATE TABLE [dbo].[SYS_DynamicWebToolUserMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferanceId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[GridStateJson] [nvarchar](max) NULL,
	[ToolType] [tinyint] NOT NULL,
	[TenantId] [int] NOT NULL,
	[BarChartInitialStateJson] [nvarchar](max) NULL,
	[DoughnutInitialStateJson] [nvarchar](max) NULL,
	[SplineChartInitialStateJson] [nvarchar](max) NULL,
	[MapInitialStateJson] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SYS_DynamicWebToolUserMapping] ADD  CONSTRAINT [DF_SYS_DynamicWebToolUserMapping_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

INSERT INTO SYS_DynamicWebToolUserMapping 
(ReferanceId, UserId, GridStateJson, ToolType, TenantId)
SELECT ReportId, UserId, GridStateJson, 2, 1 FROM SYS_SpecialReportUserMapping

DROP TABLE SYS_SpecialReportUserMapping;
