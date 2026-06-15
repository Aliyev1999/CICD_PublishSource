CREATE TABLE [dbo].[SYS_SqlQueryExecutorSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SqlQuery] [nvarchar](max) NOT NULL,
	[ScheduleTime] [datetime] NOT NULL,
	[Period] [bigint] NOT NULL,
	[IsPeriodic] [bit] NOT NULL,
	[MustDelete] [bit] NOT NULL,
	[Status] [varchar](20) NULL,
	[RegisteredDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SYS_SqlQueryExecutorSchedule] ADD  DEFAULT ((0)) FOR [MustDelete]
GO

ALTER TABLE [dbo].[SYS_SqlQueryExecutorSchedule] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO