

CREATE TABLE [dbo].[MSG_AutoGeneratingReportLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportId] [int] NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Details] [nvarchar](max) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))


