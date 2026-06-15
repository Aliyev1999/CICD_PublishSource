
CREATE TABLE [dbo].[DTM_ExternalApi]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Code] [nvarchar](100) NULL,
	[URL] [nvarchar](max) NULL,
	[HTTPRequestType] [tinyint] NULL,
	[AuthorizationType] [tinyint] NULL,
	[SqlQuery] [nvarchar](max) NULL, 
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Token] [nvarchar](max) NULL,
	[Body] [nvarchar](max) NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[CreationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[TenantId] [int] NOT NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[SendingSchedule] [nvarchar](max)
 CONSTRAINT [PK_DTM_ExternalApi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO 

CREATE TABLE [dbo].[DTM_ExternalApiHeader]
(
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[ExternalApiId] [int] NOT NULL,
	[Key] [nvarchar](max) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[Type] [tinyint] NOT NULL,
	[SqlQuery] [nvarchar](max) NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[CreationTime] [datetime] NULL,
)
