
CREATE TABLE [dbo].[MD_UserGroupPermittedTradingGroup](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[TigerTradingGroupId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_UserGroupPermittedTradingGroup] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[TigerTradingGroupId] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedTradingGroup] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO


