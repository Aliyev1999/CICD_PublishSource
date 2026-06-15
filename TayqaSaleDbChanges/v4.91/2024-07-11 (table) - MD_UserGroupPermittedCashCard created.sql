
CREATE TABLE [dbo].[MD_UserGroupPermittedCashCard](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[TigerCashCardId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_UserGroupPermittedCashCard] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[TigerCashCardId] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedCashCard] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
