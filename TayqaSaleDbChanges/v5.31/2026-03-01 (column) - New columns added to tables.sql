ALTER TABLE [dbo].[MD_ItemGroup]
ADD SyncFlag bit NOT NULL CONSTRAINT DF_MD_ItemGroup_SyncFlag DEFAULT (0);

GO

ALTER TABLE [dbo].[MD_ItemGroupItemMapping]
ADD SyncFlag bit NOT NULL CONSTRAINT DF_MD_ItemGroupItemMapping_SyncFlag DEFAULT (0);

GO

ALTER TABLE [dbo].[MD_ItemGroupPlanForUser]
ADD SyncFlag bit NOT NULL CONSTRAINT DF_MD_ItemGroupPlanForUser_SyncFlag DEFAULT (0);

GO


ALTER TABLE [dbo].[AbpOrganizationUnits]
ADD SyncFlag bit NOT NULL CONSTRAINT DF_MD_AbpOrganizationUnits_SyncFlag DEFAULT (0);

GO

ALTER TABLE [dbo].[AbpUserOrganizationUnits]
ADD SyncFlag bit NOT NULL CONSTRAINT DF_MD_AbpUserOrganizationUnits_SyncFlag DEFAULT (0);

GO

ALTER TABLE [dbo].[MD_BannedClient]
ADD SyncFlag bit NOT NULL CONSTRAINT DF_MD_MD_BannedClient_SyncFlag DEFAULT (0);

GO

ALTER TABLE [dbo].[MD_BannedClientLog]
ADD SyncFlag bit NOT NULL CONSTRAINT DF_MD_MD_BannedClientLog_SyncFlag DEFAULT (0);