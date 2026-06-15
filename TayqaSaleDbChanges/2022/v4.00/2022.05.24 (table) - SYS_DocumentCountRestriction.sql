CREATE TABLE [dbo].[MD_DocumentCountRestriction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[RestrictionType] [tinyint] NOT NULL,
	[ReferenceId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[RestrictionCount] [smallint] NOT NULL,
	[Limit] [int] NOT NULL,
	[WarehouseNr] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_DocumentCountRestriction] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[MD_DocumentCountRestriction] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[MD_DocumentCountRestriction] ADD  DEFAULT ((0)) FOR [RestrictionCount]
GO

ALTER TABLE [dbo].[MD_DocumentCountRestriction] ADD  DEFAULT ((1)) FOR [Limit]
GO


