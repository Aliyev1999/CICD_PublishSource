CREATE TABLE [dbo].[MSG_DynamicNotificationSendingLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DynamicNotificationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsSuccess] [bit] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[LogLevel] [int] NOT NULL,
	[Exception] [nvarchar](max) NULL,
 CONSTRAINT [PK_MSG_DynamicNotificationSendingLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[MSG_DynamicNotificationSendingLog] ADD  CONSTRAINT [DF_MSG_DynamicNotificationSendingLog_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Trace = 0,
Debug = 1,
Information = 2,
Warning = 3,
Error = 4,
Critical = 5,
None = 6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MSG_DynamicNotificationSendingLog', @level2type=N'COLUMN',@level2name=N'LogLevel'
GO


