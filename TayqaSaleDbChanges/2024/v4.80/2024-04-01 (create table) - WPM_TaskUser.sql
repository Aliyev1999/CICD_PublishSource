
CREATE TABLE [dbo].[WPM_TaskUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[OrderNo] [smallint] NOT NULL,
	[IsOptional] [bit] NOT NULL,
	[Priority] [smallint] NOT NULL,
	[Status] [bit] NOT NULL
) ON [PRIMARY]
GO
