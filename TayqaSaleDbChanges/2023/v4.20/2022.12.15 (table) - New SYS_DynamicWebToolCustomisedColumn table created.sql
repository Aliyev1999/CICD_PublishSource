
/****** Object:  Table [dbo].[SYS_DynamicWebToolCustomisedColumn]    Script Date: 12/15/2022 2:02:20 PM ******/

CREATE TABLE [dbo].[SYS_DynamicWebToolCustomisedColumn](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferanceId] [int] NOT NULL,
	[FieldName] [nvarchar](100) NOT NULL,
	[IsHidden] [bit] NOT NULL,
	[ToolType] [tinyint] NOT NULL,
	[TenantId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SYS_DynamicWebToolCustomisedColumn] ADD  CONSTRAINT [DF_SYS_DynamicWebToolCustomisedColumn_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

INSERT INTO SYS_DynamicWebToolCustomisedColumn 
(ReferanceId, FieldName, IsHidden, ToolType, TenantId)
SELECT ReportId, FieldName, 1, 2, 1 FROM SYS_WebReportCustomisedColumn

DROP TABLE SYS_WebReportCustomisedColumn;
