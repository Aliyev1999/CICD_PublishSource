
CREATE TABLE [dbo].[MD_UserGroupPermittedDivision](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[TigerDivisionNr] [smallint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_UserGroupPermittedDivision] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[TigerDivisionNr] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedDivision] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
