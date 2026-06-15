CREATE TABLE [dbo].[SYS_SqlQueryExecutorLog](
	[SqlQuery] [nvarchar](max) NOT NULL,
	[Result] [nvarchar](max) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Status] [varchar](20) NULL,
	[RegisteredDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SYS_SqlQueryExecutorLog] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO


