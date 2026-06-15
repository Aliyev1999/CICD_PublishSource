
CREATE TABLE [dbo].[MSG_ReplyToNotification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationId] [int] NOT NULL,
	[Reply] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
	[ReplyTime] [datetime] NOT NULL,
	[Firm] [smallint] NULL,
	[ClientId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
