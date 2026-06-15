
CREATE TABLE [dbo].[MD_UserGroupPermittedFactory](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[TigerFactoryNr] [smallint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_UserGroupPermittedFactory] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[TigerFactoryNr] ASC,
	[OperationId] ASC,
	[DivisionNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedFactory] ADD  CONSTRAINT [DF__MD_UserGroupPermittedFactory__Regis__6D6D25A7]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
