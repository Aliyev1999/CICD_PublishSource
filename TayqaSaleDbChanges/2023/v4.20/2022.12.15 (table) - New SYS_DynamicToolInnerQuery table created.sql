
/****** Object:  Table [dbo].[SYS_DynamicToolInnerQuery]    Script Date: 12/15/2022 1:58:11 PM ******/

CREATE TABLE [dbo].[SYS_DynamicToolInnerQuery](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayLabel] [nvarchar](100) NOT NULL,
	[SqlQuery] [nvarchar](max) NOT NULL,
	[ParentId] [int] NOT NULL,
	[QueryType] [tinyint] NOT NULL,
	[ToolType] [tinyint] NOT NULL,
	[TenantId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

INSERT INTO SYS_DynamicToolInnerQuery 
(DisplayLabel, SqlQuery, ParentId, QueryType, ToolType, TenantId)
SELECT DisplayLabel, SqlQuery, ParentId, 2, 2, 1 FROM SYS_WebDetailReport

DROP TABLE SYS_WebDetailReport;

INSERT INTO SYS_DynamicToolInnerQuery 
(DisplayLabel, SqlQuery, ParentId, QueryType, ToolType, TenantId)
SELECT 'Detal', SqlQuery, ParentId, 2, 1, 1 FROM SYS_MobileReport WHERE ParentId IS NOT NULL

DELETE FROM SYS_MobileReport WHERE ParentId IS NOT NULL;
