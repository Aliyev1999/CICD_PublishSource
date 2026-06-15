CREATE TABLE [dbo].[MSG_Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Priority] [tinyint] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_MSG_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/****** Object:  Table [dbo].[MSG_NotificationAttachment]    Script Date: 12/2/2021 4:57:33 PM ******/
CREATE TABLE [dbo].[MSG_NotificationAttachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationId] [int] NOT NULL,
	[Url] [nvarchar](max) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_MSG_NotificationAttachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/****** Object:  Table [dbo].[MSG_NotificationClient]    Script Date: 12/2/2021 4:57:33 PM ******/
CREATE TABLE [dbo].[MSG_NotificationClient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[CanUseByOtherModules] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_MSG_NotificationClient] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[MSG_NotificationClientReadLog]    Script Date: 12/2/2021 4:57:33 PM ******/
CREATE TABLE [dbo].[MSG_NotificationClientReadLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationUserId] [int] NOT NULL,
	[NotificationClientId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_MSG_NotificationClientReadLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[MSG_NotificationUser]    Script Date: 12/2/2021 4:57:33 PM ******/
CREATE TABLE [dbo].[MSG_NotificationUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationId] [int] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_MSG_NotificationUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[MSG_NotificationUserReadLog]    Script Date: 12/2/2021 4:57:33 PM ******/
CREATE TABLE [dbo].[MSG_NotificationUserReadLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationUserId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_MSG_NotificationUserReadLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MSG_Notification] ADD  CONSTRAINT [DF_MSG_Notification_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
ALTER TABLE [dbo].[MSG_NotificationAttachment] ADD  CONSTRAINT [DF_MSG_NotificationAttachment_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
ALTER TABLE [dbo].[MSG_NotificationClient] ADD  CONSTRAINT [DF_MSG_NotificationClient_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
ALTER TABLE [dbo].[MSG_NotificationClient] ADD  CONSTRAINT [DF_MSG_NotificationClient_CanUseByOtherModules]  DEFAULT ((0)) FOR [CanUseByOtherModules]
GO
ALTER TABLE [dbo].[MSG_NotificationClient] ADD  CONSTRAINT [DF_MSG_NotificationClient_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MSG_NotificationClientReadLog] ADD  CONSTRAINT [DF_MSG_NotificationClientReadLog_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
ALTER TABLE [dbo].[MSG_NotificationUser] ADD  CONSTRAINT [DF_MSG_NotificationUser_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
ALTER TABLE [dbo].[MSG_NotificationUserReadLog] ADD  CONSTRAINT [DF_MSG_NotificationUserReadLog_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
