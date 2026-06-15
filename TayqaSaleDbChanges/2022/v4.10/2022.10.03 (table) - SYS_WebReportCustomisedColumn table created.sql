
/****** Object:  Table [dbo].[SYS_WebReportCustomisedColumn]    Script Date: 10/3/2022 2:41:02 PM ******/

CREATE TABLE [dbo].[SYS_WebReportCustomisedColumn](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportId] [int] NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[IsHidden] [bit] NOT NULL,
 CONSTRAINT [PK__SYS_WebR__3214EC0748AF9135] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
