
CREATE TABLE [dbo].[MSG_Conversation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[Type] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MSG_Conversation] ADD  CONSTRAINT [DF_MSG_Conversation_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

CREATE TABLE [dbo].[MSG_ConversationMember](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [bigint] NOT NULL,
	[ConversationId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastReadTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MSG_ConversationMember] ADD  CONSTRAINT [DF_MSG_ConversationMember_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO


CREATE TABLE [dbo].[MSG_ConversationMessage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConversationId] [int] NULL,
	[SenderUserId] [int] NOT NULL,
	[SentDate] [datetime] NULL,
	[Type] [tinyint] NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[MessageText] [nvarchar](max) NULL,
	[ContactPersonName] [nvarchar](50) NULL,
	[ContactPersonPhoneNumber] [nvarchar](50) NULL,
	[State] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[MSG_MessageAttachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MessageId] [bigint] NULL,
	[Url] [nvarchar](max) NOT NULL,
	[SecureUrl]  AS (concat('NewImage-MSG-MessageAttachment','-',[Id],reverse(left(reverse([Url]),charindex('\',reverse([Url])))))),
 CONSTRAINT [PK_MSG_MessageAttachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


CREATE TABLE [dbo].[MSG_UserChatStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[IsOnline] [bit] NOT NULL,
	[LastOnlineTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
