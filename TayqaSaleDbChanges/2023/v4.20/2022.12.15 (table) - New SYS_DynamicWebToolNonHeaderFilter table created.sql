
/****** Object:  Table [dbo].[SYS_DynamicWebToolNonHeaderFilter]    Script Date: 12/15/2022 2:40:58 PM ******/

CREATE TABLE [dbo].[SYS_DynamicWebToolNonHeaderFilter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferanceId] [int] NOT NULL,
	[FieldName] [nvarchar](100) NOT NULL,
	[OrderNo] [smallint] NULL,
	[IsHidden] [bit] NOT NULL,
	[ToolType] [tinyint] NOT NULL,
	[FilterType] [tinyint] NOT NULL,
	[TenantId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SYS_DynamicWebToolNonHeaderFilter] ADD  CONSTRAINT [DF_SYS_DynamicWebToolNonHeaderFilter_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

INSERT INTO SYS_DynamicWebToolNonHeaderFilter 
(ReferanceId, FieldName, OrderNo, IsHidden, ToolType, FilterType, TenantId)
SELECT ReportId, FieldName, OrderNo, IsHidden, 2, FilterType, 1 FROM SYS_WebReportNonHeaderFilter

DROP TABLE SYS_WebReportNonHeaderFilter;
