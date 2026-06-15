CREATE TABLE [dbo].[MSG_NotificationPushQueue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationId] [int] NOT NULL,
	[PushMethodId] [smallint] NOT NULL,
	[SendDate] [datetime] NULL,
	[Message] [nvarchar](500) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
 CONSTRAINT [PK_MSG_NotificationPushQueue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MSG_NotificationPushQueue] ADD  CONSTRAINT [DF_MSG_NotificationPushQueue_CreatedDate]  DEFAULT (getdate()) FOR [CreationTime]
GO


