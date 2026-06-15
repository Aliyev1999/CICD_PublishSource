
CREATE TABLE [dbo].[IM_UserGroupPermittedCatalog](
	[UserGroupId] [int] NOT NULL,
	[CatalogId] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_IM_UserGroupPermittedCatalog] PRIMARY KEY CLUSTERED 
(
	[UserGroupId] ASC,
	[CatalogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_UserGroupPermittedCatalog] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
