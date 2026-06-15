ALTER TABLE MD_ItemGroupItemMapping
ADD GroupType tinyint;

GO

UPDATE MD_ItemGroupItemMapping Set GroupType = 1;

GO

ALTER TABLE MD_ItemGroupItemMapping
ALTER COLUMN GroupType tinyint not null;

alter table MD_ItemGroupItemMapping
drop constraint IX_MD_ItemGroupItemMapping;

GO

/****** Object:  Index [IX_MD_ItemGroupItemMapping_Firm_ItemId_GroupType]    Script Date: 10/27/2021 12:06:58 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MD_ItemGroupItemMapping_Firm_ItemId_GroupType] ON [dbo].[MD_ItemGroupItemMapping]
(
	[Firm] ASC,
	[ItemId] ASC,
	[GroupType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

