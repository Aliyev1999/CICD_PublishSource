CREATE TABLE [dbo].[AbpUserCommonPasswordSettings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpiredDay] [int] NOT NULL,
	[EntryAttempt] [smallint] NOT NULL,
	[PasswordComplexity] [bit] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedUserId] [bigint] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedUserId] [bigint] NULL,
 CONSTRAINT [PK_AbpUserCommonPasswordSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


