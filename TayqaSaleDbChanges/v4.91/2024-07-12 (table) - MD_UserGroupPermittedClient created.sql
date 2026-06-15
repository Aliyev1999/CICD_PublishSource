
CREATE TABLE [dbo].[MD_UserGroupPermittedClient](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[TigerClientId] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserGroupPermittedClient] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[TigerClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedClient] ADD  CONSTRAINT [DF_UserGroupPermittedClient_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
