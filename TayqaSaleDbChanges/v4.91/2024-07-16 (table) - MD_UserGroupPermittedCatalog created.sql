
CREATE TABLE [dbo].[MD_UserGroupPermittedCatalog](
	[UserGroupId] [int] NOT NULL,
	[CatalogId] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_UserGroupPermittedCatalog] PRIMARY KEY CLUSTERED 
(
	[UserGroupId] ASC,
	[CatalogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedCatalog] ADD  CONSTRAINT [DF_MD_UserGroupPermittedCatalog_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO

