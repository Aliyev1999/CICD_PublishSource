/*
Date: 2019-07-20 16:02:40
*/


-- ----------------------------
-- Table structure for AbpAuditLogs
-- ----------------------------
DROP TABLE [dbo].[AbpAuditLogs]
GO
CREATE TABLE [dbo].[AbpAuditLogs] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[BrowserInfo] nvarchar(256) NULL ,
[ClientIpAddress] nvarchar(64) NULL ,
[ClientName] nvarchar(128) NULL ,
[CustomData] nvarchar(2000) NULL ,
[Exception] nvarchar(2000) NULL ,
[ExecutionDuration] int NOT NULL ,
[ExecutionTime] datetime2(7) NOT NULL ,
[ImpersonatorTenantId] int NULL ,
[ImpersonatorUserId] bigint NULL ,
[MethodName] nvarchar(256) NULL ,
[Parameters] nvarchar(1024) NULL ,
[ServiceName] nvarchar(256) NULL ,
[TenantId] int NULL ,
[UserId] bigint NULL 
)


GO

-- ----------------------------
-- Records of AbpAuditLogs
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpAuditLogs] ON
GO
SET IDENTITY_INSERT [dbo].[AbpAuditLogs] OFF
GO

-- ----------------------------
-- Table structure for AbpBackgroundJobs
-- ----------------------------
DROP TABLE [dbo].[AbpBackgroundJobs]
GO
CREATE TABLE [dbo].[AbpBackgroundJobs] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[IsAbandoned] bit NOT NULL ,
[JobArgs] nvarchar(MAX) NOT NULL ,
[JobType] nvarchar(512) NOT NULL ,
[LastTryTime] datetime2(7) NULL ,
[NextTryTime] datetime2(7) NOT NULL ,
[Priority] tinyint NOT NULL ,
[TryCount] smallint NOT NULL 
)


GO

-- ----------------------------
-- Records of AbpBackgroundJobs
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpBackgroundJobs] ON
GO
SET IDENTITY_INSERT [dbo].[AbpBackgroundJobs] OFF
GO

-- ----------------------------
-- Table structure for AbpEditions
-- ----------------------------
DROP TABLE [dbo].[AbpEditions]
GO
CREATE TABLE [dbo].[AbpEditions] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(32) NOT NULL ,
[DisplayName] nvarchar(64) NOT NULL ,
[IsDeleted] bit NOT NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[Discriminator] nvarchar(MAX) NOT NULL ,
[AnnualPrice] decimal(18,2) NULL ,
[ExpiringEditionId] int NULL ,
[MonthlyPrice] decimal(18,2) NULL ,
[TrialDayCount] int NULL ,
[WaitingDayAfterExpire] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpEditions]', RESEED, 1)
GO-- ----------------------------
-- Records of AbpEditions
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpEditions] ON
GO
INSERT INTO [dbo].[AbpEditions] ([Id], [Name], [DisplayName], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [Discriminator], [AnnualPrice], [ExpiringEditionId], [MonthlyPrice], [TrialDayCount], [WaitingDayAfterExpire]) VALUES (N'1', N'Standard', N'Standard', N'0', null, null, null, null, N'2018-11-22 21:34:08.3376829', null, N'SubscribableEdition', null, null, null, null, null)
GO
GO
SET IDENTITY_INSERT [dbo].[AbpEditions] OFF
GO

-- ----------------------------
-- Table structure for AbpFeatures
-- ----------------------------
DROP TABLE [dbo].[AbpFeatures]
GO
CREATE TABLE [dbo].[AbpFeatures] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(128) NOT NULL ,
[Value] nvarchar(2000) NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[EditionId] int NULL ,
[TenantId] int NULL ,
[Discriminator] nvarchar(MAX) NOT NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpFeatures]', RESEED, 3)
GO

-- ----------------------------
-- Records of AbpFeatures
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpFeatures] ON
GO
INSERT INTO [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (N'1', N'App.ChatFeature', N'True', N'2018-11-22 21:38:27.5800247', null, N'1', null, N'EditionFeatureSetting')
GO
GO
INSERT INTO [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (N'2', N'App.ChatFeature.TenantToTenant', N'True', N'2018-11-22 21:38:28.4920825', null, N'1', null, N'EditionFeatureSetting')
GO
GO
INSERT INTO [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (N'3', N'App.ChatFeature.TenantToHost', N'True', N'2018-11-22 21:38:29.2272906', null, N'1', null, N'EditionFeatureSetting')
GO
GO
SET IDENTITY_INSERT [dbo].[AbpFeatures] OFF
GO

-- ----------------------------
-- Table structure for AbpLanguages
-- ----------------------------
DROP TABLE [dbo].[AbpLanguages]
GO
CREATE TABLE [dbo].[AbpLanguages] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[DisplayName] nvarchar(64) NOT NULL ,
[Icon] nvarchar(128) NULL ,
[IsDeleted] bit NOT NULL ,
[IsDisabled] bit NOT NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[Name] nvarchar(10) NOT NULL ,
[TenantId] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpLanguages]', RESEED, 4)
GO

-- ----------------------------
-- Records of AbpLanguages
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpLanguages] ON
GO
INSERT INTO [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (N'1', N'2017-10-07 16:00:03.7275331', null, null, null, N'English', N'famfamfam-flags gb', N'0', N'0', null, null, N'en', N'1')
GO
GO
INSERT INTO [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (N'2', N'2017-10-07 16:00:03.7285324', null, null, null, N'Azərbaycanca', N'famfamfam-flags az', N'0', N'0', null, null, N'az', N'1')
GO
GO
INSERT INTO [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (N'3', N'2017-10-07 16:00:03.7285324', null, null, null, N'Türkçe', N'famfamfam-flags tr', N'0', N'0', null, null, N'tr', N'1')
GO
GO
INSERT INTO [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (N'4', N'2017-10-07 16:00:03.7285324', null, null, null, N'Pусский', N'famfamfam-flags ru', N'0', N'0', null, null, N'ru', N'1')
GO
GO
SET IDENTITY_INSERT [dbo].[AbpLanguages] OFF
GO

-- ----------------------------
-- Table structure for AbpLanguageTexts
-- ----------------------------
DROP TABLE [dbo].[AbpLanguageTexts]
GO
CREATE TABLE [dbo].[AbpLanguageTexts] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[Key] nvarchar(256) NOT NULL ,
[LanguageName] nvarchar(10) NOT NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[Source] nvarchar(128) NOT NULL ,
[TenantId] int NULL ,
[Value] nvarchar(MAX) NOT NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpLanguageTexts]', RESEED, 15)
GO

-- ----------------------------
-- Records of AbpLanguageTexts
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpLanguageTexts] ON
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'1', N'2018-09-10 21:51:07.7031105', N'2', N'AreYouSure', N'az', null, null, N'AbpWeb', N'1', N'Əminsinizmi?')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'2', N'2018-09-10 21:51:37.8506918', N'2', N'Yes', N'az', null, null, N'AbpWeb', N'1', N'Hə')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'3', N'2018-09-10 21:51:43.7942516', N'2', N'Cancel', N'az', null, null, N'AbpWeb', N'1', N'İmtina')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'4', N'2018-09-10 21:51:58.4105194', N'2', N'DefaultError', N'az', null, null, N'AbpWeb', N'1', N'Xəta baş verdi!')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'5', N'2018-09-10 21:52:21.8255617', N'2', N'ValidationError', N'az', null, null, N'AbpWeb', N'1', N'Müraciətiniz xətalıdır!')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'6', N'2018-09-10 21:53:32.8805281', N'2', N'DefaultError404', N'az', null, null, N'AbpWeb', N'1', N'Resurs tapılmadı!')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'7', N'2018-09-10 21:54:05.3386668', N'2', N'DefaultError403', N'az', N'2018-09-11 13:13:35.2906768', N'2', N'AbpWeb', N'1', N'Sistemə daxil olmamısınız!')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'8', N'2018-09-10 21:54:18.6803770', N'2', N'DefaultErrorDetail403', N'az', N'2018-09-10 21:55:02.1305471', N'2', N'AbpWeb', N'1', N'Bu əməliyyatı icra etməyə icazəniz yoxdur.')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'9', N'2018-09-10 21:55:30.4011745', N'2', N'DefaultErrorDetail404', N'az', null, null, N'AbpWeb', N'1', N'Axtarılan resurs serverdə tapılmadı.')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'10', N'2018-09-10 21:56:26.5912401', N'2', N'EntityNotFound', N'az', null, null, N'AbpWeb', N'1', N'id = {1} olan {0} element tapılmadı!')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'11', N'2018-09-11 13:06:08.6251849', N'2', N'InternalServerError', N'az', null, null, N'AbpWeb', N'1', N'Sorğu icra edilərkən daxili xəta baş verdi!')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'12', N'2018-09-11 13:06:43.4077566', N'2', N'ValidationNarrativeTitle', N'az', null, null, N'AbpWeb', N'1', N'Yoxlama zamanı aşağıdakı xətalar aşkarlandı.')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'13', N'2018-09-11 13:07:18.9385187', N'2', N'DefaultErrorDetail', N'az', null, null, N'AbpWeb', N'1', N'Server tərəfindən xətanın təfərrüatları göndəriməmişdir.')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'14', N'2018-09-11 13:11:29.7493604', N'2', N'DefaultErrorDetail401', N'az', N'2018-09-11 13:13:14.2180935', N'2', N'AbpWeb', N'1', N'Bu əməliyyatı həyata keçirmək üçün sistemə daxil olmalısınız.')
GO
GO
INSERT INTO [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (N'15', N'2018-09-11 13:11:43.3178215', N'2', N'DefaultError401', N'az', N'2018-09-11 13:12:51.6502759', N'2', N'AbpWeb', N'1', N'Sistemə daxil olmamısınız!')
GO
GO
SET IDENTITY_INSERT [dbo].[AbpLanguageTexts] OFF
GO

-- ----------------------------
-- Table structure for AbpNotifications
-- ----------------------------
DROP TABLE [dbo].[AbpNotifications]
GO
CREATE TABLE [dbo].[AbpNotifications] (
[Id] uniqueidentifier NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[Data] nvarchar(MAX) NULL ,
[DataTypeName] nvarchar(512) NULL ,
[EntityId] nvarchar(96) NULL ,
[EntityTypeAssemblyQualifiedName] nvarchar(512) NULL ,
[EntityTypeName] nvarchar(250) NULL ,
[ExcludedUserIds] nvarchar(MAX) NULL ,
[NotificationName] nvarchar(96) NOT NULL ,
[Severity] tinyint NOT NULL ,
[TenantIds] nvarchar(MAX) NULL ,
[UserIds] nvarchar(MAX) NULL 
)


GO

-- ----------------------------
-- Records of AbpNotifications
-- ----------------------------

-- ----------------------------
-- Table structure for AbpNotificationSubscriptions
-- ----------------------------
DROP TABLE [dbo].[AbpNotificationSubscriptions]
GO
CREATE TABLE [dbo].[AbpNotificationSubscriptions] (
[Id] uniqueidentifier NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[EntityId] nvarchar(96) NULL ,
[EntityTypeAssemblyQualifiedName] nvarchar(512) NULL ,
[EntityTypeName] nvarchar(250) NULL ,
[NotificationName] nvarchar(96) NULL ,
[TenantId] int NULL ,
[UserId] bigint NOT NULL 
)


GO

-- ----------------------------
-- Records of AbpNotificationSubscriptions
-- ----------------------------

-- ----------------------------
-- Table structure for AbpOrganizationUnits
-- ----------------------------
DROP TABLE [dbo].[AbpOrganizationUnits]
GO
CREATE TABLE [dbo].[AbpOrganizationUnits] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[Code] nvarchar(95) NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[DisplayName] nvarchar(128) NOT NULL ,
[IsDeleted] bit NOT NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[ParentId] bigint NULL ,
[TenantId] int NULL 
)


GO

-- ----------------------------
-- Records of AbpOrganizationUnits
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpOrganizationUnits] ON
GO
SET IDENTITY_INSERT [dbo].[AbpOrganizationUnits] OFF
GO

-- ----------------------------
-- Table structure for AbpPermissions
-- ----------------------------
DROP TABLE [dbo].[AbpPermissions]
GO
CREATE TABLE [dbo].[AbpPermissions] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[Discriminator] nvarchar(MAX) NOT NULL ,
[IsGranted] bit NOT NULL ,
[Name] nvarchar(128) NOT NULL ,
[TenantId] int NULL ,
[RoleId] int NULL ,
[UserId] bigint NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpPermissions]', RESEED, 110)
GO

-- ----------------------------
-- Records of AbpPermissions
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpPermissions] ON
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'1', N'2017-10-07 16:00:04.0664220', null, N'RolePermissionSetting', N'1', N'Pages', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'2', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.CatalogGroups.Create', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'3', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.CatalogGroups', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'4', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Tenant.Dashboard', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'5', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.HangfireDashboard', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'6', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Host.Maintenance', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'7', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Tenant.SubscriptionManagement', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'8', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Tenant.Settings', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'9', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.OrganizationUnits.ManageMembers', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'10', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.OrganizationUnits.ManageOrganizationTree', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'11', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.OrganizationUnits', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'12', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.AuditLogs', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'13', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.ChangeTexts', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'14', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.Delete', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'15', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Catalogs', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'16', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.Edit', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'17', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'18', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Impersonation', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'19', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.ChangePermissions', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'20', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Delete', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'21', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Edit', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'22', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Create', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'23', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'24', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles.Delete', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'25', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles.Edit', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'26', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles.Create', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'27', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'28', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'29', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.DemoUiComponents', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'30', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.Create', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'31', N'2017-10-07 16:00:04.0774220', null, N'RolePermissionSetting', N'1', N'Pages.Catalogs.Create', N'1', N'2', N'2')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'32', N'2018-05-10 13:14:19.8304950', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'33', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'34', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.CatalogGroups.Create', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'35', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.CatalogGroups', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'36', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Tenant.Dashboard', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'37', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.HangfireDashboard', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'38', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Host.Maintenance', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'39', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Tenant.SubscriptionManagement', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'40', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Tenant.Settings', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'41', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.OrganizationUnits.ManageMembers', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'42', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.OrganizationUnits.ManageOrganizationTree', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'43', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.OrganizationUnits', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'44', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.AuditLogs', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'45', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.ChangeTexts', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'46', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.Delete', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'47', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Catalogs', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'48', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.Edit', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'49', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'50', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Impersonation', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'51', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.ChangePermissions', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'52', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Delete', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'53', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Edit', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'54', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users.Create', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'55', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Users', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'56', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles.Delete', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'57', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles.Edit', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'58', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles.Create', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'59', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Roles', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'60', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'61', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.DemoUiComponents', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'62', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Administration.Languages.Create', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'63', N'2019-01-21 19:28:38.6770000', null, N'RolePermissionSetting', N'1', N'Pages.Catalogs.Create', N'1', N'2', N'606')
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'64', N'2019-07-18 10:34:05.0782350', N'2', N'RolePermissionSetting', N'1', N'Pages.Dm', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'65', N'2019-07-18 10:34:05.0912400', N'2', N'RolePermissionSetting', N'1', N'Pages.Dm.DeleteLoadedPackage', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'66', N'2019-07-18 10:34:05.0932430', N'2', N'RolePermissionSetting', N'1', N'Pages.Dm.HomePage', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'67', N'2019-07-18 10:34:05.0962380', N'2', N'RolePermissionSetting', N'1', N'Pages.Dm.PackageStatuses', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'68', N'2019-07-18 10:34:05.0992360', N'2', N'RolePermissionSetting', N'1', N'Pages.Dm.Trucks', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'69', N'2019-07-18 10:34:05.1022350', N'2', N'RolePermissionSetting', N'1', N'Pages.Catalogs.UserCatalogs.Import', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'70', N'2019-07-18 10:34:05.1042400', N'2', N'RolePermissionSetting', N'1', N'Pages.Catalogs.CatalogItems.Import', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'71', N'2019-07-18 10:34:05.1072410', N'2', N'RolePermissionSetting', N'1', N'Pages.DeviceManagement', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'72', N'2019-07-18 10:34:05.1092350', N'2', N'RolePermissionSetting', N'1', N'Pages.DeviceManagement.ChangeStatus', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'73', N'2019-07-18 10:34:05.1122350', N'2', N'RolePermissionSetting', N'1', N'Pages.Licensing', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'74', N'2019-07-18 10:34:05.1142360', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'75', N'2019-07-18 10:34:05.1173610', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Users', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'76', N'2019-07-18 10:34:05.1193610', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Users.SpecReturnLimit', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'77', N'2019-07-18 10:34:05.1223630', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Users.PlanConfig', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'78', N'2019-07-18 10:34:05.1253590', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Users.SetPlanMethod', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'79', N'2019-07-18 10:34:05.1273660', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Users.Tasks', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'80', N'2019-07-18 10:34:05.1293670', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.ImportDistByUser', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'81', N'2019-07-18 10:34:05.1324350', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.ImportDistByClient', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'82', N'2019-07-18 10:34:05.1333780', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Plans', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'83', N'2019-07-18 10:34:05.1363650', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Tasks', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'84', N'2019-07-18 10:34:05.1383690', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.AppUserManagement.Tasks.Create', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'85', N'2019-07-18 10:34:05.1405420', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.UserTracking', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'86', N'2019-07-18 10:34:05.1425400', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.ItemManagement', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'87', N'2019-07-18 10:34:05.1445400', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.ItemManagement.ReturnLimits', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'88', N'2019-07-18 10:34:05.1465390', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Items', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'89', N'2019-07-18 10:34:05.1485420', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Items.ReturnLimit', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'90', N'2019-07-18 10:34:05.1515440', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Items.ReturnLimit.Import', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'91', N'2019-07-18 10:34:05.1545380', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'92', N'2019-07-18 10:34:05.1565430', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients.BannedClients', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'93', N'2019-07-18 10:34:05.1595360', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients.BannedClients.Import', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'94', N'2019-07-18 10:34:05.1615360', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients.ClientData', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'95', N'2019-07-18 10:34:05.1635360', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients.ClientData.ItemRestriction', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'96', N'2019-07-18 10:34:05.1655330', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients.ClientData.ItemRestriction.Import', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'97', N'2019-07-18 10:34:05.1675370', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients.ClientData.ClientRoute', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'98', N'2019-07-18 10:34:05.1695370', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Clients.ClientData.ClientRoute.Import', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'99', N'2019-07-18 10:34:05.1715370', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Reporting', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'100', N'2019-07-18 10:34:05.1735370', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Reporting.Penetration', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'101', N'2019-07-18 10:34:05.1765380', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Reporting.PlanFact', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'102', N'2019-07-18 10:34:05.1785460', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Reporting.SalesmanActions', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'103', N'2019-07-18 10:34:05.1805400', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Reporting.ExpeditorWorkFlow', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'104', N'2019-07-18 10:34:05.1825390', N'2', N'RolePermissionSetting', N'1', N'Pages.Mip.Reporting.SalesmanStats', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'105', N'2019-07-18 10:34:05.1855390', N'2', N'RolePermissionSetting', N'1', N'Pages.Faq', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'106', N'2019-07-18 10:34:05.1885480', N'2', N'RolePermissionSetting', N'1', N'Pages.Faq.Update', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'107', N'2019-07-18 10:34:05.1905440', N'2', N'RolePermissionSetting', N'1', N'Pages.Faq.Add', N'1', N'2', null)
GO
GO
INSERT INTO [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (N'108', N'2019-07-18 10:34:05.1122350', N'2', N'UserPermissionSetting', N'1', N'Pages.Licensing', N'1', null, 3)
GO
GO
SET IDENTITY_INSERT [dbo].[AbpPermissions] OFF
GO

-- ----------------------------
-- Table structure for AbpPersistedGrants
-- ----------------------------
DROP TABLE [dbo].[AbpPersistedGrants]
GO
CREATE TABLE [dbo].[AbpPersistedGrants] (
[Id] nvarchar(200) NOT NULL ,
[ClientId] nvarchar(200) NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[Data] nvarchar(MAX) NOT NULL ,
[Expiration] datetime2(7) NULL ,
[SubjectId] nvarchar(200) NULL ,
[Type] nvarchar(50) NOT NULL 
)


GO

-- ----------------------------
-- Records of AbpPersistedGrants
-- ----------------------------

-- ----------------------------
-- Table structure for AbpRoleClaims
-- ----------------------------
DROP TABLE [dbo].[AbpRoleClaims]
GO
CREATE TABLE [dbo].[AbpRoleClaims] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[ClaimType] nvarchar(450) NULL ,
[ClaimValue] nvarchar(MAX) NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[RoleId] int NOT NULL ,
[TenantId] int NULL 
)


GO

-- ----------------------------
-- Records of AbpRoleClaims
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpRoleClaims] ON
GO
SET IDENTITY_INSERT [dbo].[AbpRoleClaims] OFF
GO

-- ----------------------------
-- Table structure for AbpRoles
-- ----------------------------
DROP TABLE [dbo].[AbpRoles]
GO
CREATE TABLE [dbo].[AbpRoles] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ConcurrencyStamp] nvarchar(MAX) NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[DisplayName] nvarchar(64) NOT NULL ,
[IsDefault] bit NOT NULL ,
[IsDeleted] bit NOT NULL ,
[IsStatic] bit NOT NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[Name] nvarchar(32) NOT NULL ,
[NormalizedName] nvarchar(32) NOT NULL ,
[TenantId] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpRoles]', RESEED, 3)
GO

-- ----------------------------
-- Records of AbpRoles
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpRoles] ON
GO
INSERT INTO [dbo].[AbpRoles] ([Id], [ConcurrencyStamp], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [IsDefault], [IsDeleted], [IsStatic], [LastModificationTime], [LastModifierUserId], [Name], [NormalizedName], [TenantId]) VALUES (N'1', N'bfb5aedb-393d-47c4-b678-d88ac21f06bc', N'2017-10-07 16:00:03.8654520', null, null, null, N'Admin', N'1', N'0', N'1', null, null, N'Admin', N'ADMIN', null)
GO
GO
INSERT INTO [dbo].[AbpRoles] ([Id], [ConcurrencyStamp], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [IsDefault], [IsDeleted], [IsStatic], [LastModificationTime], [LastModifierUserId], [Name], [NormalizedName], [TenantId]) VALUES (N'2', N'6c0e4e31-153e-481e-bf49-5e5220957a0b', N'2017-10-07 16:00:04.0514315', null, null, null, N'Admin', N'0', N'0', N'1', null, null, N'Admin', N'ADMIN', N'1')
GO
GO
INSERT INTO [dbo].[AbpRoles] ([Id], [ConcurrencyStamp], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [IsDefault], [IsDeleted], [IsStatic], [LastModificationTime], [LastModifierUserId], [Name], [NormalizedName], [TenantId]) VALUES (N'3', N'f6e5ed67-565e-4517-a546-73d9ed570f19', N'2017-10-07 16:00:04.1235975', null, null, null, N'User', N'1', N'0', N'1', null, null, N'User', N'USER', N'1')
GO
GO
SET IDENTITY_INSERT [dbo].[AbpRoles] OFF
GO

-- ----------------------------
-- Table structure for AbpSettings
-- ----------------------------
DROP TABLE [dbo].[AbpSettings]
GO
CREATE TABLE [dbo].[AbpSettings] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[Name] nvarchar(256) NOT NULL ,
[TenantId] int NULL ,
[UserId] bigint NULL ,
[Value] nvarchar(2000) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpSettings]', RESEED, 3)
GO

-- ----------------------------
-- Records of AbpSettings
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpSettings] ON
GO
INSERT INTO [dbo].[AbpSettings] ([Id], [CreationTime], [CreatorUserId], [LastModificationTime], [LastModifierUserId], [Name], [TenantId], [UserId], [Value]) VALUES (N'1', N'2018-03-29 10:34:24.3952971', null, null, null, N'Abp.Net.Mail.DefaultFromAddress', null, null, N'admin@mydomain.com')
GO
GO
INSERT INTO [dbo].[AbpSettings] ([Id], [CreationTime], [CreatorUserId], [LastModificationTime], [LastModifierUserId], [Name], [TenantId], [UserId], [Value]) VALUES (N'2', N'2018-03-29 10:34:24.5359215', null, null, null, N'Abp.Net.Mail.DefaultFromDisplayName', null, null, N'mydomain.com mailer')
GO
GO
INSERT INTO [dbo].[AbpSettings] ([Id], [CreationTime], [CreatorUserId], [LastModificationTime], [LastModifierUserId], [Name], [TenantId], [UserId], [Value]) VALUES (N'3', N'2018-03-29 10:34:24.5359215', null, null, null, N'Abp.Localization.DefaultLanguageName', null, null, N'en')
GO
GO
SET IDENTITY_INSERT [dbo].[AbpSettings] OFF
GO

-- ----------------------------
-- Table structure for AbpTenantNotifications
-- ----------------------------
DROP TABLE [dbo].[AbpTenantNotifications]
GO
CREATE TABLE [dbo].[AbpTenantNotifications] (
[Id] uniqueidentifier NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[Data] nvarchar(MAX) NULL ,
[DataTypeName] nvarchar(512) NULL ,
[EntityId] nvarchar(96) NULL ,
[EntityTypeAssemblyQualifiedName] nvarchar(512) NULL ,
[EntityTypeName] nvarchar(250) NULL ,
[NotificationName] nvarchar(96) NOT NULL ,
[Severity] tinyint NOT NULL ,
[TenantId] int NULL 
)


GO

-- ----------------------------
-- Records of AbpTenantNotifications
-- ----------------------------

-- ----------------------------
-- Table structure for AbpTenants
-- ----------------------------
DROP TABLE [dbo].[AbpTenants]
GO
CREATE TABLE [dbo].[AbpTenants] (
[Id] int NOT NULL IDENTITY(1,1) ,
[TenancyName] nvarchar(64) NOT NULL ,
[Name] nvarchar(128) NOT NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[IsActive] bit NOT NULL ,
[IsDeleted] bit NOT NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[EditionId] int NULL ,
[ConnectionString] nvarchar(1024) NULL ,
[CustomCssId] uniqueidentifier NULL ,
[LogoId] uniqueidentifier NULL ,
[LogoFileType] nvarchar(64) NULL ,
[IsInTrialPeriod] bit NOT NULL ,
[SubscriptionEndDateUtc] datetime2(7) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpTenants]', RESEED, 1)
GO

-- ----------------------------
-- Records of AbpTenants
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpTenants] ON
GO
INSERT INTO [dbo].[AbpTenants] ([Id], [TenancyName], [Name], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [IsDeleted], [DeleterUserId], [DeletionTime], [EditionId], [ConnectionString], [CustomCssId], [LogoId], [LogoFileType], [IsInTrialPeriod], [SubscriptionEndDateUtc]) VALUES (N'1', N'Default', N'Default', null, null, N'2017-03-06 19:58:37.0100000', null, N'1', N'0', null, null, null, null, null, null, null, N'0', null)
GO
GO
SET IDENTITY_INSERT [dbo].[AbpTenants] OFF
GO

-- ----------------------------
-- Table structure for AbpUserAccounts
-- ----------------------------
DROP TABLE [dbo].[AbpUserAccounts]
GO
CREATE TABLE [dbo].[AbpUserAccounts] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[TenantId] int NULL ,
[UserId] bigint NOT NULL ,
[UserLinkId] bigint NULL ,
[UserName] nvarchar(450) NULL ,
[EmailAddress] nvarchar(450) NULL ,
[IsDeleted] bit NOT NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[LastLoginTime] datetime2(7) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpUserAccounts]', RESEED, 3)
GO

-- ----------------------------
-- Records of AbpUserAccounts
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUserAccounts] ON
GO
INSERT INTO [dbo].[AbpUserAccounts] ([Id], [TenantId], [UserId], [UserLinkId], [UserName], [EmailAddress], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [LastLoginTime]) VALUES (N'1', null, N'1', null, N'admin', N'admin@aspnetzero.com', N'0', null, null, N'2017-06-07 16:25:18.6270000', null, N'2017-03-06 19:58:35.2200000', null, N'2017-06-07 16:25:18.5670000')
GO
GO
INSERT INTO [dbo].[AbpUserAccounts] ([Id], [TenantId], [UserId], [UserLinkId], [UserName], [EmailAddress], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [LastLoginTime]) VALUES (N'2', N'1', N'2', N'2', N'admin', N'admin@defaulttenant.com', N'0', null, null, N'2019-07-18 09:03:29.9639235', null, N'2017-03-06 19:58:42.4500000', null, N'2019-07-18 09:03:29.1769486')
GO
GO
INSERT INTO [dbo].[AbpUserAccounts] ([Id], [TenantId], [UserId], [UserLinkId], [UserName], [EmailAddress], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [LastLoginTime]) VALUES (N'3', N'1', N'3', null, N'service_user', N'support@tayqatech.com', N'0', null, null, null, null, N'2019-07-20 15:35:38.0000000', null, null)
GO
GO
SET IDENTITY_INSERT [dbo].[AbpUserAccounts] OFF
GO

-- ----------------------------
-- Table structure for AbpUserClaims
-- ----------------------------
DROP TABLE [dbo].[AbpUserClaims]
GO
CREATE TABLE [dbo].[AbpUserClaims] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[TenantId] int NULL ,
[UserId] bigint NOT NULL ,
[ClaimType] nvarchar(450) NULL ,
[ClaimValue] nvarchar(MAX) NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL 
)


GO

-- ----------------------------
-- Records of AbpUserClaims
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUserClaims] ON
GO
SET IDENTITY_INSERT [dbo].[AbpUserClaims] OFF
GO

-- ----------------------------
-- Table structure for AbpUserLoginAttempts
-- ----------------------------
DROP TABLE [dbo].[AbpUserLoginAttempts]
GO
CREATE TABLE [dbo].[AbpUserLoginAttempts] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[TenantId] int NULL ,
[TenancyName] nvarchar(64) NULL ,
[UserId] bigint NULL ,
[UserNameOrEmailAddress] nvarchar(255) NULL ,
[ClientIpAddress] nvarchar(64) NULL ,
[ClientName] nvarchar(128) NULL ,
[BrowserInfo] nvarchar(256) NULL ,
[Result] tinyint NOT NULL ,
[CreationTime] datetime2(7) NOT NULL 
)


GO

-- ----------------------------
-- Records of AbpUserLoginAttempts
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUserLoginAttempts] ON
GO
SET IDENTITY_INSERT [dbo].[AbpUserLoginAttempts] OFF
GO

-- ----------------------------
-- Table structure for AbpUserLogins
-- ----------------------------
DROP TABLE [dbo].[AbpUserLogins]
GO
CREATE TABLE [dbo].[AbpUserLogins] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[UserId] bigint NOT NULL ,
[LoginProvider] nvarchar(128) NOT NULL ,
[ProviderKey] nvarchar(256) NOT NULL ,
[TenantId] int NULL 
)


GO

-- ----------------------------
-- Records of AbpUserLogins
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUserLogins] ON
GO
SET IDENTITY_INSERT [dbo].[AbpUserLogins] OFF
GO

-- ----------------------------
-- Table structure for AbpUserNotifications
-- ----------------------------
DROP TABLE [dbo].[AbpUserNotifications]
GO
CREATE TABLE [dbo].[AbpUserNotifications] (
[Id] uniqueidentifier NOT NULL ,
[UserId] bigint NOT NULL ,
[TenantNotificationId] uniqueidentifier NOT NULL ,
[State] int NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[TenantId] int NULL 
)


GO

-- ----------------------------
-- Records of AbpUserNotifications
-- ----------------------------

-- ----------------------------
-- Table structure for AbpUserOrganizationUnits
-- ----------------------------
DROP TABLE [dbo].[AbpUserOrganizationUnits]
GO
CREATE TABLE [dbo].[AbpUserOrganizationUnits] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[UserId] bigint NOT NULL ,
[OrganizationUnitId] bigint NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[TenantId] int NULL ,
[IsDeleted] bit NOT NULL 
)


GO

-- ----------------------------
-- Records of AbpUserOrganizationUnits
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUserOrganizationUnits] ON
GO
SET IDENTITY_INSERT [dbo].[AbpUserOrganizationUnits] OFF
GO

-- ----------------------------
-- Table structure for AbpUserRoles
-- ----------------------------
DROP TABLE [dbo].[AbpUserRoles]
GO
CREATE TABLE [dbo].[AbpUserRoles] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[UserId] bigint NOT NULL ,
[RoleId] int NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[TenantId] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpUserRoles]', RESEED, 3)
GO

-- ----------------------------
-- Records of AbpUserRoles
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUserRoles] ON
GO
INSERT INTO [dbo].[AbpUserRoles] ([Id], [UserId], [RoleId], [CreationTime], [CreatorUserId], [TenantId]) VALUES (N'1', N'1', N'1', N'2017-03-06 19:58:31.0500000', null, null)
GO
GO
INSERT INTO [dbo].[AbpUserRoles] ([Id], [UserId], [RoleId], [CreationTime], [CreatorUserId], [TenantId]) VALUES (N'2', N'2', N'2', N'2017-03-06 19:58:42.1030000', null, N'1')
GO
GO
SET IDENTITY_INSERT [dbo].[AbpUserRoles] OFF
GO

-- ----------------------------
-- Table structure for AbpUsers
-- ----------------------------
DROP TABLE [dbo].[AbpUsers]
GO
CREATE TABLE [dbo].[AbpUsers] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[TenantId] int NULL ,
[Name] nvarchar(32) NOT NULL ,
[Surname] nvarchar(32) NOT NULL ,
[UserName] nvarchar(32) NOT NULL ,
[Password] nvarchar(128) NOT NULL ,
[EmailAddress] nvarchar(256) NOT NULL ,
[IsEmailConfirmed] bit NOT NULL ,
[EmailConfirmationCode] nvarchar(328) NULL ,
[PasswordResetCode] nvarchar(328) NULL ,
[LastLoginTime] datetime2(7) NULL ,
[IsDeleted] bit NOT NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[IsActive] bit NOT NULL ,
[ShouldChangePasswordOnNextLogin] bit NOT NULL ,
[ProfilePictureId] uniqueidentifier NULL ,
[AuthenticationSource] nvarchar(64) NULL ,
[LockoutEndDateUtc] datetime2(7) NULL ,
[AccessFailedCount] int NOT NULL ,
[IsLockoutEnabled] bit NOT NULL ,
[PhoneNumber] nvarchar(MAX) NULL ,
[IsPhoneNumberConfirmed] bit NOT NULL ,
[SecurityStamp] nvarchar(MAX) NULL ,
[IsTwoFactorEnabled] bit NOT NULL ,
[ConcurrencyStamp] nvarchar(MAX) NULL ,
[GoogleAuthenticatorKey] nvarchar(MAX) NULL ,
[NormalizedEmailAddress] nvarchar(256) NOT NULL ,
[NormalizedUserName] nvarchar(32) NOT NULL ,
[SignInToken] nvarchar(MAX) NULL ,
[SignInTokenExpireTimeUtc] datetime2(7) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[AbpUsers]', RESEED, 3)
GO

-- ----------------------------
-- Records of AbpUsers
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUsers] ON
GO
INSERT INTO [dbo].[AbpUsers] ([Id], [TenantId], [Name], [Surname], [UserName], [Password], [EmailAddress], [IsEmailConfirmed], [EmailConfirmationCode], [PasswordResetCode], [LastLoginTime], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [ShouldChangePasswordOnNextLogin], [ProfilePictureId], [AuthenticationSource], [LockoutEndDateUtc], [AccessFailedCount], [IsLockoutEnabled], [PhoneNumber], [IsPhoneNumberConfirmed], [SecurityStamp], [IsTwoFactorEnabled], [ConcurrencyStamp], [GoogleAuthenticatorKey], [NormalizedEmailAddress], [NormalizedUserName], [SignInToken], [SignInTokenExpireTimeUtc]) VALUES (N'1', null, N'admin', N'admin', N'admin', N'ABOSLExhA1dWtSCKQ5PUWdonoOdIK0H+RvLhPDUggwGkLn9bHLylFzEke0OtKhkM6A==', N'admin@aspnetzero.com', N'1', null, null, N'2017-06-07 16:25:18.5670000', N'0', null, null, N'2017-06-07 16:25:18.5670000', null, N'2017-03-06 19:58:30.6470000', null, N'1', N'0', null, null, null, N'0', N'1', null, N'0', N'071c6b47-06d4-0b5f-dc4f-39ddb7299278', N'1', null, null, N'ADMIN@ASPNETZERO.COM', N'ADMIN', null, null)
GO
GO
INSERT INTO [dbo].[AbpUsers] ([Id], [TenantId], [Name], [Surname], [UserName], [Password], [EmailAddress], [IsEmailConfirmed], [EmailConfirmationCode], [PasswordResetCode], [LastLoginTime], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [ShouldChangePasswordOnNextLogin], [ProfilePictureId], [AuthenticationSource], [LockoutEndDateUtc], [AccessFailedCount], [IsLockoutEnabled], [PhoneNumber], [IsPhoneNumberConfirmed], [SecurityStamp], [IsTwoFactorEnabled], [ConcurrencyStamp], [GoogleAuthenticatorKey], [NormalizedEmailAddress], [NormalizedUserName], [SignInToken], [SignInTokenExpireTimeUtc]) VALUES (N'2', N'1', N'admin', N'admin', N'admin', N'AQAAAAEAACcQAAAAEDamYhbjh6V4ne9YAdJMuZ8s2NEowet15XT6w3U8E47x/eWovkUsuVCDGXm4VgzdzA==', N'admin@defaulttenant.com', N'1', null, null, N'2019-07-18 09:03:29.1769486', N'0', null, null, N'2019-07-18 09:03:29.3402573', null, N'2017-03-06 19:58:41.7430000', null, N'1', N'0', null, null, null, N'0', N'1', null, N'0', N'144654ab-f8d7-4231-b1ae-8701e2a2ca99', N'1', N'ff75b6ce-4b3a-4741-aecf-0480a9834e2e', null, N'ADMIN@DEFAULTTENANT.COM', N'ADMIN', N'0677b6d5-6518-486a-85a1-6dc83ee648e7', N'2019-01-26 12:52:03.9113872')
GO
GO
INSERT INTO [dbo].[AbpUsers] ([Id], [TenantId], [Name], [Surname], [UserName], [Password], [EmailAddress], [IsEmailConfirmed], [EmailConfirmationCode], [PasswordResetCode], [LastLoginTime], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [ShouldChangePasswordOnNextLogin], [ProfilePictureId], [AuthenticationSource], [LockoutEndDateUtc], [AccessFailedCount], [IsLockoutEnabled], [PhoneNumber], [IsPhoneNumberConfirmed], [SecurityStamp], [IsTwoFactorEnabled], [ConcurrencyStamp], [GoogleAuthenticatorKey], [NormalizedEmailAddress], [NormalizedUserName], [SignInToken], [SignInTokenExpireTimeUtc]) VALUES (N'3', N'1', N'Service', N'User', N'service_user', N'AQAAAAEAACcQAAAAELoXvfcuFdp14U4iGXuN23RHt6rSWv5RKTnXRY4CHhi4TrUvRjwEyovY/eIjtiNfKw==', N'support@tayqatech.com', N'1', N'', N'', N'2019-07-20 15:14:00.8239752', N'0', null, null, N'2019-07-20 15:14:00.8660275', null, N'2019-01-17 09:56:38.5925406', N'2', N'1', N'0', null, null, null, N'0', N'1', null, N'0', N'5IAHMBSZSV5RXYWKTWSSF6ZHEQCOON4M', N'0', N'aaf61892-56f1-44b0-9c51-16ca3cd5c1a8', null, N'SUPPORT@TAYQATECH.COM', N'SERVICE_USER', null, null)
GO
GO
SET IDENTITY_INSERT [dbo].[AbpUsers] OFF
GO

-- ----------------------------
-- Table structure for AbpUserTokens
-- ----------------------------
DROP TABLE [dbo].[AbpUserTokens]
GO
CREATE TABLE [dbo].[AbpUserTokens] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[LoginProvider] nvarchar(MAX) NULL ,
[Name] nvarchar(MAX) NULL ,
[TenantId] int NULL ,
[UserId] bigint NOT NULL ,
[Value] nvarchar(MAX) NULL ,
[ExpireDate] datetime2(7) NULL 
)


GO

-- ----------------------------
-- Records of AbpUserTokens
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AbpUserTokens] ON
GO
SET IDENTITY_INSERT [dbo].[AbpUserTokens] OFF
GO

-- ----------------------------
-- Table structure for AppBinaryObjects
-- ----------------------------
DROP TABLE [dbo].[AppBinaryObjects]
GO
CREATE TABLE [dbo].[AppBinaryObjects] (
[Id] uniqueidentifier NOT NULL ,
[Bytes] varbinary(MAX) NOT NULL ,
[TenantId] int NULL 
)


GO

-- ----------------------------
-- Records of AppBinaryObjects
-- ----------------------------

-- ----------------------------
-- Table structure for AppChatMessages
-- ----------------------------
DROP TABLE [dbo].[AppChatMessages]
GO
CREATE TABLE [dbo].[AppChatMessages] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[Message] nvarchar(MAX) NOT NULL ,
[ReadState] int NOT NULL ,
[Side] int NOT NULL ,
[TargetTenantId] int NULL ,
[TargetUserId] bigint NOT NULL ,
[TenantId] int NULL ,
[UserId] bigint NOT NULL 
)


GO

-- ----------------------------
-- Records of AppChatMessages
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AppChatMessages] ON
GO
SET IDENTITY_INSERT [dbo].[AppChatMessages] OFF
GO

-- ----------------------------
-- Table structure for AppFriendships
-- ----------------------------
DROP TABLE [dbo].[AppFriendships]
GO
CREATE TABLE [dbo].[AppFriendships] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[FriendProfilePictureId] uniqueidentifier NULL ,
[FriendTenancyName] nvarchar(MAX) NULL ,
[FriendTenantId] int NULL ,
[FriendUserId] bigint NOT NULL ,
[FriendUserName] nvarchar(32) NOT NULL ,
[State] int NOT NULL ,
[TenantId] int NULL ,
[UserId] bigint NOT NULL 
)


GO

-- ----------------------------
-- Records of AppFriendships
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AppFriendships] ON
GO
SET IDENTITY_INSERT [dbo].[AppFriendships] OFF
GO

-- ----------------------------
-- Table structure for AppSubscriptionPayments
-- ----------------------------
DROP TABLE [dbo].[AppSubscriptionPayments]
GO
CREATE TABLE [dbo].[AppSubscriptionPayments] (
[Id] bigint NOT NULL IDENTITY(1,1) ,
[Amount] decimal(18,2) NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[DayCount] int NOT NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[EditionId] int NOT NULL ,
[Gateway] int NOT NULL ,
[IsDeleted] bit NOT NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[PaymentId] nvarchar(450) NULL ,
[PaymentPeriodType] int NULL ,
[Status] int NOT NULL ,
[TenantId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of AppSubscriptionPayments
-- ----------------------------
SET IDENTITY_INSERT [dbo].[AppSubscriptionPayments] ON
GO
SET IDENTITY_INSERT [dbo].[AppSubscriptionPayments] OFF
GO

-- ----------------------------
-- Table structure for DF_ClientGroupType
-- ----------------------------
DROP TABLE [dbo].[DF_ClientGroupType]
GO
CREATE TABLE [dbo].[DF_ClientGroupType] (
[Type] smallint NOT NULL ,
[Name] nvarchar(50) NOT NULL 
)


GO

-- ----------------------------
-- Records of DF_ClientGroupType
-- ----------------------------
INSERT INTO [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (N'1', N'Price Group')
GO
GO
INSERT INTO [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (N'2', N'Warehouse Group')
GO
GO
INSERT INTO [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (N'3', N'Catalog Group')
GO
GO
INSERT INTO [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (N'4', N'Suggested Price Group')
GO
GO

-- ----------------------------
-- Table structure for DM_AutoPark
-- ----------------------------
DROP TABLE [dbo].[DM_AutoPark]
GO
CREATE TABLE [dbo].[DM_AutoPark] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Description] nvarchar(300) NULL ,
[Name] nvarchar(30) NOT NULL ,
[Number] nvarchar(20) NOT NULL ,
[SpecialCode1] nvarchar(20) NULL ,
[SpecialCode2] nvarchar(20) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[DM_AutoPark]', RESEED, 2)
GO

-- ----------------------------
-- Records of DM_AutoPark
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_AutoPark] ON
GO
INSERT INTO [dbo].[DM_AutoPark] ([Id], [Description], [Name], [Number], [SpecialCode1], [SpecialCode2]) VALUES (N'1', N'Test1 Description', N'Test1', N'1000', N'11', N'12')
GO
GO
INSERT INTO [dbo].[DM_AutoPark] ([Id], [Description], [Name], [Number], [SpecialCode1], [SpecialCode2]) VALUES (N'2', N'Test2 Description', N'Test2', N'1002', N'13', N'14')
GO
GO
SET IDENTITY_INSERT [dbo].[DM_AutoPark] OFF
GO

-- ----------------------------
-- Table structure for DM_Invoice
-- ----------------------------
DROP TABLE [dbo].[DM_Invoice]
GO
CREATE TABLE [dbo].[DM_Invoice] (
[Id] int NOT NULL ,
[RequestId] int NOT NULL ,
[AppDocId] varchar(50) NOT NULL ,
[Firm] smallint NOT NULL ,
[ERPId] int NOT NULL ,
[FicheNo] nvarchar(20) NOT NULL ,
[DeliveryOrderId] int NULL ,
[ClientId] int NOT NULL ,
[Date] date NOT NULL ,
[Status] tinyint NOT NULL ,
[Warehouse] int NOT NULL ,
[Division] smallint NOT NULL ,
[Department] smallint NULL ,
[Factory] smallint NULL ,
[OptAffectCollatrl] bit NULL ,
[DockTrackingNo] nvarchar(20) NULL ,
[Type] tinyint NOT NULL ,
[SalesmanId] int NULL ,
[SpecialCode] nvarchar(255) NULL ,
[SpecialCode1] nvarchar(20) NULL ,
[SpecialCode2] nvarchar(20) NULL ,
[SpecialCode3] nvarchar(20) NULL ,
[SpecialCode4] nvarchar(20) NULL ,
[SpecialCode5] nvarchar(20) NULL ,
[TradingGroup] nvarchar(50) NULL ,
[PaymentPlanId] int NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[Note] nvarchar(255) NULL ,
[IsDeleted] bit NOT NULL DEFAULT ((0)) ,
[IsInRoute] bit NOT NULL ,
[DocCreatedDate] datetime NOT NULL ,
[DeletedUserId] bigint NULL ,
[LastModificationTime] datetime NULL ,
[DeletionTime] datetime NULL ,
[GpsLongitude] float(53) NULL ,
[GpsLatitude] float(53) NULL 
)


GO

-- ----------------------------
-- Records of DM_Invoice
-- ----------------------------

-- ----------------------------
-- Table structure for DM_InvoiceLine
-- ----------------------------
DROP TABLE [dbo].[DM_InvoiceLine]
GO
CREATE TABLE [dbo].[DM_InvoiceLine] (
[Id] int NOT NULL IDENTITY(1,1) ,
[InvoiceId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitCode] nvarchar(50) NOT NULL ,
[Amount] float(53) NOT NULL ,
[Price] float(53) NOT NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[IsPromo] bit NULL ,
[BeepCount] smallint NULL ,
[VatAmount] float(53) NULL ,
[IsVatIncluded] bit NULL 
)


GO

-- ----------------------------
-- Records of DM_InvoiceLine
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_InvoiceLine] ON
GO
SET IDENTITY_INSERT [dbo].[DM_InvoiceLine] OFF
GO

-- ----------------------------
-- Table structure for DM_Order
-- ----------------------------
DROP TABLE [dbo].[DM_Order]
GO
CREATE TABLE [dbo].[DM_Order] (
[Id] int NOT NULL ,
[Firm] smallint NOT NULL ,
[ERPId] int NOT NULL ,
[OrderFicheNo] nvarchar(20) NOT NULL ,
[ClientId] int NOT NULL ,
[OrderDate] date NOT NULL ,
[DeliveryDate] date NULL ,
[Status] tinyint NOT NULL ,
[Warehouse] int NOT NULL ,
[Division] smallint NOT NULL ,
[Department] smallint NOT NULL ,
[Factory] smallint NULL ,
[OptAffectCollatrl] bit NULL ,
[DockTrackingNo] nvarchar(20) NULL ,
[OrderType] tinyint NOT NULL ,
[SalesmanRef] int NOT NULL ,
[SpecialCode] nvarchar(255) NULL ,
[SpecialCode1] nvarchar(20) NULL ,
[SpecialCode2] nvarchar(20) NULL ,
[SpecialCode3] nvarchar(20) NULL ,
[SpecialCode4] nvarchar(20) NULL ,
[SpecialCode5] nvarchar(20) NULL ,
[TradingGroup] nvarchar(50) NULL ,
[PaymentPlanId] int NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[Note] nvarchar(255) NULL ,
[IsInRoute] bit NOT NULL ,
[CreationTime] datetime NOT NULL ,
[DeleterUserId] bigint NULL ,
[LastModificationTime] datetime NULL ,
[DeletionTime] datetime NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsProcessed] bit NOT NULL DEFAULT ((0)) ,
[IsExcluded] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of DM_Order
-- ----------------------------

-- ----------------------------
-- Table structure for DM_OrderLine
-- ----------------------------
DROP TABLE [dbo].[DM_OrderLine]
GO
CREATE TABLE [dbo].[DM_OrderLine] (
[Id] int NOT NULL IDENTITY(1,1) ,
[OrderId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitCode] nvarchar(50) NOT NULL ,
[Amount] float(53) NOT NULL ,
[Price] float(53) NOT NULL ,
[VatAmount] float(53) NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[IsPromo] bit NULL ,
[VatRate] float(53) NULL 
)


GO

-- ----------------------------
-- Records of DM_OrderLine
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_OrderLine] ON
GO
SET IDENTITY_INSERT [dbo].[DM_OrderLine] OFF
GO

-- ----------------------------
-- Table structure for DM_OrderStock
-- ----------------------------
DROP TABLE [dbo].[DM_OrderStock]
GO
CREATE TABLE [dbo].[DM_OrderStock] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ItemId] int NOT NULL ,
[ItemUnitCode] nvarchar(50) NOT NULL ,
[Amount] float(53) NOT NULL ,
[PackageId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of DM_OrderStock
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_OrderStock] ON
GO
SET IDENTITY_INSERT [dbo].[DM_OrderStock] OFF
GO

-- ----------------------------
-- Table structure for DM_ProcessingQueue
-- ----------------------------
DROP TABLE [dbo].[DM_ProcessingQueue]
GO
CREATE TABLE [dbo].[DM_ProcessingQueue] (
[Firm] smallint NOT NULL ,
[Period] smallint NOT NULL ,
[DeliveryOrderId] int NOT NULL ,
[RequestId] int NOT NULL ,
[DocId] varchar(50) NOT NULL ,
[UserId] int NOT NULL ,
[ERPTransactionId] int NULL ,
[GeneralId] int NULL ,
[GpsLatitude] float(53) NULL ,
[GpsLongitude] float(53) NULL ,
[ProcessingStatus] bit NULL DEFAULT ((0)) ,
[ConsiderOrder] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of DM_ProcessingQueue
-- ----------------------------

-- ----------------------------
-- Table structure for DM_ProcessingLog
-- ----------------------------
DROP TABLE [dbo].[DM_ProcessingLog]
GO
CREATE TABLE [dbo].[DM_ProcessingLog] (
[GeneralId] int NOT NULL ,
[DeliveryOrderId] int NOT NULL ,
[ERPTransactionId] int NOT NULL ,
[StartdDate] datetime NOT NULL DEFAULT (getdate()) ,
[FinalizedDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of DM_ProcessingLog
-- ----------------------------

-- ----------------------------
-- Table structure for DM_Setting
-- ----------------------------
DROP TABLE [dbo].[DM_Setting]
GO
CREATE TABLE [dbo].[DM_Setting] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[DeviceId] uniqueidentifier NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[Name] nvarchar(50) NOT NULL ,
[Value] nvarchar(30) NOT NULL 
)


GO

-- ----------------------------
-- Records of DM_Setting
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_Setting] ON
GO
SET IDENTITY_INSERT [dbo].[DM_Setting] OFF
GO

-- ----------------------------
-- Table structure for DM_SpecialCode
-- ----------------------------
DROP TABLE [dbo].[DM_SpecialCode]
GO
CREATE TABLE [dbo].[DM_SpecialCode] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Description] nvarchar(100) NOT NULL ,
[SpecialCode1] bit NOT NULL ,
[SpecialCode2] bit NOT NULL ,
[SpecialCode3] bit NOT NULL ,
[SpecialCode4] bit NOT NULL ,
[Type] tinyint NOT NULL ,
[Value] nvarchar(20) NOT NULL 
)


GO

-- ----------------------------
-- Records of DM_SpecialCode
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_SpecialCode] ON
GO
SET IDENTITY_INSERT [dbo].[DM_SpecialCode] OFF
GO

-- ----------------------------
-- Table structure for DM_TransportClient
-- ----------------------------
DROP TABLE [dbo].[DM_TransportClient]
GO
CREATE TABLE [dbo].[DM_TransportClient] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ArriveTime] datetime2(7) NULL ,
[ClientFirm] smallint NOT NULL ,
[ClientTigerId] int NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[DeliveryNote] nvarchar(200) NULL ,
[DeliveryOrder] smallint NOT NULL ,
[DeliveryStatus] tinyint NOT NULL ,
[DepartureTime] datetime2(7) NULL ,
[EstimatedArriveTime] datetime2(7) NULL ,
[EstimatedDistance] float(53) NULL ,
[EstimatedSpentTime] float(53) NULL ,
[LastModificationTime] datetime2(7) NULL ,
[TransportPackageId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of DM_TransportClient
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_TransportClient] ON
GO
SET IDENTITY_INSERT [dbo].[DM_TransportClient] OFF
GO

-- ----------------------------
-- Table structure for DM_TransportOrder
-- ----------------------------
DROP TABLE [dbo].[DM_TransportOrder]
GO
CREATE TABLE [dbo].[DM_TransportOrder] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[DeliveryStatus] tinyint NOT NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[OrderId] int NOT NULL ,
[TransportClientId] int NOT NULL ,
[GpsLongitude] float(53) NULL ,
[GpsLatitude] float(53) NULL 
)


GO

-- ----------------------------
-- Records of DM_TransportOrder
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_TransportOrder] ON
GO
SET IDENTITY_INSERT [dbo].[DM_TransportOrder] OFF
GO

-- ----------------------------
-- Table structure for DM_TransportPackage
-- ----------------------------
DROP TABLE [dbo].[DM_TransportPackage]
GO
CREATE TABLE [dbo].[DM_TransportPackage] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Color] nvarchar(20) NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[CreatorUserId] bigint NULL ,
[DepartureWarehouseGroupId] smallint NULL ,
[EstimatedTripCompletionTime] datetime2(7) NULL ,
[LastModificationTime] datetime2(7) NULL ,
[LastModifierUserId] bigint NULL ,
[Region] tinyint NULL ,
[TotalDistance] float(53) NULL ,
[TotalDuration] float(53) NULL ,
[TransportRoute] nvarchar(MAX) NULL ,
[TransportStatusId] tinyint NOT NULL ,
[TruckId] int NULL ,
[StartTime] datetime NULL ,
[EndTime] datetime NULL ,
[UserId] bigint NULL ,
[ActualStartTime] datetime NULL ,
[ActualEndTime] datetime NULL ,
[Description] nvarchar(200) NULL ,
[Status] tinyint NULL ,
[Firm] smallint NOT NULL DEFAULT ((9)) 
)


GO

-- ----------------------------
-- Records of DM_TransportPackage
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_TransportPackage] ON
GO
SET IDENTITY_INSERT [dbo].[DM_TransportPackage] OFF
GO

-- ----------------------------
-- Table structure for DM_TransportStatus
-- ----------------------------
DROP TABLE [dbo].[DM_TransportStatus]
GO
CREATE TABLE [dbo].[DM_TransportStatus] (
[Id] tinyint NOT NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[Description] nvarchar(100) NULL ,
[Name] nvarchar(50) NOT NULL 
)


GO

-- ----------------------------
-- Records of DM_TransportStatus
-- ----------------------------
INSERT INTO [dbo].[DM_TransportStatus] ([Id], [CreationTime], [Description], [Name]) VALUES (N'1', N'2017-07-25 09:23:45.5270000', N'Planlanır', N'Created')
GO
GO
INSERT INTO [dbo].[DM_TransportStatus] ([Id], [CreationTime], [Description], [Name]) VALUES (N'2', N'2017-07-25 09:24:02.7370000', N'Tamamlanmış', N'Assigned')
GO
GO
INSERT INTO [dbo].[DM_TransportStatus] ([Id], [CreationTime], [Description], [Name]) VALUES (N'4', N'2017-07-25 09:24:26.1000000', N'Hazır', N'Loaded')
GO
GO
INSERT INTO [dbo].[DM_TransportStatus] ([Id], [CreationTime], [Description], [Name]) VALUES (N'5', N'2017-07-25 09:28:32.4700000', N'Yolda', N'EnRoute')
GO
GO
INSERT INTO [dbo].[DM_TransportStatus] ([Id], [CreationTime], [Description], [Name]) VALUES (N'6', N'2017-07-25 09:32:44.8770000', N'Daşınıb', N'Completed')
GO
GO
INSERT INTO [dbo].[DM_TransportStatus] ([Id], [CreationTime], [Description], [Name]) VALUES (N'7', N'2017-07-29 10:35:25.1400000', N'Admin tərəfindən sonlanıb', N'ManualCompleted')
GO
GO

-- ----------------------------
-- Table structure for DM_Truck
-- ----------------------------
DROP TABLE [dbo].[DM_Truck]
GO
CREATE TABLE [dbo].[DM_Truck] (
[Id] int NOT NULL IDENTITY(1,1) ,
[AutoParkId] int NOT NULL ,
[AverageCapacity] float(53) NOT NULL ,
[AverageWeight] float(53) NOT NULL ,
[BreakDuration] int NOT NULL ,
[BreakEndTime] time(7) NOT NULL ,
[BreakStartTime] time(7) NOT NULL ,
[DailyCost] decimal(18,2) NOT NULL ,
[DistanceCost] decimal(18,2) NOT NULL ,
[HasAirConditioner] bit NOT NULL ,
[HasShelf] bit NOT NULL ,
[IsVirtual] bit NOT NULL ,
[MaximumCapacity] float(53) NOT NULL ,
[MaximumClientCount] int NOT NULL ,
[MaximumClientGroupCount] int NOT NULL ,
[MaximumWeight] float(53) NOT NULL ,
[Model] nvarchar(20) NOT NULL ,
[Number] nvarchar(20) NOT NULL ,
[SpecialCode1] nvarchar(20) NULL ,
[SpecialCode2] nvarchar(20) NULL ,
[Status] tinyint NOT NULL ,
[TruckGroupId] int NOT NULL ,
[TruckTypeId] smallint NULL ,
[WorkingEndTime] time(7) NOT NULL ,
[WorkingStartTime] time(7) NOT NULL 
)


GO

-- ----------------------------
-- Records of DM_Truck
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_Truck] ON
GO
SET IDENTITY_INSERT [dbo].[DM_Truck] OFF
GO

-- ----------------------------
-- Table structure for DM_TruckGroup
-- ----------------------------
DROP TABLE [dbo].[DM_TruckGroup]
GO
CREATE TABLE [dbo].[DM_TruckGroup] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Description] nvarchar(300) NULL ,
[GroupCode] nvarchar(20) NULL ,
[Name] nvarchar(30) NOT NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[DM_TruckGroup]', RESEED, 2)
GO

-- ----------------------------
-- Records of DM_TruckGroup
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_TruckGroup] ON
GO
INSERT INTO [dbo].[DM_TruckGroup] ([Id], [Description], [GroupCode], [Name]) VALUES (N'1', N'Ordinal Group Description', N'45', N'Ordinal')
GO
GO
INSERT INTO [dbo].[DM_TruckGroup] ([Id], [Description], [GroupCode], [Name]) VALUES (N'2', N'VIP Group Description', N'56', N'VIP')
GO
GO
SET IDENTITY_INSERT [dbo].[DM_TruckGroup] OFF
GO

-- ----------------------------
-- Table structure for DM_TruckType
-- ----------------------------
DROP TABLE [dbo].[DM_TruckType]
GO
CREATE TABLE [dbo].[DM_TruckType] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(50) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[DM_TruckType]', RESEED, 3)
GO

-- ----------------------------
-- Records of DM_TruckType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[DM_TruckType] ON
GO
INSERT INTO [dbo].[DM_TruckType] ([Id], [Name]) VALUES (N'1', N'Furqon')
GO
GO
INSERT INTO [dbo].[DM_TruckType] ([Id], [Name]) VALUES (N'2', N'Furqon soyuducu')
GO
GO
INSERT INTO [dbo].[DM_TruckType] ([Id], [Name]) VALUES (N'3', N'Vaqon')
GO
GO
SET IDENTITY_INSERT [dbo].[DM_TruckType] OFF
GO

-- ----------------------------
-- Table structure for LM_Campaign
-- ----------------------------
DROP TABLE [dbo].[LM_Campaign]
GO
CREATE TABLE [dbo].[LM_Campaign] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Title] nvarchar(100) NOT NULL ,
[Description] nvarchar(100) NULL ,
[ShortDescription] nvarchar(500) NULL ,
[LongDescription] nvarchar(MAX) NULL ,
[StartDate] datetime NOT NULL ,
[EndDate] datetime NOT NULL ,
[VisibleFrom] datetime NULL ,
[VisibleTo] datetime NULL ,
[Image1] varchar(100) NULL ,
[Image2] varchar(100) NULL ,
[Image3] varchar(100) NULL ,
[Video1] varchar(100) NULL ,
[Video2] varchar(100) NULL ,
[Video3] varchar(100) NULL ,
[IsActive] bit NOT NULL DEFAULT ((1)) ,
[CreatedUserId] int NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[ModifiedDate] datetime NULL ,
[ModifiedUserId] int NULL 
)


GO

-- ----------------------------
-- Records of LM_Campaign
-- ----------------------------
SET IDENTITY_INSERT [dbo].[LM_Campaign] ON
GO
SET IDENTITY_INSERT [dbo].[LM_Campaign] OFF
GO

-- ----------------------------
-- Table structure for LM_UserCampaign
-- ----------------------------
DROP TABLE [dbo].[LM_UserCampaign]
GO
CREATE TABLE [dbo].[LM_UserCampaign] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[CampaignId] int NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of LM_UserCampaign
-- ----------------------------
SET IDENTITY_INSERT [dbo].[LM_UserCampaign] ON
GO
SET IDENTITY_INSERT [dbo].[LM_UserCampaign] OFF
GO

-- ----------------------------
-- Table structure for MC_ClientMediaInfo
-- ----------------------------
DROP TABLE [dbo].[MC_ClientMediaInfo]
GO
CREATE TABLE [dbo].[MC_ClientMediaInfo] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[Title] nvarchar(100) NULL ,
[Description] nvarchar(500) NULL ,
[Url] nvarchar(500) NULL ,
[Version] nvarchar(50) NULL ,
[ContentType] smallint NULL ,
[Status] bit NULL ,
[ValidFrom] datetime NULL ,
[ValidTo] datetime NULL ,
[PublishedDate] datetime NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MC_ClientMediaInfo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MC_ClientMediaInfo] ON
GO
SET IDENTITY_INSERT [dbo].[MC_ClientMediaInfo] OFF
GO

-- ----------------------------
-- Table structure for MD_AuditCatalog
-- ----------------------------
DROP TABLE [dbo].[MD_AuditCatalog]
GO
CREATE TABLE [dbo].[MD_AuditCatalog] (
[Id] int NOT NULL ,
[Firm] smallint NOT NULL ,
[CatalogGroupId] int NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Specode] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_AuditCatalog
-- ----------------------------

-- ----------------------------
-- Table structure for MD_AuditCatalogGroup
-- ----------------------------
DROP TABLE [dbo].[MD_AuditCatalogGroup]
GO
CREATE TABLE [dbo].[MD_AuditCatalogGroup] (
[Id] int NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NULL ,
[RegisteredDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_AuditCatalogGroup
-- ----------------------------

-- ----------------------------
-- Table structure for MD_AuditCatalogItemMapping
-- ----------------------------
DROP TABLE [dbo].[MD_AuditCatalogItemMapping]
GO
CREATE TABLE [dbo].[MD_AuditCatalogItemMapping] (
[CatalogId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[AvaliableFlag] bit NOT NULL ,
[PriceFlag] bit NOT NULL ,
[StockFlag] bit NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_AuditCatalogItemMapping
-- ----------------------------

-- ----------------------------
-- Table structure for MD_AuditPermitedCatalog
-- ----------------------------
DROP TABLE [dbo].[MD_AuditPermitedCatalog]
GO
CREATE TABLE [dbo].[MD_AuditPermitedCatalog] (
[UserId] int NOT NULL ,
[CatalogId] smallint NOT NULL ,
[RegisteredDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_AuditPermitedCatalog
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Bank
-- ----------------------------
DROP TABLE [dbo].[MD_Bank]
GO
CREATE TABLE [dbo].[MD_Bank] (
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[Status] bit NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[Branch] nvarchar(100) NULL ,
[Specode] nvarchar(100) NULL ,
[BranchNo] nvarchar(50) NULL ,
[Country] nvarchar(50) NULL ,
[City] nvarchar(50) NULL ,
[Address] nvarchar(100) NULL ,
[AddressExtension] nvarchar(100) NULL ,
[Postcode] nvarchar(50) NULL ,
[Telephone] nvarchar(50) NULL ,
[FaxNo] nvarchar(50) NULL ,
[Incharge] nvarchar(50) NULL ,
[Email] nvarchar(50) NULL ,
[WebAddress] nvarchar(50) NULL ,
[CorporateAccount] nvarchar(50) NULL ,
[RegisteredDate] datetime NOT NULL ,
[IsDeleted] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of MD_Bank
-- ----------------------------

-- ----------------------------
-- Table structure for MD_BankAccount
-- ----------------------------
DROP TABLE [dbo].[MD_BankAccount]
GO
CREATE TABLE [dbo].[MD_BankAccount] (
[Firm] smallint NOT NULL ,
[BankTigerId] int NOT NULL ,
[TigerId] int NOT NULL ,
[Status] bit NOT NULL ,
[Type] smallint NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Specode] nvarchar(50) NULL ,
[CurrencyType] smallint NOT NULL ,
[AccountNo] nvarchar(100) NULL ,
[Iban] nvarchar(100) NULL ,
[RegisteredDate] datetime NOT NULL ,
[IsDeleted] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of MD_BankAccount
-- ----------------------------

-- ----------------------------
-- Table structure for MD_BannedClient
-- ----------------------------
DROP TABLE [dbo].[MD_BannedClient]
GO
CREATE TABLE [dbo].[MD_BannedClient] (
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[Status] bit NOT NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of MD_BannedClient
-- ----------------------------

-- ----------------------------
-- Table structure for MD_BannedClientLog
-- ----------------------------
DROP TABLE [dbo].[MD_BannedClientLog]
GO
CREATE TABLE [dbo].[MD_BannedClientLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[Action] tinyint NOT NULL ,
[OldStatus] bit NULL ,
[NewStatus] bit NOT NULL ,
[Note] nvarchar(255) NULL ,
[CreatedUserId] int NULL ,
[CreatedDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_BannedClientLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_BannedClientLog] ON
GO
SET IDENTITY_INSERT [dbo].[MD_BannedClientLog] OFF
GO

-- ----------------------------
-- Table structure for MD_CashCard
-- ----------------------------
DROP TABLE [dbo].[MD_CashCard]
GO
CREATE TABLE [dbo].[MD_CashCard] (
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[Status] bit NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_CashCard
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Catalog
-- ----------------------------
DROP TABLE [dbo].[MD_Catalog]
GO
CREATE TABLE [dbo].[MD_Catalog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[CatalogGroupId] int NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Specode] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_Catalog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_Catalog] ON
GO
SET IDENTITY_INSERT [dbo].[MD_Catalog] OFF
GO

-- ----------------------------
-- Table structure for MD_CatalogCompetingItemMapping
-- ----------------------------
DROP TABLE [dbo].[MD_CatalogCompetingItemMapping]
GO
CREATE TABLE [dbo].[MD_CatalogCompetingItemMapping] (
[CatalogId] int NOT NULL ,
[CompetingItemId] int NOT NULL ,
[CanSell] bit NOT NULL ,
[CanReturn] bit NOT NULL ,
[IsSpecial] bit NOT NULL ,
[IsOffered] bit NOT NULL ,
[Mastock] bit NOT NULL ,
[ForAudit] bit NOT NULL ,
[MinStock] int NOT NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_CatalogCompetingItemMapping
-- ----------------------------

-- ----------------------------
-- Table structure for MD_CatalogGroup
-- ----------------------------
DROP TABLE [dbo].[MD_CatalogGroup]
GO
CREATE TABLE [dbo].[MD_CatalogGroup] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_CatalogGroup
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_CatalogGroup] ON
GO
SET IDENTITY_INSERT [dbo].[MD_CatalogGroup] OFF
GO

-- ----------------------------
-- Table structure for MD_CatalogItemMapping
-- ----------------------------
DROP TABLE [dbo].[MD_CatalogItemMapping]
GO
CREATE TABLE [dbo].[MD_CatalogItemMapping] (
[CatalogId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[CanSell] bit NOT NULL ,
[CanReturn] bit NOT NULL ,
[IsSpecial] bit NOT NULL ,
[IsOffered] bit NOT NULL ,
[Mastock] bit NOT NULL ,
[MinStock] int NOT NULL ,
[ForAudit] bit NULL ,
[CanPromote] bit NULL ,
[IsDecimal] bit NULL ,
[RegisteredDate] datetime2(7) NOT NULL DEFAULT ('1900-01-01') ,
[ModifiedDate] datetime2(7) NULL ,
[OrderNo] int NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of MD_CatalogItemMapping
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Client
-- ----------------------------
DROP TABLE [dbo].[MD_Client]
GO
CREATE TABLE [dbo].[MD_Client] (
[Status] bit NOT NULL ,
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[CardType] tinyint NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[Address] nvarchar(400) NOT NULL ,
[AddressExtension] nvarchar(400) NULL ,
[Country] nvarchar(50) NULL ,
[City] nvarchar(50) NULL ,
[Town] nvarchar(50) NULL ,
[District] nvarchar(50) NULL ,
[Telephone] nvarchar(50) NULL ,
[Taxno] nvarchar(50) NULL ,
[TradingGroupCode] nvarchar(50) NULL ,
[Edino] nvarchar(50) NULL ,
[InCharge] nvarchar(50) NULL ,
[SpecialCode] nvarchar(50) NULL ,
[SpecialCodeDesc] nvarchar(50) NULL ,
[SpecialCode2] nvarchar(50) NULL ,
[SpecialCode2Desc] nvarchar(50) NULL ,
[SpecialCode3] nvarchar(50) NULL ,
[SpecialCode3Desc] nvarchar(50) NULL ,
[SpecialCode4] nvarchar(50) NULL ,
[SpecialCode4Desc] nvarchar(50) NULL ,
[SpecialCode5] nvarchar(50) NULL ,
[SpecialCode5Desc] nvarchar(50) NULL ,
[AuthorizationCode] nvarchar(50) NULL ,
[AuthorizationCodeDesc] nvarchar(50) NULL ,
[Longitude] float(53) NULL ,
[Latitude] float(53) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[TigerParentId] int NULL ,
[IsDeleted] bit NULL ,
[GroupId] int NULL ,
[IdentityNo] nvarchar(50) NULL ,
[WarehouseGroupId] int NULL ,
[PaymentPlanId] int NULL ,
[SyncFlag] bit NULL DEFAULT ((0)) ,
[Name2] nvarchar(100) NULL 
)


GO

-- ----------------------------
-- Records of MD_Client
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ClientFinanceData
-- ----------------------------
DROP TABLE [dbo].[MD_ClientFinanceData]
GO
CREATE TABLE [dbo].[MD_ClientFinanceData] (
[TigerId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[PaymentPlanId] int NULL ,
[AccumulatedRiskLimit] float(53) NOT NULL ,
[SelfCheckVoucherRiskLimit] float(53) NOT NULL ,
[ClientCheckVoucherRiskLimit] float(53) NOT NULL ,
[CheckVoucherCirculationRiskLimit] float(53) NOT NULL ,
[DispatchRiskLimit] float(53) NOT NULL ,
[DispatchProposalRiskLimit] float(53) NOT NULL ,
[OrderRiskLimit] float(53) NOT NULL ,
[OrderProposalRiskLimit] float(53) NOT NULL ,
[ClosedRisk] float(53) NULL ,
[TotalRisk] float(53) NULL ,
[RegisteredDate] datetime NOT NULL ,
[IsDeleted] bit NOT NULL DEFAULT ((0)) ,
[Status] bit NOT NULL DEFAULT ((0)) ,
[Debit] float(53) NULL DEFAULT ((0)) ,
[Credit] float(53) NULL DEFAULT ((0)) ,
[Balance] float(53) NULL DEFAULT ((0)) ,
[CurrencyTypeId] smallint NULL DEFAULT ((0)) ,
[PayplansCode] nvarchar(100) NULL DEFAULT (N'') ,
[PayplansName] nvarchar(250) NULL DEFAULT (N'') ,
[AccRiskLimit] float(53) NULL DEFAULT ((0)) ,
[MycsRiskLimit] float(53) NULL DEFAULT ((0)) ,
[CstcsRiskLimit] float(53) NULL DEFAULT ((0)) ,
[CstcsciroRiskLimit] float(53) NULL DEFAULT ((0)) ,
[DespRiskLimit] float(53) NULL DEFAULT ((0)) ,
[DespRiskLimitSug] float(53) NULL DEFAULT ((0)) ,
[OrdRiskLimit] float(53) NULL DEFAULT ((0)) ,
[OrdRiskLimitSugg] float(53) NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of MD_ClientFinanceData
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ClientGpsData
-- ----------------------------
DROP TABLE [dbo].[MD_ClientGpsData]
GO
CREATE TABLE [dbo].[MD_ClientGpsData] (
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[Latitude] float(53) NULL ,
[Longitude] float(53) NULL ,
[Note] nvarchar(400) NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of MD_ClientGpsData
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ClientGroupCatalogRestriction
-- ----------------------------
DROP TABLE [dbo].[MD_ClientGroupCatalogRestriction]
GO
CREATE TABLE [dbo].[MD_ClientGroupCatalogRestriction] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NULL ,
[ClientGroupId] int NOT NULL ,
[CatalogId] int NOT NULL ,
[Type] tinyint NOT NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedUserId] int NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[Firm] smallint NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_ClientGroupCatalogRestriction
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_ClientGroupCatalogRestriction] ON
GO
SET IDENTITY_INSERT [dbo].[MD_ClientGroupCatalogRestriction] OFF
GO

-- ----------------------------
-- Table structure for MD_ClientGroupData
-- ----------------------------
DROP TABLE [dbo].[MD_ClientGroupData]
GO
CREATE TABLE [dbo].[MD_ClientGroupData] (
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[GroupType] smallint NOT NULL ,
[GroupId] int NOT NULL ,
[RegisteredDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_ClientGroupData
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ClientGroupInfo
-- ----------------------------
DROP TABLE [dbo].[MD_ClientGroupInfo]
GO
CREATE TABLE [dbo].[MD_ClientGroupInfo] (
[Firm] smallint NOT NULL ,
[GroupType] smallint NOT NULL ,
[GroupId] int NOT NULL ,
[GroupName] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Records of MD_ClientGroupInfo
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ClientItemRestriction
-- ----------------------------
DROP TABLE [dbo].[MD_ClientItemRestriction]
GO
CREATE TABLE [dbo].[MD_ClientItemRestriction] (
[Firm] smallint NOT NULL ,
[TigerClientId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[Min] float(53) NOT NULL ,
[Max] float(53) NOT NULL ,
[Status] bit NOT NULL ,
[IsForbidden] bit NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[UserId] int NULL 
)


GO

-- ----------------------------
-- Records of MD_ClientItemRestriction
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ClientItemRestrictionLog
-- ----------------------------
DROP TABLE [dbo].[MD_ClientItemRestrictionLog]
GO
CREATE TABLE [dbo].[MD_ClientItemRestrictionLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[TigerClientId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[Min] float(53) NOT NULL ,
[Max] float(53) NOT NULL ,
[Status] bit NOT NULL ,
[IsForbidden] bit NOT NULL ,
[RegisteredDate] datetime NOT NULL ,
[Action] tinyint NOT NULL ,
[Note] nvarchar(255) NULL ,
[UserId] int NULL 
)


GO

-- ----------------------------
-- Records of MD_ClientItemRestrictionLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_ClientItemRestrictionLog] ON
GO
SET IDENTITY_INSERT [dbo].[MD_ClientItemRestrictionLog] OFF
GO

-- ----------------------------
-- Table structure for MD_ClientWarehouseRestriction
-- ----------------------------
DROP TABLE [dbo].[MD_ClientWarehouseRestriction]
GO
CREATE TABLE [dbo].[MD_ClientWarehouseRestriction] (
[Firm] smallint NOT NULL ,
[ClientWarehouseGroupId] int NOT NULL ,
[WarehouseNr] int NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_ClientWarehouseRestriction
-- ----------------------------

-- ----------------------------
-- Table structure for MD_CompetingItem
-- ----------------------------
DROP TABLE [dbo].[MD_CompetingItem]
GO
CREATE TABLE [dbo].[MD_CompetingItem] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(100) NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Status] bit NOT NULL ,
[GroupCode] nvarchar(50) NULL ,
[GroupName] nvarchar(50) NULL ,
[ProducerName] nvarchar(50) NULL ,
[SpecialCode] nvarchar(50) NULL ,
[SpecialCodeDesc] nvarchar(50) NULL ,
[SpecialCode2] nvarchar(50) NULL ,
[SpecialCode2Desc] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Records of MD_CompetingItem
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_CompetingItem] ON
GO
SET IDENTITY_INSERT [dbo].[MD_CompetingItem] OFF
GO

-- ----------------------------
-- Table structure for MD_Currency
-- ----------------------------
DROP TABLE [dbo].[MD_Currency]
GO
CREATE TABLE [dbo].[MD_Currency] (
[Firm] smallint NOT NULL ,
[Type] smallint NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_Currency
-- ----------------------------

-- ----------------------------
-- Table structure for MD_CurrencyExchange
-- ----------------------------
DROP TABLE [dbo].[MD_CurrencyExchange]
GO
CREATE TABLE [dbo].[MD_CurrencyExchange] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CurrencyTypeId] smallint NOT NULL ,
[Rate] float(53) NOT NULL ,
[ModifiedDate] datetime NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_CurrencyExchange
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_CurrencyExchange] ON
GO
INSERT INTO [dbo].[MD_CurrencyExchange] ([Id], [CurrencyTypeId], [Rate], [ModifiedDate], [RegisteredDate]) VALUES (N'1', N'1', N'1.7', N'2018-11-02 12:28:50.770', N'2018-11-02 12:20:37.657')
GO
GO
SET IDENTITY_INSERT [dbo].[MD_CurrencyExchange] OFF
GO

-- ----------------------------
-- Table structure for MD_Department
-- ----------------------------
DROP TABLE [dbo].[MD_Department]
GO
CREATE TABLE [dbo].[MD_Department] (
[Firm] smallint NOT NULL ,
[Nr] smallint NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[Status] bit NULL ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_Department
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Division
-- ----------------------------
DROP TABLE [dbo].[MD_Division]
GO
CREATE TABLE [dbo].[MD_Division] (
[Firm] smallint NOT NULL ,
[Nr] smallint NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[Status] bit NULL ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_Division
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ExpenseCenter
-- ----------------------------
DROP TABLE [dbo].[MD_ExpenseCenter]
GO
CREATE TABLE [dbo].[MD_ExpenseCenter] (
[TigerId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL ,
[Status] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_ExpenseCenter
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Factory
-- ----------------------------
DROP TABLE [dbo].[MD_Factory]
GO
CREATE TABLE [dbo].[MD_Factory] (
[Firm] smallint NOT NULL ,
[Nr] smallint NOT NULL ,
[DivisionNr] smallint NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_Factory
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Firm
-- ----------------------------
DROP TABLE [dbo].[MD_Firm]
GO
CREATE TABLE [dbo].[MD_Firm] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Status] bit NOT NULL ,
[Nr] smallint NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[LocalCurrencyTypeId] smallint NULL ,
[ExchangeCurrencyTypeId] smallint NULL ,
[IsActive] bit NOT NULL DEFAULT ((1)) ,
[IgnoreDivisionSalesmanCheck] bit NULL ,
[IgnoreDivisionWarehouseCheck] bit NULL ,
[IgnoreDivisionFactoryCheck] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_Firm
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_Firm] ON
GO
SET IDENTITY_INSERT [dbo].[MD_Firm] OFF
GO

-- ----------------------------
-- Table structure for MD_Item
-- ----------------------------
DROP TABLE [dbo].[MD_Item]
GO
CREATE TABLE [dbo].[MD_Item] (
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[Status] bit NOT NULL ,
[CardType] tinyint NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[GroupCode] nvarchar(50) NULL ,
[GroupName] nvarchar(50) NULL ,
[ProducerCode] nvarchar(50) NULL ,
[ProducerName] nvarchar(50) NULL ,
[SpecialCode] nvarchar(50) NULL ,
[SpecialCodeDesc] nvarchar(50) NULL ,
[SpecialCode2] nvarchar(50) NULL ,
[SpecialCode2Desc] nvarchar(50) NULL ,
[SpecialCode3] nvarchar(50) NULL ,
[SpecialCode3Desc] nvarchar(50) NULL ,
[SpecialCode4] nvarchar(50) NULL ,
[SpecialCode4Desc] nvarchar(50) NULL ,
[SpecialCode5] nvarchar(50) NULL ,
[SpecialCode5Desc] nvarchar(50) NULL ,
[AuthorizationCode] nvarchar(50) NULL ,
[AuthorizationCodeDesc] nvarchar(50) NULL ,
[Vat] float(53) NULL ,
[SellVat] float(53) NULL ,
[ReturnVat] float(53) NULL ,
[SellPRVat] float(53) NULL ,
[ReturnPRVat] float(53) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[Image1] nvarchar(100) NULL ,
[Image2] nvarchar(100) NULL ,
[Image3] nvarchar(100) NULL ,
[Image4] nvarchar(100) NULL ,
[Image5] nvarchar(100) NULL ,
[IsDeleted] bit NULL ,
[SyncFlag] bit NULL DEFAULT ((0)) ,
[SubTotalRef] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Records of MD_Item
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ItemBarcode
-- ----------------------------
DROP TABLE [dbo].[MD_ItemBarcode]
GO
CREATE TABLE [dbo].[MD_ItemBarcode] (
[Firm] smallint NOT NULL ,
[TigerItemId] int NOT NULL ,
[TigerItemUnitId] int NOT NULL ,
[Barcode] varchar(20) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[LineNr] smallint NOT NULL ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_ItemBarcode
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ItemCardType
-- ----------------------------
DROP TABLE [dbo].[MD_ItemCardType]
GO
CREATE TABLE [dbo].[MD_ItemCardType] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[MD_ItemCardType]', RESEED, 3)
GO

-- ----------------------------
-- Records of MD_ItemCardType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_ItemCardType] ON
GO
INSERT INTO [dbo].[MD_ItemCardType] ([Id], [Code], [Name], [Description]) VALUES (N'1', N'1', N'1', N'1')
GO
GO
INSERT INTO [dbo].[MD_ItemCardType] ([Id], [Code], [Name], [Description]) VALUES (N'2', N'2', N'2', N'2')
GO
GO
INSERT INTO [dbo].[MD_ItemCardType] ([Id], [Code], [Name], [Description]) VALUES (N'3', N'12', N'12', N'12')
GO
GO
SET IDENTITY_INSERT [dbo].[MD_ItemCardType] OFF
GO

-- ----------------------------
-- Table structure for MD_ItemImageChangedCatalog
-- ----------------------------
DROP TABLE [dbo].[MD_ItemImageChangedCatalog]
GO
CREATE TABLE [dbo].[MD_ItemImageChangedCatalog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CatalogId] int NOT NULL ,
[ChangedTIme] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_ItemImageChangedCatalog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_ItemImageChangedCatalog] ON
GO
SET IDENTITY_INSERT [dbo].[MD_ItemImageChangedCatalog] OFF
GO

-- ----------------------------
-- Table structure for MD_ItemPrice
-- ----------------------------
DROP TABLE [dbo].[MD_ItemPrice]
GO
CREATE TABLE [dbo].[MD_ItemPrice] (
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[TigerItemUnitId] int NOT NULL ,
[ItemUnitCode] nvarchar(50) NULL ,
[BeginDate] datetime NOT NULL ,
[EndDate] datetime NOT NULL ,
[Price] float(53) NOT NULL ,
[CurrencyTypeId] smallint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL ,
[Status] bit NULL ,
[OperationMask] varchar(10) NULL DEFAULT ((1111100000)) ,
[VatIncluded] bit NULL ,
[SyncFlag] bit NULL DEFAULT ((0)) ,
[IsConvertible] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_ItemPrice
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ItemPriceDivisionMapping
-- ----------------------------
DROP TABLE [dbo].[MD_ItemPriceDivisionMapping]
GO
CREATE TABLE [dbo].[MD_ItemPriceDivisionMapping] (
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[DivisionNr] smallint NOT NULL 
)


GO

-- ----------------------------
-- Records of MD_ItemPriceDivisionMapping
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ItemSpecificClientGroupPrice
-- ----------------------------
DROP TABLE [dbo].[MD_ItemSpecificClientGroupPrice]
GO
CREATE TABLE [dbo].[MD_ItemSpecificClientGroupPrice] (
[Firm] smallint NOT NULL ,
[ClientGroupId] int NOT NULL ,
[TigerId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[TigerItemUnitId] int NOT NULL ,
[BeginDate] datetime NOT NULL ,
[EndDate] datetime NOT NULL ,
[Price] float(53) NOT NULL ,
[CurrencyTypeId] smallint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL ,
[Status] bit NULL ,
[OperationMask] varchar(10) NULL DEFAULT ((1111100000)) ,
[VatIncluded] bit NULL ,
[IsConvertible] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_ItemSpecificClientGroupPrice
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ItemSpecificClientPrice
-- ----------------------------
DROP TABLE [dbo].[MD_ItemSpecificClientPrice]
GO
CREATE TABLE [dbo].[MD_ItemSpecificClientPrice] (
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[TigerId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[TigerItemUnitId] int NOT NULL ,
[BeginDate] datetime NOT NULL ,
[EndDate] datetime NOT NULL ,
[Price] float(53) NOT NULL ,
[CurrencyTypeId] smallint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL ,
[Status] bit NULL ,
[OperationMask] varchar(10) NULL DEFAULT ((1111100000)) ,
[VatIncluded] bit NULL ,
[IsConvertible] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_ItemSpecificClientPrice
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ItemSuggestedPrice
-- ----------------------------
DROP TABLE [dbo].[MD_ItemSuggestedPrice]
GO
CREATE TABLE [dbo].[MD_ItemSuggestedPrice] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[ItemId] int NOT NULL ,
[Price] float(53) NOT NULL ,
[ClientGroupId] int NOT NULL ,
[CurrencyTypeId] smallint NOT NULL ,
[RegisteredDate] datetime NOT NULL ,
[ItemUnitId] int NOT NULL ,
[IsConvertible] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_ItemSuggestedPrice
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_ItemSuggestedPrice] ON
GO
SET IDENTITY_INSERT [dbo].[MD_ItemSuggestedPrice] OFF
GO

-- ----------------------------
-- Table structure for MD_ItemUnit
-- ----------------------------
DROP TABLE [dbo].[MD_ItemUnit]
GO
CREATE TABLE [dbo].[MD_ItemUnit] (
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[TigerItemId] int NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[IsMainUnit] bit NOT NULL ,
[LineNr] tinyint NOT NULL ,
[Widht] float(53) NULL ,
[Length] float(53) NULL ,
[Height] float(53) NULL ,
[Area] float(53) NULL ,
[Volume] float(53) NULL ,
[GrossWeight] float(53) NULL ,
[Convfact1] float(53) NOT NULL ,
[Convfact2] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_ItemUnit
-- ----------------------------

-- ----------------------------
-- Table structure for MD_NoVatCalculationList
-- ----------------------------
DROP TABLE [dbo].[MD_NoVatCalculationList]
GO
CREATE TABLE [dbo].[MD_NoVatCalculationList] (
[Firm] smallint NOT NULL ,
[WarehouseNr] int NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_NoVatCalculationList
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PaymentPlan
-- ----------------------------
DROP TABLE [dbo].[MD_PaymentPlan]
GO
CREATE TABLE [dbo].[MD_PaymentPlan] (
[TigerId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(400) NOT NULL ,
[Specode] nvarchar(50) NULL ,
[Cyphcode] nvarchar(50) NULL ,
[WorkDays] smallint NULL ,
[Status] bit NOT NULL ,
[IsDeleted] bit NOT NULL ,
[RegisteredDate] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PaymentPlan
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedBankAccount
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedBankAccount]
GO
CREATE TABLE [dbo].[MD_PermittedBankAccount] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerId] int NOT NULL ,
[OperationId] tinyint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedBankAccount
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedCashCard
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedCashCard]
GO
CREATE TABLE [dbo].[MD_PermittedCashCard] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerCashCardId] int NOT NULL ,
[OperationId] tinyint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedCashCard
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedCatalog
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedCatalog]
GO
CREATE TABLE [dbo].[MD_PermittedCatalog] (
[UserId] int NOT NULL ,
[CatalogId] smallint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedCatalog
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedClient
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedClient]
GO
CREATE TABLE [dbo].[MD_PermittedClient] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerClientId] int NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[SyncFlag] bit NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of MD_PermittedClient
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedCurrency
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedCurrency]
GO
CREATE TABLE [dbo].[MD_PermittedCurrency] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[CurrencyType] smallint NOT NULL ,
[OperationId] tinyint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedCurrency
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedDepartment
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedDepartment]
GO
CREATE TABLE [dbo].[MD_PermittedDepartment] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerDepartmentNr] smallint NOT NULL ,
[OperationId] tinyint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedDepartment
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedDivision
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedDivision]
GO
CREATE TABLE [dbo].[MD_PermittedDivision] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerDivisionNr] smallint NOT NULL ,
[OperationId] tinyint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedDivision
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedFactory
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedFactory]
GO
CREATE TABLE [dbo].[MD_PermittedFactory] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerFactoryNr] smallint NOT NULL ,
[OperationId] tinyint NOT NULL ,
[DivisionNr] smallint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedFactory
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedFirm
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedFirm]
GO
CREATE TABLE [dbo].[MD_PermittedFirm] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedFirm
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedPaymentPlan
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedPaymentPlan]
GO
CREATE TABLE [dbo].[MD_PermittedPaymentPlan] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerId] int NOT NULL ,
[OperationId] tinyint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedPaymentPlan
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedTradingGroup
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedTradingGroup]
GO
CREATE TABLE [dbo].[MD_PermittedTradingGroup] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerTradingGroupId] int NOT NULL ,
[OperationId] tinyint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedTradingGroup
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PermittedWarehouse
-- ----------------------------
DROP TABLE [dbo].[MD_PermittedWarehouse]
GO
CREATE TABLE [dbo].[MD_PermittedWarehouse] (
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[TigerWarehouseNr] int NOT NULL ,
[OperationId] tinyint NOT NULL ,
[DivisionNr] smallint NOT NULL ,
[IsDefault] bit NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PermittedWarehouse
-- ----------------------------

-- ----------------------------
-- Table structure for MD_PlanDistributedByClient
-- ----------------------------
DROP TABLE [dbo].[MD_PlanDistributedByClient]
GO
CREATE TABLE [dbo].[MD_PlanDistributedByClient] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[ClientId] int NOT NULL ,
[Year] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[Quantity] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PlanDistributedByClient
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_PlanDistributedByClient] ON
GO
SET IDENTITY_INSERT [dbo].[MD_PlanDistributedByClient] OFF
GO

-- ----------------------------
-- Table structure for MD_PlanDistributedByUser
-- ----------------------------
DROP TABLE [dbo].[MD_PlanDistributedByUser]
GO
CREATE TABLE [dbo].[MD_PlanDistributedByUser] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[Year] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[Quantity] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PlanDistributedByUser
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_PlanDistributedByUser] ON
GO
SET IDENTITY_INSERT [dbo].[MD_PlanDistributedByUser] OFF
GO

-- ----------------------------
-- Table structure for MD_PlanTotal
-- ----------------------------
DROP TABLE [dbo].[MD_PlanTotal]
GO
CREATE TABLE [dbo].[MD_PlanTotal] (
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[Year] smallint NOT NULL ,
[Type] tinyint NOT NULL ,
[Plan] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_PlanTotal
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Project
-- ----------------------------
DROP TABLE [dbo].[MD_Project]
GO
CREATE TABLE [dbo].[MD_Project] (
[TigerId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[Status] bit NULL ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_Project
-- ----------------------------

-- ----------------------------
-- Table structure for MD_ReturnLimit
-- ----------------------------
DROP TABLE [dbo].[MD_ReturnLimit]
GO
CREATE TABLE [dbo].[MD_ReturnLimit] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NULL ,
[Firm] smallint NOT NULL ,
[TigerItemId] int NOT NULL ,
[WarehouseGroupId] smallint NOT NULL ,
[ReturnLimit] float(53) NOT NULL ,
[Year] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_ReturnLimit
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_ReturnLimit] ON
GO
SET IDENTITY_INSERT [dbo].[MD_ReturnLimit] OFF
GO

-- ----------------------------
-- Table structure for MD_Route
-- ----------------------------
DROP TABLE [dbo].[MD_Route]
GO
CREATE TABLE [dbo].[MD_Route] (
[Status] bit NOT NULL ,
[Firm] smallint NOT NULL ,
[TigerClientId] int NOT NULL ,
[Date] date NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[UserId] int NOT NULL ,
[SyncFlag] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of MD_Route
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Salesman
-- ----------------------------
DROP TABLE [dbo].[MD_Salesman]
GO
CREATE TABLE [dbo].[MD_Salesman] (
[Firm] smallint NOT NULL ,
[TigerId] int NOT NULL ,
[DivisionNr] smallint NOT NULL ,
[Code] nvarchar(20) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL ,
[Status] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_Salesman
-- ----------------------------

-- ----------------------------
-- Table structure for MD_SalesmanClientMapping
-- ----------------------------
DROP TABLE [dbo].[MD_SalesmanClientMapping]
GO
CREATE TABLE [dbo].[MD_SalesmanClientMapping] (
[Firm] smallint NOT NULL ,
[SalesmanId] int NOT NULL ,
[ClientId] int NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[SyncFlag] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of MD_SalesmanClientMapping
-- ----------------------------

-- ----------------------------
-- Table structure for MD_TradingGroup
-- ----------------------------
DROP TABLE [dbo].[MD_TradingGroup]
GO
CREATE TABLE [dbo].[MD_TradingGroup] (
[TigerId] int NOT NULL ,
[Code] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL ,
[Status] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_TradingGroup
-- ----------------------------

-- ----------------------------
-- Table structure for MD_UserPlanning
-- ----------------------------
DROP TABLE [dbo].[MD_UserPlanning]
GO
CREATE TABLE [dbo].[MD_UserPlanning] (
[UserId] bigint NOT NULL ,
[PlanMethodId] int NOT NULL ,
[RegisteredDate] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_UserPlanning
-- ----------------------------

-- ----------------------------
-- Table structure for MD_Warehouse
-- ----------------------------
DROP TABLE [dbo].[MD_Warehouse]
GO
CREATE TABLE [dbo].[MD_Warehouse] (
[Firm] smallint NOT NULL ,
[Nr] int NOT NULL ,
[DivisionNr] smallint NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[CostGrp] smallint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[IsDeleted] bit NULL 
)


GO

-- ----------------------------
-- Records of MD_Warehouse
-- ----------------------------

-- ----------------------------
-- Table structure for MD_WarehouseGroup
-- ----------------------------
DROP TABLE [dbo].[MD_WarehouseGroup]
GO
CREATE TABLE [dbo].[MD_WarehouseGroup] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[RegisteredDate] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_WarehouseGroup
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MD_WarehouseGroup] ON
GO
SET IDENTITY_INSERT [dbo].[MD_WarehouseGroup] OFF
GO

-- ----------------------------
-- Table structure for MD_WarehouseGroupWarehouseRelation
-- ----------------------------
DROP TABLE [dbo].[MD_WarehouseGroupWarehouseRelation]
GO
CREATE TABLE [dbo].[MD_WarehouseGroupWarehouseRelation] (
[WarehouseGroupId] smallint NOT NULL ,
[WarehouseNr] int NOT NULL ,
[RegisteredDate] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of MD_WarehouseGroupWarehouseRelation
-- ----------------------------

-- ----------------------------
-- Table structure for MN_ClientServiceStatus
-- ----------------------------
DROP TABLE [dbo].[MN_ClientServiceStatus]
GO
CREATE TABLE [dbo].[MN_ClientServiceStatus] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ServiceName] nvarchar(50) NOT NULL ,
[NextDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[MN_ClientServiceStatus]', RESEED, 9)
GO

-- ----------------------------
-- Records of MN_ClientServiceStatus
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MN_ClientServiceStatus] ON
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'1', N'RequestQueueService', N'2019-07-15 17:29:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'2', N'PushQueueService', N'2019-07-15 17:29:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'3', N'IncomingLogService', N'2019-07-15 17:29:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'4', N'AdministrativePushQueueService', N'2019-07-15 17:29:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'5', N'SyncService', N'2019-07-15 17:20:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'6', N'CpuProcessService', N'2019-07-15 17:30:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'7', N'OperationStatService', N'2019-07-15 17:00:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'8', N'ControlStatusService', N'2019-07-15 17:30:00.000')
GO
GO
INSERT INTO [dbo].[MN_ClientServiceStatus] ([Id], [ServiceName], [NextDate]) VALUES (N'9', N'UserDeviceService', N'2019-07-15 17:00:00.000')
GO
GO
SET IDENTITY_INSERT [dbo].[MN_ClientServiceStatus] OFF
GO

-- ----------------------------
-- Table structure for MN_HttpRequestQueue
-- ----------------------------
DROP TABLE [dbo].[MN_HttpRequestQueue]
GO
CREATE TABLE [dbo].[MN_HttpRequestQueue] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Url] nvarchar(255) NULL ,
[Method] nvarchar(50) NULL ,
[Body] nvarchar(MAX) NULL ,
[Priority] tinyint NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[MN_HttpRequestQueue]', RESEED, 701974)
GO

-- ----------------------------
-- Records of MN_HttpRequestQueue
-- ----------------------------
SET IDENTITY_INSERT [dbo].[MN_HttpRequestQueue] ON
GO
SET IDENTITY_INSERT [dbo].[MN_HttpRequestQueue] OFF
GO

-- ----------------------------
-- Table structure for OP_AdministrativePushQueue
-- ----------------------------
DROP TABLE [dbo].[OP_AdministrativePushQueue]
GO
CREATE TABLE [dbo].[OP_AdministrativePushQueue] (
[PushNotificationId] bigint NOT NULL IDENTITY(1,1) ,
[PushMethodId] smallint NOT NULL ,
[Message] nvarchar(500) NULL ,
[Status] bit NOT NULL DEFAULT ((0)) ,
[PushToken] nvarchar(500) NOT NULL ,
[UserId] int NULL DEFAULT ((0)) ,
[DeviceId] uniqueidentifier NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[RegisteredUserId] int NULL ,
[Priority] tinyint NOT NULL DEFAULT ((0)) ,
[RegisteredDate] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_AdministrativePushQueue
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_AdministrativePushQueue] ON
GO
SET IDENTITY_INSERT [dbo].[OP_AdministrativePushQueue] OFF
GO

-- ----------------------------
-- Table structure for OP_AdministrativePushLog
-- ----------------------------
DROP TABLE [dbo].[OP_AdministrativePushLog]
GO
CREATE TABLE [dbo].[OP_AdministrativePushLog] (
[PushNotificationId] bigint NOT NULL ,
[PushType] nvarchar(50) NOT NULL ,
[MethodName] nvarchar(100) NULL ,
[Message] nvarchar(500) NULL ,
[SendDate] datetime NOT NULL ,
[DeliveryStatus] tinyint NULL ,
[MulticastId] bigint NULL ,
[PushToken] nvarchar(500) NOT NULL ,
[UserId] int NULL ,
[DeviceId] uniqueidentifier NULL ,
[CreatedDate] datetime NULL DEFAULT (getdate()) ,
[RegisteredUserId] int NULL ,
[ScheduleTime] datetime NULL 
)


GO

-- ----------------------------
-- Records of OP_AdministrativePushLog
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditCompetingItemIsCampaignExistData
-- ----------------------------
DROP TABLE [dbo].[OP_AuditCompetingItemIsCampaignExistData]
GO
CREATE TABLE [dbo].[OP_AuditCompetingItemIsCampaignExistData] (
[OperationId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[IsExist] bit NOT NULL ,
[Note] nvarchar(255) NULL 
)


GO

-- ----------------------------
-- Records of OP_AuditCompetingItemIsCampaignExistData
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditCompetingItemIsExistData
-- ----------------------------
DROP TABLE [dbo].[OP_AuditCompetingItemIsExistData]
GO
CREATE TABLE [dbo].[OP_AuditCompetingItemIsExistData] (
[OperationId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[IsExist] bit NOT NULL ,
[Note] nvarchar(255) NULL 
)


GO

-- ----------------------------
-- Records of OP_AuditCompetingItemIsExistData
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditCompetingItemPriceData
-- ----------------------------
DROP TABLE [dbo].[OP_AuditCompetingItemPriceData]
GO
CREATE TABLE [dbo].[OP_AuditCompetingItemPriceData] (
[OperationId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[Price] float(53) NOT NULL ,
[Note] nvarchar(255) NULL 
)


GO

-- ----------------------------
-- Records of OP_AuditCompetingItemPriceData
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditCompetingItemShelfShareData
-- ----------------------------
DROP TABLE [dbo].[OP_AuditCompetingItemShelfShareData]
GO
CREATE TABLE [dbo].[OP_AuditCompetingItemShelfShareData] (
[OperationId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[ShelfShare] float(53) NOT NULL ,
[Note] nvarchar(255) NULL 
)


GO

-- ----------------------------
-- Records of OP_AuditCompetingItemShelfShareData
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditOperation
-- ----------------------------
DROP TABLE [dbo].[OP_AuditOperation]
GO
CREATE TABLE [dbo].[OP_AuditOperation] (
[Id] int NOT NULL ,
[DocId] varchar(50) NOT NULL ,
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[ClientId] int NOT NULL ,
[Date] datetime NOT NULL ,
[Type] tinyint NULL DEFAULT ((0)) ,
[Note] nvarchar(255) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_AuditOperation
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditOperationIsExistData
-- ----------------------------
DROP TABLE [dbo].[OP_AuditOperationIsExistData]
GO
CREATE TABLE [dbo].[OP_AuditOperationIsExistData] (
[OperationId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[IsExist] bit NOT NULL ,
[Note] nvarchar(255) NULL 
)


GO

-- ----------------------------
-- Records of OP_AuditOperationIsExistData
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditOperationQuantityData
-- ----------------------------
DROP TABLE [dbo].[OP_AuditOperationQuantityData]
GO
CREATE TABLE [dbo].[OP_AuditOperationQuantityData] (
[OperationId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[Quantity] float(53) NOT NULL ,
[Note] nvarchar(255) NULL 
)


GO

-- ----------------------------
-- Records of OP_AuditOperationQuantityData
-- ----------------------------

-- ----------------------------
-- Table structure for OP_AuditOperationPriceData
-- ----------------------------
DROP TABLE [dbo].[OP_AuditOperationPriceData]
GO
CREATE TABLE [dbo].[OP_AuditOperationPriceData] (
[OperationId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[Price] float(53) NOT NULL ,
[Note] nvarchar(255) NULL 
)


GO

-- ----------------------------
-- Records of OP_AuditOperationPriceData
-- ----------------------------

-- ----------------------------
-- Table structure for OP_ClientDebt
-- ----------------------------
DROP TABLE [dbo].[OP_ClientDebt]
GO
CREATE TABLE [dbo].[OP_ClientDebt] (
[Firm] smallint NOT NULL ,
[TigerClientId] int NOT NULL ,
[CurrencyType] smallint NOT NULL ,
[Debit] float(53) NOT NULL ,
[Credit] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[OrderNo] tinyint NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_ClientDebt
-- ----------------------------

-- ----------------------------
-- Table structure for OP_ClientImageUploadLog
-- ----------------------------
DROP TABLE [dbo].[OP_ClientImageUploadLog]
GO
CREATE TABLE [dbo].[OP_ClientImageUploadLog] (
[Id] numeric(18) NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[ClientTigerId] int NOT NULL ,
[FileName] nvarchar(100) NULL ,
[FilePath] nvarchar(100) NULL ,
[Note] nvarchar(500) NULL ,
[ImageCreatedDate] datetime NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_ClientImageUploadLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_ClientImageUploadLog] ON
GO
SET IDENTITY_INSERT [dbo].[OP_ClientImageUploadLog] OFF
GO

-- ----------------------------
-- Table structure for OP_ClientVisitLog
-- ----------------------------
DROP TABLE [dbo].[OP_ClientVisitLog]
GO
CREATE TABLE [dbo].[OP_ClientVisitLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[DocId] varchar(50) NULL ,
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[Subject] nvarchar(200) NOT NULL ,
[Note] nvarchar(4000) NULL ,
[Longitude] float(53) NULL ,
[Latitude] float(53) NULL ,
[Date] datetime NOT NULL ,
[FileName] nvarchar(100) NULL ,
[FilePath] nvarchar(100) NULL ,
[CreatedUserId] int NULL ,
[CreatedDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of OP_ClientVisitLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_ClientVisitLog] ON
GO
SET IDENTITY_INSERT [dbo].[OP_ClientVisitLog] OFF
GO

-- ----------------------------
-- Table structure for OP_DataExchangeMethodLog
-- ----------------------------
DROP TABLE [dbo].[OP_DataExchangeMethodLog]
GO
CREATE TABLE [dbo].[OP_DataExchangeMethodLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[MethodId] int NULL ,
[UserId] int NULL ,
[StartedDate] datetime NULL ,
[FinalizedDate] datetime NULL ,
[Params] varchar(100) NULL ,
[Note] varchar(100) NULL ,
[ExtraNote] varchar(4000) NULL 
)


GO

-- ----------------------------
-- Records of OP_DataExchangeMethodLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_DataExchangeMethodLog] ON
GO
SET IDENTITY_INSERT [dbo].[OP_DataExchangeMethodLog] OFF
GO

-- ----------------------------
-- Table structure for OP_DataExchangeSchedule
-- ----------------------------
DROP TABLE [dbo].[OP_DataExchangeSchedule]
GO
CREATE TABLE [dbo].[OP_DataExchangeSchedule] (
[Id] int NOT NULL ,
[DataExchangeMethodId] smallint NOT NULL ,
[Parameters] nvarchar(500) NULL ,
[ExtraInfo] nvarchar(100) NULL ,
[Period] int NOT NULL ,
[Status] bit NULL ,
[Note] nvarchar(500) NULL ,
[NextSyncTime] datetime NULL ,
[LastExecutionTime] datetime NOT NULL DEFAULT (getdate()) ,
[ExtraNote] nvarchar(4000) NULL 
)


GO

-- ----------------------------
-- Records of OP_DataExchangeSchedule
-- ----------------------------
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'1', N'4', N'{"Firms": [1]}', null, N'1800', N'1', N'OK', N'2019-07-18 11:10:16.667', N'2019-07-18 10:40:16.667', N'{"syncedObjectsInfo":[{"objectName":"SalesMan","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T10:40:16.6664799+04:00","message":"SyncedSuccess","timestamp":1563432016}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'5', N'6', N'{"Firms": [1]}', null, N'1800', N'1', N'OK', N'2019-07-18 11:09:16.500', N'2019-07-18 10:39:16.500', N'{"syncedObjectsInfo":[{"objectName":"Division","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T10:39:16.5001047+04:00","message":"SyncedSuccess","timestamp":1563431956}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'6', N'7', N'{"Firms": [1]}', null, N'1800', N'1', N'OK', N'2019-07-18 11:09:16.550', N'2019-07-18 10:39:16.550', N'{"syncedObjectsInfo":[{"objectName":"WareHouse","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T10:39:16.5484014+04:00","message":"SyncedSuccess","timestamp":1563431956}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'9', N'10', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 12:13:55.150', N'2019-07-17 12:13:55.150', N'{"syncedObjectsInfo":[{"objectName":"Factory","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T12:13:55.1483196+04:00","message":"SyncedSuccess","timestamp":1563351235}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'10', N'11', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 12:13:55.227', N'2019-07-17 12:13:55.227', N'{"syncedObjectsInfo":[{"objectName":"Currency","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T12:13:55.2267388+04:00","message":"SyncedSuccess","timestamp":1563351235}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'13', N'14', N'{"Firms": [1]}', null, N'1800', N'1', N'OK', N'2019-07-18 11:10:16.640', N'2019-07-18 10:40:16.640', N'{"syncedObjectsInfo":[{"objectName":"CashCard","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T10:40:16.6382689+04:00","message":"SyncedSuccess","timestamp":1563432016}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'14', N'15', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 15:31:05.927', N'2019-07-17 15:31:05.927', N'{"syncedObjectsInfo":[{"objectName":"CashCard","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:31:05.9270721+04:00","message":"SyncedSuccess","timestamp":1563363065}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'15', N'16', N'{"Firms": [1]}', null, N'1800', N'1', N'OK', N'2019-07-18 11:33:18.853', N'2019-07-18 11:03:18.853', N'{"syncedObjectsInfo":[{"objectName":"Client","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T11:03:18.8524454+04:00","message":"SyncedSuccess","timestamp":1563433398}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'16', N'17', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 15:31:05.957', N'2019-07-17 15:31:05.957', N'{"syncedObjectsInfo":[{"objectName":"Client","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:31:05.9542676+04:00","message":"SyncedSuccess","timestamp":1563363065}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'17', N'18', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 15:31:06.073', N'2019-07-17 15:31:06.073', N'{"syncedObjectsInfo":[{"objectName":"Item","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0},{"objectName":"ItemUnit","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0},{"objectName":"ItemBarcode","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0},{"objectName":"ItemPrice","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:31:06.0714533+04:00","message":"SyncedSuccess","timestamp":1563363066}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'18', N'19', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 15:31:06.117', N'2019-07-17 15:31:06.117', N'{"syncedObjectsInfo":[{"objectName":"Item","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0},{"objectName":"ItemUnit","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0},{"objectName":"ItemBarcode","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0},{"objectName":"ItemPrice","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:31:06.1156406+04:00","message":"SyncedSuccess","timestamp":1563363066}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'19', N'20', N'{"Firms": [1]}', null, N'1800', N'1', N'OK', N'2019-07-18 11:34:18.973', N'2019-07-18 11:04:18.973', N'{"syncedObjectsInfo":[{"objectName":"PermittedClient","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T11:04:18.9735069+04:00","message":"SyncedSuccess","timestamp":1563433458}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'20', N'23', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 15:32:06.177', N'2019-07-17 15:32:06.177', N'{"syncedObjectsInfo":[{"objectName":"Department","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:32:06.1745594+04:00","message":"SyncedSuccess","timestamp":1563363126}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'21', N'21', N'{"Firms":[{"Nr":1, "ActivePeriod":1}]}', null, N'300', N'1', N'OK', N'2019-07-18 11:10:19.183', N'2019-07-18 11:05:19.183', N'{"syncedObjectsInfo":[{"objectName":"ItemStock","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T11:05:19.1826267+04:00","message":"SyncedSuccess","timestamp":1563433519}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'22', N'22', N'{"Firms":[{"Nr":1, "ActivePeriod":1}]}', null, N'300', N'1', N'OK', N'2019-07-18 11:10:19.297', N'2019-07-18 11:05:19.297', N'{"syncedObjectsInfo":[{"objectName":"ClientDebt","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-18T11:05:19.296901+04:00","message":"SyncedSuccess","timestamp":1563433519}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'25', N'5', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 15:32:06.193', N'2019-07-17 15:32:06.193', N'{"syncedObjectsInfo":[{"objectName":"SalesMan","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:32:06.1935713+04:00","message":"SyncedSuccess","timestamp":1563363126}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'27', N'24', N'{"Firms": [1]}', null, N'86400', N'1', N'OK', N'2019-07-18 15:37:06.500', N'2019-07-17 15:37:06.500', N'{"syncedObjectsInfo":[{"objectName":"TradingGroup","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:37:06.4993821+04:00","message":"SyncedSuccess","timestamp":1563363426}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'28', N'25', N'', N'AuthToken', N'2592000', N'1', N'OK', N'2019-08-15 15:36:46.200', N'2019-07-16 15:36:46.200', N'{"authToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIyIiwidW5pcXVlX25hbWUiOiJhZG1pbiIsIm5iZiI6MTU2MzI3NzAwNiwiZXhwIjoxNTk0MzgxMDA2LCJpYXQiOjE1NjMyNzcwMDYsImlzcyI6Imh0dHA6Ly93d3cudGF5cWF0ZWNoLmNvbSIsImF1ZCI6Imh0dHA6Ly93d3cudGF5cWF0ZWNoLmNvbSJ9.QuRu9q0fcnSiMU3i1omIy3yid9PwHBUl-B5husJJqko","message":"msgNewToken","date":1563277006}')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (N'31', N'31', N'{"Firms": [1] }', null, N'86400', N'1', N'OK', N'2019-07-18 15:37:06.550', N'2019-07-17 15:37:06.550', N'{"syncedObjectsInfo":[{"objectName":"ClientRoute","insertedLineCount":0,"couldNotInsertedLineCount":0,"updatedLineCount":0,"couldNotUpdatedLineCount":0,"softDeletedLineCount":0,"couldNotSoftDeletedLineCount":0,"deletedLineCount":0,"couldNotDeletedLineCount":0,"status":"Ok","couldnCompletedLineCount":0}],"date":"2019-07-17T15:37:06.5484966+04:00","message":"SyncedSuccess","timestamp":1563363426}')
GO
GO

-- ----------------------------
-- Table structure for OP_DataExchangeStatus
-- ----------------------------
DROP TABLE [dbo].[OP_DataExchangeStatus]
GO
CREATE TABLE [dbo].[OP_DataExchangeStatus] (
[Id] int NOT NULL IDENTITY(1,1) ,
[LastSyncAt] datetime NOT NULL ,
[MethodId] smallint NOT NULL ,
[Note] nvarchar(500) NULL ,
[RegisteredAt] datetime NOT NULL DEFAULT (getdate()) ,
[RegisteredUserId] int NULL ,
[Status] bit NULL ,
[ResponseStatus] nvarchar(500) NULL ,
[Firm] smallint NOT NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[OP_DataExchangeStatus]', RESEED, 46)
GO

-- ----------------------------
-- Records of OP_DataExchangeStatus
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_DataExchangeStatus] ON
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'1', N'2019-07-18 10:40:16.657', N'4', N'', N'2019-07-18 10:40:16.663', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'2', N'2019-07-18 10:40:16.657', N'5', N'', N'2019-07-17 18:00:44.527', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'3', N'2019-07-18 10:39:16.550', N'6', N'', N'2019-07-18 10:39:16.493', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'4', N'2019-07-18 10:39:16.523', N'7', N'', N'2019-07-18 10:39:16.540', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'7', N'2019-07-17 18:24:31.997', N'10', N'', N'2019-07-17 18:24:32.017', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'8', N'2019-07-17 12:13:55.163', N'11', N'', N'2019-07-17 12:13:55.220', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'11', N'2019-07-18 10:40:16.617', N'14', N'', N'2019-07-18 10:40:16.630', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'12', N'2019-07-18 11:03:18.853', N'15', N'', N'2019-07-17 18:00:55.017', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'13', N'2019-07-18 11:03:18.820', N'16', N'', N'2019-07-18 11:03:18.847', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'14', N'2019-07-18 11:03:18.820', N'17', N'', N'2019-07-17 18:24:22.323', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'15', N'2019-07-17 15:31:06.117', N'18', N'', N'2019-07-17 15:31:06.063', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'16', N'2019-07-18 11:04:18.973', N'19', N'', N'2019-07-17 15:31:06.110', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'17', N'2019-07-18 11:04:18.957', N'20', N'', N'2019-07-18 11:04:18.967', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'18', N'2019-07-18 11:05:19.183', N'21', N'', N'2019-07-18 11:05:19.177', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'19', N'2019-07-18 11:05:19.297', N'22', N'', N'2019-07-18 11:05:19.290', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'20', N'2019-07-17 15:32:06.160', N'23', N'', N'2019-07-17 15:32:06.170', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'21', N'2019-07-17 18:12:29.887', N'24', null, N'2019-07-17 18:12:29.920', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'22', N'2019-07-17 18:24:25.350', N'26', N'paymentplan', N'2019-07-17 18:12:25.387', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'23', N'2019-07-17 18:24:25.350', N'27', N'paymentplan', N'2019-07-17 18:24:25.373', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'25', N'2018-04-10 00:00:00.000', N'100', N'', N'2018-04-10 00:00:00.000', N'2', N'1', null, N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'27', N'2019-07-17 19:05:49.887', N'31', N'clientroute', N'2019-07-17 19:05:49.927', N'2', N'1', N'Ok', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'41', N'2019-07-16 15:36:46.200', N'28', N'', N'2019-07-16 12:07:09.950', N'2', N'1', N'OK', N'9')
GO
GO
INSERT INTO [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (N'46', N'2019-06-18 18:50:00.017', N'56', N'', N'2019-06-18 18:49:41.093', N'584', N'1', N'Ok', N'9')
GO
GO
SET IDENTITY_INSERT [dbo].[OP_DataExchangeStatus] OFF
GO

-- ----------------------------
-- Table structure for OP_DocStatus
-- ----------------------------
DROP TABLE [dbo].[OP_DocStatus]
GO
CREATE TABLE [dbo].[OP_DocStatus] (
[DocId] varchar(50) NOT NULL ,
[Status] smallint NULL ,
[ReceivedDt] datetime NOT NULL ,
[ProcessedDt] datetime NULL ,
[UserId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_DocStatus
-- ----------------------------

-- ----------------------------
-- Table structure for OP_ERPIntegrationtResultQueue
-- ----------------------------
DROP TABLE [dbo].[OP_ERPIntegrationtResultQueue]
GO
CREATE TABLE [dbo].[OP_ERPIntegrationtResultQueue] (
[GeneralId] int NOT NULL ,
[RequestId] int NOT NULL ,
[PartNo] tinyint NOT NULL ,
[ResultText] nvarchar(MAX) NOT NULL ,
[ERPTransactionId] int NULL ,
[ResultId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_ERPIntegrationtResultQueue
-- ----------------------------

-- ----------------------------
-- Table structure for OP_ERPIntegrationtResultLog
-- ----------------------------
DROP TABLE [dbo].[OP_ERPIntegrationtResultLog]
GO
CREATE TABLE [dbo].[OP_ERPIntegrationtResultLog] (
[GeneralId] int NOT NULL ,
[ImportResult] nvarchar(MAX) NOT NULL ,
[StartDate] datetime NOT NULL ,
[FinalizedDate] datetime NOT NULL ,
[ServiceName] nvarchar(100) NULL 
)


GO

-- ----------------------------
-- Records of OP_ERPIntegrationtResultLog
-- ----------------------------

-- ----------------------------
-- Table structure for OP_ErpOrderStatusLog
-- ----------------------------
DROP TABLE [dbo].[OP_ErpOrderStatusLog]
GO
CREATE TABLE [dbo].[OP_ErpOrderStatusLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[Period] smallint NOT NULL ,
[OrderId] int NOT NULL ,
[UserId] int NOT NULL ,
[Status] tinyint NOT NULL ,
[ProcessDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_ErpOrderStatusLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_ErpOrderStatusLog] ON
GO
SET IDENTITY_INSERT [dbo].[OP_ErpOrderStatusLog] OFF
GO

-- ----------------------------
-- Table structure for OP_FactCalculatedTotal
-- ----------------------------
DROP TABLE [dbo].[OP_FactCalculatedTotal]
GO
CREATE TABLE [dbo].[OP_FactCalculatedTotal] (
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[Year] smallint NOT NULL ,
[Type] tinyint NOT NULL ,
[Fact] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_FactCalculatedTotal
-- ----------------------------

-- ----------------------------
-- Table structure for OP_FactDistributedByClient
-- ----------------------------
DROP TABLE [dbo].[OP_FactDistributedByClient]
GO
CREATE TABLE [dbo].[OP_FactDistributedByClient] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[ClientId] int NOT NULL ,
[Year] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[Quantity] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_FactDistributedByClient
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_FactDistributedByClient] ON
GO
SET IDENTITY_INSERT [dbo].[OP_FactDistributedByClient] OFF
GO

-- ----------------------------
-- Table structure for OP_FactDistributedByUser
-- ----------------------------
DROP TABLE [dbo].[OP_FactDistributedByUser]
GO
CREATE TABLE [dbo].[OP_FactDistributedByUser] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Firm] smallint NOT NULL ,
[UserId] int NOT NULL ,
[ItemId] int NOT NULL ,
[ItemUnitId] int NOT NULL ,
[Year] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[Quantity] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_FactDistributedByUser
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_FactDistributedByUser] ON
GO
SET IDENTITY_INSERT [dbo].[OP_FactDistributedByUser] OFF
GO

-- ----------------------------
-- Table structure for OP_FileUploadLog
-- ----------------------------
DROP TABLE [dbo].[OP_FileUploadLog]
GO
CREATE TABLE [dbo].[OP_FileUploadLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[DocId] varchar(50) NULL ,
[Firm] smallint NOT NULL ,
[ContentType] smallint NOT NULL ,
[ClientId] int NULL ,
[FileName] nvarchar(100) NOT NULL ,
[FilePath] nvarchar(255) NOT NULL ,
[UploadedUserName] nvarchar(50) NULL ,
[UploadedUserId] int NULL ,
[UploadedDeviceId] uniqueidentifier NULL ,
[FileCreatedDate] datetime NULL ,
[Note] nvarchar(500) NULL ,
[Longitude] float(53) NULL ,
[Latitude] float(53) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_FileUploadLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_FileUploadLog] ON
GO
SET IDENTITY_INSERT [dbo].[OP_FileUploadLog] OFF
GO

-- ----------------------------
-- Table structure for OP_GeneralLog
-- ----------------------------
DROP TABLE [dbo].[OP_GeneralLog]
GO
CREATE TABLE [dbo].[OP_GeneralLog] (
[Id] int NOT NULL ,
[RequestId] int NOT NULL ,
[TigerId] int NOT NULL ,
[ImportResult] int NOT NULL ,
[RegisteredDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_GeneralLog
-- ----------------------------

-- ----------------------------
-- Table structure for OP_IncomingLog
-- ----------------------------
DROP TABLE [dbo].[OP_IncomingLog]
GO
CREATE TABLE [dbo].[OP_IncomingLog] (
[Id] int NOT NULL ,
[Firm] smallint NOT NULL ,
[Period] smallint NOT NULL ,
[ProcessDate] date NOT NULL ,
[ClientId] int NOT NULL ,
[Division] smallint NOT NULL ,
[Department] smallint NOT NULL ,
[FillAccode] bit NOT NULL ,
[DocType] tinyint NOT NULL ,
[DocId] varchar(50) NOT NULL ,
[DocCreatedTime] datetime NOT NULL ,
[GpsLatitude] float(53) NULL DEFAULT ((0)) ,
[GpsLongitude] float(53) NULL DEFAULT ((0)) ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[Specode] nvarchar(50) NULL ,
[TradingGroup] varchar(100) NULL ,
[UserId] int NOT NULL ,
[DeviceId] uniqueidentifier NOT NULL ,
[DocStatus] tinyint NULL ,
[SalesmanRef] int NULL ,
[Note] nvarchar(2000) NULL ,
[DocSavedTime] datetime NULL ,
[DocSavedGpsLongitude] float(53) NULL DEFAULT ((0)) ,
[DocSavedGpsLatitude] float(53) NULL DEFAULT ((0)) ,
[DocLastUpdatedStartTime] datetime NULL ,
[DocLastUpdatedEndTime] datetime NULL ,
[CurrencyType] smallint NULL ,
[OptAffectCollatrl] bit NULL ,
[DocNumber] nvarchar(50) NULL ,
[AuthCode] nvarchar(50) NULL ,
[IntegratorVersion] varchar(50) NULL ,
[ChannelType] tinyint NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of OP_IncomingLog
-- ----------------------------

-- ----------------------------
-- Table structure for OP_IncomingLogCashExtension
-- ----------------------------
DROP TABLE [dbo].[OP_IncomingLogCashExtension]
GO
CREATE TABLE [dbo].[OP_IncomingLogCashExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[CashCode] varchar(50) NOT NULL ,
[TranGroupNo] varchar(50) NULL ,
[MasterTitle] varchar(100) NULL 
)


GO

-- ----------------------------
-- Records of OP_IncomingLogCashExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_IncomingLogCheckPaymentExtension
-- ----------------------------
DROP TABLE [dbo].[OP_IncomingLogCheckPaymentExtension]
GO
CREATE TABLE [dbo].[OP_IncomingLogCheckPaymentExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[ExpiryDate] datetime NOT NULL ,
[SerialNumber] varchar(100) NOT NULL ,
[Debtor] varchar(100) NOT NULL ,
[BankName] varchar(100) NOT NULL ,
[BankBranchCode] varchar(100) NOT NULL ,
[BankAccountCode] varchar(100) NOT NULL ,
[Giro] bit NULL ,
[TaxNo] varchar(50) NULL ,
[PieceCount] smallint NULL ,
[DayCount] smallint NULL ,
[DayOfMonth] tinyint NULL 
)


GO

-- ----------------------------
-- Records of OP_IncomingLogCheckPaymentExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_IncomingLogCommonExtension
-- ----------------------------
DROP TABLE [dbo].[OP_IncomingLogCommonExtension]
GO
CREATE TABLE [dbo].[OP_IncomingLogCommonExtension] (
[Id] int NOT NULL ,
[WhouseNr] int NOT NULL ,
[FactoryNr] smallint NOT NULL ,
[DoctrackingValue] varchar(50) NULL ,
[DeliveryFirm] varchar(100) NULL ,
[ProjectCode] varchar(100) NULL ,
[DoReserve] bit NULL ,
[OptAffectCollatrl] smallint NULL ,
[RetCostType] tinyint NULL ,
[PaymentPlanId] int NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[DeliveryDate] datetime NULL ,
[PaymentPlanCode] nvarchar(50) NULL ,
[DiscountAmount2] float(53) NULL ,
[DiscountPercent2] float(53) NULL ,
[DiscountAmount3] float(53) NULL ,
[DiscountPercent3] float(53) NULL ,
[CalculateVat] bit NULL 
)


GO

-- ----------------------------
-- Records of OP_IncomingLogCommonExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_IncomingLogCommonLineExtension
-- ----------------------------
DROP TABLE [dbo].[OP_IncomingLogCommonLineExtension]
GO
CREATE TABLE [dbo].[OP_IncomingLogCommonLineExtension] (
[Id] int NOT NULL ,
[ItemId] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[Price] float(53) NOT NULL ,
[ItemUnitCode] nvarchar(50) NOT NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[IsPromo] bit NULL ,
[IsCustomPrice] bit NULL DEFAULT ((0)) ,
[DiscountAmount2] float(53) NULL ,
[DiscountPercent2] float(53) NULL ,
[DiscountAmount3] float(53) NULL ,
[DiscountPercent3] float(53) NULL ,
[VatAmount] float(53) NULL ,
[BeepCount] smallint NULL DEFAULT ((1)) 
)


GO

-- ----------------------------
-- Records of OP_IncomingLogCommonLineExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_IncomingLogCreditCardPaymentExtension
-- ----------------------------
DROP TABLE [dbo].[OP_IncomingLogCreditCardPaymentExtension]
GO
CREATE TABLE [dbo].[OP_IncomingLogCreditCardPaymentExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[CreditCardNo] varchar(100) NOT NULL ,
[PaymentPlanId] int NOT NULL ,
[BankAccountId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_IncomingLogCreditCardPaymentExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_IncomingLogVoucherPaymentExtension
-- ----------------------------
DROP TABLE [dbo].[OP_IncomingLogVoucherPaymentExtension]
GO
CREATE TABLE [dbo].[OP_IncomingLogVoucherPaymentExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[ExpiryDate] datetime NOT NULL ,
[SerialNumber] varchar(100) NOT NULL ,
[Debtor] varchar(100) NOT NULL ,
[Guarantor] varchar(100) NOT NULL ,
[PaymentPlace] varchar(100) NOT NULL ,
[Stamp] float(53) NOT NULL DEFAULT ((0)) ,
[Giro] bit NULL ,
[TaxNo] varchar(50) NULL 
)


GO

-- ----------------------------
-- Records of OP_IncomingLogVoucherPaymentExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_ItemStock
-- ----------------------------
DROP TABLE [dbo].[OP_ItemStock]
GO
CREATE TABLE [dbo].[OP_ItemStock] (
[Firm] smallint NOT NULL ,
[TigerItemId] int NOT NULL ,
[WarehouseNr] int NOT NULL ,
[RealAmount] float(53) NOT NULL ,
[ActualAmount] float(53) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_ItemStock
-- ----------------------------

-- ----------------------------
-- Table structure for OP_OutQueue
-- ----------------------------
DROP TABLE [dbo].[OP_OutQueue]
GO
CREATE TABLE [dbo].[OP_OutQueue] (
[GeneralId] int NOT NULL ,
[RequestId] int NOT NULL ,
[UserId] int NOT NULL ,
[DocType] tinyint NOT NULL ,
[Result] int NOT NULL ,
[Note] nvarchar(MAX) NOT NULL ,
[DocId] varchar(50) NOT NULL ,
[Status] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Records of OP_OutQueue
-- ----------------------------

-- ----------------------------
-- Table structure for OP_PerformanceLog
-- ----------------------------
DROP TABLE [dbo].[OP_PerformanceLog]
GO
CREATE TABLE [dbo].[OP_PerformanceLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[TestId] uniqueidentifier NULL ,
[UserId] int NULL ,
[UserName] nvarchar(50) NULL ,
[Firm] smallint NULL ,
[ClientId] int NULL ,
[OperationName] nvarchar(255) NULL ,
[LineCount] int NULL ,
[Url] nvarchar(100) NULL ,
[RequestHeader] nvarchar(MAX) NULL ,
[RequestBody] nvarchar(MAX) NULL ,
[RequestQuery] nvarchar(MAX) NULL ,
[WebMethod] varchar(50) NULL ,
[Response] nvarchar(MAX) NULL ,
[StatusCode] varchar(50) NULL ,
[Note] nvarchar(255) NULL ,
[StartTime] datetime NULL ,
[EndTime] datetime NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_PerformanceLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_PerformanceLog] ON
GO
SET IDENTITY_INSERT [dbo].[OP_PerformanceLog] OFF
GO

-- ----------------------------
-- Table structure for OP_PushQueue
-- ----------------------------
DROP TABLE [dbo].[OP_PushQueue]
GO
CREATE TABLE [dbo].[OP_PushQueue] (
[DocId] varchar(50) NOT NULL ,
[GeneralId] int NOT NULL ,
[Status] bit NOT NULL DEFAULT ((0)) ,
[PushToken] nvarchar(500) NOT NULL ,
[RegisteredDate] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_PushQueue
-- ----------------------------

-- ----------------------------
-- Table structure for OP_PushLog
-- ----------------------------
DROP TABLE [dbo].[OP_PushLog]
GO
CREATE TABLE [dbo].[OP_PushLog] (
[GeneralId] int NOT NULL ,
[DocId] varchar(50) NOT NULL ,
[SendDate] datetime NOT NULL ,
[DeliveryStatus] tinyint NULL ,
[MulticastId] bigint NULL ,
[PushToken] nvarchar(500) NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_PushLog
-- ----------------------------

-- ----------------------------
-- Table structure for OP_PushSchedule
-- ----------------------------
DROP TABLE [dbo].[OP_PushSchedule]
GO
CREATE TABLE [dbo].[OP_PushSchedule] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[PushMethodId] smallint NOT NULL ,
[Period] int NOT NULL ,
[Status] bit NULL ,
[Note] nvarchar(500) NULL ,
[NextPushSendTime] datetime NULL ,
[LastPushSendTime] datetime NOT NULL ,
[RegisteredUserId] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[OP_PushSchedule]', RESEED, 3)
GO

-- ----------------------------
-- Records of OP_PushSchedule
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_PushSchedule] ON
GO
INSERT INTO [dbo].[OP_PushSchedule] ([Id], [PushMethodId], [Period], [Status], [Note], [NextPushSendTime], [LastPushSendTime], [RegisteredUserId]) VALUES (N'1', N'1', N'30', N'1', null, null, N'2019-07-20 15:55:15.457', null)
GO
GO
INSERT INTO [dbo].[OP_PushSchedule] ([Id], [PushMethodId], [Period], [Status], [Note], [NextPushSendTime], [LastPushSendTime], [RegisteredUserId]) VALUES (N'2', N'2', N'360', N'1', null, null, N'2019-07-20 15:55:15.457', null)
GO
GO
INSERT INTO [dbo].[OP_PushSchedule] ([Id], [PushMethodId], [Period], [Status], [Note], [NextPushSendTime], [LastPushSendTime], [RegisteredUserId]) VALUES (N'3', N'3', N'360', N'1', null, null, N'2019-07-20 15:55:15.457', null)
GO
GO
SET IDENTITY_INSERT [dbo].[OP_PushSchedule] OFF
GO

-- ----------------------------
-- Table structure for OP_RequestQueue
-- ----------------------------
DROP TABLE [dbo].[OP_RequestQueue]
GO
CREATE TABLE [dbo].[OP_RequestQueue] (
[Id] int NOT NULL ,
[PartNo] tinyint NOT NULL DEFAULT ((0)) ,
[DocStatus] tinyint NOT NULL ,
[ProcessingStatus] bit NOT NULL DEFAULT ((0)) ,
[Step] tinyint NOT NULL DEFAULT ((0)) ,
[Firm] smallint NOT NULL ,
[Period] smallint NOT NULL ,
[ProcessDate] date NOT NULL ,
[ClientId] int NOT NULL ,
[Division] smallint NOT NULL ,
[Department] smallint NOT NULL ,
[FillAccode] bit NOT NULL ,
[DocType] tinyint NOT NULL ,
[DocId] varchar(50) NOT NULL ,
[DocCreatedTime] datetime NOT NULL ,
[GpsLatitude] float(53) NULL ,
[GpsLongitude] float(53) NULL ,
[UserId] int NOT NULL ,
[SalesmanRef] int NULL ,
[Specode] nvarchar(50) NULL ,
[TradingGroup] varchar(100) NULL ,
[DeviceId] uniqueidentifier NOT NULL ,
[Note] nvarchar(2000) NULL ,
[CurrencyType] smallint NULL DEFAULT ((162)) ,
[OptAffectCollatrl] bit NULL ,
[DocNumber] nvarchar(50) NULL ,
[AuthCode] nvarchar(50) NULL ,
[IntegratorVersion] varchar(50) NULL ,
[ChannelType] tinyint NOT NULL DEFAULT ((0)) ,
[RegisteredDate] datetime NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_RequestQueue
-- ----------------------------

-- ----------------------------
-- Table structure for OP_RequestQueueCashExtension
-- ----------------------------
DROP TABLE [dbo].[OP_RequestQueueCashExtension]
GO
CREATE TABLE [dbo].[OP_RequestQueueCashExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[CashCode] varchar(50) NOT NULL ,
[TranGroupNo] varchar(50) NULL ,
[MasterTitle] varchar(100) NULL 
)


GO

-- ----------------------------
-- Records of OP_RequestQueueCashExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_RequestQueueCheckPaymentExtension
-- ----------------------------
DROP TABLE [dbo].[OP_RequestQueueCheckPaymentExtension]
GO
CREATE TABLE [dbo].[OP_RequestQueueCheckPaymentExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[ExpiryDate] datetime NOT NULL ,
[SerialNumber] nvarchar(100) NOT NULL ,
[Debtor] nvarchar(100) NOT NULL ,
[BankName] nvarchar(100) NOT NULL ,
[BankBranchCode] nvarchar(100) NOT NULL ,
[BankAccountCode] nvarchar(100) NOT NULL ,
[Giro] bit NULL ,
[TaxNo] varchar(50) NULL ,
[PieceCount] smallint NULL ,
[DayCount] smallint NULL ,
[DayOfMonth] tinyint NULL 
)


GO

-- ----------------------------
-- Records of OP_RequestQueueCheckPaymentExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_RequestQueueCommonExtension
-- ----------------------------
DROP TABLE [dbo].[OP_RequestQueueCommonExtension]
GO
CREATE TABLE [dbo].[OP_RequestQueueCommonExtension] (
[Id] int NOT NULL ,
[PartNo] tinyint NOT NULL DEFAULT ((0)) ,
[WhouseNr] int NOT NULL ,
[FactoryNr] smallint NOT NULL ,
[DoctrackingValue] varchar(50) NULL ,
[DeliveryFirm] varchar(100) NULL ,
[ProjectCode] varchar(100) NULL ,
[DoReserve] bit NULL DEFAULT ((1)) ,
[OptAffectCollatrl] smallint NULL DEFAULT ((0)) ,
[RetCostType] tinyint NULL ,
[PaymentPlanId] int NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[DeliveryDate] datetime NULL ,
[PaymentPlanCode] nvarchar(50) NULL ,
[DiscountAmount2] float(53) NULL ,
[DiscountPercent2] float(53) NULL ,
[DiscountAmount3] float(53) NULL ,
[DiscountPercent3] float(53) NULL 
)


GO

-- ----------------------------
-- Records of OP_RequestQueueCommonExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_RequestQueueCommonLineExtension
-- ----------------------------
DROP TABLE [dbo].[OP_RequestQueueCommonLineExtension]
GO
CREATE TABLE [dbo].[OP_RequestQueueCommonLineExtension] (
[Id] int NOT NULL ,
[PartNo] tinyint NOT NULL DEFAULT ((0)) ,
[ItemId] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[Price] float(53) NOT NULL ,
[ItemUnitCode] nvarchar(50) NOT NULL ,
[DiscountAmount] float(53) NULL ,
[DiscountPercent] float(53) NULL ,
[IsPromo] bit NULL ,
[IsCustomPrice] bit NULL DEFAULT ((0)) ,
[DiscountAmount2] float(53) NULL ,
[DiscountPercent2] float(53) NULL ,
[DiscountAmount3] float(53) NULL ,
[DiscountPercent3] float(53) NULL ,
[BeepCount] smallint NULL DEFAULT ((1)) 
)


GO

-- ----------------------------
-- Records of OP_RequestQueueCommonLineExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_RequestQueueCreditCardPaymentExtension
-- ----------------------------
DROP TABLE [dbo].[OP_RequestQueueCreditCardPaymentExtension]
GO
CREATE TABLE [dbo].[OP_RequestQueueCreditCardPaymentExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[CreditCardNo] nvarchar(100) NOT NULL ,
[PaymentPlanId] int NOT NULL ,
[BankAccountId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_RequestQueueCreditCardPaymentExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_RequestQueueVoucherPaymentExtension
-- ----------------------------
DROP TABLE [dbo].[OP_RequestQueueVoucherPaymentExtension]
GO
CREATE TABLE [dbo].[OP_RequestQueueVoucherPaymentExtension] (
[Id] int NOT NULL ,
[Amount] float(53) NOT NULL ,
[ExpiryDate] datetime NOT NULL ,
[SerialNumber] nvarchar(100) NOT NULL ,
[Debtor] nvarchar(100) NOT NULL ,
[Guarantor] nvarchar(100) NOT NULL ,
[PaymentPlace] nvarchar(100) NOT NULL ,
[Stamp] float(53) NOT NULL DEFAULT ((0)) ,
[Giro] bit NULL ,
[TaxNo] varchar(50) NULL 
)


GO

-- ----------------------------
-- Records of OP_RequestQueueVoucherPaymentExtension
-- ----------------------------

-- ----------------------------
-- Table structure for OP_ReturnFact
-- ----------------------------
DROP TABLE [dbo].[OP_ReturnFact]
GO
CREATE TABLE [dbo].[OP_ReturnFact] (
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[TigerItemId] int NOT NULL ,
[WarehouseGroupId] smallint NOT NULL ,
[CurrentState] float(53) NOT NULL ,
[TotalSaleAmount] float(53) NOT NULL ,
[TotalReturnAmount] float(53) NOT NULL ,
[Year] smallint NOT NULL ,
[Month] tinyint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_ReturnFact
-- ----------------------------

-- ----------------------------
-- Table structure for OP_RiskLimitClient
-- ----------------------------
DROP TABLE [dbo].[OP_RiskLimitClient]
GO
CREATE TABLE [dbo].[OP_RiskLimitClient] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ClientId] int NOT NULL ,
[CurrentLimit] float(53) NOT NULL ,
[RequestedLimit] float(53) NOT NULL ,
[RequestId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_RiskLimitClient
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_RiskLimitClient] ON
GO
SET IDENTITY_INSERT [dbo].[OP_RiskLimitClient] OFF
GO

-- ----------------------------
-- Table structure for OP_RiskLimitRequest
-- ----------------------------
DROP TABLE [dbo].[OP_RiskLimitRequest]
GO
CREATE TABLE [dbo].[OP_RiskLimitRequest] (
[Id] int NOT NULL IDENTITY(1,1) ,
[RequestId] uniqueidentifier NOT NULL ,
[Firm] smallint NOT NULL ,
[CreatedNote] nvarchar(200) NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[ControlledUserId] int NULL ,
[ControlledDate] datetime NULL ,
[ControlledNote] nvarchar(200) NULL ,
[Status] tinyint NOT NULL DEFAULT ((0)) ,
[Specode] varchar(50) NULL 
)


GO

-- ----------------------------
-- Records of OP_RiskLimitRequest
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_RiskLimitRequest] ON
GO
SET IDENTITY_INSERT [dbo].[OP_RiskLimitRequest] OFF
GO

-- ----------------------------
-- Table structure for OP_SpecialSequence
-- ----------------------------
DROP TABLE [dbo].[OP_SpecialSequence]
GO
CREATE TABLE [dbo].[OP_SpecialSequence] (
[Firm] smallint NOT NULL ,
[ClientId] int NOT NULL ,
[SequenceNo] int NOT NULL ,
[DocType] tinyint NOT NULL 
)


GO

-- ----------------------------
-- Records of OP_SpecialSequence
-- ----------------------------

-- ----------------------------
-- Table structure for OP_SyncMethod
-- ----------------------------
DROP TABLE [dbo].[OP_SyncMethod]
GO
CREATE TABLE [dbo].[OP_SyncMethod] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] varchar(500) NOT NULL ,
[Description] nvarchar(500) NULL ,
[Period] int NOT NULL ,
[Status] bit NULL ,
[LastPushSendTime] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[OP_SyncMethod]', RESEED, 4)
GO

-- ----------------------------
-- Records of OP_SyncMethod
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_SyncMethod] ON
GO
INSERT INTO [dbo].[OP_SyncMethod] ([Id], [Name], [Description], [Period], [Status], [LastPushSendTime]) VALUES (N'1', N'GetItemStock', null, N'5', N'1', N'2017-11-16 14:55:38.140')
GO
GO
INSERT INTO [dbo].[OP_SyncMethod] ([Id], [Name], [Description], [Period], [Status], [LastPushSendTime]) VALUES (N'2', N'GetClientDebt', null, N'6', N'1', N'2017-11-16 14:55:38.140')
GO
GO
INSERT INTO [dbo].[OP_SyncMethod] ([Id], [Name], [Description], [Period], [Status], [LastPushSendTime]) VALUES (N'3', N'GetAllMasterData', null, N'17', N'1', N'2017-11-16 14:55:38.140')
GO
GO
INSERT INTO [dbo].[OP_SyncMethod] ([Id], [Name], [Description], [Period], [Status], [LastPushSendTime]) VALUES (N'4', N'LogOut', null, N'2', N'0', N'2017-03-29 21:56:28.260')
GO
GO
SET IDENTITY_INSERT [dbo].[OP_SyncMethod] OFF
GO

-- ----------------------------
-- Table structure for OP_UserActionGpsData
-- ----------------------------
DROP TABLE [dbo].[OP_UserActionGpsData]
GO
CREATE TABLE [dbo].[OP_UserActionGpsData] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[ActionTypeId] smallint NOT NULL ,
[ActionLogId] int NULL ,
[Firm] smallint NOT NULL ,
[ClientId] int NULL ,
[Latitude] float(53) NOT NULL ,
[Longitude] float(53) NOT NULL ,
[Subject] nvarchar(100) NULL ,
[Note] nvarchar(4000) NULL ,
[GpsDate] datetime NOT NULL ,
[SendDate] datetime NOT NULL DEFAULT (getdate()) ,
[DocSavedTime] datetime NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) ,
[Status] tinyint NULL 
)


GO

-- ----------------------------
-- Records of OP_UserActionGpsData
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_UserActionGpsData] ON
GO
SET IDENTITY_INSERT [dbo].[OP_UserActionGpsData] OFF
GO

-- ----------------------------
-- Table structure for OP_UserGpsData
-- ----------------------------
DROP TABLE [dbo].[OP_UserGpsData]
GO
CREATE TABLE [dbo].[OP_UserGpsData] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Latitude] float(53) NULL ,
[Longitude] float(53) NULL ,
[GpsDate] datetime NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_UserGpsData
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_UserGpsData] ON
GO
SET IDENTITY_INSERT [dbo].[OP_UserGpsData] OFF
GO

-- ----------------------------
-- Table structure for OP_UserTaskExecutionLog
-- ----------------------------
DROP TABLE [dbo].[OP_UserTaskExecutionLog]
GO
CREATE TABLE [dbo].[OP_UserTaskExecutionLog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[TaskId] int NOT NULL ,
[ExecutionStatusId] tinyint NULL ,
[Note] nvarchar(500) NULL ,
[ExecutionDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of OP_UserTaskExecutionLog
-- ----------------------------
SET IDENTITY_INSERT [dbo].[OP_UserTaskExecutionLog] ON
GO
SET IDENTITY_INSERT [dbo].[OP_UserTaskExecutionLog] OFF
GO

-- ----------------------------
-- Table structure for SYS_AccountingPeriod
-- ----------------------------
DROP TABLE [dbo].[SYS_AccountingPeriod]
GO
CREATE TABLE [dbo].[SYS_AccountingPeriod] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[CreatedUserId] int NOT NULL ,
[FirmNr] smallint NOT NULL ,
[ModifiedDate] datetime NULL ,
[ModifiedUserId] int NULL ,
[Period] smallint NOT NULL ,
[Year] smallint NOT NULL ,
[IsActive] bit NULL 
)


GO

-- ----------------------------
-- Records of SYS_AccountingPeriod
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_AccountingPeriod] ON
GO
SET IDENTITY_INSERT [dbo].[SYS_AccountingPeriod] OFF
GO

-- ----------------------------
-- Table structure for SYS_AppConfigParameter
-- ----------------------------
DROP TABLE [dbo].[SYS_AppConfigParameter]
GO
CREATE TABLE [dbo].[SYS_AppConfigParameter] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Name] varchar(20) NULL ,
[Description] nvarchar(50) NULL ,
[Value] nvarchar(50) NOT NULL ,
[Status] tinyint NOT NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_AppConfigParameter]', RESEED, 3)
GO

-- ----------------------------
-- Records of SYS_AppConfigParameter
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_AppConfigParameter] ON
GO
INSERT INTO [dbo].[SYS_AppConfigParameter] ([Id], [Name], [Description], [Value], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'SyncTimeDefault', N'Random sync time from', N'21:00:00', N'1', N'1', N'1', N'2016-11-17 00:53:02.930', N'2016-11-17 00:53:02.930')
GO
GO
INSERT INTO [dbo].[SYS_AppConfigParameter] ([Id], [Name], [Description], [Value], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', N'SyncScheduleUntil', N'Random sync time until', N'07:00:00', N'1', N'1', N'1', N'2016-11-17 00:53:45.227', N'2016-11-17 00:53:45.227')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_AppConfigParameter] OFF
GO

-- ----------------------------
-- Table structure for SYS_ConfigObject
-- ----------------------------
DROP TABLE [dbo].[SYS_ConfigObject]
GO
CREATE TABLE [dbo].[SYS_ConfigObject] (
[Id] smallint NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NOT NULL ,
[ValueFromTable] bit NULL ,
[AppRelevant] bit NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of SYS_ConfigObject
-- ----------------------------
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'Specode', N'Special code', N'1', N'1', null, N'1', null, N'2017-02-13 02:59:51.353')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'OptAffectCollatrl', N'Opt affect collatrl', N'1', N'1', null, N'1', null, N'2017-02-13 02:59:51.353')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', N'OperationStatus', N'Operation status', N'1', N'1', null, N'1', null, N'2017-02-13 00:02:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'4', N'DoReserve', N'Ammount do reserve', N'1', N'0', null, N'1', null, N'2017-02-13 00:04:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'5', N'FillAccode', N'Fill accounting code', N'1', N'0', null, N'1', null, N'2017-02-13 00:05:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'6', N'RetCostType', N'Return cost type', N'1', N'0', null, N'1', null, N'2017-02-13 00:06:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'7', N'TranGroupPrefix', N'Tran group prefix', N'0', N'0', null, N'1', null, N'2017-02-13 00:07:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'8', N'ShouldGroupPayments', N'Should group payments', N'1', N'0', null, N'1', null, N'2017-02-13 00:07:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'9', N'ExpenseCenter', N'Expense center', N'1', N'1', null, N'1', null, N'2017-02-13 00:25:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'10', N'DocTrackingNr', N'Document tracking number', N'0', N'1', null, N'1', null, N'2017-02-13 01:05:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'11', N'GroupPaymentPrefix', N'Group payment prefix', N'0', N'0', null, N'1', null, N'2017-02-13 01:48:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'12', N'Firm', N'Firm', N'1', N'1', null, N'1', null, N'2017-02-13 01:47:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'13', N'MinimumOrderLimit', N'Minimum order limit ', N'0', N'0', null, N'1', null, N'2017-11-30 09:47:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'14', N'MaximumOrderLimit', N'Maximum order limit', N'0', N'0', null, N'1', null, N'2017-11-30 09:47:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'15', N'MaxLineExpensePercent', N'Maximum line expense percent', N'0', N'1', null, N'1', null, N'2018-04-13 16:39:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'16', N'MaxLineDiscountAmount', N'Maximum line discount amount', N'0', N'1', null, N'1', null, N'2018-04-13 16:40:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'17', N'MaxTotalExpensePercent', N'Maximum total expense percent', N'0', N'1', null, N'1', null, N'2018-04-13 16:43:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'18', N'MaxTotalDiscountAmount', N'Maximum total discount amount', N'0', N'1', null, N'1', null, N'2018-04-13 16:44:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'19', N'ItemPriceEditUpperLimit', N'Item price edit upper limit', N'0', N'1', null, N'1', null, N'2018-04-13 16:58:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'20', N'ItemPriceEditLowerLimit', N'Item price edit lower limit', N'0', N'1', null, N'1', null, N'2018-04-13 17:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'21', N'MaxLineDiscountPercent', N'Maximum line discount percent', N'0', N'1', null, N'1', null, N'2018-04-23 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'22', N'MaxTotalDiscountPercent', N'Maximum total discount percent', N'0', N'1', null, N'1', null, N'2018-04-23 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'23', N'NegativeControl', N'Negative control check', N'0', N'1', null, N'1', null, N'2018-04-24 10:40:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'24', N'Note', N'Note', N'0', N'1', null, N'1', null, N'2018-05-02 18:18:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'25', N'DecimalQuantities', N'Decimal quantities', N'0', N'1', null, N'1', null, N'2018-10-12 16:51:44.083')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'26', N'DocNumber', N'Document number', N'0', N'1', null, N'2', null, N'2018-11-08 18:36:07.623')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'27', N'AuthCode', N'Authentication code', N'1', N'1', null, N'2', null, N'2018-11-08 18:36:07.627')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'28', N'ShowVatIncludedPrice', N'Show vat included price', N'0', N'1', null, N'2', null, N'2019-01-19 16:37:49.237')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'29', N'AutoSendDelay', N'Send automatically created operations after  x seconds', N'0', N'1', null, N'2', null, N'2019-05-24 13:45:57.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'30', N'AutoSendEnabled', N'Auto send enabled', N'0', N'1', null, N'2', null, N'2019-06-07 17:57:28.000')
GO
GO

-- ----------------------------
-- Table structure for SYS_ConfigObjectValue
-- ----------------------------
DROP TABLE [dbo].[SYS_ConfigObjectValue]
GO
CREATE TABLE [dbo].[SYS_ConfigObjectValue] (
[Value] nvarchar(255) NOT NULL ,
[OperationId] tinyint NOT NULL ,
[ObjectId] smallint NOT NULL ,
[TranslationObject] nvarchar(30) NULL ,
[Description] nvarchar(255) NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of SYS_ConfigObjectValue
-- ----------------------------
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'', N'2', N'1', N'', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:43.037')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'', N'3', N'1', N'', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:46.350')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'', N'4', N'1', N'', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:48.137')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'', N'5', N'1', N'', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:49.467')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'', N'6', N'1', N'', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:50.903')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'', N'7', N'1', N'', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:53.303')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'1', N'2', N'No', N'No', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'1', N'4', N'No', N'No', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'1', N'5', N'No', N'No', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'2', N'2', N'No', N'No', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'2', N'3', N'Truth', N'Gerçək', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'2', N'5', N'No', N'No', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'3', N'2', N'No', N'No', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'3', N'3', N'Truth', N'Gerçək', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'3', N'5', N'No', N'No', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'4', N'2', N'No', N'No', null, N'1', null, N'2017-02-18 01:55:43.940')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'4', N'3', N'Truth', N'Gerçək', null, N'1', null, N'2017-02-18 01:55:43.940')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'4', N'5', N'No', N'No', null, N'1', null, N'2017-02-18 01:55:43.940')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'5', N'2', N'No', N'No', null, N'1', null, N'2017-02-18 01:57:48.313')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'5', N'3', N'Truth', N'Gerçək', null, N'1', null, N'2017-02-18 01:57:48.313')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'5', N'5', N'No', N'No', null, N'1', null, N'2017-02-18 01:57:48.313')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'6', N'2', N'No', N'No', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'6', N'3', N'Truth', N'Gerçək', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'6', N'5', N'No', N'No', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', N'6', N'8', N'No', N'No', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'1', N'2', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'1', N'3', N'Oneri', N'Önəri', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'1', N'4', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'1', N'5', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'2', N'2', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'2', N'3', N'Oneri', N'Önəri', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'2', N'5', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'2', N'6', N'CurrentCost', N'Current cost', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'3', N'2', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'3', N'3', N'Oneri', N'Önəri', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'3', N'5', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'3', N'6', N'CurrentCost', N'Current cost', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'4', N'2', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:55:43.940')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'4', N'3', N'Oneri', N'Önəri', null, N'1', null, N'2017-02-18 01:55:43.940')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'4', N'5', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:55:43.940')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'5', N'2', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:57:48.313')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'5', N'3', N'Oneri', N'Önəri', null, N'1', null, N'2017-02-18 01:57:48.313')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'5', N'5', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:57:48.313')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'6', N'2', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'6', N'3', N'Oneri', N'Önəri', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'6', N'5', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'6', N'8', N'Yes', N'Yes', null, N'1', null, N'2017-02-18 01:58:16.833')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'1', N'3', N'NoPortable', N'Daşınıla Bilməz', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'2', N'6', N'ReturnCost', N'Return cost', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'3', N'6', N'ReturnCost', N'Return cost', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', N'2', N'6', N'InputOutputCost', N'Input/output cost', null, N'1', null, N'2017-02-18 01:50:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', N'3', N'6', N'InputOutputCost', N'Input/output cost', null, N'1', null, N'2017-02-18 01:55:18.977')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'4', N'1', N'3', N'Portable', N'Daşınıla Bilər', null, N'1', null, N'2017-02-18 01:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'authcode1', N'2', N'27', N'AuthCode1', N'auth code 1', null, N'2', null, N'2019-02-25 15:20:11.980')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'authcode2', N'2', N'27', N'AuthCode2', N'auth code 2', null, N'2', null, N'2019-02-25 15:20:20.810')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'authcode4', N'2', N'27', N'AuthCode4', N'auth code 4', null, N'2', null, N'2019-04-11 11:53:27.230')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'imanov', N'1', N'27', N'test', N'ceyhun', null, N'2', null, N'2019-05-31 12:42:01.263')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'imanov1', N'1', N'27', N'user2', N'resul2', null, N'2', null, N'2019-06-03 10:34:16.933')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test1', N'2', N'1', N'specode_test1', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:43.037')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test1', N'3', N'1', N'specode_test1', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:46.350')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test1', N'4', N'1', N'specode_test1', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:48.137')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test1', N'5', N'1', N'specode_test1', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:49.467')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test2', N'2', N'1', N'specode_test2', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:43.037')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test2', N'3', N'1', N'specode_test2', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:46.350')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test2', N'4', N'1', N'specode_test2', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:48.137')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test2', N'5', N'1', N'specode_test2', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:49.467')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test2', N'7', N'1', N'specode_test2', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:53.303')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'specode_test55', N'7', N'1', N'specode_test55', N'Specode11_DEscription', null, N'2', null, N'2019-02-20 15:57:53.303')
GO
GO
INSERT INTO [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'test1', N'1', N'1', N'test', N'1', null, N'2', null, N'2019-05-31 12:36:10.867')
GO
GO

-- ----------------------------
-- Table structure for SYS_DataExchangeMethod
-- ----------------------------
DROP TABLE [dbo].[SYS_DataExchangeMethod]
GO
CREATE TABLE [dbo].[SYS_DataExchangeMethod] (
[Id] smallint NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[Source] nvarchar(100) NULL ,
[Description] nvarchar(100) NULL ,
[ExtraInfo] nvarchar(100) NULL ,
[Url] nvarchar(250) NULL ,
[DataTypeId] smallint NULL ,
[Status] bit NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of SYS_DataExchangeMethod
-- ----------------------------
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'4', N'SyncSalesMan', N'SalesMan', N'Sync SalesMan', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/SyncSalesMan', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'5', N'RefreshSalesMan', N'SalesMan', N'Refresh SalesMan', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshSalesMan', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'6', N'RefreshDivision', N'Division', N'Refresh Division', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshDivision', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'7', N'RefreshWareHouse', N'Warehouse', N'Refresh Warehouse', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshWarehouse', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'10', N'RefreshFactory', N'Factory', N'Refresh Factory', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshFactory', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'11', N'RefreshCurrency', N'Currency', N'Refresh Currency', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshCurrency', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'14', N'SyncCashCard', N'CashCard', N'Sync Cash Card', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/SyncCashCard', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'15', N'RefreshCashCard', N'CashCard', N'Refresh Cash Card', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshCashCard', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'16', N'SyncClient', N'Client', N'Sync Client', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/SyncClient', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'17', N'RefreshClient', N'Client', N'Refresh Client', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshClient', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'18', N'SyncItemAll', N'Item', N'Sync Item', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/SyncItemAll', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'19', N'RefreshItemAll', N'Item', N'Refresh Item', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshItemAll', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'20', N'RefreshPermittedClient', N'PermittedClient', N'Refresh Permitted Client', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshPermittedClient', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'21', N'RefreshItemStock', N'ItemStock', N'Refresh Item Stock', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshItemStock', N'2', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'22', N'RefreshClientDebt', N'ClientDebt', N'Refresh Client Debt', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshClientDebt', N'2', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'23', N'RefreshDepartment', N'Department', N'Refresh Department', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshDepartment', N'1', N'1', null, null, N'1', N'2018-03-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'24', N'RefreshTradingGroup', N'TradingGroup', N'Refresh Trading Group', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshTradingGroup', N'1', N'1', null, null, N'1', N'2018-03-16 11:19:49.463')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'25', N'RefreshAuthToken', N'AuthToken', N'Refhresh Auth Token', N'GET', N'http://10.91.10.24:1150/tayqa/tiger/api/unity/v2.91/uid/RefreshAuthToken', N'5', N'1', null, null, N'1', N'2018-04-02 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'26', N'SyncPaymentPlan', N'PaymentPlan', N'Sync Payment Plan', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/SyncPaymentPlan', N'1', N'1', null, null, N'1', N'2018-04-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'27', N'RefreshPaymentPlan', N'PaymentPlan', N'Refresh Payment Plan', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshPaymentPlan', N'1', N'1', null, null, N'1', N'2018-04-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'28', N'RefreshClientFinance', N'ClientFinanceData', N'Refresh Client Finance Data', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshClientFinance', N'2', N'1', null, null, N'1', N'2018-04-05 12:40:00.530')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'31', N'RefreshClientRoute', N'ClientRoute', N'Refresh Client Route', N'POST', N'http://10.91.10.24:1401/unity/V2.20/TigerCore/RefreshClientRoute', N'1', N'1', null, null, N'1', N'2018-06-22 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (N'100', N'ReconnectToLogo', N'ReconnectToLogo', N'Integration Reconnect To Logo', N'POST', N'http://10.91.10.24:11101/unity/Integration/ReconnectToLogo/', N'3', N'1', null, null, N'1', N'2018-04-10 00:00:00.000')
GO
GO

-- ----------------------------
-- Table structure for SYS_DataOperationMapping
-- ----------------------------
DROP TABLE [dbo].[SYS_DataOperationMapping]
GO
CREATE TABLE [dbo].[SYS_DataOperationMapping] (
[Id] int NOT NULL IDENTITY(1,1) ,
[DataType] nvarchar(50) NOT NULL ,
[OperationBitmask] varchar(20) NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_DataOperationMapping]', RESEED, 13)
GO

-- ----------------------------
-- Records of SYS_DataOperationMapping
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_DataOperationMapping] ON
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'2', N'Division', N'11111111110', N'2018-08-04 11:23:59.860')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'3', N'Department', N'11111111110', N'2018-08-04 11:24:08.910')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'4', N'Warehouse', N'11111000001', N'2018-08-04 11:24:20.763')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'5', N'TradingGroup', N'11111111110', N'2018-08-04 11:24:27.697')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'6', N'Factory', N'11111000000', N'2018-08-04 11:24:32.310')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'8', N'CashCard', N'00000110000', N'2018-08-04 11:35:36.027')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'9', N'PaymentPlan', N'11111000000', N'2018-08-04 11:35:50.630')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'11', N'Bank', N'00000000010', N'2018-08-04 11:36:15.513')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'12', N'BankAccount', N'00000000010', N'2018-08-04 11:37:58.447')
GO
GO
INSERT INTO [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (N'13', N'Currency', N'11111111110', N'2018-09-24 15:19:10.430')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_DataOperationMapping] OFF
GO

-- ----------------------------
-- Table structure for SYS_DataType
-- ----------------------------
DROP TABLE [dbo].[SYS_DataType]
GO
CREATE TABLE [dbo].[SYS_DataType] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Type] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NULL ,
[Status] bit NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_DataType]', RESEED, 3)
GO

-- ----------------------------
-- Records of SYS_DataType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_DataType] ON
GO
INSERT INTO [dbo].[SYS_DataType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'1', N'MasterData', N'Master data', N'1', N'2017-10-19 10:56:59.103')
GO
GO
INSERT INTO [dbo].[SYS_DataType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'2', N'OperationalData', N'Operational data', N'1', N'2017-10-19 10:57:14.013')
GO
GO
INSERT INTO [dbo].[SYS_DataType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'3', N'Integration', N'Integration related operations', N'1', N'2017-10-19 10:59:14.033')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_DataType] OFF
GO

-- ----------------------------
-- Table structure for SYS_DeviceSyncSchedule
-- ----------------------------
DROP TABLE [dbo].[SYS_DeviceSyncSchedule]
GO
CREATE TABLE [dbo].[SYS_DeviceSyncSchedule] (
[Id] int NOT NULL IDENTITY(1,1) ,
[DeviceId] uniqueidentifier NOT NULL ,
[DeviceSyncTime] time(7) NOT NULL ,
[MasterDataLastSyncDate] datetime NULL ,
[AppDataLastSyncDate] datetime NULL ,
[ModifiedDate] datetime NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NULL ,
[CreatedDate] datetime NULL DEFAULT (getdate()) 
)


-- ----------------------------
-- Table structure for SYS_EmailSetting
-- ----------------------------
DROP TABLE [dbo].[SYS_EmailSetting]
GO
CREATE TABLE [dbo].[SYS_EmailSetting] (
[Id] int NOT NULL IDENTITY(1,1) ,
[IsActive] bit NOT NULL ,
[Password] nvarchar(MAX) NOT NULL ,
[SmtpServerName] nvarchar(MAX) NOT NULL ,
[Username] nvarchar(MAX) NOT NULL 
)


GO

-- ----------------------------
-- Records of SYS_EmailSetting
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_EmailSetting] ON
GO
SET IDENTITY_INSERT [dbo].[SYS_EmailSetting] OFF
GO

-- ----------------------------
-- Table structure for SYS_Language
-- ----------------------------
DROP TABLE [dbo].[SYS_Language]
GO
CREATE TABLE [dbo].[SYS_Language] (
[Id] tinyint NOT NULL IDENTITY(1,1) ,
[Language] varchar(10) NOT NULL ,
[Description] nvarchar(20) NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_Language]', RESEED, 4)
GO

-- ----------------------------
-- Records of SYS_Language
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_Language] ON
GO
INSERT INTO [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'az', N'Azərbaycan dili', N'1', N'1', N'2016-11-17 00:10:12.483', N'2016-11-17 00:10:12.483')
GO
GO
INSERT INTO [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'tr', N'Türkçe', N'1', N'1', N'2016-11-17 00:11:08.833', N'2016-11-17 00:11:08.833')
GO
GO
INSERT INTO [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', N'en', N'English', N'1', N'1', N'2016-11-17 00:11:28.040', N'2016-11-17 00:11:28.040')
GO
GO
INSERT INTO [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'4', N'ru', N'Русский', N'1', N'1', N'2016-11-17 00:12:36.420', N'2016-11-17 00:12:36.420')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_Language] OFF
GO

-- ----------------------------
-- Table structure for SYS_LicenseInfo
-- ----------------------------
DROP TABLE [dbo].[SYS_LicenseInfo]
GO
CREATE TABLE [dbo].[SYS_LicenseInfo] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Client] varchar(MAX) NOT NULL ,
[Info] varchar(MAX) NOT NULL ,
[Data] varchar(MAX) NOT NULL ,
[Data2] varchar(MAX) NULL ,
[Type] tinyint NOT NULL 
)


GO

-- ----------------------------
-- Records of SYS_LicenseInfo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_LicenseInfo] ON
GO
INSERT INTO [dbo].[SYS_LicenseInfo] ([Id], [Client], [Info], [Data], [Data2], [Type]) VALUES (N'1', N'Development', N'Gm1BA3mXw6VyYdCyydYomc/TlymC9Pp9divaHNbLqrlKRcaQ7TbOePM21FnMBu0BRTOb0pGA9T01rtr7DiFQ1rVJG30hMmolgS3cGVgpiVPcdzijG2VCvvCvYpauOXFpxSGY3tGQ9fq4qYqt9jv7CvW2zThjCv8KFJ1Tf3teoGJLTh0RBcHBda0p/l5Dtp68Vbnq3Gg4KH8ggPaBy4uaIaEG32V22fvdBzPO/2KvF/c9uP7BscmZYZx7RxuEHqOaQXHQOR6S0L9Jipin6E9oXbiaevakF+AxDtEKkXtNX1fhTcDvkJYhwO1ylDof3nhmmpQTlg70hfXVaZu9SQB1t7dNZBiBNOQkcOKn4BSic/7psraq9vi4r3uIUr2+jsE6a8n0AmFipy8hxS0v6+WTpHYZocDo6xADdI71ZO4cFIp6aHQdePdzg76JEXVCGZjG1uaq1F1Je1L+M/zcTU6j+2bKjd0VVvyMIm3tpRpw7D/yA/p835j6TCgXEWg8SOLCaTVdrJNns5ml4+08U43p2q13HjieWEMW+z/bv/7cHpo1r8vttku6j0VHzyFpc78WFyK+dfBkKOa9vd3NXU3tteBU0uT06I0lxat09WEuy+bU1MwsTNegFwFgtFH9NYCnk3WL6wgqZZWJAevRC+0G/LPBWOsHqCohaBfCugduAXsir0snIeCuxIoOJNcCo2emf2cszl+HOfXWVtIwmm/+/o1dBk37jdho8nbT7ZKNONDNIjiGWIyA/59DXPWQb4tS3GM03aMXNpSaNxCMkU9NDA76dVsyqHqxyHAQi3Epsn9wQwV0Zf8igyf4KrpVfP/3/5lwl+0MCI4bPobnoFWUiL2I145W13NfvOBFRdykZn56ilZN5Yq6oyasEQVq7cmTykosMXfjHMjjvUXq0NevQLD9LynQYi9N6OuLFOzBrv/B9w1CqKxoLL2JGaK3nPrNj2knbbTRFozDCDm7AdOWGLCCLc+ZHObN+3B6gg+Y7wD8bmBbSS77twtsWyUwYVgBwxpusbwyqPjgYt4mBZ2N2/T466sfdVJUntcNcXGf2eMymQaFIzppQM4Nre74Q00c84X7E9navhZbcbCqxl9bT37WT9uWtoN0jh6ZNLr5VhG+Mt2h3WsRU=', N'', N'', N'0')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_LicenseInfo] OFF
GO

-- ----------------------------
-- Table structure for SYS_MethodPermission
-- ----------------------------
DROP TABLE [dbo].[SYS_MethodPermission]
GO
CREATE TABLE [dbo].[SYS_MethodPermission] (
[MethodId] smallint NOT NULL ,
[PermissionId] smallint NOT NULL ,
[PermissionValue] tinyint NULL ,
[Description] nvarchar(50) NULL ,
[CreatedDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of SYS_MethodPermission
-- ----------------------------
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'1', N'67', N'1', null, N'2016-11-24 03:40:49.860')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'2', N'67', N'1', null, N'2016-11-24 03:40:54.377')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'3', N'67', N'1', null, N'2016-11-24 03:40:56.500')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'4', N'67', N'1', null, N'2016-11-24 03:40:58.743')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'5', N'67', N'1', null, N'2016-11-24 03:41:01.020')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'6', N'67', N'1', null, N'2016-11-24 03:41:03.273')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'7', N'67', N'1', null, N'2016-11-24 03:41:05.510')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'8', N'67', N'1', null, N'2016-11-24 03:41:19.073')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'9', N'67', N'1', null, N'2016-11-24 03:41:21.003')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'10', N'67', N'1', null, N'2016-11-24 03:41:23.390')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'11', N'67', N'1', null, N'2016-11-24 03:41:25.193')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'12', N'67', N'1', null, N'2016-11-24 03:41:26.710')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'13', N'67', N'1', null, N'2016-11-24 03:41:28.230')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'14', N'67', N'1', null, N'2016-11-24 03:41:30.033')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'15', N'67', N'1', null, N'2016-11-24 03:41:32.600')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'16', N'67', N'1', null, N'2016-11-24 03:42:32.353')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'17', N'67', N'1', null, N'2016-11-24 03:42:32.370')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'18', N'67', N'1', null, N'2016-11-24 03:42:32.377')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'19', N'67', N'1', null, N'2016-11-24 03:42:32.387')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'20', N'67', N'1', null, N'2016-11-24 03:42:32.393')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'21', N'67', N'1', null, N'2016-11-24 03:42:32.400')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'22', N'67', N'1', null, N'2016-11-24 03:42:32.420')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'23', N'67', N'1', null, N'2016-11-24 03:42:32.427')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'24', N'67', N'1', null, N'2016-11-24 03:42:32.433')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'25', N'67', N'1', null, N'2016-11-24 03:42:32.453')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'26', N'67', N'1', null, N'2016-11-24 03:42:32.460')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'27', N'67', N'1', null, N'2016-11-24 03:42:32.470')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'28', N'67', N'1', null, N'2016-11-24 03:42:32.477')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'29', N'67', N'1', null, N'2016-11-24 03:42:32.493')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'30', N'67', N'1', null, N'2016-11-24 03:42:32.500')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'31', N'67', N'1', null, N'2016-11-24 03:42:32.510')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'32', N'67', N'1', null, N'2016-11-24 03:42:32.520')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'33', N'67', N'1', null, N'2016-11-24 03:42:32.537')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'34', N'67', N'1', null, N'2016-11-24 03:42:32.543')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'35', N'67', N'1', null, N'2016-11-26 04:39:39.783')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'36', N'67', N'1', null, N'2016-11-26 04:39:39.783')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'37', N'67', N'1', null, N'2016-12-23 02:30:33.533')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'38', N'67', N'1', null, N'2016-12-23 02:30:33.533')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'39', N'67', N'1', null, N'2017-01-06 01:35:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'40', N'67', N'1', N'Order Import Result', N'2017-01-15 18:54:46.710')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'41', N'67', N'1', null, N'2017-01-28 11:49:36.143')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'42', N'67', N'1', null, N'2017-01-28 11:49:36.143')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'43', N'67', N'1', null, N'2017-01-29 12:18:39.677')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'44', N'67', N'1', null, N'2017-01-30 19:10:36.737')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'45', N'67', N'1', null, N'2017-02-15 02:58:48.630')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'46', N'67', N'1', null, N'2017-02-21 18:51:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'47', N'67', N'1', null, N'2017-02-21 18:52:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'48', N'67', N'1', null, N'2017-03-09 03:40:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'49', N'67', N'1', null, N'2017-03-28 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'50', N'67', N'1', null, N'2017-04-20 17:53:24.857')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'51', N'2', N'1', null, N'2017-04-12 20:21:13.160')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'52', N'67', N'1', null, N'2017-04-16 22:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'53', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'54', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'55', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'56', N'67', N'1', null, N'2018-05-24 11:49:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'61', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'62', N'67', N'1', null, N'2017-11-07 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'81', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'82', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'83', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'100', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'101', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'102', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'103', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'104', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'105', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'106', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'107', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'108', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'109', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'110', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'111', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'112', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'113', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'114', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'115', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'116', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'117', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'118', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'119', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'121', N'67', N'1', null, N'2018-04-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'122', N'67', N'1', N'ItemSpecificClientPrice', N'2018-04-24 16:54:59.890')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'123', N'67', N'1', N'ItemSpecificClientGroupPrice', N'2018-04-24 16:54:59.890')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'124', N'67', N'1', N'GetClientGeneralData', N'2018-08-03 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'125', N'67', N'1', N'GetClientContactData', N'2018-08-03 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'126', N'67', N'1', N'GetClientFinanceData', N'2018-08-03 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'127', N'67', N'1', null, N'2019-01-07 20:03:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'200', N'67', N'1', null, N'2017-03-05 04:46:53.273')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'201', N'67', N'1', null, N'2017-03-05 04:46:57.547')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'202', N'67', N'1', null, N'2017-03-28 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'203', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'204', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'205', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'206', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'207', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'208', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'209', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'210', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'211', N'67', N'1', null, N'2018-04-01 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'212', N'67', N'1', N'SetCashOutPaymentData', N'2018-08-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'213', N'67', N'1', N'SetCheckPaymentData', N'2018-08-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'214', N'67', N'1', N'SetVoucherPaymentData', N'2018-08-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'215', N'67', N'1', N'SetCreditCardPaymentData', N'2018-08-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'216', N'67', N'1', null, N'2019-05-30 16:13:04.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'217', N'67', N'1', null, N'2019-05-30 16:13:39.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'218', N'67', N'1', null, N'2019-07-04 10:13:14.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'219', N'67', N'1', null, N'2019-07-04 10:13:32.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'220', N'67', N'1', null, N'2019-07-04 10:13:42.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'300', N'67', N'1', null, N'2017-03-28 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'301', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'302', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'401', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'402', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'403', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'404', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'405', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'406', N'67', N'1', N'OperationResultDataByDocIdEndpoint', N'2018-08-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'407', N'67', N'1', N'GetOperationResultDataByTransactionIdEndpoint', N'2018-08-09 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'501', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'502', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'503', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'504', N'67', N'1', null, N'2018-01-19 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'505', N'67', N'1', null, N'2018-01-19 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'506', N'67', N'1', null, N'2018-01-19 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'507', N'67', N'1', null, N'2018-01-26 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'508', N'67', N'1', null, N'2018-02-16 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'509', N'67', N'1', N'GetReportPeriodData', N'2018-04-25 17:18:41.300')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'510', N'67', N'1', null, N'2018-05-22 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'511', N'67', N'1', null, N'2018-09-26 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'512', N'67', N'1', null, N'2018-10-01 20:53:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'513', N'67', N'1', null, N'2018-12-06 19:56:21.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'514', N'67', N'1', null, N'2019-01-30 18:42:46.260')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'515', N'67', N'1', N'User debt data', N'2019-02-04 17:24:06.980')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'516', N'67', N'1', N'Daily sale and sale related actions', N'2019-02-04 17:24:06.980')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'517', N'67', N'1', N'Order with confirmation status', N'2019-02-18 15:49:02.563')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'590', N'67', N'1', N'Set order status', N'2019-02-18 16:09:57.137')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'601', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'602', N'67', N'1', null, N'2017-10-25 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'603', N'67', N'1', null, N'2017-09-25 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'604', N'67', N'1', null, N'2018-05-24 11:49:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'605', N'67', N'1', null, N'2018-08-01 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'606', N'67', N'1', null, N'2018-08-03 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'607', N'67', N'1', null, N'2018-08-18 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'701', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'702', N'67', N'1', null, N'2017-09-13 18:23:30.183')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'751', N'67', N'1', null, N'2017-11-06 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'752', N'67', N'1', null, N'2017-11-08 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'753', N'67', N'1', null, N'2018-04-04 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'801', N'81', N'1', null, N'2017-12-02 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'802', N'67', N'1', null, N'2019-01-12 16:59:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'851', N'67', N'1', null, N'2017-03-28 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'870', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'871', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'872', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'873', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'874', N'67', N'1', N'', N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'875', N'67', N'1', N'', N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'900', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'901', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'902', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'930', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'931', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'932', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'933', N'67', N'1', null, N'2018-09-17 00:00:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'960', N'67', N'1', null, N'2019-01-04 18:06:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'980', N'573', N'1', N'Risk Limit Change', N'2019-04-22 10:31:19.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'980', N'574', N'1', null, N'2019-05-11 14:47:25.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'981', N'572', N'1', N'Get Risk Limit Change Requests for User', N'2019-04-22 10:32:00.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'982', N'576', N'1', N'Get Risk Limit Change Requests for Controller', N'2019-04-22 10:32:26.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'982', N'577', N'1', null, N'2019-05-11 14:48:38.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'983', N'576', N'1', null, N'2019-05-10 15:44:52.000')
GO
GO
INSERT INTO [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (N'983', N'577', N'1', null, N'2019-05-10 15:45:07.000')
GO
GO

-- ----------------------------
-- Table structure for SYS_ModuleConfigObject
-- ----------------------------
DROP TABLE [dbo].[SYS_ModuleConfigObject]
GO
CREATE TABLE [dbo].[SYS_ModuleConfigObject] (
[Id] smallint NOT NULL ,
[ModuleName] nvarchar(20) NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NULL ,
[ValueFromTable] bit NOT NULL DEFAULT ((0)) ,
[AppRelevant] bit NOT NULL DEFAULT ((0)) ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of SYS_ModuleConfigObject
-- ----------------------------
INSERT INTO [dbo].[SYS_ModuleConfigObject] ([Id], [ModuleName], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [ModifiedDate]) VALUES (N'1', N'Delivery', N'PartialDelivery', N'Allowed to deliver partially', N'1', N'1', N'2', N'2019-06-15 14:19:41.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObject] ([Id], [ModuleName], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [ModifiedDate]) VALUES (N'2', N'Delivery', N'FinalizeInCompletePackage', N'Allow to finalize incomplete package', N'0', N'1', N'2', N'2019-06-15 14:24:54.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObject] ([Id], [ModuleName], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [ModifiedDate]) VALUES (N'3', N'Delivery', N'ConsiderOrderInInvoice', N'Consider Order In Invoice', N'0', N'1', N'2', N'2019-07-04 09:13:32.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObject] ([Id], [ModuleName], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [ModifiedDate]) VALUES (N'4', N'Delivery', N'ConsiderOrderInDispatch', N'Consider Order In Dispatch', N'0', N'1', N'2', N'2019-07-04 09:13:32.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObject] ([Id], [ModuleName], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [ModifiedDate]) VALUES (N'5', N'Delivery', N'CheckPackageStock', N'Check Package Stosck', N'0', N'1', N'2', N'2019-07-05 11:11:43.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObject] ([Id], [ModuleName], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [ModifiedDate]) VALUES (N'6', N'Delivery', N'IgnoreOrderParametersInInvoice', N'Ignore Order Parameters InI nvoice', N'0', N'1', N'2', N'2019-07-12 17:53:13.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObject] ([Id], [ModuleName], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [ModifiedDate]) VALUES (N'7', N'Delivery', N'IgnoreOrderParametersInDispatch', N'Ignore Order Parameters In Dispatch', N'0', N'1', N'2', N'2019-07-12 17:53:38.000')
GO
GO

-- ----------------------------
-- Table structure for SYS_ModuleConfigObjectValue
-- ----------------------------
DROP TABLE [dbo].[SYS_ModuleConfigObjectValue]
GO
CREATE TABLE [dbo].[SYS_ModuleConfigObjectValue] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ObjectId] smallint NOT NULL ,
[Value] nvarchar(100) NOT NULL ,
[TranslationObject] nvarchar(50) NULL ,
[Description] nvarchar(255) NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_ModuleConfigObjectValue]', RESEED, 3)
GO

-- ----------------------------
-- Records of SYS_ModuleConfigObjectValue
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_ModuleConfigObjectValue] ON
GO
INSERT INTO [dbo].[SYS_ModuleConfigObjectValue] ([Id], [ObjectId], [Value], [TranslationObject], [Description], [ModifiedUserId], [ModifiedDate]) VALUES (N'1', N'1', N'0', N'PartialDeliveryNotAllowed', null, N'2', N'2019-06-15 14:21:18.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObjectValue] ([Id], [ObjectId], [Value], [TranslationObject], [Description], [ModifiedUserId], [ModifiedDate]) VALUES (N'2', N'1', N'1', N'PartialDeliveryAllowed', null, N'2', N'2019-06-15 14:21:43.000')
GO
GO
INSERT INTO [dbo].[SYS_ModuleConfigObjectValue] ([Id], [ObjectId], [Value], [TranslationObject], [Description], [ModifiedUserId], [ModifiedDate]) VALUES (N'3', N'1', N'2', N'PartialDeliveryExceedUpperLimit', null, N'2', N'2019-06-15 14:23:24.000')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_ModuleConfigObjectValue] OFF
GO

-- ----------------------------
-- Table structure for SYS_PlanMethod
-- ----------------------------
DROP TABLE [dbo].[SYS_PlanMethod]
GO
CREATE TABLE [dbo].[SYS_PlanMethod] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CreatedDate] datetime NOT NULL ,
[CreatedUserId] int NOT NULL ,
[IsActive] bit NOT NULL ,
[ModifiedDate] datetime NULL ,
[ModifiedUserId] int NULL ,
[Name] nvarchar(100) NOT NULL ,
[Type] tinyint NULL DEFAULT ((1)) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_PlanMethod]', RESEED, 8)
GO

-- ----------------------------
-- Records of SYS_PlanMethod
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_PlanMethod] ON
GO
INSERT INTO [dbo].[SYS_PlanMethod] ([Id], [CreatedDate], [CreatedUserId], [IsActive], [ModifiedDate], [ModifiedUserId], [Name], [Type]) VALUES (N'4', N'2018-01-15 20:13:36.103', N'2', N'1', N'2018-04-26 18:08:09.167', N'2', N'UserBased', N'1')
GO
GO
INSERT INTO [dbo].[SYS_PlanMethod] ([Id], [CreatedDate], [CreatedUserId], [IsActive], [ModifiedDate], [ModifiedUserId], [Name], [Type]) VALUES (N'7', N'2018-01-20 15:57:15.073', N'2', N'0', N'2018-04-26 18:08:15.967', N'2', N'ClientBased', N'2')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_PlanMethod] OFF
GO

-- ----------------------------
-- Table structure for SYS_PushMethod
-- ----------------------------
DROP TABLE [dbo].[SYS_PushMethod]
GO
CREATE TABLE [dbo].[SYS_PushMethod] (
[Name] nvarchar(100) NOT NULL ,
[Description] nvarchar(100) NULL ,
[ExtraInfo] nvarchar(100) NULL ,
[Url] nvarchar(250) NULL ,
[DataTypeId] smallint NULL ,
[PushTypeId] smallint NOT NULL ,
[Status] bit NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[Id] smallint NOT NULL 
)


GO

-- ----------------------------
-- Records of SYS_PushMethod
-- ----------------------------
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetItemStock', N'Gets item stock', null, null, N'1', N'1', N'1', null, null, N'1', N'2017-10-19 10:48:23.077', N'1')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetClientDebt', N'Gets clients debt', null, null, N'1', N'1', N'1', null, null, N'1', N'2017-10-19 11:00:42.777', N'2')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetAllMasterData', N'Gets all master data', null, null, N'3', N'1', N'1', null, null, N'1', N'2017-10-19 11:01:05.943', N'3')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'AppLogOut', N'Log out for app', null, null, null, N'1', N'1', null, null, N'1', N'2017-10-19 11:59:13.500', N'4')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'Update 1.1.5', N'App update v 1.1.5', null, null, null, N'2', N'1', null, null, N'1', N'2017-10-19 12:00:32.527', N'5')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'Update 1.1.6', N'App update v 1.1.6', null, null, null, N'2', N'1', null, null, N'1', N'2017-11-22 10:44:29.087', N'6')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'Update 2.0.90', N'App update 2.0.90', null, N'http://89.147.210.226:511/tayqa/tiger/api/test/v3.00/download/getappapk?apkname=tayqasale-2.0.90_20180328', null, N'2', N'1', null, null, N'1', N'2018-03-28 00:00:00.000', N'10')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'Update 2.0.95', N'App update 2.0.95', null, N'http://89.147.210.226:511/tayqa/tiger/api/test/v3.00/download/getappapk?apkname=tayqasale-2.0.95_20180329', null, N'2', N'1', null, null, N'1', N'2018-03-29 00:00:00.000', N'11')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetReturnLimitData', N'GetReturnLimitData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'13')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetPlanData', N'GetPlanData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'14')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'Location', N'Send Current Location', null, null, N'1', N'3', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'16')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetItemUnitData', N'GetItemUnitData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'17')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetTradgrpData', N'GetTradgrpData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'18')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetFirmData', N'GetFirmData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'19')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetCurrencyData', N'GetCurrencyData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'20')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetDepartmentData', N'GetDepartmentData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'21')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetDivisionData', N'GetDivisionData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'22')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetFactoryData', N'GetFactoryData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'25')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetWarehouseData', N'GetWarehouseData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'26')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetCashCardData', N'GetCashCardData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'27')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetClientData', N'GetClientData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'28')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetItemData', N'GetItemData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'30')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetItemBarcodeData', N'GetItemBarcodeData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'33')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetItemCatalogData', N'GetItemCatalogData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'34')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetSalesmanRefData', N'GetSalesmanRefData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'35')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetClientItemRestrictionData', N'GetClientItemRestrictionData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'36')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetClientRouteDatesData', N'GetClientRouteDatesData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'37')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetWarehouseGroupData', N'GetWarehouseGroupData', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'38')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetUserOperationHistoryData', N'GetUserOperationHistoryData', null, null, N'2', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'39')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetAppConfig', N'GetAppConfig', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'40')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetAppTranslations', N'GetAppTranslations', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'41')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetServerTime', N'GetServerTime', null, null, N'3', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'42')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetTasks', N'Get tasks', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'43')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetUserConfigs', N'GetUserConfigs', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'44')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetUserPermissions', N'GetUserPermissions', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-03-31 10:28:49.040', N'45')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'Tasks', N'Task notification', null, null, N'1', N'3', N'1', null, null, N'1', N'2018-03-31 10:37:00.000', N'46')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'UpdateLicense', N'Updates license data in device', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-07-20 13:24:43.350', N'47')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'ClearLicenseData', N'Clear license data in device', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-07-25 13:30:49.513', N'48')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetItemImages', N'Gets item images', null, null, N'1', N'1', N'1', null, null, N'2', N'2018-11-09 12:34:56.323', N'49')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'UploadLogFiles', N'Upload app log files', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-12-05 16:28:26.227', N'50')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'RestoreOperations', N'Restore operations', null, null, N'1', N'1', N'1', null, null, N'1', N'2018-12-05 17:50:08.587', N'51')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'Update 2.9.0', N'Update 2.9.0 version', null, N'http://81.21.86.124:1153/tayqa/tiger/api/development/v2.9.0/download/getappapk?apkname=tayqasale-2.9.1.2000_AQUA_20190501', null, N'2', N'1', null, null, N'1', N'2019-01-03 00:00:00.000', N'52')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'CheckLicense', N'Check Liencese', null, null, N'1', N'1', N'1', null, null, N'1', N'2019-01-05 14:06:18.013', N'53')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'RiskLimitChangeRequest', N'Risk Limit Change Request', null, null, N'1', N'3', N'1', null, null, N'2', N'2019-04-19 18:17:31.000', N'54')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'UpdateRiskLimitChangeRequest', N'Update Risk Limit Change Request', null, null, N'1', N'3', N'1', null, null, N'2', N'2019-04-19 18:23:28.000', N'55')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'GetClientRiskData', N'Get client risk data', null, null, N'1', N'1', N'1', null, null, N'1', N'2019-05-30 12:34:21.697', N'57')
GO
GO
INSERT INTO [dbo].[SYS_PushMethod] ([Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate], [Id]) VALUES (N'DmPackageManuallyFinalized', N'Delivery package finalized manually', null, null, N'1', N'3', N'1', null, null, N'2', N'2019-07-09 10:57:07.000', N'58')
GO
GO

-- ----------------------------
-- Table structure for SYS_PushType
-- ----------------------------
DROP TABLE [dbo].[SYS_PushType]
GO
CREATE TABLE [dbo].[SYS_PushType] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Type] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NULL ,
[Status] bit NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_PushType]', RESEED, 3)
GO

-- ----------------------------
-- Records of SYS_PushType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_PushType] ON
GO
INSERT INTO [dbo].[SYS_PushType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'1', N'CallMethod', N'Call method', N'1', N'2017-10-19 10:58:00.210')
GO
GO
INSERT INTO [dbo].[SYS_PushType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'2', N'Update', N'Update app', N'1', N'2017-10-19 10:58:11.790')
GO
GO
INSERT INTO [dbo].[SYS_PushType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'3', N'Info', N'Info message', N'1', N'2017-10-19 12:01:08.720')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_PushType] OFF
GO

-- ----------------------------
-- Table structure for SYS_SetOperation
-- ----------------------------
DROP TABLE [dbo].[SYS_SetOperation]
GO
CREATE TABLE [dbo].[SYS_SetOperation] (
[Id] tinyint NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NOT NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of SYS_SetOperation
-- ----------------------------
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'Order', N'Order', null, N'1', null, N'2017-02-13 00:36:00.000')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'ReturnDispatch', N'Return dispatch', null, N'1', null, N'2017-02-13 00:36:00.000')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', N'ReturnInvoice', N'Return invoice', null, N'1', null, N'2017-02-13 00:36:00.000')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'4', N'SaleDispatch', N'Sale dispatch', null, N'1', null, N'2017-02-13 00:36:00.000')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'5', N'SaleInvoice', N'Sale invoice', null, N'1', null, N'2017-02-13 00:36:00.000')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'6', N'Cash', N'Cash', null, N'1', null, N'2017-02-13 00:36:00.000')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'7', N'CashOut', N'Cash out', null, N'1', null, N'2018-08-04 12:13:50.033')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'8', N'CheckPayment', N'Check payment', null, N'1', null, N'2018-08-04 12:14:58.990')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'9', N'VoucherPayment', N'Voucher payment', null, N'1', null, N'2018-08-04 12:15:22.470')
GO
GO
INSERT INTO [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'10', N'CreditCardPayment', N'Credit card payment', null, N'1', null, N'2018-08-04 12:15:40.697')
GO
GO

-- ----------------------------
-- Table structure for SYS_SyncTimeTable
-- ----------------------------
DROP TABLE [dbo].[SYS_SyncTimeTable]
GO
CREATE TABLE [dbo].[SYS_SyncTimeTable] (
[Name] varchar(50) NOT NULL ,
[Date] datetime NOT NULL 
)


GO

-- ----------------------------
-- Records of SYS_SyncTimeTable
-- ----------------------------
INSERT INTO [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'LastChangeDate', N'2018-03-29 08:41:37.140')
GO
GO
INSERT INTO [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'SyncExtraReportingData', N'2018-03-29 11:07:21.157')
GO
GO
INSERT INTO [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'SyncMasterData', N'2018-03-29 10:42:40.313')
GO
GO
INSERT INTO [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'SyncOperationData', N'2018-03-29 09:27:48.850')
GO
GO

-- ----------------------------
-- Table structure for SYS_TaskExecutionStatus
-- ----------------------------
DROP TABLE [dbo].[SYS_TaskExecutionStatus]
GO
CREATE TABLE [dbo].[SYS_TaskExecutionStatus] (
[Id] tinyint NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(20) NULL ,
[Description] nvarchar(50) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_TaskExecutionStatus]', RESEED, 4)
GO

-- ----------------------------
-- Records of SYS_TaskExecutionStatus
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionStatus] ON
GO
INSERT INTO [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'1', N'NotDone', N'Not done', N'2017-11-07 16:17:55.507')
GO
GO
INSERT INTO [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'2', N'Ok', N'Ok', N'2017-11-07 16:17:56.697')
GO
GO
INSERT INTO [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'3', N'Yes', N'Yes', N'2017-11-07 16:18:00.643')
GO
GO
INSERT INTO [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'4', N'No', N'No', N'2017-11-23 18:23:58.340')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionStatus] OFF
GO

-- ----------------------------
-- Table structure for SYS_TaskExecutionType
-- ----------------------------
DROP TABLE [dbo].[SYS_TaskExecutionType]
GO
CREATE TABLE [dbo].[SYS_TaskExecutionType] (
[Id] tinyint NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(20) NULL ,
[Description] nvarchar(50) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_TaskExecutionType]', RESEED, 2)
GO

-- ----------------------------
-- Records of SYS_TaskExecutionType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionType] ON
GO
INSERT INTO [dbo].[SYS_TaskExecutionType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'1', N'Important', N'Important', N'2017-11-07 16:17:28.237')
GO
GO
INSERT INTO [dbo].[SYS_TaskExecutionType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'2', N'Routine', N'Routine', N'2017-11-07 16:17:34.607')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionType] OFF
GO

-- ----------------------------
-- Table structure for SYS_TaskFormType
-- ----------------------------
DROP TABLE [dbo].[SYS_TaskFormType]
GO
CREATE TABLE [dbo].[SYS_TaskFormType] (
[Id] tinyint NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(20) NULL ,
[Description] nvarchar(50) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_TaskFormType]', RESEED, 2)
GO

-- ----------------------------
-- Records of SYS_TaskFormType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_TaskFormType] ON
GO
INSERT INTO [dbo].[SYS_TaskFormType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'1', N'Ok', N'Only Ok button', N'2017-11-07 16:18:26.983')
GO
GO
INSERT INTO [dbo].[SYS_TaskFormType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'2', N'YesNo', N'Yes and No buttons', N'2017-11-07 16:18:34.127')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_TaskFormType] OFF
GO

-- ----------------------------
-- Table structure for SYS_TaskType
-- ----------------------------
DROP TABLE [dbo].[SYS_TaskType]
GO
CREATE TABLE [dbo].[SYS_TaskType] (
[Id] tinyint NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(20) NULL ,
[Description] nvarchar(50) NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_TaskType]', RESEED, 2)
GO

-- ----------------------------
-- Records of SYS_TaskType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_TaskType] ON
GO
INSERT INTO [dbo].[SYS_TaskType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'1', N'General', N'General', N'2017-11-07 16:16:37.360')
GO
GO
INSERT INTO [dbo].[SYS_TaskType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (N'2', N'Special', N'Client special', N'2017-11-07 16:16:42.317')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_TaskType] OFF
GO

-- ----------------------------
-- Table structure for SYS_Translation
-- ----------------------------
DROP TABLE [dbo].[SYS_Translation]
GO
CREATE TABLE [dbo].[SYS_Translation] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ObjectName] varchar(50) NOT NULL ,
[LanguageId] tinyint NOT NULL ,
[Type] tinyint NULL ,
[Value] nvarchar(500) NOT NULL ,
[UserType] tinyint NOT NULL ,
[Status] tinyint NOT NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_Translation]', RESEED, 1057)
GO

-- ----------------------------
-- Records of SYS_Translation
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_Translation] ON
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'608', N'errTxtForbidden', N'1', N'0', N'Bu cihaz və ya əməliyyat üçün icazəniz yoxdur!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.733')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'609', N'errTxtBadRequestSyntaxLogin', N'1', N'0', N'Daxil edilenler bosdur!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.760')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'610', N'errTxtNotFoundLogin', N'1', N'0', N'Istifadeci melumatlari sehvdir!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.767')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'611', N'errTxtNotFoundLogin', N'3', N'0', N'Invalid user credentials!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.777')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'612', N'msgLogin', N'3', N'0', N'Welcome!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.783')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'613', N'msgLogin', N'1', N'0', N'Xos gelmisiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.790')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'614', N'errTxtUnauthorized', N'1', N'0', N'Once istifadeci melumatlarini istifade ederek sisteme daxil olun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.800')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'615', N'errTxtUnauthorized', N'3', N'0', N'Unauthorized user!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.807')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'616', N'errTxtForbidden', N'3', N'0', N'This device or operation is forbidden!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.817')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'617', N'errTxtBadRequestSyntaxLogin', N'3', N'0', N'Bad input data syntax!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.823')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'618', N'errOrderInProcess', N'1', N'0', N'errOrderInProcess', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.830')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'619', N'errOrderGeneralError', N'1', N'0', N'errOrderGeneralError', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.840')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'620', N'errOrderAlreadyProcessed', N'1', N'0', N'errOrderAlreadyProcessed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.847')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'621', N'errOrderNotActiveClient', N'1', N'0', N'errOrderNotActiveClient', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.857')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'622', N'errOrderNotNotActiveItem', N'1', N'0', N'errOrderNotActiveItem', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.863')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'623', N'errOrderDbError', N'1', N'0', N'errOrderDbError', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.870')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'624', N'errOrderInvalidDocType', N'1', N'0', N'errOrderInvalidDocType', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.877')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'625', N'errOrderNotPermittedItem', N'1', N'0', N'errOrderNotPermittedItem', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.877')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'626', N'errOrderNotPermittedClient', N'1', N'0', N'errOrderNotPermittedClient', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.883')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'627', N'errOrderNotPermittedDivision', N'1', N'0', N'errOrderNotPermittedDivision', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.900')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'628', N'errOrderNotActiveCashCard', N'1', N'0', N'errOrderNotActiveCashCard', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.907')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'629', N'errOrderNotActiveDivision', N'1', N'0', N'errOrderNotActiveDivision', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.910')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'630', N'errOrderNotActiveProjectCode', N'1', N'0', N'errOrderNotActiveProjectCode', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.913')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'631', N'errOrderNotActiveBolum', N'1', N'0', N'errOrderNotActiveBolum', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.917')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'632', N'errOrderNotActiveExpenseCode', N'1', N'0', N'errOrderNotActiveExpenseCode', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.917')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'633', N'errOrderNotActiveWarehouse', N'1', N'0', N'errOrderNotActiveWarehouse', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.920')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'634', N'errOrderNoClientFound', N'1', N'0', N'errOrderNoClientFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.923')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'635', N'errOrderNoItemFound', N'1', N'0', N'errOrderNoItemFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.930')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'636', N'errOrderNoCashCardFound', N'1', N'0', N'errOrderNoCashCardFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.933')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'637', N'errOrderNoDivisionFound', N'1', N'0', N'errOrderNoDivisionFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.933')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'638', N'errOrderNoBolumFound', N'1', N'0', N'errOrderNoBolumFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.937')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'639', N'errOrderNoExpenseCodeFound', N'1', N'0', N'errOrderNoExpenseCodeFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.937')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'640', N'errOrderNoProjectCodeFound', N'1', N'0', N'errOrderNoProjectCodeFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.937')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'641', N'errOrderNoWarehouseFound', N'1', N'0', N'errOrderNoWarehouseFound', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.940')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'642', N'docDefaultStatusException', N'1', N'0', N'Status secilmeyib', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.947')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'643', N'docConfigDepartmentException', N'1', N'0', N'Bolume Yetki Verilmeyib', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.953')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'644', N'NegativeItemIssue', N'1', N'0', N'Mənfiyə gedən mal var!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.960')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'645', N'RiskLimitExceededIssue', N'1', N'0', N'Sənəd risk limitini aşıb!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.967')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'646', N'ApprovalDateIssue', N'1', N'0', N'Sənədin tarixi təsdiq tarixindən əvvəldir!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.973')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'647', N'FicheNoIssue', N'1', N'0', N'Sənədə nömrə verilə bilmir!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.980')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'648', N'CashCardIssue', N'1', N'0', N'Kassa nömrəsi tapıla bilmir!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.990')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'649', N'GeneralError', N'1', N'0', N'Ümumi xəta!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:50.997')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'650', N'NoRelatedItemIssue', N'1', N'0', N'Mal bağlantısı yoxdur!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.007')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'651', N'AlreadyProcessed', N'1', N'0', N'Sənəd artıq əməliyyatdan keçib!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.013')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'652', N'InProcess', N'1', N'0', N'Əməliyyat gedir. Gözləyin!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.023')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'653', N'InvalidUser', N'1', N'0', N'İstifadəçi səhvdir!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.030')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'654', N'InvalidDocType', N'1', N'0', N'Yanlış sənəd növü!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.037')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'655', N'NoClientFound', N'1', N'0', N'Cari bağlantısı yoxdur!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.047')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'656', N'NotActiveClient', N'1', N'0', N'Cari aktiv deyil!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.053')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'657', N'NotActiveItem', N'1', N'0', N'Mal aktiv deyil!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.060')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'658', N'NoCashCardFound', N'1', N'0', N'Kassa tapıla bilmir!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.070')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'659', N'NotPermittedItem', N'1', N'0', N'İsifadəçinin icazəsi olmayan mal var!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.077')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'660', N'NotPermittedClient', N'1', N'0', N'İstifadəçinin icazəsi olmayan cari var!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.083')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'661', N'DbError', N'1', N'0', N'Verilənlər bazası xətası!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.093')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'662', N'LineType', N'1', N'0', N'Sətir növu', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.100')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'663', N'ItemCode', N'1', N'0', N'Mal Kodu', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.103')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'664', N'ItemName', N'1', N'0', N'Mal Adı', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.110')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'665', N'Barcode', N'1', N'0', N'Barkod', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.117')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'666', N'Quantity', N'1', N'0', N'Miqdar', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.127')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'667', N'UnitName', N'1', N'0', N'Vahid', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.137')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'668', N'Price', N'1', N'0', N'Qiymət', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.143')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'669', N'Amount', N'1', N'0', N'Məbləğ', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.150')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'670', N'errTxtBadRequestSyntaxInvoiceDetailsData', N'1', N'0', N'Bad syntax ', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.157')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'671', N'LineType', N'2', N'0', N'Satır tipi', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.160')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'672', N'ItemCode', N'2', N'0', N'Malzeme kodu', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.167')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'673', N'ItemName', N'2', N'0', N'Malzeme Adı', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.173')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'674', N'Barcode', N'2', N'0', N'Barkod', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.177')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'675', N'Quantity', N'2', N'0', N'Miktar', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.187')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'676', N'UnitName', N'2', N'0', N'Birim', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.190')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'677', N'Price', N'2', N'0', N'Fiyat', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.197')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'678', N'Amount', N'2', N'0', N'Tutar', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.203')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'679', N'errTxtBadRequestSyntaxInvoiceDetailsData', N'2', N'0', N'Bad syntax ', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.207')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'680', N'LineType', N'3', N'0', N'Line type', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.210')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'681', N'ItemCode', N'3', N'0', N'Item code', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.213')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'682', N'ItemName', N'3', N'0', N'Item name', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.213')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'683', N'Barcode', N'3', N'0', N'Barcode', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.220')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'684', N'Quantity', N'3', N'0', N'Quantity', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.223')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'685', N'UnitName', N'3', N'0', N'Unit name', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.223')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'686', N'Price', N'3', N'0', N'Price', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.227')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'687', N'Amount', N'3', N'0', N'Amount', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.233')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'688', N'errTxtBadRequestSyntaxInvoiceDetailsData', N'3', N'0', N'Bad syntax ', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.233')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'689', N'ClientCode', N'1', N'0', N'Müştəri Kodu', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.240')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'690', N'ClientCode', N'2', N'0', N'Cari Kod', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.247')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'691', N'ClientCode', N'3', N'0', N'Client Code', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.253')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'692', N'ClientName', N'1', N'0', N'Müştəri Adı', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.257')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'693', N'ClientName', N'2', N'0', N'Cari Ad', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.263')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'694', N'ClientName', N'3', N'0', N'Client Name', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.267')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'695', N'Edino', N'1', N'0', N'Edino', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.267')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'696', N'Edino', N'2', N'0', N'Edino', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.270')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'697', N'Edino', N'3', N'0', N'Edino', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.270')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'698', N'NetSale', N'1', N'0', N'Net Satış', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.277')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'699', N'NetSale', N'2', N'0', N'Net Satış', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.280')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'700', N'NetSale', N'3', N'0', N'Net Sale', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.287')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'701', N'ClientDebt', N'1', N'0', N'Cari Borc', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.293')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'702', N'ClientDebt', N'2', N'0', N'Cari Borc', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.293')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'703', N'ClientDebt', N'3', N'0', N'Client Debt', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.297')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'704', N'Return', N'1', N'0', N'Geri Qaytarma', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.300')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'705', N'Return', N'2', N'0', N'İade', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.310')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'706', N'Return', N'3', N'0', N'Return', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.310')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'707', N'Cash', N'1', N'0', N'Kassa', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.317')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'708', N'Cash', N'2', N'0', N'Tahsilat', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.327')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'709', N'Cash', N'3', N'0', N'Cash İn', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.333')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'710', N'ActualAmount', N'1', N'0', N'Feili Miqdar', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.340')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'711', N'ActualAmount', N'2', N'0', N'Fiili Stok', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.347')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'712', N'ActualAmount', N'3', N'0', N'Actual Amount', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.357')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'713', N'RealAmount', N'1', N'0', N'Həqiqi Miqdar', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.363')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'714', N'RealAmount', N'2', N'0', N'Gerçek Stok', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.367')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'715', N'RealAmount', N'3', N'0', N'Real Amount', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.370')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'716', N'Currency', N'1', N'0', N'Valyuta', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.370')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'717', N'Currency', N'2', N'0', N'Doviz', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.373')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'718', N'Currency', N'3', N'0', N'Currency', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.373')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'719', N'errConnectionFailure', N'1', N'0', N'Bağlantı Xətası', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.380')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'720', N'errConnectionFailure', N'2', N'0', N'Bağlantı Hatası', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.383')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'721', N'errConnectionFailure', N'3', N'0', N'Connection Issue', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.390')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'722', N'extErrUnauthorized', N'1', N'0', N'Yeniden sisteme daxil olun', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.397')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'723', N'extErrUnauthorized', N'2', N'0', N'Yeniden sisteme giriniz', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.403')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'724', N'extErrUnauthorized', N'3', N'0', N'Log in to the system', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.417')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'725', N'errCashAlreadyProcessed', N'1', N'0', N'Kassa sənədi artıq proses olunub', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.427')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'726', N'errReturnAlreadyProcessed', N'1', N'0', N'Qaytarma sənədi artıq proses olunub', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.437')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'727', N'errCashAlreadyProcessed', N'4', N'0', N'Кассовый документ уже отработан', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.443')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'728', N'errOrderAlreadyProcessed', N'4', N'0', N'Документ заказа уже отработан', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.450')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'729', N'errReturnAlreadyProcessed', N'4', N'0', N'Документ возврата уже отработан', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.460')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'730', N'errCashAlreadyProcessed', N'2', N'0', N'Kasa fişi artık işlemden geçmiş', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.463')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'731', N'errOrderAlreadyProcessed', N'2', N'0', N'Sipariş artık işlemden geçmiş', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.467')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'732', N'errReturnAlreadyProcessed', N'2', N'0', N'Iade artık işlemden geçmiş', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.477')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'733', N'errCashAlreadyProcessed', N'3', N'0', N'Cash already processed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.483')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'734', N'errOrderAlreadyProcessed', N'3', N'0', N'Order already processed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.490')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'735', N'errReturnAlreadyProcessed', N'3', N'0', N'Return already processed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.500')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'736', N'errOrderOperationNotAllowedNow', N'1', N'0', N'İndki zaman aralığında sifariş yazmağınıza icazə yoxdur', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.510')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'737', N'errOrderOperationNotAllowedNow', N'2', N'0', N'Şu andaki zaman aralığında sipariş yazma izniniz yok', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.517')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'738', N'errOrderOperationNotAllowedNow', N'3', N'0', N'Order is not allowed in this time span', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.527')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'739', N'errOrderOperationNotAllowedNow', N'4', N'0', N'В этом отрезке времени заказ не позволен', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.533')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'740', N'errOrderBannedClient', N'3', N'0', N'No order operation was allowed to banned client!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.540')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'741', N'errOrderBannedClient', N'4', N'0', N'No order operation was allowed to banned client!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.540')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'742', N'errOrderBannedClient', N'2', N'0', N'Yasaklanmış müşteriye sipariş yazılamaz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.547')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'743', N'errOrderBannedClient', N'1', N'0', N'Qadağan olunmuş muştəriyə satış edə bilməzsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.550')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'744', N'errOrderMinimumOrderLimit', N'3', N'0', N'Amount of Order is below defined minimum limit for an order operation!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.557')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'745', N'errOrderMinimumOrderLimit', N'1', N'0', N'Sifarişin miqdarı sifariş əməliyyatı üçün müəyyən edilmiş minimum limitdən aşağıdadır!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.563')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'746', N'errOrderMinimumOrderLimit', N'2', N'0', N'Siparişin tutarı sipariş işlemi işin belirlenmiş minimum limitden azdır!', N'1', N'1', N'1', N'1', N'2019-03-19 20:59:54.970', N'2019-03-18 12:50:51.570')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'747', N'errOrderMinimumOrderLimit', N'4', N'0', N'Amount of Order is below defined minimum limit for an order operation!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.570')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'748', N'Accepted', N'1', N'0', N'Qəbul edildi', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.573')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'749', N'Accepted', N'2', N'0', N'Kabul edildi', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.577')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'750', N'Accepted', N'3', N'0', N'Accepted', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.577')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'751', N'Accepted', N'4', N'0', N'Принято', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.580')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'752', N'AlreadyProcessed', N'2', N'0', N'Artık işlemden geçmiş', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.590')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'753', N'AlreadyProcessed', N'3', N'0', N'Operation was already processed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.590')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'754', N'AlreadyProcessed', N'4', N'0', N'Операция уже обработана', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.603')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'755', N'BannedClient', N'1', N'0', N'Müştəri blok olunub', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.613')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'756', N'BannedClient', N'2', N'0', N'Cari bloklanmıştır', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.620')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'757', N'BannedClient', N'3', N'0', N'Client was banned', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.627')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'758', N'BannedClient', N'4', N'0', N'Клиент был заблокирован', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.637')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'759', N'DbError', N'2', N'0', N'Veritabanı hatası oluştu', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.643')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'760', N'DbError', N'3', N'0', N'Database error', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.650')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'761', N'DbError', N'4', N'0', N'Ошибка базы данных', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.660')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'762', N'ErrorInvalidPassword', N'1', N'0', N'Şifrə səhvdir', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.667')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'763', N'ErrorInvalidPassword', N'2', N'0', N'Şifre yanlıştır', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.670')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'764', N'ErrorInvalidPassword', N'3', N'0', N'Password is wrong', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.677')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'765', N'ErrorInvalidPassword', N'4', N'0', N'Неверный пароль', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.680')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'766', N'ErrorInvalidUserName', N'1', N'0', N'İstifadəçi adı səhvdir', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.687')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'767', N'ErrorInvalidUserName', N'2', N'0', N'Kullanıcı adı yanlıştır', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.693')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'768', N'ErrorInvalidUserName', N'3', N'0', N'User name is wrong', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.700')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'769', N'ErrorInvalidUserName', N'4', N'0', N'Неверное имя пользователя', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.710')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'770', N'ErrorUnknown', N'1', N'0', N'Qeyri müəyyən xəta baş verdi', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.717')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'771', N'ErrorUnknown', N'2', N'0', N'Belirsiz hata oluştu', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.723')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'772', N'ErrorUnknown', N'3', N'1', N'Unknown error', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.727')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'773', N'ErrorUnknown', N'4', N'1', N'Неизвестная ошибка', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.730')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'774', N'errTxtInvalidLicense', N'1', N'1', N'Lisenziya müddəti bitmişdir və ya lisenziya məlumatları xətalıdır! Xahiş olunur administratorla əlaqə saxlayasınız!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.737')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'775', N'errTxtInvalidLicense', N'2', N'1', N'Lisans süresi bitmişdir veya lisans bilgileri hatalıdır! Lütfen yöneticinize başvurunuz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.743')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'776', N'errTxtInvalidLicense', N'3', N'1', N'The license period has expired or the license information is invalid! Please contact your administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.750')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'777', N'errTxtInvalidLicense', N'4', N'1', N'Срок лицензии закончился или данные о лицензии недействительны! Пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.760')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'778', N'errTxtLimitedLicense', N'1', N'1', N'Lisenziya məlumatları köhnədir, proqramı istifadə edə bilməyiniz üçün lisenziyanız DD gün ərzində yenilənməlidir! Xahiş olunur administratorla əlaqə saxlayasınız!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.767')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'779', N'errTxtLimitedLicense', N'2', N'1', N'Lisans bilgileri güncel degil, programı kullanabilmeniz için lisansınızın DD gün içerisinde yenilenmesi gerekiyor! Lütfen yöneticinize başvurun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.777')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'780', N'errTxtLimitedLicense', N'3', N'1', N'License information is outdated, the license must be updated within DD days to use the program! Please contact your administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.783')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'781', N'errTxtLimitedLicense', N'4', N'1', N'Данные лицензии устарели, для возможности дальнейшего использования программы лицензия должна быть обновлена в течение DD дней! Пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.790')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'782', N'GeneralError', N'2', N'0', N'Genel hata', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.797')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'783', N'GeneralError', N'3', N'0', N'General error', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.800')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'784', N'GeneralError', N'4', N'0', N'Общая ошибка', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.800')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'785', N'InProcess', N'2', N'0', N'İşlem yapılıyor', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.810')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'786', N'InProcess', N'3', N'0', N'Operation is being processed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.817')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'787', N'InProcess', N'4', N'0', N'Операция обрабатывается', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.823')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'788', N'InvalidDocType', N'2', N'0', N'Yanlış fiş türü mevcuttur', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.830')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'789', N'InvalidDocType', N'3', N'0', N'Invalid document type', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.840')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'790', N'InvalidDocType', N'4', N'0', N'Недопустимый тип документа', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.847')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'791', N'InvalidUser', N'2', N'0', N'Yanlış kullanıcı mevcuttur', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.857')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'792', N'InvalidUser', N'3', N'0', N'Invalid user name', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.863')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'793', N'InvalidUser', N'4', N'0', N'Неправильное имя пользователя', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.873')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'794', N'MaximumOrderLimit', N'1', N'0', N'Maksimum limitdən çox ola bilməz', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.880')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'795', N'MaximumOrderLimit', N'2', N'0', N'Azami limitten fazla olamaz', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.890')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'796', N'MaximumOrderLimit', N'3', N'0', N'Upper maximum limit was not allowed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.897')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'797', N'MaximumOrderLimit', N'4', N'0', N'Не может быть выше максимального лимита', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.903')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'798', N'MinimumOrderLimit', N'1', N'0', N'Minimum limitdən az ola bilməz', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.910')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'799', N'MinimumOrderLimit', N'2', N'0', N'Askari limitten az olamaz', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.920')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'800', N'MinimumOrderLimit', N'3', N'0', N'Below minimum limit was not allowed', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.923')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'801', N'MinimumOrderLimit', N'4', N'0', N'Не может быть ниже минимального лимита', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.930')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'802', N'NoCashCardFound', N'2', N'0', N'Kasa kartı bulunamadı', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.947')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'803', N'NoCashCardFound', N'3', N'0', N'Cash card was not found', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.957')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'804', N'NoCashCardFound', N'4', N'0', N'Кассовая карта не была найдена', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.963')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'805', N'NoClientFound', N'2', N'0', N'Cari hesap bulunamadı', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.973')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'806', N'NoClientFound', N'3', N'0', N'Client was not found', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.980')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'807', N'NoClientFound', N'4', N'0', N'Клиент не найден', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.983')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'808', N'NotActiveClient', N'2', N'0', N'Kullanımdışı cari hesap mevcuttur', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:51.997')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'809', N'NotActiveClient', N'3', N'0', N'Client is not active', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.000')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'810', N'NotActiveClient', N'4', N'0', N'Клиент неактивен', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.010')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'811', N'NotActiveItem', N'2', N'0', N'Kullanımdışı ürün mevcuttur', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.020')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'812', N'NotActiveItem', N'3', N'0', N'Item is not active', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.027')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'813', N'NotActiveItem', N'4', N'0', N'Товар неактивен', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.033')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'814', N'NotPermittedClient', N'2', N'0', N'Cariye yetki bulunamadı', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.037')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'815', N'NotPermittedClient', N'3', N'0', N'No permission for client', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.043')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'816', N'NotPermittedClient', N'4', N'0', N'Нет разрешения для клиента', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.053')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'817', N'NotPermittedItem', N'2', N'0', N'Ürüne yetki bulunamadı', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.063')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'818', N'NotPermittedItem', N'3', N'0', N'No permission for item', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.063')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'819', N'NotPermittedItem', N'4', N'0', N'Нет разрешения на товар', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.067')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'820', N'errTxtLogin', N'1', N'0', N'Login zamanı xəta baş verdi!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.073')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'821', N'errTxtLogin', N'2', N'0', N'Login zamanı hata oluştu!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.080')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'822', N'errTxtLogin', N'3', N'0', N'Login failed!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.087')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'823', N'errTxtLogin', N'4', N'0', N'Login failed!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.090')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'824', N'ErrorCantConnectDataBase', N'1', N'0', N'Xəta: Verilənlər bazasına bağlanmaq mümkün olmadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.097')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'825', N'ErrorCantConnectDataBase', N'2', N'0', N'Hata: Veri tabanına ulaşılamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.107')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'826', N'ErrorCantConnectDataBase', N'3', N'0', N'Error: Db connection problem!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.107')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'827', N'ErrorCantConnectDataBase', N'4', N'0', N'Нет соединения с базой данных', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.110')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'828', N'TigerDbRelatedIssue', N'1', N'0', N'Xəta: Verilənlər bazası ilə əlaqədar problem!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.127')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'829', N'TigerDbRelatedIssue', N'2', N'0', N'Hata: Veri tabanı ile ilgili problem!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.133')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'830', N'TigerDbRelatedIssue', N'3', N'0', N'Error: Db related issue!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.143')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'831', N'TigerDbRelatedIssue', N'4', N'0', N'Error: Db related issue!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.147')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'832', N'ErrorDuplicateFichne', N'1', N'0', N'Xəta: Eyni sənəd artıq mövcuddur!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.153')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'833', N'ErrorDuplicateFichne', N'2', N'0', N'Hata: Aynı fiş mevcuttur!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.157')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'834', N'ErrorDuplicateFichne', N'3', N'0', N'Error: Same document exists!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.163')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'835', N'ErrorDuplicateFichne', N'4', N'0', N'Тот же документ уже существует.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.170')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'836', N'WarningNegativeItemIssue', N'1', N'0', N'Xəbərdarlıq: Stoku mənfiyə enən məhsul mövcuddur.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.177')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'837', N'WarningNegativeItemIssue', N'2', N'0', N'Uyarı: Stoku eksiye inen ürün var.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.183')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'838', N'WarningNegativeItemIssue', N'3', N'0', N'Warning: Negative item issue.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.187')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'839', N'WarningNegativeItemIssue', N'4', N'0', N'Warning: Negative item issue.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.190')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'840', N'WarningOrderRiskLimitIssue', N'1', N'0', N'Uyarı: Sipariş belirlenmiş risk limitini aşmışdır.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.197')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'841', N'WarningOrderRiskLimitIssue', N'2', N'0', N'Xəbərdarlıq: Sifariş nəzərdə tutulan risk limitini aşmışdır.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.203')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'842', N'WarningOrderRiskLimitIssue', N'3', N'0', N'Warning: Orders risk limit exceeded.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.210')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'843', N'WarningOrderRiskLimitIssue', N'4', N'0', N'Warning: Orders risk limit exceeded.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.213')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'844', N'WarningApprovalDateIssue', N'1', N'0', N'Xəbərdarlıq: Təsdiq tarixindən əvvələ sənəd yazıla bilməz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.220')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'845', N'WarningApprovalDateIssue', N'2', N'0', N'Uyarı: Onay tarihinden önceye fiş yazılamaz.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.230')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'846', N'WarningApprovalDateIssue', N'3', N'0', N'Warning: No operation is permitted before approved date.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.237')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'847', N'WarningApprovalDateIssue', N'4', N'0', N'Документ не может быть написан до даты утверждения.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.243')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'848', N'ErrorCashCardIssue', N'1', N'0', N'Xəta:  Kassa kartı ilə əlaqədar problem!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.253')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'849', N'ErrorCashCardIssue', N'2', N'0', N'Hata: Kasa kartı ile ilgili problem!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.263')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'850', N'ErrorCashCardIssue', N'3', N'0', N'Error: There is an issue with cash card.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.267')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'851', N'ErrorCashCardIssue', N'4', N'0', N'Существует проблема с кассовой картой.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.273')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'852', N'ErrorBankAccountCouldntFoundIssue', N'1', N'0', N'Xəta: Qeyd edilən bank hesabı mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.280')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'853', N'ErrorBankAccountCouldntFoundIssue', N'2', N'0', N'Hata: Banka hesabı bulunamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.290')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'854', N'ErrorBankAccountCouldntFoundIssue', N'3', N'0', N'Error: The bank account could not be found!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.290')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'855', N'ErrorBankAccountCouldntFoundIssue', N'4', N'0', N'Error: The bank account could not be found!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.293')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'856', N'ErrorNoCashCardErrorIssue', N'1', N'0', N'Xəta: Qeyd edilən kassa kartı mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.300')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'857', N'ErrorNoCashCardErrorIssue', N'2', N'0', N'Hata: Kasa kartı bulunamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.307')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'858', N'ErrorNoCashCardErrorIssue', N'3', N'0', N'Error: The cash card could not be found!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.313')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'859', N'ErrorNoCashCardErrorIssue', N'4', N'0', N'Не удалось найти кассовую карту.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.323')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'860', N'ErrorNoSuchProjectCodeIssue', N'1', N'0', N'Xəta: Qeyd edilən proyekt kodu mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.330')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'861', N'ErrorNoSuchProjectCodeIssue', N'2', N'0', N'Hata: Proje kodu bulunamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.340')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'862', N'ErrorNoSuchProjectCodeIssue', N'3', N'0', N'Error: Project code does not exists!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.347')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'863', N'ErrorNoSuchProjectCodeIssue', N'4', N'0', N'Не удалось найти код проекта!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.357')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'864', N'ErrorNoRelatedItemActionFoundIssue', N'1', N'0', N'Xəta: Qeyd edilən məhsul hərəkəti mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.363')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'865', N'ErrorNoRelatedItemActionFoundIssue', N'2', N'0', N'Hata: Ürün hareketi bulunamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.373')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'866', N'ErrorNoRelatedItemActionFoundIssue', N'3', N'0', N'Error: The item action could not be found!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.380')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'867', N'ErrorNoRelatedItemActionFoundIssue', N'4', N'0', N'Связанное движение товара не найдено.', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.390')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'868', N'ErrorCouldnConvertTayqaTokenToTigerToken', N'1', N'0', N'Xəta: TayqaToken TigerToken-e kecirilə bilmədi!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.397')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'869', N'ErrorCouldnConvertTayqaTokenToTigerToken', N'2', N'0', N'Hata: TayqaToken TigerToken-a dönüştürülemedi!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.403')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'870', N'ErrorCouldnConvertTayqaTokenToTigerToken', N'3', N'0', N'Error: TayqaToken could not be converted to TigerToken!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.413')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'871', N'ErrorCouldnConvertTayqaTokenToTigerToken', N'4', N'0', N'Error: TayqaToken could not be converted to TigerToken!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.417')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'872', N'ErrorERPRelatedNoDocInfoProblem', N'1', N'0', N'Xəta: ERP-yə inteqrasiya zamanı sənəd məlumatları tapılmamışdır!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.423')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'873', N'ErrorERPRelatedNoDocInfoProblem', N'2', N'0', N'Hata: ERP entegrasyonunda doküman bilgileri bulunamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.430')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'874', N'ErrorERPRelatedNoDocInfoProblem', N'3', N'0', N'Error: No document information was found in ERP integration!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.437')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'875', N'ErrorERPRelatedNoDocInfoProblem', N'4', N'0', N'Error: No document information was found in ERP integration!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.440')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'876', N'ErrorItemUnitInfoNotFound', N'1', N'0', N'Xəta: Qeyd edilən məhsul vahidi mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.447')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'877', N'ErrorItemUnitInfoNotFound', N'2', N'0', N'Hata: Ürün birimi bulunamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.457')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'878', N'ErrorItemUnitInfoNotFound', N'3', N'0', N'Error: The item unit could not be found!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.457')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'879', N'ErrorItemUnitInfoNotFound', N'4', N'0', N'Error: The item unit could not be found!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.460')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'880', N'ErrorCouldnSetSpecialPrice', N'1', N'0', N'Xəta: Xüsusi qiymət əlavə edilərkən problem baş verdi!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.470')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'881', N'ErrorCouldnSetSpecialPrice', N'2', N'0', N'Hata: Özel fiyat yazılamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.477')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'882', N'ErrorCouldnSetSpecialPrice', N'3', N'0', N'Error: Special price could not be set!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.490')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'883', N'ErrorCouldnSetSpecialPrice', N'4', N'0', N'Error: Special price could not be set!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.490')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'884', N'ExchangeRateNotDefined', N'1', N'0', N'Xəta: Qeyd edilən valyuta üzrə mərkəzdə kurs təyin edilməmişdir!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.503')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'885', N'ExchangeRateNotDefined', N'2', N'0', N'Hata: Para birimi üçün merkezde döviz kursu bulunamadı!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.510')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'886', N'ExchangeRateNotDefined', N'3', N'0', N'Error: Exchange rate for the currency could not be found in center!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.520')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'887', N'ExchangeRateNotDefined', N'4', N'0', N'Error: Exchange rate for the currency could not be found in center!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.523')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'888', N'errSaleInvoiceBannedClient', N'3', N'0', N'No sale invoice operation was allowed to banned client!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.530')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'889', N'errSaleInvoiceBannedClient', N'4', N'0', N'  No sale invoice operation was allowed to banned client!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.537')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'890', N'errSaleInvoiceBannedClient', N'2', N'0', N'Yasaklanmış müşteriye satış faturası yazılamaz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.547')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'891', N'errSaleInvoiceBannedClient', N'1', N'0', N'Qadağan olunmuş muştəriyə satış edə bilməzsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.553')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'892', N'errTxtInvalidLicenseCount', N'1', N'1', N'Lisenziyada icazə verilən cihaz sayı bitmişdir! Xahiş olunur administratorla əlaqə saxlayasınız!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.560')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'893', N'errTxtInvalidLicenseCount', N'2', N'1', N'Lisansta izin verilen cihaz sayısı bitmiştir! Lütfen yöneticinize başvurun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.570')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'894', N'errTxtInvalidLicenseCount', N'3', N'1', N'The number of devices allowed in the license has expired! Please contact your administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.577')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'895', N'errTxtInvalidLicenseCount', N'4', N'1', N'Количество разрешенных в лицензии устройств закончилось! Пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.587')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'896', N'errTxtLimitedLicenseCount', N'1', N'1', N'Lisenziyada icazə verilən cihaz sayı bitmişdir! Proqramı istifadə edə bilməyiniz üçün lisenziyanız DD gün ərzində yenilənməlidir! Xahiş olunur administratorla əlaqə saxlayasınız!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.593')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'897', N'errTxtLimitedLicenseCount', N'2', N'1', N'Lisansta izin verilen cihaz sayısı bitmiştir! Programı kullanabilmeniz için lisansınızın DD gün içerisinde yenilenmesi gerekiyor! Lütfen yöneticinize başvurun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.603')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'898', N'errTxtLimitedLicenseCount', N'3', N'1', N'The number of devices allowed in the license has expired! The license must be updated within DD days to use the program! Please contact your administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.610')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'899', N'errTxtLimitedLicenseCount', N'4', N'1', N'Количество разрешенных в лицензии устройств закончилось, для возможности дальнейшего использования программы лицензия должна быть обновлена в течение DD дней! Пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.620')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'900', N'errTxtUnknownDevice', N'1', N'1', N'Bu cihaz, icazə verilənlər siyahısında olmadığından, qeydiyyatdan keçirilə bilməz! Cihazdan istifadə edə bilmək üçün administratora müraciət edə bilərsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.627')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'901', N'errTxtUnknownDevice', N'2', N'1', N'Bu cihaz, izin verilenler listesinde bulunmadığından kaydedilemiyor! Cihazı kullanmak için yöneticinize başvurabilirsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.633')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'902', N'errTxtUnknownDevice', N'3', N'1', N'This device can not be registered because it is not in the allowed device list! You can contact your administrator to use the device!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.643')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'903', N'errTxtUnknownDevice', N'4', N'1', N'Это устройство отсутствует в списке разрешенных, поэтому не может пройти регистрацию! Пожалуйста, для продолжения использования данного устройства обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.650')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'904', N'errTxtBlockedDevice', N'1', N'1', N'Bu cihazın istifadəsi qadağan edilmişdir! Cihazdan istifadə edə bilmək üçün administratora müraciət edə bilərsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.660')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'905', N'errTxtBlockedDevice', N'2', N'1', N'Bu cihazın kullanımı yasaklanmıştır! Cihazı kullanmak için yöneticinize başvurabilirsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.667')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'906', N'errTxtBlockedDevice', N'3', N'1', N'This device is forbidden to use! You can contact your administrator to use the device!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.673')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'907', N'errTxtBlockedDevice', N'4', N'1', N'Использование этого устройства было запрещено! Для возможности дальнейшего использования, пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.683')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'908', N'errTxtForbidden', N'2', N'0', N'Bu cihaz veya operasyon için izniniz bulunmamaktadır!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.690')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'909', N'errTxtForbidden', N'4', N'0', N'Это устройство или операция не разрешены!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.700')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'910', N'docConfigWarehouseException', N'1', N'0', N'Anbar məlumatlarınız və ya tənzimləriniz hazır deyil! Xahiş olunur administratora müraciət edəsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.707')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'911', N'docConfigWarehouseException', N'2', N'0', N'Anbar bilgileriniz veya ayarlarınız mevcut değil! Lütfen yöneticinize başvurun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.717')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'912', N'docConfigWarehouseException', N'3', N'0', N'Your warehouse data or configurations are not available! Please contact the administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.723')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'913', N'docConfigWarehouseException', N'4', N'0', N'Ваши данные или настройки о складе не готовы! Пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.730')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'914', N'docConfigDivisionException', N'4', N'0', N'Ваши данные или настройки о рабочем месте не готовы! Пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.740')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'915', N'docConfigStatusException', N'4', N'0', N'Настройки Ваших операционных статусов не готовы! Пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.750')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'916', N'errBackendProblem', N'4', N'0', N'В системе произошла ошибка! Если ошибка повторится, пожалуйста, обратитесь к Вашему администратору!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.757')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'917', N'docConfigDivisionException', N'1', N'0', N'İş yeri məlumatlarınız və ya tənzimləriniz hazır deyil! Xahiş olunur administratora müraciət edəsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.763')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'918', N'docConfigDivisionException', N'2', N'0', N'İş yeri bilgileriniz veya ayarlarınız mevcut değil! Lütfen yöneticinize başvurun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.780')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'919', N'docConfigDivisionException', N'3', N'0', N'Your division data or configurations are not available! Please contact the administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.790')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'920', N'docConfigStatusException', N'1', N'0', N'Əməliyyat statusları ilə bağlı tənzimləriniz hazır deyil! Xahiş olunur administratora müraciət edəsiniz!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.800')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'921', N'docConfigStatusException', N'2', N'0', N'Fiş durumu ile bağlı ayarlarınız mevcut değil! Lütfen yöneticinize başvurun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.807')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'922', N'docConfigStatusException', N'3', N'0', N'Your status configurations for operations are not available! Please contact the administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.817')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'923', N'errBackendProblem', N'1', N'0', N'Sistemdə xəta baş vermişdir! Bu hal təkrarlandıqda, administratora müraciət etməyiniz xahiş olunur!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.820')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'924', N'errBackendProblem', N'2', N'0', N'Sistemde bir hata oluştu! Bu durum devam ederse, lütfen yöneticinize başvurun!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.827')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'925', N'errBackendProblem', N'3', N'0', N'An error has occurred on the system! If the situation persists, please contact your administrator!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.833')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'926', N'WarningWrongOrNoTaxNrInfoForClient', N'1', N'0', N'Xəbərdarlıq: Müştərinin VÖEN məlumatlarında yanlışlıq var!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.840')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'927', N'WarningWrongOrNoTaxNrInfoForClient', N'2', N'0', N'Uyarı: Müşteri Vergi numarasında yanlışlık var!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.843')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'928', N'WarningWrongOrNoTaxNrInfoForClient', N'3', N'0', N'Warning: Wrong TaxNr info for client!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.847')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'929', N'WarningWrongOrNoTaxNrInfoForClient', N'4', N'0', N'Warning: Wrong TaxNr info for client!', N'1', N'1', null, N'1', null, N'2019-03-18 12:50:52.850')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'930', N'TigerClientNotRelatedWithSalesPerson', N'1', N'0', N'Müştəri satış təmsilçisinə bağlı deyil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.643')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'931', N'TigerClientNotRelatedWithSalesPerson', N'2', N'0', N'Cari hesap satış temsilci bağlantısı uygun değil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.677')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'932', N'TigerClientNotRelatedWithSalesPerson', N'3', N'0', N'Client is not related with sales person!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.687')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'933', N'TigerClientNotRelatedWithSalesPerson', N'4', N'0', N'Client is not related with sales person!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.690')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'934', N'TigerNotEligibleClient', N'1', N'0', N'Müştəri tipi uyğun deyil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.697')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'935', N'TigerNotEligibleClient', N'2', N'0', N'Cari türü uygun değil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.707')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'936', N'TigerNotEligibleClient', N'3', N'0', N'Client type is not eligible!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.713')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'937', N'TigerNotEligibleClient', N'4', N'0', N'Client type is not eligible!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.717')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'938', N'TigerOrderNumberNotSetIssue', N'1', N'0', N'Sifariş nömrəsi set olunmayıb!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.727')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'939', N'TigerOrderNumberNotSetIssue', N'2', N'0', N'Sipariş numarası girilmemiştir!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.733')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'940', N'TigerOrderNumberNotSetIssue', N'3', N'0', N'Order number not set!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.740')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'941', N'TigerOrderNumberNotSetIssue', N'4', N'0', N'Order number not set!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.743')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'942', N'TigerDuplicateDocNumberIssue', N'1', N'0', N'Təkralanan sənəd nömrəsi!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.753')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'943', N'TigerDuplicateDocNumberIssue', N'2', N'0', N'Tekrar edilen evrak numarası!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.760')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'944', N'TigerDuplicateDocNumberIssue', N'3', N'0', N'Duplicate doc number!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.770')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'945', N'TigerDuplicateDocNumberIssue', N'4', N'0', N'Duplicate doc number!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.770')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'946', N'TigerErrorDocDateNotInsideFinancialPeriod', N'1', N'0', N'Sənəd tarixi mali il xaricindədir!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.780')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'947', N'TigerErrorDocDateNotInsideFinancialPeriod', N'2', N'0', N'Evrak tarihi mali yil dışındadır!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.787')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'948', N'TigerErrorDocDateNotInsideFinancialPeriod', N'3', N'0', N'Doc date is outside of financial period!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.797')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'949', N'TigerErrorDocDateNotInsideFinancialPeriod', N'4', N'0', N'Doc date is outside of financial period!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.797')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'950', N'TigerErrorDateNotInsideFinancialPeriod', N'1', N'0', N'Sənəd tarixi mali il xaricindədir!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.803')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'951', N'TigerErrorDateNotInsideFinancialPeriod', N'2', N'0', N'Evrak tarihi mali yil dışındadır!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.813')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'952', N'TigerErrorDateNotInsideFinancialPeriod', N'3', N'0', N'Doc date is outside of financial period!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.820')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'953', N'TigerErrorDateNotInsideFinancialPeriod', N'4', N'0', N'Doc date is outside of financial period!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.823')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'954', N'TigerErrorNoRelatedItemActionFoundIssue', N'1', N'0', N'Xəta: Qeyd edilən məhsul hərəkəti mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.830')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'955', N'TigerErrorNoRelatedItemActionFoundIssue', N'2', N'0', N'Hata: Ürün hareketi bulunamadı!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.840')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'956', N'TigerErrorNoRelatedItemActionFoundIssue', N'3', N'0', N'Error: The item action could not be found!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.847')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'957', N'TigerErrorNoRelatedItemActionFoundIssue', N'4', N'0', N'Связанное движение товара не найдено.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.857')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'958', N'TigerErrorNoSuchProjectCodeIssue', N'1', N'0', N'Xəta: Qeyd edilən proyekt kodu mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.873')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'959', N'TigerErrorNoSuchProjectCodeIssue', N'2', N'0', N'Hata: Proje kodu bulunamadı!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.883')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'960', N'TigerErrorNoSuchProjectCodeIssue', N'3', N'0', N'Error: Project code does not exists!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.890')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'961', N'TigerErrorNoSuchProjectCodeIssue', N'4', N'0', N'Не удалось найти код проекта!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.900')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'962', N'TigerErrorNoCashCardErrorIssue', N'1', N'0', N'Xəta: Qeyd edilən kassa kartı mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.910')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'963', N'TigerErrorNoCashCardErrorIssue', N'2', N'0', N'Hata: Kasa kartı bulunamadı!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.917')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'964', N'TigerErrorNoCashCardErrorIssue', N'3', N'0', N'Error: The cash card could not be found!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.927')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'965', N'TigerErrorNoCashCardErrorIssue', N'4', N'0', N'Не удалось найти кассовую карту.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.933')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'966', N'TigerErrorBankAccountCouldntFoundIssue', N'1', N'0', N'Xəta: Qeyd edilən bank hesabı mövcud deyil!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.940')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'967', N'TigerErrorBankAccountCouldntFoundIssue', N'2', N'0', N'Hata: Banka hesabı bulunamadı!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.950')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'968', N'TigerErrorBankAccountCouldntFoundIssue', N'3', N'0', N'Error: The bank account could not be found!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.953')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'969', N'TigerErrorBankAccountCouldntFoundIssue', N'4', N'0', N'Error: The bank account could not be found!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.957')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'970', N'TigerErrorCashCardIssue', N'1', N'0', N'Xəta:  Kassa kartı ilə əlaqədar problem!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.963')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'971', N'TigerErrorCashCardIssue', N'2', N'0', N'Hata: Kasa kartı ile ilgili problem!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.970')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'972', N'TigerErrorCashCardIssue', N'3', N'0', N'Error: There is an issue with cash card.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.973')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'973', N'TigerErrorCashCardIssue', N'4', N'0', N'Существует проблема с кассовой картой.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.980')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'974', N'TigerWarningApprovalDateIssue', N'1', N'0', N'Xəbərdarlıq: Təsdiq tarixindən əvvələ sənəd yazıla bilməz!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.990')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'975', N'TigerWarningApprovalDateIssue', N'2', N'0', N'Uyarı: Onay tarihinden önceye fiş yazılamaz.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:58.997')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'976', N'TigerWarningApprovalDateIssue', N'3', N'0', N'Warning: No operation is permitted before approved date.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.003')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'977', N'TigerWarningApprovalDateIssue', N'4', N'0', N'Документ не может быть написан до даты утверждения.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.013')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'978', N'TigerWarningOrderRiskLimitIssue', N'1', N'0', N'Uyarı: Sipariş belirlenmiş risk limitini aşmışdır.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.020')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'979', N'TigerWarningOrderRiskLimitIssue', N'2', N'0', N'Xəbərdarlıq: Sifariş nəzərdə tutulan risk limitini aşmışdır.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.030')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'980', N'TigerWarningOrderRiskLimitIssue', N'3', N'0', N'Warning: Orders risk limit exceeded.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.037')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'981', N'TigerWarningOrderRiskLimitIssue', N'4', N'0', N'Warning: Orders risk limit exceeded.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.040')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'982', N'TigerWarningNegativeItemIssue', N'1', N'0', N'Xəbərdarlıq: Stoku mənfiyə enən məhsul mövcuddur.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.050')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'983', N'TigerWarningNegativeItemIssue', N'2', N'0', N'Uyarı: Stoku eksiye inen ürün var.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.057')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'984', N'TigerWarningNegativeItemIssue', N'3', N'0', N'Warning: Negative item issue.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.063')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'985', N'TigerWarningNegativeItemIssue', N'4', N'0', N'Warning: Negative item issue.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.067')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'986', N'TigerErrorDuplicateFichne', N'1', N'0', N'Xəta: Eyni sənəd artıq mövcuddur!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.077')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'987', N'TigerErrorDuplicateFichne', N'2', N'0', N'Hata: Aynı fiş mevcuttur!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.083')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'988', N'TigerErrorDuplicateFichne', N'3', N'0', N'Error: Same document exists!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.090')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'989', N'TigerErrorDuplicateFichne', N'4', N'0', N'Тот же документ уже существует.', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.100')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'990', N'TigerErrorInvalidPassword', N'1', N'0', N'Şifrə səhvdir', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.107')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'991', N'TigerErrorInvalidPassword', N'2', N'0', N'Şifre yanlıştır', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.117')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'992', N'TigerErrorInvalidPassword', N'3', N'0', N'Password is wrong', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.123')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'993', N'TigerErrorInvalidPassword', N'4', N'0', N'Неверный пароль', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.127')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'994', N'TigerErrorInvalidUserName', N'1', N'0', N'İstifadəçi adı səhvdir', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.137')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'995', N'TigerErrorInvalidUserName', N'2', N'0', N'Kullanıcı adı yanlıştır', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.157')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'996', N'TigerErrorInvalidUserName', N'3', N'0', N'User name is wrong', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.163')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'997', N'TigerErrorInvalidUserName', N'4', N'0', N'Неверное имя пользователя', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.167')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'998', N'TigerErrorCantConnectDataBase', N'1', N'0', N'Xəta: Verilənlər bazasına bağlanmaq mümkün olmadı!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.177')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'999', N'TigerErrorCantConnectDataBase', N'2', N'0', N'Hata: Veri tabanına ulaşılamadı!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.183')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1000', N'TigerErrorCantConnectDataBase', N'3', N'0', N'Error: Db connection problem!', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.187')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1001', N'TigerErrorCantConnectDataBase', N'4', N'0', N'Нет соединения с базой данных', N'1', N'1', null, N'1', null, N'2019-05-07 21:11:59.190')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1002', N'errCashNotPermittedOperation', N'1', N'0', N'Kassa əməliyyatı etməyə səlahiyyətiniz yoxdur!', N'1', N'1', null, N'1', null, N'2019-05-09 13:42:46.893')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1003', N'errCashNotPermittedOperation', N'2', N'0', N'Nakit işlem yapmaya yetkiniz yokdur!', N'1', N'1', null, N'1', null, N'2019-05-09 13:42:46.923')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1004', N'errCashNotPermittedOperation', N'3', N'0', N'You have not access to cash operation!', N'1', N'1', null, N'1', null, N'2019-05-09 13:42:46.933')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1005', N'errCashNotPermittedOperation', N'4', N'0', N'Для осуществления кассовых операций у вас нет прав!', N'1', N'1', null, N'1', null, N'2019-05-09 13:42:46.943')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1006', N'errOrderNotPermittedOperation', N'1', N'0', N'Sifariş əməliyyatı etməyə səlahiyyətiniz yoxdur!', N'1', N'1', null, N'1', null, N'2019-05-09 14:18:04.663')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1007', N'errOrderNotPermittedOperation', N'2', N'0', N'Sipariş işlemi yapmaya yetkiniz yokdur!', N'1', N'1', null, N'1', null, N'2019-05-09 14:18:04.670')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1008', N'errOrderNotPermittedOperation', N'3', N'0', N'You have not access to order operation!', N'1', N'1', null, N'1', null, N'2019-05-09 14:18:04.673')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1009', N'errOrderNotPermittedOperation', N'4', N'0', N'Для осуществления заказовых операций у вас нет прав!', N'1', N'1', null, N'1', null, N'2019-05-09 14:18:04.680')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1010', N'errSaleInvoiceNotPermittedOperation', N'1', N'0', N'Satış fakturası əməliyyatı etməyə səlahiyyətiniz yoxdur!', N'1', N'1', null, N'1', null, N'2019-05-09 16:05:24.267')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1011', N'errSaleInvoiceNotPermittedOperation', N'2', N'0', N'Satış faturası işlemi yapmaya yetkiniz yokdur!', N'1', N'1', null, N'1', null, N'2019-05-09 16:05:24.283')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1012', N'errSaleInvoiceNotPermittedOperation', N'3', N'0', N'You do not have access for SaleInvoice operation!', N'1', N'1', null, N'1', null, N'2019-05-09 16:05:24.293')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1013', N'errSaleInvoiceNotPermittedOperation', N'4', N'0', N'У вас нет прав для операций по счет-фактурам!', N'1', N'1', null, N'1', null, N'2019-05-09 16:05:24.303')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1014', N'errOrderAllowedOrderLineCountExceeded', N'1', N'0', N'Xəbərdarlıq: Sifariş üçün icazə verilən sətir sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:11:19.453')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1015', N'errOrderAllowedOrderLineCountExceeded', N'2', N'0', N'Uyarı: Sipariş için izin verilen satır sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:11:19.490')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1016', N'errOrderAllowedOrderLineCountExceeded', N'3', N'0', N'Warning: Allowed order line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:11:19.500')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1017', N'errOrderAllowedOrderLineCountExceeded', N'4', N'0', N'Warning: Allowed order line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:11:19.503')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1018', N'errSaleInvoiceAllowedOrderLineCountExceeded', N'1', N'0', N'Xəbərdarlıq: Satış fakturası üçün icazə verilən sətir sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.533')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1019', N'errSaleInvoiceAllowedOrderLineCountExceeded', N'2', N'0', N'Uyarı: Satış faturası için izin verilen satır sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.553')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1020', N'errSaleInvoiceAllowedOrderLineCountExceeded', N'3', N'0', N'Warning: Allowed sale invoice line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.560')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1021', N'errSaleInvoiceAllowedOrderLineCountExceeded', N'4', N'0', N'Warning: Allowed sale invoice line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.563')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1022', N'errSaleDispatchAllowedOrderLineCountExceeded', N'1', N'0', N'Xəbərdarlıq: Satış qaiməsi üçün icazə verilən sətir sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.570')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1023', N'errSaleDispatchAllowedOrderLineCountExceeded', N'2', N'0', N'Uyarı: Satış irsaliyesi için izin verilen satır sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.580')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1024', N'errSaleDispatchAllowedOrderLineCountExceeded', N'3', N'0', N'Warning: Allowed sale dispatch line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.587')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1025', N'errSaleDispatchAllowedOrderLineCountExceeded', N'4', N'0', N'Warning: Allowed sale dispatch line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.590')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1026', N'errReturnDispatchAllowedOrderLineCountExceeded', N'1', N'0', N'Xəbərdarlıq: Geri qaytarma qaiməsi üçün icazə verilən sətir sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.597')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1027', N'errReturnDispatchAllowedOrderLineCountExceeded', N'2', N'0', N'Uyarı: İade irsaliyesi için izin verilen satır sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.603')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1028', N'errReturnDispatchAllowedOrderLineCountExceeded', N'3', N'0', N'Warning: Allowed return dispatch line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.610')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1029', N'errReturnDispatchAllowedOrderLineCountExceeded', N'4', N'0', N'Warning: Allowed return dispatch line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.613')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1030', N'errReturnInvoiceAllowedOrderLineCountExceeded', N'1', N'0', N'Xəbərdarlıq: Geri qaytarma fakturası üçün icazə verilən sətir sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.620')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1031', N'errReturnInvoiceAllowedOrderLineCountExceeded', N'2', N'0', N'Uyarı: İade faturası için izin verilen satır sayı aşılmışdır!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.630')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1032', N'errReturnInvoiceAllowedOrderLineCountExceeded', N'3', N'0', N'Warning: Allowed return invoice line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.637')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1033', N'errReturnInvoiceAllowedOrderLineCountExceeded', N'4', N'0', N'Warning: Allowed return invoice line count exceeded!', N'1', N'1', null, N'1', null, N'2019-05-10 18:32:10.640')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1034', N'RiskLimitChangeRequest', N'1', N'0', N'Risk Limiti Yeni Sorğu', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.500')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1035', N'RiskLimitChangeRequest', N'2', N'0', N'Risk Sınırı Yeni İstek', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.513')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1036', N'RiskLimitChangeRequest', N'3', N'0', N'Risk Limit New Request', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.517')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1037', N'RiskLimitChangeRequest', N'4', N'0', N'Предел Риска Новый Запрос', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.533')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1038', N'UpdateRiskLimitChangeRequest', N'1', N'0', N'Risk Limiti Dəyişim Sorğusu Yenilənməsi', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.540')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1039', N'UpdateRiskLimitChangeRequest', N'2', N'0', N'Risk Sınırı Değişim İsteği Güncellenmesi', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.550')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1040', N'UpdateRiskLimitChangeRequest', N'3', N'0', N'Risk Limit Change Request Update', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.557')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1041', N'UpdateRiskLimitChangeRequest', N'4', N'0', N'Предел Риска Обновить Запрос', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.567')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1042', N'RiskLimitNewRequest', N'1', N'0', N'Sizin yeni Risk Limiti Sorğunuz var', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.573')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1043', N'RiskLimitNewRequest', N'2', N'0', N'Yeni bir Risk Limiti isteğiniz var', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.583')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1044', N'RiskLimitNewRequest', N'3', N'0', N'You have a new Risk Limit request', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.590')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1045', N'RiskLimitNewRequest', N'4', N'0', N'У вас есть новый запрос на предел риска', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.600')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1046', N'RiskLimitRequestConfirmed', N'1', N'0', N'Sizin Risk Limiti sorğunuz təsdiqləndi', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.607')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1047', N'RiskLimitRequestConfirmed', N'2', N'0', N'Sizin Risk Sınırı isteğiniz onaylandı', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.617')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1048', N'RiskLimitRequestConfirmed', N'3', N'0', N'Your Risk Limit request has been approved', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.623')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1049', N'RiskLimitRequestConfirmed', N'4', N'0', N'Ваш запрос на предел риска был одобрен', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.627')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1050', N'RiskLimitRequestCancelled', N'1', N'0', N'Sizin Risk limitini istəyiniz ləğv edildi', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.630')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1051', N'RiskLimitRequestCancelled', N'2', N'0', N'Sizin Risk Sınırı isteğiniz iptal edildi', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.640')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1052', N'RiskLimitRequestCancelled', N'3', N'0', N'Your Risk Limit request has been cancelled', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.647')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1053', N'RiskLimitRequestCancelled', N'4', N'0', N'Ваш запрос на ограничение риска был отменен', N'1', N'1', null, N'1', null, N'2019-05-11 13:53:46.653')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1054', N'TigerErrorSafeDepositNumberNotSpecified', N'1', N'0', N'Xəta: Kassa mədaxil qəbzi üçün sənəd nömrəsi təyin edilməyin!', N'1', N'1', null, N'1', null, N'2019-05-24 20:57:03.550')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1055', N'TigerErrorSafeDepositNumberNotSpecified', N'2', N'0', N'Hata: Carhi hesap tahsilat için evrak numarası set edilmimiş!', N'1', N'1', null, N'1', null, N'2019-05-24 20:57:03.563')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1056', N'TigerErrorSafeDepositNumberNotSpecified', N'3', N'0', N'Error: Safe deposit number was not specified!', N'1', N'1', null, N'1', null, N'2019-05-24 20:57:03.573')
GO
GO
INSERT INTO [dbo].[SYS_Translation] ([Id], [ObjectName], [LanguageId], [Type], [Value], [UserType], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1057', N'TigerErrorSafeDepositNumberNotSpecified', N'4', N'0', N'Error: Safe deposit number was not specified!', N'1', N'1', null, N'1', null, N'2019-05-24 20:57:03.577')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_Translation] OFF
GO

-- ----------------------------
-- Table structure for SYS_UserActionType
-- ----------------------------
DROP TABLE [dbo].[SYS_UserActionType]
GO
CREATE TABLE [dbo].[SYS_UserActionType] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Type] nvarchar(50) NOT NULL ,
[Description] nvarchar(100) NULL ,
[Status] bit NOT NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_UserActionType]', RESEED, 30)
GO

-- ----------------------------
-- Records of SYS_UserActionType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_UserActionType] ON
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'1', N'Order', N'Order', N'1', N'2018-04-06 16:14:25.513')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'2', N'ReturnDispatch', N'Return Dispatch', N'1', N'2018-06-20 16:27:37.930')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'3', N'ReturnInvoice', N'Return Invoice', N'1', N'2018-06-20 16:27:42.857')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'4', N'SaleDispatch', N'Sale Dispatch', N'1', N'2018-06-20 16:27:47.220')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'5', N'SaleInvoice', N'Sale Invoice', N'1', N'2018-06-20 16:27:54.630')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'6', N'Cash', N'Cash', N'1', N'2018-06-20 16:28:02.017')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'7', N'CashOut', N'CashOut', N'1', N'2018-06-20 16:28:06.277')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'8', N'CheckPayment', N'Check payment', N'1', N'2018-09-27 13:10:25.693')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'9', N'VoucherPayment', N'Voucher payment', N'1', N'2018-09-27 13:10:37.337')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'10', N'CreditCardPayment', N'Credit card payment', N'1', N'2018-09-27 13:10:51.120')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'11', N'Empty', N'Empty', N'0', N'2018-09-27 13:12:40.723')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'12', N'Empty', N'Empty', N'0', N'2018-09-27 13:13:42.277')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'13', N'Empty', N'Empty', N'0', N'2018-09-27 13:13:45.263')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'14', N'Empty', N'Empty', N'0', N'2018-09-27 13:13:46.947')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'15', N'Empty', N'Empty', N'0', N'2018-09-27 13:13:48.813')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'16', N'Empty', N'Empty', N'0', N'2018-09-27 13:13:50.383')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'17', N'Empty', null, N'0', N'2018-09-27 13:14:01.397')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'18', N'Empty', null, N'0', N'2018-09-27 13:14:10.457')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'19', N'Empty', null, N'0', N'2018-09-27 13:14:13.160')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'20', N'Empty', null, N'0', N'2018-09-27 13:14:16.530')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'21', N'Empty', null, N'0', N'2018-09-27 13:16:22.093')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'22', N'Empty', null, N'0', N'2018-09-27 13:16:24.527')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'23', N'Empty', null, N'0', N'2018-09-27 13:16:26.597')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'24', N'Delivery', N'Delivery', N'1', N'2018-09-27 13:16:34.023')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'25', N'Standard Form', N'Standard form (blank)', N'1', N'2018-09-27 13:16:41.020')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'26', N'Free survey', N'Free survey', N'1', N'2018-09-27 13:16:42.910')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'27', N'Checklist', N'Checklist', N'1', N'2018-09-27 13:16:44.903')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'28', N'Photo', N'Photo taking', N'1', N'2018-09-27 13:16:46.753')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'29', N'Video', N'Video record', N'1', N'2018-09-27 13:16:48.877')
GO
GO
INSERT INTO [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (N'30', N'Visit', N'Visit', N'1', N'2018-09-27 13:17:02.767')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_UserActionType] OFF
GO

-- ----------------------------
-- Table structure for SYS_UserSettingObject
-- ----------------------------
DROP TABLE [dbo].[SYS_UserSettingObject]
GO
CREATE TABLE [dbo].[SYS_UserSettingObject] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[Name] nvarchar(50) NOT NULL ,
[Description] nvarchar(50) NULL ,
[Status] tinyint NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[SYS_UserSettingObject]', RESEED, 16)
GO

-- ----------------------------
-- Records of SYS_UserSettingObject
-- ----------------------------
SET IDENTITY_INSERT [dbo].[SYS_UserSettingObject] ON
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', N'RouteRestriction', N'Route restriction', N'1', null, N'1', null, N'2017-08-18 16:09:00.000')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', N'GpsRestriction', N'Gps restriction', N'1', null, N'1', null, N'2017-08-18 16:09:46.727')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', N'GpsDistance', N'Gps distance', N'1', null, N'1', null, N'2017-08-18 16:09:56.627')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'4', N'GpsLogEnabled', N'Flag for Gps log enabling', N'1', null, N'1', null, N'2017-08-18 16:10:05.130')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'5', N'GpsLogSize', N'Gps log size', N'1', null, N'1', null, N'2017-08-18 16:10:13.680')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'6', N'GpsLogSubmitPeriod', N'Gps log submit period', N'1', null, N'1', null, N'2017-08-18 16:10:27.893')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'7', N'GpsLogFetchPeriod', N'Gps log fetch period', N'1', null, N'1', null, N'2017-08-18 16:10:36.490')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'8', N'GpsLogStartTime', N'Gps log start time', N'1', null, N'1', null, N'2017-11-30 09:45:00.000')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'9', N'GpsLogEndTime', N'Gps log end time', N'1', null, N'1', null, N'2017-11-30 09:46:00.000')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'10', N'OperationsStartTime', N'Operations start time', N'1', null, N'1', null, N'2018-04-13 17:20:00.000')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'11', N'OperationsEndTime', N'Operations end time', N'1', null, N'1', null, N'2018-04-13 17:20:00.000')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'12', N'PlanDistributionType', N'Plan distribution type', N'1', null, N'1', null, N'2018-08-24 18:59:57.503')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'13', N'ItemsSaleDaysCount', N'Items sale days count  for color changing in App', N'1', null, N'1', null, N'2018-08-24 19:01:06.953')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'14', N'MaxDiscounts', N'Max discounts', N'1', null, N'1', null, N'2018-10-12 17:44:50.613')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'15', N'ShowVatIncludedPrice', N'ShowVatIncludedPrice', N'1', null, N'1', null, N'2019-01-19 16:37:14.777')
GO
GO
INSERT INTO [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'16', N'ItemBarcodePattern', N'Item Barcode Pattern', N'1', null, N'1', null, N'2019-07-24 16:37:14.777')
GO
GO
SET IDENTITY_INSERT [dbo].[SYS_UserSettingObject] OFF
GO

-- ----------------------------
-- Table structure for sysdiagrams
-- ----------------------------
DROP TABLE [dbo].[sysdiagrams]
GO
CREATE TABLE [dbo].[sysdiagrams] (
[name] sysname NOT NULL ,
[principal_id] int NOT NULL ,
[diagram_id] int NOT NULL IDENTITY(1,1) ,
[version] int NULL ,
[definition] varbinary(MAX) NULL 
)


GO

-- ----------------------------
-- Records of sysdiagrams
-- ----------------------------
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON
GO
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
GO

-- ----------------------------
-- Table structure for TDP_UserParam
-- ----------------------------
DROP TABLE [dbo].[TDP_UserParam]
GO
CREATE TABLE [dbo].[TDP_UserParam] (
[UserId] int NOT NULL ,
[OrderParamDoRezerv] bit NOT NULL ,
[OrderParamStatus] tinyint NOT NULL ,
[OrderParamFillAccode] bit NOT NULL ,
[DispatchParamFillAccode] bit NOT NULL ,
[ReturnParamRetCostType] tinyint NOT NULL ,
[InvoiceParamFillAccode] bit NOT NULL ,
[CashParamFillAccode] bit NOT NULL ,
[CashTranGorupPrefix] varchar(4) NOT NULL ,
[CashShouldGroupPayments] bit NOT NULL ,
[SyncPeriod] smallint NOT NULL 
)


GO

-- ----------------------------
-- Records of TDP_UserParam
-- ----------------------------

-- ----------------------------
-- Table structure for TPD_ImportConfig
-- ----------------------------
DROP TABLE [dbo].[TPD_ImportConfig]
GO
CREATE TABLE [dbo].[TPD_ImportConfig] (
[Firm] smallint NOT NULL ,
[ActivePeriod] smallint NOT NULL ,
[IsSpecialExchangeRate] bit NOT NULL ,
[ExchangeCurrencyType] smallint NOT NULL ,
[UserIdForCreatedBy] smallint NOT NULL ,
[LogoUserName] nvarchar(50) NOT NULL ,
[LogoPassword] nvarchar(50) NOT NULL ,
[OrderUnitPriceType] tinyint NOT NULL 
)


GO

-- ----------------------------
-- Records of TPD_ImportConfig
-- ----------------------------

-- ----------------------------
-- Table structure for UID_UserPermissionBannedClients
-- ----------------------------
DROP TABLE [dbo].[UID_UserPermissionBannedClients]
GO
CREATE TABLE [dbo].[UID_UserPermissionBannedClients] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] bigint NOT NULL ,
[OperationId] tinyint NOT NULL ,
[PermissionValue] nvarchar(50) NULL ,
[FirmNr] smallint NOT NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of UID_UserPermissionBannedClients
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UID_UserPermissionBannedClients] ON
GO
SET IDENTITY_INSERT [dbo].[UID_UserPermissionBannedClients] OFF
GO

-- ----------------------------
-- Table structure for UIM_AllowedDevice
-- ----------------------------
DROP TABLE [dbo].[UIM_AllowedDevice]
GO
CREATE TABLE [dbo].[UIM_AllowedDevice] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Imei] varchar(15) NULL ,
[Specode1] varchar(50) NULL ,
[Specode2] varchar(50) NULL ,
[CreatorUserId] bigint NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[LastModifierUserId] bigint NULL ,
[LastModificationTime] datetime2(7) NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[IsDeleted] bit NOT NULL 
)


GO

-- ----------------------------
-- Records of UIM_AllowedDevice
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_AllowedDevice] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_AllowedDevice] OFF
GO

-- ----------------------------
-- Table structure for UIM_Device
-- ----------------------------
DROP TABLE [dbo].[UIM_Device]
GO
CREATE TABLE [dbo].[UIM_Device] (
[Id] uniqueidentifier NOT NULL ,
[UID] varchar(50) NULL ,
[PushToken] nvarchar(500) NULL ,
[PushPermission] tinyint NULL ,
[TotpSecret] varchar(50) NOT NULL ,
[AppVersion] varchar(50) NULL ,
[Brand] varchar(50) NULL ,
[Model] varchar(50) NULL ,
[OS] varchar(50) NULL ,
[OSVersion] varchar(50) NULL ,
[Imei] varchar(50) NULL ,
[Mac] varchar(50) NULL ,
[ExtraInfo] varchar(50) NULL ,
[Status] tinyint NOT NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of UIM_Device
-- ----------------------------

-- ----------------------------
-- Table structure for UIM_Faq
-- ----------------------------
DROP TABLE [dbo].[UIM_Faq]
GO
CREATE TABLE [dbo].[UIM_Faq] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Question] varchar(500) NOT NULL ,
[Answer] varchar(2000) NOT NULL ,
[CreatorUserId] bigint NULL ,
[CreationTime] datetime2(7) NOT NULL ,
[LastModifierUserId] bigint NULL ,
[LastModificationTime] datetime2(7) NULL ,
[DeleterUserId] bigint NULL ,
[DeletionTime] datetime2(7) NULL ,
[IsDeleted] bit NOT NULL DEFAULT ((0)) ,
[CategoryId] int NOT NULL 
)


GO

-- ----------------------------
-- Records of UIM_Faq
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_Faq] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_Faq] OFF
GO

-- ----------------------------
-- Table structure for UIM_FaqCategory
-- ----------------------------
DROP TABLE [dbo].[UIM_FaqCategory]
GO
CREATE TABLE [dbo].[UIM_FaqCategory] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] varchar(500) NOT NULL ,
[CreationTime] datetime2(7) NOT NULL DEFAULT (getdate()) 
)


GO
DBCC CHECKIDENT(N'[dbo].[UIM_FaqCategory]', RESEED, 5)
GO

-- ----------------------------
-- Records of UIM_FaqCategory
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_FaqCategory] ON
GO
INSERT INTO [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (N'1', N'TDP', N'2018-12-27 19:15:10.1530000')
GO
GO
INSERT INTO [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (N'2', N'MIP', N'2018-12-28 00:00:00.0000000')
GO
GO
INSERT INTO [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (N'3', N'Delivery Management', N'2018-12-28 13:21:40.8530000')
GO
GO
INSERT INTO [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (N'4', N'CheckList', N'2018-12-28 13:21:48.3100000')
GO
GO
SET IDENTITY_INSERT [dbo].[UIM_FaqCategory] OFF
GO

-- ----------------------------
-- Table structure for UIM_NonLoggingDay
-- ----------------------------
DROP TABLE [dbo].[UIM_NonLoggingDay]
GO
CREATE TABLE [dbo].[UIM_NonLoggingDay] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Date] datetime NOT NULL ,
[FirmNr] smallint NULL ,
[UserId] bigint NOT NULL 
)


GO

-- ----------------------------
-- Records of UIM_NonLoggingDay
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_NonLoggingDay] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_NonLoggingDay] OFF
GO

-- ----------------------------
-- Table structure for UIM_Permission
-- ----------------------------
DROP TABLE [dbo].[UIM_Permission]
GO
CREATE TABLE [dbo].[UIM_Permission] (
[Id] smallint NOT NULL IDENTITY(1,1) ,
[ParentId] smallint NULL ,
[ObjectName] nvarchar(100) NOT NULL ,
[Description] nvarchar(100) NOT NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[OnlyHybridUser] bit NULL ,
[ClientId] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[UIM_Permission]', RESEED, 605)
GO

-- ----------------------------
-- Records of UIM_Permission
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_Permission] ON
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'1', null, N'Cash', N'Cash', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'2', N'1', N'Cash.CashCardCode', N'Cash cashcard code', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'3', N'1', N'Cash.Date', N'Cash time', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'4', N'1', N'Cash.Department', N'Cash department', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'5', N'1', N'Cash.Division', N'Cash division', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'6', N'1', N'Cash.SpeCode', N'Cash special code', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'7', N'1', N'Cash.Status', N'Cash status', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'8', N'1', N'Cash.TradingGroup', N'Cash trading group', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'9', null, N'Order', N'Order', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'10', N'9', N'Order.Date', N'Order time', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'11', N'9', N'Order.Department', N'Order department', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'12', N'9', N'Order.Division', N'Order division', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'13', N'9', N'Order.DocTrackingNr', N'Order document tracking number', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'14', N'9', N'Order.Factory', N'Order factory', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'15', N'9', N'Order.OptAffectCollatrl', N'Order opt affect collatrl', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'16', N'9', N'Order.SpeCode', N'Order special code', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'17', N'9', N'Order.Status', N'Order status', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'18', N'9', N'Order.TradingGroup', N'Order trading group', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'19', N'9', N'Order.Warehouse', N'Order warehouse', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'23', null, N'ReturnDispatch', N'ReturnDispatch', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'24', N'23', N'ReturnDispatch.Date', N'ReturnDispatch time', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'25', N'23', N'ReturnDispatch.Department', N'ReturnDispatch department', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'26', N'23', N'ReturnDispatch.Division', N'ReturnDispatch division', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'27', N'23', N'ReturnDispatch.DocTrackingNr', N'ReturnDispatch document tracking number', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'28', N'23', N'ReturnDispatch.Factory', N'ReturnDispatch factory', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'29', N'23', N'ReturnDispatch.OptAffectCollatrl', N'Return dispatch OptAffectCollatrl', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'30', N'23', N'ReturnDispatch.SpeCode', N'ReturnDispatch special code', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'31', N'23', N'ReturnDispatch.Status', N'ReturnDispatch status', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'32', N'23', N'ReturnDispatch.TradingGroup', N'ReturnDispatch trading group', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'33', N'23', N'ReturnDispatch.Warehouse', N'ReturnDispatch warehouse', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'34', null, N'ReturnInvoice', N'Return invoice', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'35', N'34', N'ReturnInvoice.Date', N'ReturnInvoice time', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'36', N'34', N'ReturnInvoice.Department', N'ReturnInvoice department', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'37', N'34', N'ReturnInvoice.Division', N'ReturnInvoice division', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'38', N'34', N'ReturnInvoice.DocTrackingNr', N'ReturnInvoice document tracking number', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'39', N'34', N'ReturnInvoice.Factory', N'ReturnInvoice factory', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'40', N'34', N'ReturnInvoice.OptAffectCollatrl', N'ReturnInvoice opt affect collatrl', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'41', N'34', N'ReturnInvoice.SpeCode', N'ReturnInvoice special code', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'42', N'34', N'ReturnInvoice.Status', N'ReturnInvoice status', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'43', N'34', N'ReturnInvoice.TradingGroup', N'ReturnInvoice trading group', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'44', N'34', N'ReturnInvoice.Warehouse', N'ReturnInvoice warehouse', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'45', null, N'SaleDispatch', N'Sale dispatch', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'46', N'45', N'SaleDispatch.Date', N'SaleDispatchInvoice time', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'47', N'45', N'SaleDispatch.Department', N'SaleDispatch department', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'48', N'45', N'SaleDispatch.Division', N'SaleDispatch division', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'49', N'45', N'SaleDispatch.DocTrackingNr', N'SaleDispatch document tracking number', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'50', N'45', N'SaleDispatch.Factory', N'SaleDispatch factory', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'51', N'45', N'SaleDispatch.OptAffectCollatrl', N'SaleDispatch opt affect collatrl', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'52', N'45', N'SaleDispatch.SpeCode', N'SaleDispatch special code', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'53', N'45', N'SaleDispatch.Status', N'SaleDispatch status', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'54', N'45', N'SaleDispatch.TradingGroup', N'SaleDispatch trading group', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'55', N'45', N'SaleDispatch.Warehouse', N'SaleDispatch warehouse', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'56', null, N'SaleInvoice', N'Sale invoice', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'57', N'56', N'SaleInvoice.Date', N'SaleInvoice time', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'58', N'56', N'SaleInvoice.Department', N'SaleInvoice department', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'59', N'56', N'SaleInvoice.Division', N'SaleInvoice division', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'60', N'56', N'SaleInvoice.DocTrackingNr', N'SaleInvoice document tracking number', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'61', N'56', N'SaleInvoice.Factory', N'SaleInvoice factory', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'62', N'56', N'SaleInvoice.OptAffectCollatrl', N'SaleInvoice opt affect collatrl', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'63', N'56', N'SaleInvoice.SpeCode', N'SaleInvoice special code', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'64', N'56', N'SaleInvoice.Status', N'SaleInvoice status', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'65', N'56', N'SaleInvoice.TradingGroup', N'SaleInvoice trading group', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'66', N'56', N'SaleInvoice.Warehouse', N'SaleInvoice warehouse', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'67', null, N'View', N'Menu/View in App', null, N'2', null, N'2017-03-06 23:26:28.727', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'79', null, N'DownloadOverCellular', N'Download over cellular', null, N'2', null, N'2017-09-23 16:12:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'80', N'79', N'DownloadOverCellular.Images', N'Download item images over cellular', null, N'2', null, N'2017-09-23 16:13:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'81', null, N'Audit', N'Audit Operations', null, N'2', null, N'2017-12-02 00:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'89', null, N'Sync', N'Sync', null, N'2', null, N'2018-03-31 11:05:48.833', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'91', N'89', N'Sync.Operational', N'Sync.Operational.ItemStocks', null, N'2', null, N'2018-03-31 11:05:50.030', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'95', N'89', N'Sync.ClientData', N'Sync.ClientData.Clients', null, N'2', null, N'2018-03-31 11:05:57.710', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'100', N'89', N'Sync.ItemCards', N'Sync.ItemCards.Items', null, N'2', null, N'2018-03-31 11:06:00.473', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'106', N'89', N'Sync.OtherProperties', N'Sync.OtherProperties.Warehouses', null, N'2', null, N'2018-03-31 11:06:02.833', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'114', N'89', N'Sync.OtherOperations', N'Sync.OtherOperations', null, N'2', null, N'2018-03-31 11:06:05.947', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'115', N'114', N'Sync.OtherOperations.UpdateOperationStatus', N'Sync.OtherOperations.UpdateOperationStatus', null, N'2', null, N'2018-03-31 11:06:06.410', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'116', N'114', N'Sync.OtherOperations.DownloadImage', N'Sync.OtherOperations.DownloadImage', null, N'2', null, N'2018-03-31 11:06:06.590', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'117', N'116', N'Sync.OtherOperations.DownloadImage.OverCellular', N'Sync.OtherOperations.DownloadImage.OverCellular', null, N'2', null, N'2018-03-31 11:06:07.190', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'118', null, N'Reports', N'Reports', null, N'2', null, N'2018-03-31 11:06:07.877', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'119', N'118', N'Reports.General', N'Reports.General', null, N'2', null, N'2018-03-31 11:06:08.160', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'120', N'119', N'Reports.General.SalesmanDebt', N'Reports.General.SalesmanDebt', null, N'2', null, N'2018-03-31 11:06:08.737', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'121', N'119', N'Reports.General.SaleActions', N'Reports.General.SaleActions', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'122', N'119', N'Reports.General.ItemStock', N'Reports.General.ItemStock', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'123', N'119', N'Reports.General.ItemPrices', N'Reports.General.ItemPrices', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'124', N'118', N'Reports.Client', N'Reports.Client', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'125', N'124', N'Reports.Client.StatementsSpecial', N'Reports.Client.StatementsSpecial', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'126', N'124', N'Reports.Client.Statements', N'Reports.Client.Statements', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'127', N'124', N'Reports.Client.ItemCirculationFinalized', N'Reports.Client.ItemCirculationFinalized', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'128', N'124', N'Reports.Client.TopSoldItems', N'Reports.Client.TopSoldItems', null, N'2', null, N'2018-03-31 11:06:08.953', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'129', null, N'Sale', N'Sale', null, N'2', null, N'2018-04-03 10:05:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'130', null, N'Statements', N'Statements', null, N'2', null, N'2018-04-03 10:05:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'131', null, N'Penetration', N'Penetration', null, N'2', null, N'2018-04-03 10:06:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'132', null, N'Tasks', N'Tasks', null, N'2', null, N'2018-04-03 10:06:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'133', null, N'Checklist', N'Checklist', null, N'2', null, N'2018-04-03 10:06:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'134', N'9', N'Order.ManualPromo', N'Order.ManualPromo', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'135', N'23', N'ReturnDispatch.ManualPromo', N'ReturnDispatch.ManualPromo', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'136', N'34', N'ReturnInvoice.ManualPromo', N'ReturnInvoice.ManualPromo', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'137', N'45', N'SaleDispatch.ManualPromo', N'SaleDispatch.ManualPromo', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'138', N'56', N'SaleInvoice.ManualPromo', N'SaleInvoice.ManualPromo', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'149', N'9', N'Order.EditItemPrice', N'Order.EditItemPrice', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'150', N'23', N'ReturnDispatch.EditItemPrice', N'ReturnDispatch.EditItemPrice', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'151', N'34', N'ReturnInvoice.EditItemPrice', N'ReturnInvoice.EditItemPrice', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'152', N'45', N'SaleDispatch.EditItemPrice', N'SaleDispatch.EditItemPrice', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'153', N'56', N'SaleInvoice.EditItemPrice', N'SaleInvoice.EditItemPrice', null, N'2', null, N'2018-04-13 15:00:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'154', null, N'Gps', N'Gps', null, N'2', null, N'2018-04-13 15:22:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'183', N'9', N'Order.ManualLineExpensePercent', N'Order.ManualLineExpensePercent', null, N'2', null, N'2018-04-17 16:19:04.963', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'184', N'23', N'ReturnDispatch.ManualLineExpensePercent', N'ReturnDispatch.ManualLineExpensePercent', null, N'2', null, N'2018-04-17 16:19:04.963', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'185', N'34', N'ReturnInvoice.ManualLineExpensePercent', N'ReturnInvoice.ManualLineExpensePercent', null, N'2', null, N'2018-04-17 16:19:04.963', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'186', N'45', N'SaleDispatch.ManualLineExpensePercent', N'SaleDispatch.ManualLineExpensePercent', null, N'2', null, N'2018-04-17 16:19:04.963', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'187', N'56', N'SaleInvoice.ManualLineExpensePercent', N'SaleInvoice.ManualLineExpensePercent', null, N'2', null, N'2018-04-17 16:19:04.963', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'188', N'9', N'Order.ManualTotalExpensePercent', N'Order.ManualTotalExpensePercent', null, N'2', null, N'2018-04-17 16:20:05.797', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'189', N'23', N'ReturnDispatch.ManualTotalExpensePercent', N'ReturnDispatch.ManualTotalExpensePercent', null, N'2', null, N'2018-04-17 16:20:05.797', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'190', N'34', N'ReturnInvoice.ManualTotalExpensePercent', N'ReturnInvoice.ManualTotalExpensePercent', null, N'2', null, N'2018-04-17 16:20:05.797', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'191', N'45', N'SaleDispatch.ManualTotalExpensePercent', N'SaleDispatch.ManualTotalExpensePercent', null, N'2', null, N'2018-04-17 16:20:05.797', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'192', N'56', N'SaleInvoice.ManualTotalExpensePercent', N'SaleInvoice.ManualTotalExpensePercent', null, N'2', null, N'2018-04-17 16:20:05.797', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'193', N'9', N'Order.PaymentPlan', N'Order.PaymentPlan', null, N'2', null, N'2018-04-20 15:25:40.123', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'194', N'23', N'ReturnDispatch.PaymentPlan', N'ReturnDispatch.PaymentPlan', null, N'2', null, N'2018-04-20 15:25:40.123', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'195', N'34', N'ReturnInvoice.PaymentPlan', N'ReturnInvoice.PaymentPlan', null, N'2', null, N'2018-04-20 15:25:40.123', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'196', N'45', N'SaleDispatch.PaymentPlan', N'SaleDispatch.PaymentPlan', null, N'2', null, N'2018-04-20 15:25:40.123', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'197', N'56', N'SaleInvoice.PaymentPlan', N'SaleInvoice.PaymentPlan', null, N'2', null, N'2018-04-20 15:25:40.123', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'198', N'9', N'Order.ManualLineDiscountAmount', N'Order.ManualLineDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'199', N'9', N'Order.ManualLineDiscountPercent', N'Order.ManualLineDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'200', N'9', N'Order.ManualTotalDiscountAmount', N'Order.ManualTotalDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'201', N'9', N'Order.ManualTotalDiscountPercent', N'Order.ManualTotalDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'202', N'23', N'ReturnDispatch.ManualLineDiscountAmount', N'ReturnDispatch.ManualLineDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'203', N'23', N'ReturnDispatch.ManualLineDiscountPercent', N'ReturnDispatch.ManualLineDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'204', N'23', N'ReturnDispatch.ManualTotalDiscountAmount', N'ReturnDispatch.ManualTotalDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'205', N'23', N'ReturnDispatch.ManualTotalDiscountPercent', N'ReturnDispatch.ManualTotalDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'206', N'34', N'ReturnInvoice.ManualLineDiscountAmount', N'ReturnInvoice.ManualLineDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'207', N'34', N'ReturnInvoice.ManualLineDiscountPercent', N'ReturnInvoice.ManualLineDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'208', N'34', N'ReturnInvoice.ManualTotalDiscountAmount', N'ReturnInvoice.ManualTotalDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'209', N'34', N'ReturnInvoice.ManualTotalDiscountPercent', N'ReturnInvoice.ManualTotalDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'210', N'45', N'SaleDispatch.ManualLineDiscountAmount', N'SaleDispatch.ManualLineDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'211', N'45', N'SaleDispatch.ManualLineDiscountPercent', N'SaleDispatch.ManualLineDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'212', N'45', N'SaleDispatch.ManualTotalDiscountAmount', N'SaleDispatch.ManualTotalDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'213', N'45', N'SaleDispatch.ManualTotalDiscountPercent', N'SaleDispatch.ManualTotalDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'214', N'56', N'SaleInvoice.ManualLineDiscountAmount', N'SaleInvoice.ManualLineDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'215', N'56', N'SaleInvoice.ManualLineDiscountPercent', N'SaleInvoice.ManualLineDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'216', N'56', N'SaleInvoice.ManualTotalDiscountAmount', N'SaleInvoice.ManualTotalDiscountAmount', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'217', N'56', N'SaleInvoice.ManualTotalDiscountPercent', N'SaleInvoice.ManualTotalDiscountPercent', null, N'1', null, N'2018-04-26 12:35:03.083', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'218', N'9', N'Order.Note', N'Order.Note', null, N'1', null, N'2018-05-04 14:55:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'219', N'23', N'ReturnDispatch.Note', N'ReturnDispatch.Note', null, N'1', null, N'2018-05-04 14:56:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'220', N'34', N'ReturnInvoice.Note', N'ReturnInvoice.Note', null, N'1', null, N'2018-05-04 14:56:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'221', N'45', N'SaleDispatch.Note', N'SaleDispatch.Note', null, N'1', null, N'2018-05-04 14:56:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'222', N'56', N'SaleInvoice.Note', N'SaleInvoice.Note', null, N'1', null, N'2018-05-04 14:56:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'223', N'1', N'Cash.Note', N'Cash.Note', null, N'1', null, N'2018-05-04 14:58:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'225', N'9', N'Order.DeliveryDate', N'Delivery date', null, N'2', null, N'2018-06-02 15:19:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'226', null, N'SendClientLocation', N'Send client location', null, N'2', null, N'2018-06-02 15:19:00.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'228', null, N'CashOut', N'Cash out', null, N'2', null, N'2018-08-04 12:46:51.400', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'229', null, N'CheckPayment', N'Check payment', null, N'2', null, N'2018-08-04 12:47:05.540', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'230', null, N'VoucherPayment', N'Voucher payment', null, N'2', null, N'2018-08-04 12:47:17.423', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'231', null, N'CreditCardPayment', N'Credit card payment', null, N'2', null, N'2018-08-04 12:47:40.990', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'232', N'228', N'CashOut.CashCardCode', N'Cash card code', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'233', N'228', N'CashOut.Date', N'Cash out time', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'234', N'228', N'CashOut.Department', N'Cash out department', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'235', N'228', N'CashOut.Division', N'Cash out division', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'236', N'228', N'CashOut.SpeCode', N'Cash out special code', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'237', N'228', N'CashOut.Status', N'Cash out status', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'238', N'228', N'CashOut.TradingGroup', N'Cash out trading group', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'239', N'228', N'CashOut.Note', N'Cash out note', null, N'2', null, N'2018-08-04 12:51:10.393', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'241', N'229', N'CheckPayment.Date', N'Check payment date', null, N'2', null, N'2018-08-04 20:35:16.520', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'242', N'229', N'CheckPayment.Division', N'Check payment division', null, N'2', null, N'2018-08-04 20:35:32.577', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'243', N'229', N'CheckPayment.Department', N'Check payment department', null, N'2', null, N'2018-08-04 20:36:06.787', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'244', N'229', N'CheckPayment.TradingGroup', N'Check payment trading group', null, N'2', null, N'2018-08-04 20:36:36.160', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'246', N'229', N'CheckPayment.SpeCode', N'Check payment special code', null, N'2', null, N'2018-08-04 20:36:55.773', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'247', N'229', N'CheckPayment.Note', N'Check payment note', null, N'2', null, N'2018-08-04 20:37:08.750', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'248', N'230', N'VoucherPayment.Date', N'Voucher payment date', null, N'2', null, N'2018-08-04 20:35:16.520', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'249', N'230', N'VoucherPayment.Division', N'Voucher payment division', null, N'2', null, N'2018-08-04 20:35:32.577', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'250', N'230', N'VoucherPayment.Department', N'Voucher payment department', null, N'2', null, N'2018-08-04 20:36:06.787', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'251', N'230', N'VoucherPayment.TradingGroup', N'Voucher payment trading group', null, N'2', null, N'2018-08-04 20:36:36.160', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'252', N'230', N'VoucherPayment.SpeCode', N'Voucher payment special code', null, N'2', null, N'2018-08-04 20:36:55.773', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'253', N'230', N'VoucherPayment.Note', N'Voucher payment note', null, N'2', null, N'2018-08-04 20:37:08.750', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'254', N'231', N'CreditCardPayment.Status', N'Credit card payment status', null, N'2', null, N'2018-08-04 20:35:16.520', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'255', N'231', N'CreditCardPayment.Division', N'Credit card payment division', null, N'2', null, N'2018-08-04 20:35:32.577', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'256', N'231', N'CreditCardPayment.Department', N'Credit card payment department', null, N'2', null, N'2018-08-04 20:36:06.787', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'257', N'231', N'CreditCardPayment.TradingGroup', N'Credit card payment trading group', null, N'2', null, N'2018-08-04 20:36:36.160', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'258', N'231', N'CreditCardPayment.SpeCode', N'Credit card payment special code', null, N'2', null, N'2018-08-04 20:36:55.773', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'259', N'231', N'CreditCardPayment.Note', N'Credit card payment note', null, N'2', null, N'2018-08-04 20:37:08.750', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'260', N'230', N'VoucherPayment.Status', N'Voucher payment status', null, N'2', null, N'2018-08-04 20:47:01.343', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'261', N'229', N'CheckPayment.Status', N'Check payment status', null, N'2', null, N'2018-08-04 20:47:24.483', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'271', N'231', N'CreditCardPayment.Date', N'Credit card payment date', null, N'2', null, N'2018-08-08 13:55:01.880', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'273', N'231', N'CreditCardPayment.PaymentPlan', N'Credit card payment payment plan', null, N'2', null, N'2018-08-08 14:01:05.767', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'275', null, N'Client', N'Client', null, N'2', null, N'2018-08-11 15:31:40.757', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'276', N'275', N'Client.Info', N'Client info general data', null, N'2', null, N'2018-08-11 15:33:34.060', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'277', N'276', N'Client.Info.GeneralData', N'Client info general data', null, N'2', null, N'2018-08-11 15:33:56.020', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'278', N'276', N'Client.Info.ContactData', N'Client info contact data', null, N'2', null, N'2018-08-11 15:34:16.253', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'279', N'276', N'Client.Info.FinanceData', N'Client info finance data', null, N'2', null, N'2018-08-11 15:34:30.950', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'280', N'276', N'Client.Info.RiskData', N'Client info risk data', null, N'2', null, N'2018-08-11 15:34:47.670', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'281', N'275', N'Client.Balance', N'Client info balance', null, N'2', null, N'2018-08-11 15:34:58.513', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'282', N'275', N'Client.Edino', N'Client info edino', null, N'2', null, N'2018-08-11 15:35:17.277', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'283', N'275', N'Client.Code', N'Client info code', null, N'2', null, N'2018-08-11 15:38:05.287', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'284', N'275', N'Client.UploadShowCasePhoto', N'Client upload show case photo', null, N'2', null, N'2018-08-11 15:38:21.703', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'285', N'275', N'Client.ShowCasePhoto', N'Client show case photo', null, N'2', null, N'2018-08-13 15:03:25.520', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'286', N'276', N'Client.Info.MediaData', N'Client info media data', null, N'2', null, N'2018-08-15 18:11:33.147', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'288', N'9', N'Order.EditDocument', N'Order edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'289', N'9', N'Order.GpsRestriction', N'Order Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'290', N'289', N'Order.GpsRestriction.CreateEdit', N'Order Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'291', N'289', N'Order.GpsRestriction.Edit', N'Order Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'292', N'9', N'Order.Print', N'Order print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'293', N'9', N'Order.Print.BeforeErp', N'Order print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'294', N'9', N'Order.RouteRestriction', N'Order route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'296', N'294', N'Order.RouteRestriction.CreateEdit', N'Order route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'298', N'154', N'Gps.Operation', N'Gps operation', null, N'2', null, N'2018-08-17 18:25:44.713', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'299', N'154', N'Gps.Incorrectness', N'Gps incorrectness', null, N'2', null, N'2018-08-17 18:26:21.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'301', N'154', N'Gps.AppStart', N'Gps app start', null, N'2', null, N'2018-08-17 18:26:50.093', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'302', N'45', N'SaleDispatch.EditDocument', N'Sale dispatch edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'303', N'45', N'SaleDispatch.GpsRestriction', N'Sale dispatch Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'304', N'303', N'SaleDispatch.GpsRestriction.CreateEdit', N'Sale dispatch Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'305', N'303', N'SaleDispatch.GpsRestriction.Edit', N'Sale dispatch Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'306', N'45', N'SaleDispatch.Print', N'Sale dispatch print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'307', N'45', N'SaleDispatch.Print.BeforeErp', N'Sale dispatch print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'308', N'45', N'SaleDispatch.RouteRestriction', N'Sale dispatch route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'309', N'308', N'SaleDispatch.RouteRestriction.CreateEdit', N'Sale dispatch route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'310', N'56', N'SaleInvoice.EditDocument', N'Sale invoice edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'311', N'56', N'SaleInvoice.GpsRestriction', N'Sale invoice Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'312', N'311', N'SaleInvoice.GpsRestriction.CreateEdit', N'Sale invoice Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'313', N'311', N'SaleInvoice.GpsRestriction.Edit', N'Sale invoice Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'314', N'56', N'SaleInvoice.Print', N'Sale invoice print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'315', N'56', N'SaleInvoice.Print.BeforeErp', N'Sale invoice print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'316', N'56', N'SaleInvoice.RouteRestriction', N'Sale invoice route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'317', N'316', N'SaleInvoice.RouteRestriction.CreateEdit', N'Sale invoice route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'318', N'23', N'ReturnDispatch.EditDocument', N'Return dispatch edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'319', N'23', N'ReturnDispatch.GpsRestriction', N'Return dispatch Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'320', N'319', N'ReturnDispatch.GpsRestriction.CreateEdit', N'Return dispatch Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'321', N'319', N'ReturnDispatch.GpsRestriction.Edit', N'Return dispatch Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'322', N'23', N'ReturnDispatch.Print', N'Return dispatch print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'323', N'23', N'ReturnDispatch.Print.BeforeErp', N'Return dispatch print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'324', N'23', N'ReturnDispatch.RouteRestriction', N'Return dispatch route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'325', N'324', N'ReturnDispatch.RouteRestriction.CreateEdit', N'Return dispatch route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'326', N'34', N'ReturnInvoice.EditDocument', N'Return invoice edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'327', N'34', N'ReturnInvoice.GpsRestriction', N'Return invoice Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'328', N'327', N'ReturnInvoice.GpsRestriction.CreateEdit', N'Return invoice Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'329', N'327', N'ReturnInvoice.GpsRestriction.Edit', N'Return invoice Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'330', N'34', N'ReturnInvoice.Print', N'Return invoice print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'331', N'34', N'ReturnInvoice.Print.BeforeErp', N'Return invoice print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'332', N'34', N'ReturnInvoice.RouteRestriction', N'Return invoice route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'333', N'332', N'ReturnInvoice.RouteRestriction.CreateEdit', N'Return invoice route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'334', N'1', N'Cash.EditDocument', N'Cash edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'335', N'1', N'Cash.GpsRestriction', N'Cash Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'336', N'335', N'Cash.GpsRestriction.CreateEdit', N'Cash Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'337', N'335', N'Cash.GpsRestriction.Edit', N'Cash Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'338', N'1', N'Cash.Print', N'Cash print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'339', N'1', N'Cash.Print.BeforeErp', N'Cash print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'340', N'1', N'Cash.RouteRestriction', N'Cash route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'341', N'340', N'Cash.RouteRestriction.CreateEdit', N'Cash route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'342', N'228', N'CashOut.EditDocument', N'Cash out edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'343', N'228', N'CashOut.GpsRestriction', N'Cash out Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'344', N'343', N'CashOut.GpsRestriction.CreateEdit', N'Cash out Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'345', N'343', N'CashOut.GpsRestriction.Edit', N'Cash out Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'346', N'228', N'CashOut.Print', N'Cash out print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'347', N'228', N'CashOut.Print.BeforeErp', N'Cash out print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'348', N'228', N'CashOut.RouteRestriction', N'Cash out route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'349', N'348', N'CashOut.RouteRestriction.CreateEdit', N'Cash out route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'350', N'229', N'CheckPayment.EditDocument', N'Check payment edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'351', N'229', N'CheckPayment.GpsRestriction', N'Check payment Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'352', N'351', N'CheckPayment.GpsRestriction.CreateEdit', N'Check payment Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'353', N'351', N'CheckPayment.GpsRestriction.Edit', N'Check payment Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'354', N'229', N'CheckPayment.Print', N'Check payment print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'355', N'229', N'CheckPayment.Print.BeforeErp', N'Check payment print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'356', N'229', N'CheckPayment.RouteRestriction', N'Check payment route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'357', N'356', N'CheckPayment.RouteRestriction.CreateEdit', N'Check payment route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'358', N'230', N'VoucherPayment.EditDocument', N'Voucher payment edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'359', N'230', N'VoucherPayment.GpsRestriction', N'Voucher payment Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'360', N'359', N'VoucherPayment.GpsRestriction.CreateEdit', N'Voucher payment Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'361', N'359', N'VoucherPayment.GpsRestriction.Edit', N'Voucher payment Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'362', N'230', N'VoucherPayment.Print', N'Voucher payment print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'363', N'230', N'VoucherPayment.Print.BeforeErp', N'Voucher payment print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'364', N'230', N'VoucherPayment.RouteRestriction', N'Voucher payment route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'365', N'364', N'VoucherPayment.RouteRestriction.CreateEdit', N'Voucher payment route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'366', N'231', N'CreditCardPayment.EditDocument', N'Credit card payment edit document', null, N'2', null, N'2018-08-17 18:16:41.507', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'367', N'231', N'CreditCardPayment.GpsRestriction', N'Credit card payment Gps restriction', null, N'2', null, N'2018-08-17 18:17:02.390', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'368', N'367', N'CreditCardPayment.GpsRestriction.CreateEdit', N'Credit card payment Gps restriction create edit', null, N'2', null, N'2018-08-17 18:17:22.887', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'369', N'367', N'CreditCardPayment.GpsRestriction.Edit', N'Credit card payment Gps restriction edit', null, N'2', null, N'2018-08-17 18:17:49.270', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'370', N'231', N'CreditCardPayment.Print', N'Credit card payment print', null, N'2', null, N'2018-08-17 18:18:04.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'371', N'231', N'CreditCardPayment.Print.BeforeErp', N'Credit card payment print before Erp', null, N'2', null, N'2018-08-17 18:18:28.313', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'372', N'231', N'CreditCardPayment.RouteRestriction', N'Credit card payment route restriction', null, N'2', null, N'2018-08-17 18:18:45.593', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'373', N'372', N'CreditCardPayment.RouteRestriction.CreateEdit', N'Credit card payment route restriction create edit', null, N'2', null, N'2018-08-17 18:19:02.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'374', null, N'Visit', N'Visit', null, N'2', null, N'2018-08-18 12:44:58.880', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'376', N'374', N'Visit.GpsRestriction', N'Visit Gps restriction', null, N'2', null, N'2018-08-18 12:45:34.177', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'378', N'376', N'Visit.GpsRestriction.CreateEdit', N'Visit Gps restriction create edit', null, N'2', null, N'2018-08-18 12:47:11.920', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'379', N'298', N'Gps.Operation.CreateEdit', N'Gps operation create edit', null, N'2', null, N'2018-08-21 10:36:41.257', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'380', N'81', N'Audit.GpsRestriction', N'Audit Gps restriction', null, N'2', null, N'2018-08-31 16:04:35.577', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'381', N'380', N'Audit.GpsRestriction.CreateEdit', N'Audit Gps restriction create edit', null, N'2', null, N'2018-08-31 16:06:31.223', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'382', N'81', N'Audit.RouteRestriction', N'Audit route restriction', null, N'2', null, N'2018-08-31 16:16:55.010', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'384', N'382', N'Audit.RouteRestriction.CreateEdit', N'Audit route restriction create edit', null, N'2', null, N'2018-08-31 16:17:10.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'385', N'275', N'Client.Map', N'Client map', null, N'2', null, N'2018-09-07 10:58:32.110', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'386', N'275', N'Client.Navigation', N'Client navigation', null, N'2', null, N'2018-09-07 10:59:09.430', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'387', N'298', N'Gps.Operation.Edit', N'Gps operation edit', null, N'2', null, N'2018-09-18 15:44:53.640', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'388', N'230', N'VoucherPayment.Giro', N'Voucher payment giro', null, N'2', null, N'2018-09-24 18:38:31.173', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'389', N'230', N'VoucherPayment.TaxNr', N'Voucher tax nr', null, N'2', null, N'2018-09-24 18:38:31.173', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'390', N'229', N'CheckPayment.Giro', N'Check payment giro', null, N'2', null, N'2018-09-24 18:38:31.177', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'391', N'229', N'CheckPayment.TaxNr', N'Check tax nr', null, N'2', null, N'2018-09-24 18:38:31.177', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'392', N'229', N'CheckPayment.PieceCount', N'Check payment piece count', null, N'2', null, N'2018-09-24 18:38:31.177', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'393', N'229', N'CheckPayment.DayCount', N'Check payment day count', null, N'2', null, N'2018-09-24 18:38:31.177', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'394', N'229', N'CheckPayment.DayOfMonth', N'Check payment day of month', null, N'2', null, N'2018-09-24 18:38:31.180', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'395', N'9', N'Order.SuggestedPrice', N'Order suggested price', null, N'2', null, N'2018-11-06 20:25:10.840', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'396', N'56', N'SaleInvoice.SuggestedPrice', N'Sale invoice suggested price', null, N'2', null, N'2018-11-06 20:25:51.040', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'397', N'45', N'SaleDispatch.SuggestedPrice', N'Sale dispatch suggested price', null, N'2', null, N'2018-11-06 20:27:14.537', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'398', N'23', N'ReturnDispatch.SuggestedPrice', N'Return dispatch suggested price', null, N'2', null, N'2018-11-07 10:25:02.000', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'399', N'34', N'ReturnInvoice.SuggestedPrice', N'Return invoice suggested price', null, N'2', null, N'2018-11-07 10:26:15.350', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'400', N'9', N'Order.DocNumber', N'Order document number', null, N'2', null, N'2018-11-08 20:19:42.620', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'401', N'23', N'ReturnDispatch.DocNumber', N'Return dispatch document number', null, N'2', null, N'2018-11-08 20:19:42.627', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'402', N'45', N'SaleDispatch.DocNumber', N'Sale dispatch document number', null, N'2', null, N'2018-11-08 20:19:42.627', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'403', N'34', N'ReturnInvoice.DocNumber', N'Return invoice document number', null, N'2', null, N'2018-11-08 20:19:42.627', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'404', N'56', N'SaleInvoice.DocNumber', N'Sale dispatch document number', null, N'2', null, N'2018-11-08 20:19:42.627', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'405', N'1', N'Cash.DocNumber', N'Cash document number', null, N'2', null, N'2018-11-08 20:19:42.627', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'406', N'228', N'CashOut.DocNumber', N'Cash out document number', null, N'2', null, N'2018-11-08 20:19:42.627', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'407', N'229', N'CheckPayment.DocNumber', N'Check payment document number', null, N'2', null, N'2018-11-08 20:19:42.630', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'408', N'230', N'VoucherPayment.DocNumber', N'Voucher payment document number', null, N'2', null, N'2018-11-08 20:19:42.630', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'409', N'231', N'CreditCardPayment.DocNumber', N'Credit card payment document number', null, N'2', null, N'2018-11-08 20:19:42.630', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'410', N'1', N'Cash.OptAffectCollatrl', N'Cash opt affect collatrl', null, N'2', null, N'2018-11-08 20:20:31.790', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'411', N'228', N'CashOut.OptAffectCollatrl', N'Cash out opt affect collatrl', null, N'2', null, N'2018-11-08 20:20:31.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'412', N'229', N'CheckPayment.OptAffectCollatrl', N'Check payment opt affect collatrl', null, N'2', null, N'2018-11-08 20:20:31.793', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'413', N'230', N'VoucherPayment.OptAffectCollatrl', N'Voucher payment opt affect collatrl', null, N'2', null, N'2018-11-08 20:20:31.797', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'414', N'231', N'CreditCardPayment.OptAffectCollatrl', N'Credit card payment opt affect collatrl', null, N'2', null, N'2018-11-08 20:20:31.797', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'415', N'9', N'Order.AuthCode', N'Order authentication code', null, N'2', null, N'2018-11-08 20:21:04.523', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'416', N'23', N'ReturnDispatch.AuthCode', N'Return dispatch authentication code', null, N'2', null, N'2018-11-08 20:21:04.523', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'417', N'45', N'SaleDispatch.AuthCode', N'Sale dispatch authentication code', null, N'2', null, N'2018-11-08 20:21:04.527', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'418', N'34', N'ReturnInvoice.AuthCode', N'Return invoice authentication code', null, N'2', null, N'2018-11-08 20:21:04.527', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'419', N'56', N'SaleInvoice.AuthCode', N'Sale dispatch authentication code', null, N'2', null, N'2018-11-08 20:21:04.527', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'420', N'1', N'Cash.AuthCode', N'Cash authentication code', null, N'2', null, N'2018-11-08 20:21:04.527', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'421', N'228', N'CashOut.AuthCode', N'Cash out authentication code', null, N'2', null, N'2018-11-08 20:21:04.527', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'422', N'229', N'CheckPayment.AuthCode', N'Check payment authentication code', null, N'2', null, N'2018-11-08 20:21:04.527', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'423', N'230', N'VoucherPayment.AuthCode', N'Voucher payment authentication code', null, N'2', null, N'2018-11-08 20:21:04.530', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'424', N'231', N'CreditCardPayment.AuthCode', N'Credit card payment authentication code', null, N'2', null, N'2018-11-08 20:21:04.530', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'427', null, N'Item', N'Item', null, N'2', null, N'2018-12-06 20:40:02.320', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'428', N'427', N'Item.Plan', N'Item.Plan', null, N'2', null, N'2018-12-06 20:40:02.320', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'429', N'427', N'Item.Limit', N'Item.Limit', null, N'2', null, N'2018-12-06 20:40:02.323', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'430', N'427', N'Item.Image', N'Item.Image', null, N'2', null, N'2018-12-06 20:40:02.323', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'431', N'427', N'Item.OperationHistory', N'Item.OperationHistory', null, N'2', null, N'2018-12-06 20:40:02.323', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'433', N'119', N'Reports.General.ItemOperationHistory', N'Reports.General.ItemOperationHistory', null, N'2', null, N'2018-12-07 13:16:56.243', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'438', N'1', N'Cash.Currency', N'Cash payment currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'439', N'9', N'Order.Currency', N'Order currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'440', N'23', N'ReturnDispatch.Currency', N'Return dispatch currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'441', N'34', N'ReturnInvoice.Currency', N'Return invoice currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'442', N'45', N'SaleDispatch.Currency', N'Sale dispatch currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'443', N'56', N'SaleInvoice.Currency', N'Sale invoice currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'444', N'228', N'CashOut.Currency', N'Cash expense currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'445', N'229', N'CheckPayment.Currency', N'Check payment currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'446', N'230', N'VoucherPayment.Currency', N'Voucher payment currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'447', N'231', N'CreditCardPayment.Currency', N'Credit card payment currency', null, N'2', null, N'2019-01-05 13:05:00.140', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'498', N'289', N'Order.GpsRestriction.IgnoreRouteOutside', N'Order gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.163', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'499', N'303', N'SaleDispatch.GpsRestriction.IgnoreRouteOutside', N'Sale dispatch gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.163', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'500', N'311', N'SaleInvoice.GpsRestriction.IgnoreRouteOutside', N'Sale invoice gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.163', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'501', N'319', N'ReturnDispatch.GpsRestriction.IgnoreRouteOutside', N'Return dispatch gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.167', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'502', N'327', N'ReturnInvoice.GpsRestriction.IgnoreRouteOutside', N'Return invoice gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.167', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'503', N'335', N'Cash.GpsRestriction.IgnoreRouteOutside', N'Cash gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.167', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'504', N'343', N'CashOut.GpsRestriction.IgnoreRouteOutside', N'Cash out gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.167', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'505', N'351', N'CheckPayment.GpsRestriction.IgnoreRouteOutside', N'Check payment out gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.170', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'506', N'359', N'VoucherPayment.GpsRestriction.IgnoreRouteOutside', N'Voucher payment out gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.170', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'507', N'367', N'CreditCardPayment.GpsRestriction.IgnoreRouteOutside', N'Credit card payment out gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.170', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'508', N'376', N'Visit.GpsRestriction.IgnoreRouteOutside', N'Visit card payment out gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.170', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'509', N'380', N'Audit.GpsRestriction.IgnoreRouteOutside', N'Audit card payment out gps restriction ignore route outside', null, N'2', null, N'2019-01-14 18:54:31.170', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'510', N'9', N'Order.Salesman', N'Order salesman', null, N'2', null, N'2019-01-28 10:16:47.830', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'511', N'45', N'SaleDispatch.Salesman', N'SaleDispatch salesman', null, N'2', null, N'2019-01-28 10:16:47.830', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'512', N'56', N'SaleInvoice.Salesman', N'SaleInvoice salesman', null, N'2', null, N'2019-01-28 10:16:47.830', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'513', N'23', N'ReturnDispatch.Salesman', N'ReturnDispatch salesman', null, N'2', null, N'2019-01-28 10:16:47.830', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'514', N'34', N'ReturnInvoice.Salesman', N'ReturnInvoice salesman', null, N'2', null, N'2019-01-28 10:16:47.830', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'515', N'119', N'Reports.General.UserDebtData', N'User debt data', null, N'2', null, N'2019-02-05 10:20:54.583', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'516', N'124', N'Reports.Client.Inventory', N'Inventory', null, N'2', null, N'2019-02-05 10:20:54.600', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'517', N'119', N'Reports.General.DailySaleRelatedActions', N'Daily sale and sale related actions', null, N'2', null, N'2019-02-05 10:20:54.600', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'518', N'6', N'Cash.SpeCode.Edit', N'Cash specode edit', null, N'2', null, N'2019-02-09 13:33:40.230', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'519', N'16', N'Order.SpeCode.Edit', N'Order specode edit', null, N'2', null, N'2019-02-09 13:33:40.230', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'520', N'30', N'ReturnDispatch.SpeCode.Edit', N'Return dispatch specode edit', null, N'2', null, N'2019-02-09 13:33:40.230', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'521', N'41', N'ReturnInvoice.SpeCode.Edit', N'Return invoice specode edit', null, N'2', null, N'2019-02-09 13:33:40.230', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'522', N'52', N'SaleDispatch.SpeCode.Edit', N'Sale dispatch specode edit', null, N'2', null, N'2019-02-09 13:33:40.230', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'523', N'63', N'SaleInvoice.SpeCode.Edit', N'Sale invoice specode edit', null, N'2', null, N'2019-02-09 13:33:40.230', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'524', N'236', N'CashOut.SpeCode.Edit', N'Cash out specode edit', null, N'2', null, N'2019-02-09 13:33:40.233', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'525', N'246', N'CheckPayment.SpeCode.Edit', N'Check payment specode edit', null, N'2', null, N'2019-02-09 13:33:40.233', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'526', N'252', N'VoucherPayment.SpeCode.Edit', N'Voucher payment specode edit', null, N'2', null, N'2019-02-09 13:33:40.233', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'527', N'258', N'CreditCardPayment.SpeCode.Edit', N'Credit card payment specode edit', null, N'2', null, N'2019-02-09 13:33:40.233', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'528', null, N'ErpOrderManagement', N'Erp order management', null, N'2', null, N'2019-02-18 16:22:45.360', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'529', N'528', N'ErpOrderManagement.Order', N'Erp order management order view', null, N'2', null, N'2019-02-18 16:26:12.137', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'532', N'6', N'Cash.SpeCode.Select', N'Cash SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.867', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'533', N'16', N'Order.SpeCode.Select', N'Order SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'534', N'30', N'ReturnDispatch.SpeCode.Select', N'ReturnDispatch SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'535', N'41', N'ReturnInvoice.SpeCode.Select', N'ReturnInvoice SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'536', N'52', N'SaleDispatch.SpeCode.Select', N'SaleDispatch SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'537', N'63', N'SaleInvoice.SpeCode.Select', N'SaleInvoice SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'538', N'236', N'CashOut.SpeCode.Select', N'CashOut SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'539', N'246', N'CheckPayment.SpeCode.Select', N'CheckPayment SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'540', N'252', N'VoucherPayment.SpeCode.Select', N'VoucherPayment SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'541', N'258', N'CreditCardPayment.SpeCode.Select', N'CreditCardPayment SpeCode Select', null, N'2', null, N'2019-02-19 12:09:34.870', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'542', N'529', N'ErpOrderManagement.Order.Confirm', N'Erp order management order confirm', null, N'2', null, N'2019-02-21 19:53:25.730', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'543', N'529', N'ErpOrderManagement.Order.Decline', N'Erp order management order decline', null, N'2', null, N'2019-02-21 19:53:32.867', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'544', N'119', N'Reports.General.OrderStatus', N'Reports general order status', null, N'2', null, N'2019-02-22 17:24:24.740', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'545', N'415', N'Order.AuthCode.Select', N'Order.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'546', N'416', N'ReturnDispatch.AuthCode.Select', N'ReturnDispatch.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'547', N'417', N'SaleDispatch.AuthCode.Select', N'SaleDispatch.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'548', N'418', N'ReturnInvoice.AuthCode.Select', N'ReturnInvoice.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'549', N'419', N'SaleInvoice.AuthCode.Select', N'SaleInvoice.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'550', N'420', N'Cash.AuthCode.Select', N'Cash.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'551', N'421', N'CashOut.AuthCode.Select', N'CashOut.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'552', N'422', N'CheckPayment.AuthCode.Select', N'CheckPayment.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'553', N'423', N'VoucherPayment.AuthCode.Select', N'VoucherPayment.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'554', N'424', N'CreditCardPayment.AuthCode.Select', N'CreditCardPayment.AuthCode.Select', null, N'2', null, N'2019-02-25 15:42:33.383', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'555', N'415', N'Order.AuthCode.Edit', N'Order.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'556', N'416', N'ReturnDispatch.AuthCode.Edit', N'ReturnDispatch.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'557', N'417', N'SaleDispatch.AuthCode.Edit', N'SaleDispatch.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'558', N'418', N'ReturnInvoice.AuthCode.Edit', N'ReturnInvoice.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'559', N'419', N'SaleInvoice.AuthCode.Edit', N'SaleInvoice.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'560', N'420', N'Cash.AuthCode.Edit', N'Cash.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'561', N'421', N'CashOut.AuthCode.Edit', N'CashOut.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'562', N'422', N'CheckPayment.AuthCode.Edit', N'CheckPayment.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'563', N'423', N'VoucherPayment.AuthCode.Edit', N'VoucherPayment.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'564', N'424', N'CreditCardPayment.AuthCode.Edit', N'CreditCardPayment.AuthCode.Edit', null, N'2', null, N'2019-02-25 15:42:42.837', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'565', N'374', N'Visit.RouteRestriction', N'Visit route restriction', null, N'2', null, N'2019-03-09 13:18:04.763', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'566', N'565', N'Visit.RouteRestriction.CreateEdit', N'Visit route restriction create edit', null, N'2', null, N'2019-03-09 13:18:04.770', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'572', null, N'ErpRiskLimits', N'Erp risk limits', null, N'2', null, N'2019-04-26 17:10:53.153', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'573', N'572', N'ErpRiskLimits.RiskLimitChange', N'Erp risk limits changing', null, N'2', null, N'2019-04-26 17:14:53.463', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'574', N'573', N'ErpRiskLimits.RiskLimitChange.Create', N'Erp risk limit create', null, N'2', null, N'2019-04-26 17:15:34.363', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'575', N'573', N'ErpRiskLimits.RiskLimitChange.Approve', N'Erp risk limits confirmation', null, N'2', null, N'2019-04-26 17:15:45.867', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'576', N'575', N'ErpRiskLimits.RiskLimitChange.Approve.GreaterThanZero', N'Erp risk limits confirmation', null, N'2', null, N'2019-04-26 17:15:56.260', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'577', N'575', N'ErpRiskLimits.RiskLimitChange.Approve.LessThanZero', N'Erp risk limits confirmation', null, N'2', null, N'2019-04-26 17:15:34.363', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'578', N'573', N'ErpRiskLimits.RiskLimitChange.Report', N'Erp risk limits confirmation', null, N'2', null, N'2019-04-26 17:15:34.363', null, N'8')
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'579', null, N'Delivery', N'Delivery Module', null, N'2', null, N'2019-06-19 16:50:05.923', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'580', N'579', N'Delivery.DeliveryOrderInvoice', N'Order related delivery invoice', null, N'2', null, N'2019-06-19 16:51:05.700', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'581', N'579', N'Delivery.DeliveryOrderDispatch', N'Order related delivery dispatch', null, N'2', null, N'2019-06-19 16:52:12.653', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'582', N'580', N'Delivery.DeliveryOrderInvoice.AutoFill', N'Enabled autofill for order related delivery invoice', null, N'2', null, N'2019-07-02 19:17:58.787', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'583', N'580', N'Delivery.DeliveryOrderInvoice.ManuallyEdit', N'Allow manual editing for order related delivery invoice', null, N'2', null, N'2019-07-02 19:20:20.273', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'584', N'580', N'Delivery.DeliveryOrderInvoice.ConsiderOrder', N'Show option for considering delivery order', null, N'2', null, N'2019-07-02 19:21:08.543', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'585', N'581', N'Delivery.DeliveryOrderDispatch.AutoFill', N'Enabled autofill for order related delivery dispatch', null, N'2', null, N'2019-07-02 19:22:45.853', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'586', N'581', N'Delivery.DeliveryOrderDispatch.ManuallyEdit', N'Allow manual editing for order related delivery dispatch', null, N'2', null, N'2019-07-02 19:22:45.853', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'587', N'581', N'Delivery.DeliveryOrderDispatch.ConsiderOrder', N'Show option for considering delivery order', null, N'2', null, N'2019-07-02 19:22:45.853', null, null)
GO
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES (N'588', N'579', N'Delivery.DeliveryOrderBilling', N'Order billing', null, N'2', null, N'2019-07-02 19:25:12.570', null, null)
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('594', '580', N'Delivery.DeliveryOrderInvoice.EditDocument', N'Description', NULL, '2', NULL, '2019-07-22 19:20:06.393', NULL, NULL)
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('595', '580', N'Delivery.DeliveryOrderInvoice.GpsRestriction', N'Description', NULL, '2', NULL, '2019-07-22 19:20:08.453', NULL, NULL)
GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('596', '595', N'Delivery.DeliveryOrderInvoice.GpsRestriction.CreateEdit', N'Description', NULL, '2', NULL, '2019-07-22 19:20:08.847', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('597', '595', N'Delivery.DeliveryOrderInvoice.GpsRestriction.Edit', N'Description', NULL, '2', NULL, '2019-07-22 19:20:09.080', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('598', '581', N'Delivery.DeliveryOrderDispatch.EditDocument', N'Description', NULL, '2', NULL, '2019-07-22 19:20:09.283', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('599', '581', N'Delivery.DeliveryOrderDispatch.GpsRestriction', N'Desc', NULL, '2', NULL, '2019-07-22 19:24:39.473', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('600', '599', N'Delivery.DeliveryOrderDispatch.GpsRestriction.CreateEdit', N'Desc', NULL, '2', NULL, '2019-07-22 19:24:40.643', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('601', '599', N'Delivery.DeliveryOrderDispatch.GpsRestriction.Edit', N'Desc', NULL, '2', NULL, '2019-07-22 19:24:41.217', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('602', '588', N'Delivery.DeliveryOrderBilling.EditDocument', N'Desc', NULL, '2', NULL, '2019-07-22 19:24:41.440', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('603', '588', N'Delivery.DeliveryOrderBilling.GpsRestriction', N'Desc', NULL, '2', NULL, '2019-07-22 19:24:41.647', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('604', '603', N'Delivery.DeliveryOrderBilling.GpsRestriction.CreateEdit', N'Desc', NULL, '2', NULL, '2019-07-22 19:24:41.893', NULL, NULL)

GO
INSERT INTO [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate], [OnlyHybridUser], [ClientId]) VALUES ('605', '603', N'Delivery.DeliveryOrderBilling.GpsRestriction.Edit', N'Desc', NULL, '2', NULL, '2019-07-22 19:24:42.370', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[UIM_Permission] OFF
GO

-- ----------------------------
-- Table structure for UIM_PermissionValue
-- ----------------------------
DROP TABLE [dbo].[UIM_PermissionValue]
GO
CREATE TABLE [dbo].[UIM_PermissionValue] (
[Value] tinyint NOT NULL ,
[Description] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Records of UIM_PermissionValue
-- ----------------------------
INSERT INTO [dbo].[UIM_PermissionValue] ([Value], [Description]) VALUES (N'0', N'No visible/disabled')
GO
GO
INSERT INTO [dbo].[UIM_PermissionValue] ([Value], [Description]) VALUES (N'1', N'Modify/Click')
GO
GO
INSERT INTO [dbo].[UIM_PermissionValue] ([Value], [Description]) VALUES (N'2', N'Read/Visible Only')
GO
GO

-- ----------------------------
-- Table structure for UIM_UserAppLoginAttempt
-- ----------------------------
DROP TABLE [dbo].[UIM_UserAppLoginAttempt]
GO
CREATE TABLE [dbo].[UIM_UserAppLoginAttempt] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Login] nvarchar(50) NOT NULL ,
[Password] nvarchar(50) NOT NULL ,
[AttemptsCount] tinyint NOT NULL ,
[ModifiedDate] datetime NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserAppLoginAttempt
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserAppLoginAttempt] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserAppLoginAttempt] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserAuthToken
-- ----------------------------
DROP TABLE [dbo].[UIM_UserAuthToken]
GO
CREATE TABLE [dbo].[UIM_UserAuthToken] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[DeviceId] uniqueidentifier NOT NULL ,
[AuthToken] nvarchar(500) NOT NULL ,
[ValidFrom] datetime NOT NULL ,
[ValidTo] datetime NOT NULL ,
[Status] tinyint NOT NULL ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserAuthToken
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserAuthToken] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserAuthToken] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserConfigParameter
-- ----------------------------
DROP TABLE [dbo].[UIM_UserConfigParameter]
GO
CREATE TABLE [dbo].[UIM_UserConfigParameter] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[OperationId] tinyint NOT NULL ,
[ObjectId] smallint NOT NULL ,
[Objectvalue] nvarchar(50) NULL ,
[IsDefault] bit NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserConfigParameter
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserConfigParameter] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserConfigParameter] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserContactData
-- ----------------------------
DROP TABLE [dbo].[UIM_UserContactData]
GO
CREATE TABLE [dbo].[UIM_UserContactData] (
[Id] int NOT NULL ,
[UserId] int NOT NULL ,
[Street] nvarchar(50) NULL ,
[AddressExtra] nvarchar(50) NULL ,
[ZIP] nvarchar(10) NULL ,
[City] nvarchar(50) NULL ,
[Country] nvarchar(50) NULL ,
[Email] nvarchar(100) NOT NULL ,
[Phone] varchar(20) NULL ,
[Mobile1] varchar(20) NULL ,
[Mobile2] varchar(20) NULL ,
[EmailPermission] tinyint NULL ,
[MobilePermission] tinyint NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of UIM_UserContactData
-- ----------------------------

-- ----------------------------
-- Table structure for UIM_UserDeviceLogHistory
-- ----------------------------
DROP TABLE [dbo].[UIM_UserDeviceLogHistory]
GO
CREATE TABLE [dbo].[UIM_UserDeviceLogHistory] (
[Id] numeric(18) NOT NULL IDENTITY(1,1) ,
[UserId] int NULL ,
[DeviceId] uniqueidentifier NULL ,
[Login] nvarchar(50) NULL ,
[UserType] tinyint NULL ,
[AuthToken] varchar(500) NULL ,
[ActivityInfo] nvarchar(100) NULL ,
[ExtraInfo] nvarchar(500) NULL ,
[RegisteredDate] datetime NULL 
)


GO

-- ----------------------------
-- Records of UIM_UserDeviceLogHistory
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserDeviceLogHistory] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserDeviceLogHistory] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserDeviceLogin
-- ----------------------------
DROP TABLE [dbo].[UIM_UserDeviceLogin]
GO
CREATE TABLE [dbo].[UIM_UserDeviceLogin] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[DeviceId] uniqueidentifier NOT NULL ,
[LoginDate] datetime NULL ,
[LogoutDate] datetime NULL ,
[Status] bit NOT NULL DEFAULT ((1)) ,
[RegisteredDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserDeviceLogin
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserDeviceLogin] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserDeviceLogin] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserEmployeeMapping
-- ----------------------------
DROP TABLE [dbo].[UIM_UserEmployeeMapping]
GO
CREATE TABLE [dbo].[UIM_UserEmployeeMapping] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[EmployeeId] int NOT NULL ,
[Status] tinyint NOT NULL ,
[Password] nvarchar(50) NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) ,
[ExtraFlagReturnLimit] bit NULL 
)


GO

-- ----------------------------
-- Records of UIM_UserEmployeeMapping
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserEmployeeMapping] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserEmployeeMapping] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserModuleConfigParameter
-- ----------------------------
DROP TABLE [dbo].[UIM_UserModuleConfigParameter]
GO
CREATE TABLE [dbo].[UIM_UserModuleConfigParameter] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[ObjectId] smallint NOT NULL ,
[ObjectValue] nvarchar(50) NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserModuleConfigParameter
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserModuleConfigParameter] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserModuleConfigParameter] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserPermission
-- ----------------------------
DROP TABLE [dbo].[UIM_UserPermission]
GO
CREATE TABLE [dbo].[UIM_UserPermission] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[PermissionId] smallint NOT NULL ,
[PermissionValue] tinyint NOT NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserPermission
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserPermission] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserPermission] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserProperty
-- ----------------------------
DROP TABLE [dbo].[UIM_UserProperty]
GO
CREATE TABLE [dbo].[UIM_UserProperty] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[Specode1] nvarchar(200) NULL ,
[Specode2] nvarchar(50) NULL ,
[Specode3] nvarchar(50) NULL ,
[ReportWhereClauseUserDebt] nvarchar(4000) NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedUserId] int NOT NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserProperty
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserProperty] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserProperty] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserSetting
-- ----------------------------
DROP TABLE [dbo].[UIM_UserSetting]
GO
CREATE TABLE [dbo].[UIM_UserSetting] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Firm] smallint NULL ,
[SettingId] smallint NOT NULL ,
[SettingValue] nvarchar(50) NULL ,
[ModifiedUserId] int NULL ,
[CreatedUserId] int NOT NULL ,
[ModifiedDate] datetime NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserSetting
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserSetting] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserSetting] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserTask
-- ----------------------------
DROP TABLE [dbo].[UIM_UserTask]
GO
CREATE TABLE [dbo].[UIM_UserTask] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] int NOT NULL ,
[Firm] smallint NOT NULL ,
[ErpClientId] int NULL ,
[Content] nvarchar(500) NULL ,
[TypeId] tinyint NOT NULL ,
[ExecutionTypeId] tinyint NOT NULL ,
[FormTypeId] tinyint NOT NULL ,
[ExecutionStatusId] tinyint NOT NULL DEFAULT ((1)) ,
[StartTime] datetime NULL ,
[EndTime] datetime NULL ,
[Note] nvarchar(500) NULL ,
[ExecutionDate] datetime NULL ,
[ModifiedUserId] int NULL ,
[ModifiedDate] datetime NULL ,
[CreatedUserId] int NULL ,
[CreatedDate] datetime NOT NULL DEFAULT (getdate()) 
)


GO

-- ----------------------------
-- Records of UIM_UserTask
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserTask] ON
GO
SET IDENTITY_INSERT [dbo].[UIM_UserTask] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserType
-- ----------------------------
DROP TABLE [dbo].[UIM_UserType]
GO
CREATE TABLE [dbo].[UIM_UserType] (
[Id] int NOT NULL IDENTITY(1,1) ,
[CanSelect] bit NOT NULL ,
[Level] int NOT NULL ,
[ParentId] int NULL ,
[Type] nvarchar(100) NOT NULL ,
[Icon] nvarchar(MAX) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[UIM_UserType]', RESEED, 10)
GO

-- ----------------------------
-- Records of UIM_UserType
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserType] ON
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'1', N'0', N'0', null, N'App', N'fa fa-mobile')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'2', N'0', N'0', null, N'Web', N'fa fa-globe')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'3', N'1', N'1', N'1', N'SalePerson', N'fa fa-mobile')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'4', N'1', N'1', N'1', N'Audit', N'fa fa-mobile')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'5', N'1', N'1', N'2', N'TDP', N'fa fa-globe')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'6', N'0', N'1', N'2', N'MİP', N'fa fa-globe')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'7', N'1', N'2', N'6', N'General', N'fa fa-globe')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'8', N'1', N'2', N'6', N'AppRelated', N'fa fa-globe')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'9', N'0', N'0', null, N'Hybrid', N'fa fa-users')
GO
GO
INSERT INTO [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (N'10', N'1', N'1', N'9', N'SalesPersonHead', N'fa fa-users')
GO
GO
SET IDENTITY_INSERT [dbo].[UIM_UserType] OFF
GO

-- ----------------------------
-- Table structure for UIM_UserTypeUserMapping
-- ----------------------------
DROP TABLE [dbo].[UIM_UserTypeUserMapping]
GO
CREATE TABLE [dbo].[UIM_UserTypeUserMapping] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserId] bigint NOT NULL ,
[UserTypeId] int NOT NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[UIM_UserTypeUserMapping]', RESEED, 3)
GO

-- ----------------------------
-- Records of UIM_UserTypeUserMapping
-- ----------------------------
SET IDENTITY_INSERT [dbo].[UIM_UserTypeUserMapping] ON
GO
INSERT INTO [dbo].[UIM_UserTypeUserMapping] ([Id], [UserId], [UserTypeId]) VALUES (N'1', N'1', N'5')
GO
GO
INSERT INTO [dbo].[UIM_UserTypeUserMapping] ([Id], [UserId], [UserTypeId]) VALUES (N'2', N'2', N'5')
GO
INSERT INTO [dbo].[UIM_UserTypeUserMapping] ([Id], [UserId], [UserTypeId]) VALUES (N'3', N'3', N'5')
GO
GO
SET IDENTITY_INSERT [dbo].[UIM_UserTypeUserMapping] OFF
GO

-- ----------------------------
-- View structure for DeviceLastLogin
-- ----------------------------
DROP VIEW [dbo].[DeviceLastLogin]
GO
CREATE VIEW [dbo].[DeviceLastLogin] AS 
SELECT        DeviceId, MAX(LoginDate) AS LastLoginDate, MAX(LogoutDate) AS LastLogoutDate,
                             (SELECT        TOP (1) UserId
                               FROM            dbo.UIM_UserDeviceLogin AS U
                               WHERE        (LoginDate = MAX(D.LoginDate))) AS UserId
FROM            dbo.UIM_UserDeviceLogin AS D
GROUP BY DeviceId
GO

-- ----------------------------
-- View structure for UserLastLogin
-- ----------------------------
DROP VIEW [dbo].[UserLastLogin]
GO
CREATE VIEW [dbo].[UserLastLogin] AS 
SELECT        UserId, MAX(LoginDate) AS LastLoginDate, MAX(LogoutDate) AS LastLogoutDate,
                             (SELECT        TOP (1) DeviceId
                               FROM            dbo.UIM_UserDeviceLogin AS D
                               WHERE        (LoginDate = MAX(U.LoginDate))) AS DeviceId
FROM            dbo.UIM_UserDeviceLogin AS U
WHERE        (UserId > 0)
GROUP BY UserId
GO

-- ----------------------------
-- Procedure structure for IncomingLogSearchById
-- ----------------------------
DROP PROCEDURE [dbo].[IncomingLogSearchById]
GO
CREATE procedure [dbo].[IncomingLogSearchById]
@userid int
as
select OIL.Id,OIL.Firm,OIL.Period,OIL.ProcessDate,OIL.ClientId,OIL.Department,OIL.RegisteredDate,OIL.UserId,OILCE.ItemId,OILCE.Amount,OILCE.Price,OILCE.DiscountAmount,OILCE.DiscountAmount2,
OILCE.DiscountAmount3,OILCE.DiscountPercent,OILCE.DiscountPercent,OILCE.DiscountPercent from OP_IncomingLog OIL
inner join OP_IncomingLogCommonLineExtension OILCE
on OIL.Id = OILCE.Id
where oil.UserId = @userid
GO
-- Encrypted function PrepareUserActionGpsData is not transferred
-- ----------------------------
-- Procedure structure for SendAdministrativeNotifications
-- ----------------------------
DROP PROCEDURE [dbo].[SendAdministrativeNotifications]
GO
-- =============================================
-- Author:		TayqaTech
-- Create date: 2018-09-22
-- Description:	Stored Procedure to send adminitrative pushes
-- =============================================
CREATE PROCEDURE [dbo].[SendAdministrativeNotifications]	
AS
BEGIN	
	SET NOCOUNT ON;    

	Declare @PushMethodId Int = 0
	-- get push methods to send
	Declare PushMethods Cursor For
		Select P.Id
		From SYS_PushMethod P
		Inner Join OP_PushSchedule S On P.Id = S.PushMethodId
		Where IsNull(P.Status, 0) = 1 And DateDiff(MI, S.LastPushSendTime, GetDate()) >= S.Period
	Open PushMethods 
	Fetch Next From PushMethods
	Into @PushMethodId
	While @@FETCH_STATUS = 0
	Begin

		-- insert push related data into queue
		Insert Into OP_AdministrativePushQueue
		(PushMethodId, Message, Status, PushToken, UserId, CreatedDate, RegisteredUserId)
		Select @PushMethodId, '', 1, D.PushToken, U.Id, GetDate(), 1
		From AbpUsers U
		Inner Join UIM_UserTypeUserMapping M On U.Id = M.UserId
		Inner Join UIM_UserType T On M.UserTypeId = T.Id
		Inner Join UIM_UserAuthToken A On A.UserId = U.Id 
		Inner Join UIM_Device D On D.Id = A.DeviceId And IsNull(D.PushToken, '') > ''
		Where U.IsDeleted = 0 And IsActive = 1 And T.Type In ('SalePerson', 'Audit', 'Hybrid')

		-- set last send time
		Update OP_PushSchedule
		Set LastPushSendTime = GetDate()
		Where PushMethodId = @PushMethodId

		Fetch Next From PushMethods
		Into @PushMethodId
	End
	Close PushMethods
	Deallocate PushMethods

END

GO

-- ----------------------------
-- Indexes structure for table AbpAuditLogs
-- ----------------------------
CREATE INDEX [IX_AbpAuditLogs_TenantId_ExecutionDuration] ON [dbo].[AbpAuditLogs]
([TenantId] ASC, [ExecutionDuration] ASC) 
GO
CREATE INDEX [IX_AbpAuditLogs_TenantId_ExecutionTime] ON [dbo].[AbpAuditLogs]
([TenantId] ASC, [ExecutionTime] ASC) 
GO
CREATE INDEX [IX_AbpAuditLogs_TenantId_UserId] ON [dbo].[AbpAuditLogs]
([TenantId] ASC, [UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpAuditLogs
-- ----------------------------
ALTER TABLE [dbo].[AbpAuditLogs] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpBackgroundJobs
-- ----------------------------
CREATE INDEX [IX_AbpBackgroundJobs_IsAbandoned_NextTryTime] ON [dbo].[AbpBackgroundJobs]
([IsAbandoned] ASC, [NextTryTime] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpBackgroundJobs
-- ----------------------------
ALTER TABLE [dbo].[AbpBackgroundJobs] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpEditions
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table AbpEditions
-- ----------------------------
ALTER TABLE [dbo].[AbpEditions] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpFeatures
-- ----------------------------
CREATE INDEX [IX_AbpFeatures_EditionId_Name] ON [dbo].[AbpFeatures]
([EditionId] ASC, [Name] ASC) 
GO
CREATE INDEX [IX_AbpFeatures_TenantId_Name] ON [dbo].[AbpFeatures]
([TenantId] ASC, [Name] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpFeatures
-- ----------------------------
ALTER TABLE [dbo].[AbpFeatures] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpLanguages
-- ----------------------------
CREATE INDEX [IX_AbpLanguages_TenantId_Name] ON [dbo].[AbpLanguages]
([TenantId] ASC, [Name] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpLanguages
-- ----------------------------
ALTER TABLE [dbo].[AbpLanguages] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpLanguageTexts
-- ----------------------------
CREATE INDEX [IX_AbpLanguageTexts_TenantId_Source_LanguageName_Key] ON [dbo].[AbpLanguageTexts]
([TenantId] ASC, [Source] ASC, [LanguageName] ASC, [Key] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpLanguageTexts
-- ----------------------------
ALTER TABLE [dbo].[AbpLanguageTexts] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpNotifications
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table AbpNotifications
-- ----------------------------
ALTER TABLE [dbo].[AbpNotifications] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpNotificationSubscriptions
-- ----------------------------
CREATE INDEX [IX_AbpNotificationSubscriptions_NotificationName_EntityTypeName_EntityId_UserId] ON [dbo].[AbpNotificationSubscriptions]
([NotificationName] ASC, [EntityTypeName] ASC, [EntityId] ASC, [UserId] ASC) 
GO
CREATE INDEX [IX_AbpNotificationSubscriptions_TenantId_NotificationName_EntityTypeName_EntityId_UserId] ON [dbo].[AbpNotificationSubscriptions]
([TenantId] ASC, [NotificationName] ASC, [EntityTypeName] ASC, [EntityId] ASC, [UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpNotificationSubscriptions
-- ----------------------------
ALTER TABLE [dbo].[AbpNotificationSubscriptions] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpOrganizationUnits
-- ----------------------------
CREATE INDEX [IX_AbpOrganizationUnits_ParentId] ON [dbo].[AbpOrganizationUnits]
([ParentId] ASC) 
GO
CREATE INDEX [IX_AbpOrganizationUnits_TenantId_Code] ON [dbo].[AbpOrganizationUnits]
([TenantId] ASC, [Code] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpOrganizationUnits
-- ----------------------------
ALTER TABLE [dbo].[AbpOrganizationUnits] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpPermissions
-- ----------------------------
CREATE INDEX [IX_AbpPermissions_RoleId] ON [dbo].[AbpPermissions]
([RoleId] ASC) 
GO
CREATE INDEX [IX_AbpPermissions_TenantId_Name] ON [dbo].[AbpPermissions]
([TenantId] ASC, [Name] ASC) 
GO
CREATE INDEX [IX_AbpPermissions_UserId] ON [dbo].[AbpPermissions]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpPermissions
-- ----------------------------
ALTER TABLE [dbo].[AbpPermissions] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpPersistedGrants
-- ----------------------------
CREATE INDEX [IX_AbpPersistedGrants_SubjectId_ClientId_Type] ON [dbo].[AbpPersistedGrants]
([SubjectId] ASC, [ClientId] ASC, [Type] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpPersistedGrants
-- ----------------------------
ALTER TABLE [dbo].[AbpPersistedGrants] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpRoleClaims
-- ----------------------------
CREATE INDEX [IX_AbpRoleClaims_RoleId] ON [dbo].[AbpRoleClaims]
([RoleId] ASC) 
GO
CREATE INDEX [IX_AbpRoleClaims_TenantId_ClaimType] ON [dbo].[AbpRoleClaims]
([TenantId] ASC, [ClaimType] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpRoleClaims
-- ----------------------------
ALTER TABLE [dbo].[AbpRoleClaims] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpRoles
-- ----------------------------
CREATE INDEX [IX_AbpRoles_CreatorUserId] ON [dbo].[AbpRoles]
([CreatorUserId] ASC) 
GO
CREATE INDEX [IX_AbpRoles_DeleterUserId] ON [dbo].[AbpRoles]
([DeleterUserId] ASC) 
GO
CREATE INDEX [IX_AbpRoles_LastModifierUserId] ON [dbo].[AbpRoles]
([LastModifierUserId] ASC) 
GO
CREATE INDEX [IX_AbpRoles_TenantId_NormalizedName] ON [dbo].[AbpRoles]
([TenantId] ASC, [NormalizedName] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpRoles
-- ----------------------------
ALTER TABLE [dbo].[AbpRoles] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpSettings
-- ----------------------------
CREATE INDEX [IX_AbpSettings_TenantId_Name] ON [dbo].[AbpSettings]
([TenantId] ASC, [Name] ASC) 
GO
CREATE INDEX [IX_AbpSettings_UserId] ON [dbo].[AbpSettings]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpSettings
-- ----------------------------
ALTER TABLE [dbo].[AbpSettings] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpTextTemplateContents
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table AbpTextTemplateContents
-- ----------------------------
ALTER TABLE [dbo].[AbpTextTemplateContents] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpTenantNotifications
-- ----------------------------
CREATE INDEX [IX_AbpTenantNotifications_TenantId] ON [dbo].[AbpTenantNotifications]
([TenantId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpTenantNotifications
-- ----------------------------
ALTER TABLE [dbo].[AbpTenantNotifications] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpTenants
-- ----------------------------
CREATE INDEX [IX_AbpTenants_CreationTime] ON [dbo].[AbpTenants]
([CreationTime] ASC) 
GO
CREATE INDEX [IX_AbpTenants_CreatorUserId] ON [dbo].[AbpTenants]
([CreatorUserId] ASC) 
GO
CREATE INDEX [IX_AbpTenants_DeleterUserId] ON [dbo].[AbpTenants]
([DeleterUserId] ASC) 
GO
CREATE INDEX [IX_AbpTenants_EditionId] ON [dbo].[AbpTenants]
([EditionId] ASC) 
GO
CREATE INDEX [IX_AbpTenants_LastModifierUserId] ON [dbo].[AbpTenants]
([LastModifierUserId] ASC) 
GO
CREATE INDEX [IX_AbpTenants_SubscriptionEndDateUtc] ON [dbo].[AbpTenants]
([SubscriptionEndDateUtc] ASC) 
GO
CREATE INDEX [IX_AbpTenants_TenancyName] ON [dbo].[AbpTenants]
([TenancyName] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpTenants
-- ----------------------------
ALTER TABLE [dbo].[AbpTenants] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUserAccounts
-- ----------------------------
CREATE INDEX [IX_AbpUserAccounts_UserName] ON [dbo].[AbpUserAccounts]
([UserName] ASC) 
GO
CREATE INDEX [IX_AbpUserAccounts_TenantId_UserName] ON [dbo].[AbpUserAccounts]
([TenantId] ASC, [UserName] ASC) 
GO
CREATE INDEX [IX_AbpUserAccounts_TenantId_UserId] ON [dbo].[AbpUserAccounts]
([TenantId] ASC, [UserId] ASC) 
GO
CREATE INDEX [IX_AbpUserAccounts_TenantId_EmailAddress] ON [dbo].[AbpUserAccounts]
([TenantId] ASC, [EmailAddress] ASC) 
GO
CREATE INDEX [IX_AbpUserAccounts_EmailAddress] ON [dbo].[AbpUserAccounts]
([EmailAddress] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUserAccounts
-- ----------------------------
ALTER TABLE [dbo].[AbpUserAccounts] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUserClaims
-- ----------------------------
CREATE INDEX [IX_AbpUserClaims_UserId] ON [dbo].[AbpUserClaims]
([UserId] ASC) 
GO
CREATE INDEX [IX_AbpUserClaims_TenantId_ClaimType] ON [dbo].[AbpUserClaims]
([TenantId] ASC, [ClaimType] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUserClaims
-- ----------------------------
ALTER TABLE [dbo].[AbpUserClaims] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUserLoginAttempts
-- ----------------------------
CREATE INDEX [IX_AbpUserLoginAttempts_TenancyName_UserNameOrEmailAddress_Result] ON [dbo].[AbpUserLoginAttempts]
([TenancyName] ASC, [UserNameOrEmailAddress] ASC, [Result] ASC) 
GO
CREATE INDEX [IX_AbpUserLoginAttempts_UserId_TenantId] ON [dbo].[AbpUserLoginAttempts]
([UserId] ASC, [TenantId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUserLoginAttempts
-- ----------------------------
ALTER TABLE [dbo].[AbpUserLoginAttempts] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUserLogins
-- ----------------------------
CREATE INDEX [IX_AbpUserLogins_TenantId_LoginProvider_ProviderKey] ON [dbo].[AbpUserLogins]
([TenantId] ASC, [LoginProvider] ASC, [ProviderKey] ASC) 
GO
CREATE INDEX [IX_AbpUserLogins_TenantId_UserId] ON [dbo].[AbpUserLogins]
([TenantId] ASC, [UserId] ASC) 
GO
CREATE INDEX [IX_AbpUserLogins_UserId] ON [dbo].[AbpUserLogins]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUserLogins
-- ----------------------------
ALTER TABLE [dbo].[AbpUserLogins] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUserNotifications
-- ----------------------------
CREATE INDEX [IX_AbpUserNotifications_UserId_State_CreationTime] ON [dbo].[AbpUserNotifications]
([UserId] ASC, [State] ASC, [CreationTime] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUserNotifications
-- ----------------------------
ALTER TABLE [dbo].[AbpUserNotifications] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUserOrganizationUnits
-- ----------------------------
CREATE INDEX [IX_AbpUserOrganizationUnits_TenantId_OrganizationUnitId] ON [dbo].[AbpUserOrganizationUnits]
([TenantId] ASC, [OrganizationUnitId] ASC) 
GO
CREATE INDEX [IX_AbpUserOrganizationUnits_TenantId_UserId] ON [dbo].[AbpUserOrganizationUnits]
([TenantId] ASC, [UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUserOrganizationUnits
-- ----------------------------
ALTER TABLE [dbo].[AbpUserOrganizationUnits] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUserRoles
-- ----------------------------
CREATE INDEX [IX_AbpUserRoles_TenantId_RoleId] ON [dbo].[AbpUserRoles]
([TenantId] ASC, [RoleId] ASC) 
GO
CREATE INDEX [IX_AbpUserRoles_TenantId_UserId] ON [dbo].[AbpUserRoles]
([TenantId] ASC, [UserId] ASC) 
GO
CREATE INDEX [IX_AbpUserRoles_UserId] ON [dbo].[AbpUserRoles]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUserRoles
-- ----------------------------
ALTER TABLE [dbo].[AbpUserRoles] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AbpUsers
-- ----------------------------
CREATE INDEX [IX_AbpUsers_CreatorUserId] ON [dbo].[AbpUsers]
([CreatorUserId] ASC) 
GO
CREATE INDEX [IX_AbpUsers_DeleterUserId] ON [dbo].[AbpUsers]
([DeleterUserId] ASC) 
GO
CREATE INDEX [IX_AbpUsers_LastModifierUserId] ON [dbo].[AbpUsers]
([LastModifierUserId] ASC) 
GO
CREATE INDEX [IX_AbpUsers_TenantId_NormalizedEmailAddress] ON [dbo].[AbpUsers]
([TenantId] ASC, [NormalizedEmailAddress] ASC) 
GO
CREATE INDEX [IX_AbpUsers_TenantId_NormalizedUserName] ON [dbo].[AbpUsers]
([TenantId] ASC, [NormalizedUserName] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AbpUsers
-- ----------------------------
ALTER TABLE [dbo].[AbpUsers] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Primary Key structure for table AbpUserTokens
-- ----------------------------
ALTER TABLE [dbo].[AbpUserTokens] ADD PRIMARY KEY ([Id])
GO


-- ----------------------------
-- Indexes structure for table AppBinaryObjects
-- ----------------------------
CREATE INDEX [IX_AppBinaryObjects_TenantId] ON [dbo].[AppBinaryObjects]
([TenantId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AppBinaryObjects
-- ----------------------------
ALTER TABLE [dbo].[AppBinaryObjects] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AppChatMessages
-- ----------------------------
CREATE INDEX [IX_AppChatMessages_TargetTenantId_TargetUserId_ReadState] ON [dbo].[AppChatMessages]
([TargetTenantId] ASC, [TargetUserId] ASC, [ReadState] ASC) 
GO
CREATE INDEX [IX_AppChatMessages_TargetTenantId_UserId_ReadState] ON [dbo].[AppChatMessages]
([TargetTenantId] ASC, [UserId] ASC, [ReadState] ASC) 
GO
CREATE INDEX [IX_AppChatMessages_TenantId_TargetUserId_ReadState] ON [dbo].[AppChatMessages]
([TenantId] ASC, [TargetUserId] ASC, [ReadState] ASC) 
GO
CREATE INDEX [IX_AppChatMessages_TenantId_UserId_ReadState] ON [dbo].[AppChatMessages]
([TenantId] ASC, [UserId] ASC, [ReadState] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AppChatMessages
-- ----------------------------
ALTER TABLE [dbo].[AppChatMessages] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AppFriendships
-- ----------------------------
CREATE INDEX [IX_AppFriendships_FriendTenantId_FriendUserId] ON [dbo].[AppFriendships]
([FriendTenantId] ASC, [FriendUserId] ASC) 
GO
CREATE INDEX [IX_AppFriendships_FriendTenantId_UserId] ON [dbo].[AppFriendships]
([FriendTenantId] ASC, [UserId] ASC) 
GO
CREATE INDEX [IX_AppFriendships_TenantId_FriendUserId] ON [dbo].[AppFriendships]
([TenantId] ASC, [FriendUserId] ASC) 
GO
CREATE INDEX [IX_AppFriendships_TenantId_UserId] ON [dbo].[AppFriendships]
([TenantId] ASC, [UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AppFriendships
-- ----------------------------
ALTER TABLE [dbo].[AppFriendships] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AppSubscriptionPayments
-- ----------------------------
CREATE INDEX [IX_AppSubscriptionPayments_EditionId] ON [dbo].[AppSubscriptionPayments]
([EditionId] ASC) 
GO
CREATE INDEX [IX_AppSubscriptionPayments_PaymentId_Gateway] ON [dbo].[AppSubscriptionPayments]
([PaymentId] ASC, [Gateway] ASC) 
GO
CREATE INDEX [IX_AppSubscriptionPayments_Status_CreationTime] ON [dbo].[AppSubscriptionPayments]
([Status] ASC, [CreationTime] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table AppSubscriptionPayments
-- ----------------------------
ALTER TABLE [dbo].[AppSubscriptionPayments] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_AutoPark
-- ----------------------------
CREATE UNIQUE INDEX [IX_AutoPark_Name] ON [dbo].[DM_AutoPark]
([Name] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE UNIQUE INDEX [IX_AutoPark_Number] ON [dbo].[DM_AutoPark]
([Number] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IX_AutoPark_SpecialCode1] ON [dbo].[DM_AutoPark]
([SpecialCode1] ASC) 
GO
CREATE INDEX [IX_AutoPark_SpecialCode2] ON [dbo].[DM_AutoPark]
([SpecialCode2] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_AutoPark
-- ----------------------------
ALTER TABLE [dbo].[DM_AutoPark] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_Invoice
-- ----------------------------
CREATE INDEX [IX_DM_Invoice_OrderId] ON [dbo].[DM_Invoice]
([DeliveryOrderId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_Invoice
-- ----------------------------
ALTER TABLE [dbo].[DM_Invoice] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_InvoiceLine
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_InvoiceLine
-- ----------------------------
ALTER TABLE [dbo].[DM_InvoiceLine] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_Order
-- ----------------------------
CREATE INDEX [IX_DM_Order_IsInRoute] ON [dbo].[DM_Order]
([IsInRoute] ASC) 
GO
CREATE INDEX [IX_DM_Order_OrderType] ON [dbo].[DM_Order]
([OrderType] ASC) 
GO
CREATE INDEX [IX_DM_Order_Status] ON [dbo].[DM_Order]
([Status] ASC) 
GO
CREATE INDEX [IX_DM_Order_ClientTigerId_Firm] ON [dbo].[DM_Order]
([ClientId] ASC, [Firm] ASC) 
GO
CREATE INDEX [IX_DM_Order_SalesmanTigerId_Firm] ON [dbo].[DM_Order]
([SalesmanRef] ASC, [Firm] ASC) 
GO
CREATE INDEX [IX_DM_Order_WarehouseNr_Firm] ON [dbo].[DM_Order]
([Warehouse] ASC, [Firm] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_Order
-- ----------------------------
ALTER TABLE [dbo].[DM_Order] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table DM_Order
-- ----------------------------
ALTER TABLE [dbo].[DM_Order] ADD UNIQUE ([Firm] ASC, [ERPId] ASC)
GO

-- ----------------------------
-- Indexes structure for table DM_OrderLine
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_OrderLine
-- ----------------------------
ALTER TABLE [dbo].[DM_OrderLine] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_OrderLine
-- ----------------------------
CREATE INDEX [IX_DM_OrderLine_OrderId] ON [dbo].[DM_OrderLine]
([OrderId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table DM_OrderStock
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_OrderStock
-- ----------------------------
ALTER TABLE [dbo].[DM_OrderStock] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_ProcessingQueue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_ProcessingQueue
-- ----------------------------
ALTER TABLE [dbo].[DM_ProcessingQueue] ADD PRIMARY KEY ([RequestId])
GO

-- ----------------------------
-- Indexes structure for table DM_ProcessingLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_ProcessingLog
-- ----------------------------
ALTER TABLE [dbo].[DM_ProcessingLog] ADD PRIMARY KEY ([GeneralId])
GO

-- ----------------------------
-- Indexes structure for table DM_Setting
-- ----------------------------
CREATE INDEX [IX_DM_Setting_DeviceId] ON [dbo].[DM_Setting]
([DeviceId] ASC) 
WHERE ([DeviceId] IS NOT NULL)
GO
CREATE INDEX [IX_DM_Setting_Name] ON [dbo].[DM_Setting]
([Name] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_Setting
-- ----------------------------
ALTER TABLE [dbo].[DM_Setting] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_SpecialCode
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_SpecialCode
-- ----------------------------
ALTER TABLE [dbo].[DM_SpecialCode] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_TransportClient
-- ----------------------------
CREATE INDEX [IX_DM_TransportClient_DeliveryStatus] ON [dbo].[DM_TransportClient]
([DeliveryStatus] ASC) 
GO
CREATE INDEX [IX_DM_TransportClient_TransportPackageId] ON [dbo].[DM_TransportClient]
([TransportPackageId] ASC) 
GO
CREATE INDEX [IX_DM_TransportClient_ClientTigerId_ClientFirm] ON [dbo].[DM_TransportClient]
([ClientTigerId] ASC, [ClientFirm] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_TransportClient
-- ----------------------------
ALTER TABLE [dbo].[DM_TransportClient] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_TransportOrder
-- ----------------------------
CREATE INDEX [IX_DM_TransportOrder_DeliveryStatus] ON [dbo].[DM_TransportOrder]
([DeliveryStatus] ASC) 
GO
CREATE INDEX [IX_DM_TransportOrder_OrderId] ON [dbo].[DM_TransportOrder]
([OrderId] ASC) 
GO
CREATE INDEX [IX_DM_TransportOrder_TransportClientId] ON [dbo].[DM_TransportOrder]
([TransportClientId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_TransportOrder
-- ----------------------------
ALTER TABLE [dbo].[DM_TransportOrder] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_TransportPackage
-- ----------------------------
CREATE INDEX [IX_TransportPackage_UserId-Firm] ON [dbo].[DM_TransportPackage]
([UserId] ASC, [Firm] ASC) 
GO
CREATE INDEX [IX_TransportPackage_TransportStatusId] ON [dbo].[DM_TransportPackage]
([TransportStatusId] ASC) 
GO
CREATE INDEX [IX_TransportPackage_TruckId] ON [dbo].[DM_TransportPackage]
([TruckId] ASC) 
GO
CREATE INDEX [IX_TransportPackage_LastModificationTime] ON [dbo].[DM_TransportPackage]
([LastModificationTime] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_TransportPackage
-- ----------------------------
ALTER TABLE [dbo].[DM_TransportPackage] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_TransportStatus
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_TransportStatus
-- ----------------------------
ALTER TABLE [dbo].[DM_TransportStatus] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_Truck
-- ----------------------------
CREATE INDEX [IX_Truck_AutoParkId] ON [dbo].[DM_Truck]
([AutoParkId] ASC) 
GO
CREATE UNIQUE INDEX [IX_Truck_Number] ON [dbo].[DM_Truck]
([Number] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IX_Truck_SpecialCode1] ON [dbo].[DM_Truck]
([SpecialCode1] ASC) 
GO
CREATE INDEX [IX_Truck_SpecialCode2] ON [dbo].[DM_Truck]
([SpecialCode2] ASC) 
GO
CREATE INDEX [IX_Truck_Status] ON [dbo].[DM_Truck]
([Status] ASC) 
GO
CREATE INDEX [IX_Truck_TruckGroupId] ON [dbo].[DM_Truck]
([TruckGroupId] ASC) 
GO
CREATE INDEX [IX_Truck_TruckTypeId] ON [dbo].[DM_Truck]
([TruckTypeId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table DM_Truck
-- ----------------------------
ALTER TABLE [dbo].[DM_Truck] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_TruckGroup
-- ----------------------------
CREATE INDEX [IX_TruckGroup_GroupCode] ON [dbo].[DM_TruckGroup]
([GroupCode] ASC) 
GO
CREATE UNIQUE INDEX [IX_TruckGroup_Name] ON [dbo].[DM_TruckGroup]
([Name] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table DM_TruckGroup
-- ----------------------------
ALTER TABLE [dbo].[DM_TruckGroup] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table DM_TruckType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table DM_TruckType
-- ----------------------------
ALTER TABLE [dbo].[DM_TruckType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table LM_Campaign
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table LM_Campaign
-- ----------------------------
ALTER TABLE [dbo].[LM_Campaign] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table LM_UserCampaign
-- ----------------------------
CREATE UNIQUE INDEX [IDX_UserCampaign] ON [dbo].[LM_UserCampaign]
([UserId] ASC, [CampaignId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table LM_UserCampaign
-- ----------------------------
ALTER TABLE [dbo].[LM_UserCampaign] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MC_ClientMediaInfo
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MC_ClientMediaInfo
-- ----------------------------
ALTER TABLE [dbo].[MC_ClientMediaInfo] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_Bank
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Bank
-- ----------------------------
ALTER TABLE [dbo].[MD_Bank] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Indexes structure for table MD_BankAccount
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_BankAccount
-- ----------------------------
ALTER TABLE [dbo].[MD_BankAccount] ADD PRIMARY KEY ([Firm], [BankTigerId], [TigerId])
GO

-- ----------------------------
-- Indexes structure for table MD_BannedClient
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_BannedClient
-- ----------------------------
ALTER TABLE [dbo].[MD_BannedClient] ADD PRIMARY KEY ([Firm], [ClientId])
GO

-- ----------------------------
-- Indexes structure for table MD_BannedClientLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_BannedClientLog
-- ----------------------------
ALTER TABLE [dbo].[MD_BannedClientLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_CashCard
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_CashCard
-- ----------------------------
ALTER TABLE [dbo].[MD_CashCard] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Indexes structure for table MD_Catalog
-- ----------------------------
CREATE INDEX [IX_MD_Catalog_CatalogGroupId] ON [dbo].[MD_Catalog]
([CatalogGroupId] ASC) 
GO
CREATE UNIQUE INDEX [IX_MD_Catalog_Code] ON [dbo].[MD_Catalog]
([Code] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table MD_Catalog
-- ----------------------------
ALTER TABLE [dbo].[MD_Catalog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_CatalogCompetingItemMapping
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_CatalogCompetingItemMapping
-- ----------------------------
ALTER TABLE [dbo].[MD_CatalogCompetingItemMapping] ADD PRIMARY KEY ([CatalogId], [CompetingItemId])
GO

-- ----------------------------
-- Indexes structure for table MD_CatalogGroup
-- ----------------------------
CREATE UNIQUE INDEX [IX_MD_CatalogGroup_Code] ON [dbo].[MD_CatalogGroup]
([Code] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table MD_CatalogGroup
-- ----------------------------
ALTER TABLE [dbo].[MD_CatalogGroup] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_CatalogItemMapping
-- ----------------------------
CREATE INDEX [IX_MD_CatalogItemMapping_CatalogId] ON [dbo].[MD_CatalogItemMapping]
([CatalogId] ASC) 
GO
-- ----------------------------
-- Primary Key structure for table MD_CatalogItemMapping
-- ----------------------------
ALTER TABLE [dbo].[MD_CatalogItemMapping] ADD PRIMARY KEY ([CatalogId], [TigerItemId])
GO

-- ----------------------------
-- Triggers structure for table MD_CatalogItemMapping
-- ----------------------------
DROP TRIGGER [dbo].[UpdateDate]
GO
CREATE TRIGGER [dbo].[UpdateDate]
ON [dbo].[MD_CatalogItemMapping]
AFTER UPDATE
AS

BEGIN	
	SET NOCOUNT ON;

    Update M
	Set M.RegisteredDate = GetDate()
	From MD_CatalogItemMapping M
	Inner Join Inserted I On M.CatalogId = I.CatalogId And M.TigerItemId = I.TigerItemId

END

GO

-- ----------------------------
-- Indexes structure for table MD_Client
-- ----------------------------
CREATE INDEX [IX_MD_Client_FirmTigerId] ON [dbo].[MD_Client]
([Firm] ASC, [TigerId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_Client
-- ----------------------------
ALTER TABLE [dbo].[MD_Client] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientFinanceData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ClientFinanceData
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientFinanceData] ADD PRIMARY KEY ([TigerId], [Firm])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientGpsData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ClientGpsData
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientGpsData] ADD PRIMARY KEY ([Firm], [ClientId])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientGroupCatalogRestriction
-- ----------------------------
CREATE UNIQUE INDEX [IDX_UserClientGroupCatalog] ON [dbo].[MD_ClientGroupCatalogRestriction]
([UserId] ASC, [ClientGroupId] ASC, [CatalogId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table MD_ClientGroupCatalogRestriction
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientGroupCatalogRestriction] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientGroupData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ClientGroupData
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientGroupData] ADD PRIMARY KEY ([Firm], [ClientId], [GroupType], [GroupId])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientGroupInfo
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ClientGroupInfo
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientGroupInfo] ADD PRIMARY KEY ([Firm], [GroupType], [GroupId])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientItemRestriction
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ClientItemRestriction
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientItemRestriction] ADD PRIMARY KEY ([Firm], [TigerClientId], [TigerItemId])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientItemRestrictionLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ClientItemRestrictionLog
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientItemRestrictionLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_ClientWarehouseRestriction
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ClientWarehouseRestriction
-- ----------------------------
ALTER TABLE [dbo].[MD_ClientWarehouseRestriction] ADD PRIMARY KEY ([Firm], [ClientWarehouseGroupId], [WarehouseNr])
GO

-- ----------------------------
-- Indexes structure for table MD_CompetingItem
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_CompetingItem
-- ----------------------------
ALTER TABLE [dbo].[MD_CompetingItem] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_Currency
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Currency
-- ----------------------------
ALTER TABLE [dbo].[MD_Currency] ADD PRIMARY KEY ([Firm], [Type])
GO

-- ----------------------------
-- Indexes structure for table MD_CurrencyExchange
-- ----------------------------
CREATE UNIQUE INDEX [IDX_Currency] ON [dbo].[MD_CurrencyExchange]
([CurrencyTypeId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table MD_CurrencyExchange
-- ----------------------------
ALTER TABLE [dbo].[MD_CurrencyExchange] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_Department
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Department
-- ----------------------------
ALTER TABLE [dbo].[MD_Department] ADD PRIMARY KEY ([Firm], [Nr])
GO

-- ----------------------------
-- Indexes structure for table MD_Division
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Division
-- ----------------------------
ALTER TABLE [dbo].[MD_Division] ADD PRIMARY KEY ([Firm], [Nr])
GO

-- ----------------------------
-- Indexes structure for table MD_ExpenseCenter
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ExpenseCenter
-- ----------------------------
ALTER TABLE [dbo].[MD_ExpenseCenter] ADD PRIMARY KEY ([TigerId], [Firm], [Code])
GO

-- ----------------------------
-- Indexes structure for table MD_Factory
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Factory
-- ----------------------------
ALTER TABLE [dbo].[MD_Factory] ADD PRIMARY KEY ([Firm], [Nr])
GO

-- ----------------------------
-- Indexes structure for table MD_Firm
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Firm
-- ----------------------------
ALTER TABLE [dbo].[MD_Firm] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_Item
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Item
-- ----------------------------
ALTER TABLE [dbo].[MD_Item] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Indexes structure for table MD_ItemBarcode
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ItemBarcode
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemBarcode] ADD PRIMARY KEY ([Firm], [TigerItemId], [TigerItemUnitId], [Barcode], [LineNr])
GO

-- ----------------------------
-- Indexes structure for table MD_ItemCardType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ItemCardType
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemCardType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_ItemImageChangedCatalog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ItemImageChangedCatalog
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemImageChangedCatalog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_ItemPrice
-- ----------------------------
CREATE INDEX [IND_MD_ItemPrice_TigerItemId] ON [dbo].[MD_ItemPrice]
([TigerItemId] ASC) 
GO
CREATE INDEX [IX_MD_ItemPrice_StatusBeginDateEndDate] ON [dbo].[MD_ItemPrice]
([Status] ASC, [BeginDate] ASC, [EndDate] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_ItemPrice
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemPrice] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Uniques structure for table MD_ItemPrice
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemPrice] ADD UNIQUE ([Firm] ASC, [TigerId] ASC, [TigerItemId] ASC, [TigerItemUnitId] ASC, [CurrencyTypeId] ASC, [BeginDate] ASC, [EndDate] ASC)
GO

-- ----------------------------
-- Indexes structure for table MD_ItemPriceDivisionMapping
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ItemPriceDivisionMapping
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemPriceDivisionMapping] ADD PRIMARY KEY ([Firm], [TigerId], [DivisionNr])
GO

-- ----------------------------
-- Indexes structure for table MD_ItemSpecificClientGroupPrice
-- ----------------------------
CREATE INDEX [IX_MD_ItemSpecificClientGroupPrice_FirmClientGroup] ON [dbo].[MD_ItemSpecificClientGroupPrice]
([Firm] ASC, [ClientGroupId] ASC) 
GO
CREATE INDEX [IX_MD_ItemSpecificClientGroupPrice_StatusBeginDateEndDate] ON [dbo].[MD_ItemSpecificClientGroupPrice]
([Status] ASC, [BeginDate] ASC, [EndDate] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_ItemSpecificClientGroupPrice
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemSpecificClientGroupPrice] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Uniques structure for table MD_ItemSpecificClientGroupPrice
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemSpecificClientGroupPrice] ADD UNIQUE ([Firm] ASC, [TigerId] ASC, [TigerItemId] ASC, [TigerItemUnitId] ASC, [ClientGroupId] ASC, [BeginDate] ASC, [EndDate] ASC, [CurrencyTypeId] ASC)
GO

-- ----------------------------
-- Indexes structure for table MD_ItemSpecificClientPrice
-- ----------------------------
CREATE INDEX [IX_MD_ItemSpecificClientPrice_FirmClientId] ON [dbo].[MD_ItemSpecificClientPrice]
([Firm] ASC, [ClientId] ASC) 
GO
CREATE INDEX [IX_MD_ItemSpecificClientPrice_StatusBeginDateEndDate] ON [dbo].[MD_ItemSpecificClientPrice]
([Status] ASC, [BeginDate] ASC, [EndDate] ASC) 
GO
CREATE INDEX [IX_MD_ItemSpecificClientPrice_FirmTigerItemId] ON [dbo].[MD_ItemSpecificClientPrice]
([Firm] ASC, [TigerItemId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_ItemSpecificClientPrice
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemSpecificClientPrice] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Uniques structure for table MD_ItemSpecificClientPrice
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemSpecificClientPrice] ADD UNIQUE ([Firm] ASC, [TigerId] ASC, [TigerItemId] ASC, [TigerItemUnitId] ASC, [ClientId] ASC, [BeginDate] ASC, [EndDate] ASC, [CurrencyTypeId] ASC)
GO

-- ----------------------------
-- Indexes structure for table MD_ItemSuggestedPrice
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ItemSuggestedPrice
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemSuggestedPrice] ADD PRIMARY KEY ([Firm], [ItemId], [ClientGroupId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table MD_ItemUnit
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ItemUnit
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemUnit] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Uniques structure for table MD_ItemUnit
-- ----------------------------
ALTER TABLE [dbo].[MD_ItemUnit] ADD UNIQUE ([Firm] ASC, [TigerItemId] ASC, [Code] ASC, [IsDeleted] ASC)
GO

-- ----------------------------
-- Indexes structure for table MD_NoVatCalculationList
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_NoVatCalculationList
-- ----------------------------
ALTER TABLE [dbo].[MD_NoVatCalculationList] ADD PRIMARY KEY ([Firm], [WarehouseNr])
GO

-- ----------------------------
-- Indexes structure for table MD_PaymentPlan
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_PaymentPlan
-- ----------------------------
ALTER TABLE [dbo].[MD_PaymentPlan] ADD PRIMARY KEY ([TigerId], [Firm])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedBankAccount
-- ----------------------------
CREATE INDEX [IX_MD_PermittedBankAccoun_UniqueDefault] ON [dbo].[MD_PermittedBankAccount]
([Firm] ASC, [OperationId] ASC, [UserId] ASC, [IsDefault] ASC) 
GO
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedBankAccount]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedBankAccount
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedBankAccount] ADD PRIMARY KEY ([Firm], [UserId], [TigerId], [OperationId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedCashCard
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedCashCard]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedCashCard
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedCashCard] ADD PRIMARY KEY ([Firm], [UserId], [TigerCashCardId], [OperationId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedCatalog
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedCatalog]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedCatalog
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedCatalog] ADD PRIMARY KEY ([UserId], [CatalogId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedClient
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedClient]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedClient
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedClient] ADD PRIMARY KEY ([Firm], [UserId], [TigerClientId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedCurrency
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedCurrency]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedCurrency
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedCurrency] ADD PRIMARY KEY ([Firm], [UserId], [CurrencyType], [OperationId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedDepartment
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedDepartment]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedDepartment
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedDepartment] ADD PRIMARY KEY ([Firm], [UserId], [TigerDepartmentNr], [OperationId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedDivision
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedDivision]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedDivision
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedDivision] ADD PRIMARY KEY ([Firm], [UserId], [TigerDivisionNr], [OperationId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedFactory
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedFactory]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedFactory
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedFactory] ADD PRIMARY KEY ([Firm], [UserId], [TigerFactoryNr], [OperationId], [DivisionNr])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedFirm
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedFirm]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedFirm
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedFirm] ADD PRIMARY KEY ([Firm], [UserId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedPaymentPlan
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedPaymentPlan]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedPaymentPlan
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedPaymentPlan] ADD PRIMARY KEY ([Firm], [UserId], [TigerId], [OperationId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedTradingGroup
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedTradingGroup]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedTradingGroup
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedTradingGroup] ADD PRIMARY KEY ([Firm], [UserId], [TigerTradingGroupId], [OperationId])
GO

-- ----------------------------
-- Indexes structure for table MD_PermittedWarehouse
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[MD_PermittedWarehouse]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_PermittedWarehouse
-- ----------------------------
ALTER TABLE [dbo].[MD_PermittedWarehouse] ADD PRIMARY KEY ([Firm], [UserId], [TigerWarehouseNr], [OperationId], [DivisionNr])
GO

-- ----------------------------
-- Indexes structure for table MD_PlanDistributedByClient
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_PlanDistributedByClient
-- ----------------------------
ALTER TABLE [dbo].[MD_PlanDistributedByClient] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table MD_PlanDistributedByClient
-- ----------------------------
ALTER TABLE [dbo].[MD_PlanDistributedByClient] ADD UNIQUE ([Firm] ASC, [ItemId] ASC, [ItemUnitId] ASC, [UserId] ASC, [Month] ASC, [Year] ASC, [ClientId] ASC)
GO

-- ----------------------------
-- Indexes structure for table MD_PlanDistributedByUser
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_PlanDistributedByUser
-- ----------------------------
ALTER TABLE [dbo].[MD_PlanDistributedByUser] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table MD_PlanDistributedByUser
-- ----------------------------
ALTER TABLE [dbo].[MD_PlanDistributedByUser] ADD UNIQUE ([Firm] ASC, [UserId] ASC, [ItemId] ASC, [ItemUnitId] ASC, [Month] ASC, [Year] ASC)
GO

-- ----------------------------
-- Indexes structure for table MD_PlanTotal
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_PlanTotal
-- ----------------------------
ALTER TABLE [dbo].[MD_PlanTotal] ADD PRIMARY KEY ([UserId], [Firm], [Month], [Year], [Type])
GO

-- ----------------------------
-- Indexes structure for table MD_Project
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Project
-- ----------------------------
ALTER TABLE [dbo].[MD_Project] ADD PRIMARY KEY ([TigerId], [Firm])
GO

-- ----------------------------
-- Indexes structure for table MD_ReturnLimit
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_ReturnLimit
-- ----------------------------
ALTER TABLE [dbo].[MD_ReturnLimit] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_Route
-- ----------------------------
CREATE INDEX [IX_MD_Route_Date] ON [dbo].[MD_Route]
([Date] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_Route
-- ----------------------------
ALTER TABLE [dbo].[MD_Route] ADD PRIMARY KEY ([Firm], [TigerClientId], [Date], [UserId])
GO

-- ----------------------------
-- Indexes structure for table MD_Salesman
-- ----------------------------
CREATE INDEX [IX_MD_Salesman_code] ON [dbo].[MD_Salesman]
([Code] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_Salesman
-- ----------------------------
ALTER TABLE [dbo].[MD_Salesman] ADD PRIMARY KEY ([Firm], [TigerId])
GO

-- ----------------------------
-- Indexes structure for table MD_SalesmanClientMapping
-- ----------------------------
CREATE INDEX [IX_MD_SalesmanClientMapping_FirmSalesmanId] ON [dbo].[MD_SalesmanClientMapping]
([Firm] ASC, [SalesmanId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table MD_SalesmanClientMapping
-- ----------------------------
ALTER TABLE [dbo].[MD_SalesmanClientMapping] ADD PRIMARY KEY ([Firm], [SalesmanId], [ClientId])
GO

-- ----------------------------
-- Indexes structure for table MD_TradingGroup
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_TradingGroup
-- ----------------------------
ALTER TABLE [dbo].[MD_TradingGroup] ADD PRIMARY KEY ([TigerId])
GO

-- ----------------------------
-- Indexes structure for table MD_UserPlanning
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_UserPlanning
-- ----------------------------
ALTER TABLE [dbo].[MD_UserPlanning] ADD PRIMARY KEY ([UserId])
GO

-- ----------------------------
-- Indexes structure for table MD_Warehouse
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_Warehouse
-- ----------------------------
ALTER TABLE [dbo].[MD_Warehouse] ADD PRIMARY KEY ([Firm], [Nr])
GO

-- ----------------------------
-- Indexes structure for table MD_WarehouseGroup
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_WarehouseGroup
-- ----------------------------
ALTER TABLE [dbo].[MD_WarehouseGroup] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MD_WarehouseGroupWarehouseRelation
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MD_WarehouseGroupWarehouseRelation
-- ----------------------------
ALTER TABLE [dbo].[MD_WarehouseGroupWarehouseRelation] ADD PRIMARY KEY ([WarehouseGroupId], [WarehouseNr])
GO

-- ----------------------------
-- Indexes structure for table MN_ClientServiceStatus
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MN_ClientServiceStatus
-- ----------------------------
ALTER TABLE [dbo].[MN_ClientServiceStatus] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MN_HttpRequestQueue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MN_HttpRequestQueue
-- ----------------------------
ALTER TABLE [dbo].[MN_HttpRequestQueue] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_AdministrativePushQueue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AdministrativePushQueue
-- ----------------------------
ALTER TABLE [dbo].[OP_AdministrativePushQueue] ADD PRIMARY KEY ([PushNotificationId])
GO

-- ----------------------------
-- Indexes structure for table OP_AdministrativePushLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AdministrativePushLog
-- ----------------------------
ALTER TABLE [dbo].[OP_AdministrativePushLog] ADD PRIMARY KEY ([PushNotificationId])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditCompetingItemIsCampaignExistData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditCompetingItemIsCampaignExistData
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditCompetingItemIsCampaignExistData] ADD PRIMARY KEY ([OperationId], [ItemId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditCompetingItemIsExistData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditCompetingItemIsExistData
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditCompetingItemIsExistData] ADD PRIMARY KEY ([OperationId], [ItemId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditCompetingItemPriceData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditCompetingItemPriceData
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditCompetingItemPriceData] ADD PRIMARY KEY ([OperationId], [ItemId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditCompetingItemShelfShareData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditCompetingItemShelfShareData
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditCompetingItemShelfShareData] ADD PRIMARY KEY ([OperationId], [ItemId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditOperation
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditOperation
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditOperation] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditOperationIsExistData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditOperationIsExistData
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditOperationIsExistData] ADD PRIMARY KEY ([OperationId], [ItemId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditOperationQuantityData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditOperationQuantityData
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditOperationQuantityData] ADD PRIMARY KEY ([OperationId], [ItemId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table OP_AuditOperationPriceData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_AuditOperationPriceData
-- ----------------------------
ALTER TABLE [dbo].[OP_AuditOperationPriceData] ADD PRIMARY KEY ([OperationId], [ItemId], [ItemUnitId])
GO

-- ----------------------------
-- Indexes structure for table OP_ClientDebt
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ClientDebt
-- ----------------------------
ALTER TABLE [dbo].[OP_ClientDebt] ADD PRIMARY KEY ([Firm], [TigerClientId], [CurrencyType], [OrderNo])
GO

-- ----------------------------
-- Indexes structure for table OP_ClientImageUploadLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ClientImageUploadLog
-- ----------------------------
ALTER TABLE [dbo].[OP_ClientImageUploadLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_ClientVisitLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ClientVisitLog
-- ----------------------------
ALTER TABLE [dbo].[OP_ClientVisitLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_DataExchangeMethodLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_DataExchangeMethodLog
-- ----------------------------
ALTER TABLE [dbo].[OP_DataExchangeMethodLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_DataExchangeSchedule
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_DataExchangeSchedule
-- ----------------------------
ALTER TABLE [dbo].[OP_DataExchangeSchedule] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_DataExchangeStatus
-- ----------------------------
CREATE UNIQUE INDEX [IX_OP_DataExchangeStatus] ON [dbo].[OP_DataExchangeStatus]
([MethodId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table OP_DataExchangeStatus
-- ----------------------------
ALTER TABLE [dbo].[OP_DataExchangeStatus] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_DocStatus
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_DocStatus
-- ----------------------------
ALTER TABLE [dbo].[OP_DocStatus] ADD PRIMARY KEY ([DocId])
GO

-- ----------------------------
-- Indexes structure for table OP_ERPIntegrationtResultQueue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ERPIntegrationtResultQueue
-- ----------------------------
ALTER TABLE [dbo].[OP_ERPIntegrationtResultQueue] ADD PRIMARY KEY ([GeneralId])
GO

-- ----------------------------
-- Indexes structure for table OP_ERPIntegrationtResultLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ERPIntegrationtResultLog
-- ----------------------------
ALTER TABLE [dbo].[OP_ERPIntegrationtResultLog] ADD PRIMARY KEY ([GeneralId])
GO

-- ----------------------------
-- Indexes structure for table OP_ErpOrderStatusLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ErpOrderStatusLog
-- ----------------------------
ALTER TABLE [dbo].[OP_ErpOrderStatusLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_FactCalculatedTotal
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_FactCalculatedTotal
-- ----------------------------
ALTER TABLE [dbo].[OP_FactCalculatedTotal] ADD PRIMARY KEY ([UserId], [Firm], [Month], [Year], [Type])
GO

-- ----------------------------
-- Indexes structure for table OP_FactDistributedByClient
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_FactDistributedByClient
-- ----------------------------
ALTER TABLE [dbo].[OP_FactDistributedByClient] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table OP_FactDistributedByClient
-- ----------------------------
ALTER TABLE [dbo].[OP_FactDistributedByClient] ADD UNIQUE ([Firm] ASC, [ItemId] ASC, [ItemUnitId] ASC, [UserId] ASC, [Month] ASC, [Year] ASC, [ClientId] ASC)
GO

-- ----------------------------
-- Indexes structure for table OP_FactDistributedByUser
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_FactDistributedByUser
-- ----------------------------
ALTER TABLE [dbo].[OP_FactDistributedByUser] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table OP_FactDistributedByUser
-- ----------------------------
ALTER TABLE [dbo].[OP_FactDistributedByUser] ADD UNIQUE ([Firm] ASC, [UserId] ASC, [ItemId] ASC, [ItemUnitId] ASC, [Year] ASC, [Month] ASC)
GO

-- ----------------------------
-- Indexes structure for table OP_FileUploadLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_FileUploadLog
-- ----------------------------
ALTER TABLE [dbo].[OP_FileUploadLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_GeneralLog
-- ----------------------------
CREATE INDEX [IX_OP_GeneralLog_RegisteredDate] ON [dbo].[OP_GeneralLog]
([RegisteredDate] ASC) 
INCLUDE ([RequestId]) 
GO

-- ----------------------------
-- Primary Key structure for table OP_GeneralLog
-- ----------------------------
ALTER TABLE [dbo].[OP_GeneralLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_IncomingLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_IncomingLog
-- ----------------------------
ALTER TABLE [dbo].[OP_IncomingLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_IncomingLogCashExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_IncomingLogCashExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_IncomingLogCashExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_IncomingLogCheckPaymentExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_IncomingLogCheckPaymentExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_IncomingLogCheckPaymentExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_IncomingLogCommonExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_IncomingLogCommonExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_IncomingLogCommonExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_IncomingLogCommonLineExtension
-- ----------------------------
CREATE INDEX [IX_OP_IncomingLogCommonLineExtension] ON [dbo].[OP_IncomingLogCommonLineExtension]
([Id] ASC) 
GO

-- ----------------------------
-- Indexes structure for table OP_IncomingLogCreditCardPaymentExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_IncomingLogCreditCardPaymentExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_IncomingLogCreditCardPaymentExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_IncomingLogVoucherPaymentExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_IncomingLogVoucherPaymentExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_IncomingLogVoucherPaymentExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_ItemStock
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ItemStock
-- ----------------------------
ALTER TABLE [dbo].[OP_ItemStock] ADD PRIMARY KEY ([Firm], [TigerItemId], [WarehouseNr])
GO

-- ----------------------------
-- Indexes structure for table OP_OutQueue
-- ----------------------------
CREATE INDEX [IX_OP_OutQueue_DocId] ON [dbo].[OP_OutQueue]
([DocId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table OP_OutQueue
-- ----------------------------
ALTER TABLE [dbo].[OP_OutQueue] ADD PRIMARY KEY ([GeneralId])
GO

-- ----------------------------
-- Indexes structure for table OP_PerformanceLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_PerformanceLog
-- ----------------------------
ALTER TABLE [dbo].[OP_PerformanceLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_PushQueue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_PushQueue
-- ----------------------------
ALTER TABLE [dbo].[OP_PushQueue] ADD PRIMARY KEY ([DocId], [GeneralId])
GO

-- ----------------------------
-- Indexes structure for table OP_PushLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_PushLog
-- ----------------------------
ALTER TABLE [dbo].[OP_PushLog] ADD PRIMARY KEY ([GeneralId])
GO

-- ----------------------------
-- Indexes structure for table OP_PushSchedule
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_PushSchedule
-- ----------------------------
ALTER TABLE [dbo].[OP_PushSchedule] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_RequestQueue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RequestQueue
-- ----------------------------
ALTER TABLE [dbo].[OP_RequestQueue] ADD PRIMARY KEY ([Id], [PartNo])
GO

-- ----------------------------
-- Indexes structure for table OP_RequestQueueCashExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RequestQueueCashExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_RequestQueueCashExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_RequestQueueCheckPaymentExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RequestQueueCheckPaymentExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_RequestQueueCheckPaymentExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_RequestQueueCommonExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RequestQueueCommonExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_RequestQueueCommonExtension] ADD PRIMARY KEY ([Id], [PartNo])
GO

-- ----------------------------
-- Indexes structure for table OP_RequestQueueCommonLineExtension
-- ----------------------------
CREATE INDEX [IX_OP_RequestQueueCommonLineExtension] ON [dbo].[OP_RequestQueueCommonLineExtension]
([Id] ASC) 
GO

-- ----------------------------
-- Indexes structure for table OP_RequestQueueCreditCardPaymentExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RequestQueueCreditCardPaymentExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_RequestQueueCreditCardPaymentExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_RequestQueueVoucherPaymentExtension
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RequestQueueVoucherPaymentExtension
-- ----------------------------
ALTER TABLE [dbo].[OP_RequestQueueVoucherPaymentExtension] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_ReturnFact
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_ReturnFact
-- ----------------------------
ALTER TABLE [dbo].[OP_ReturnFact] ADD PRIMARY KEY ([UserId], [Firm], [TigerItemId], [WarehouseGroupId], [Year], [Month])
GO

-- ----------------------------
-- Indexes structure for table OP_RiskLimitClient
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RiskLimitClient
-- ----------------------------
ALTER TABLE [dbo].[OP_RiskLimitClient] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_RiskLimitRequest
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_RiskLimitRequest
-- ----------------------------
ALTER TABLE [dbo].[OP_RiskLimitRequest] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_SpecialSequence
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_SpecialSequence
-- ----------------------------
ALTER TABLE [dbo].[OP_SpecialSequence] ADD PRIMARY KEY ([Firm], [ClientId], [DocType])
GO

-- ----------------------------
-- Indexes structure for table OP_SyncMethod
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_SyncMethod
-- ----------------------------
ALTER TABLE [dbo].[OP_SyncMethod] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_UserActionGpsData
-- ----------------------------
CREATE INDEX [IDX_UserActionGpsData_1] ON [dbo].[OP_UserActionGpsData]
([ActionTypeId] ASC) 
INCLUDE ([Id], [UserId], [Firm], [ClientId], [Latitude], [Longitude], [Subject], [Note], [GpsDate], [RegisteredDate], [SendDate]) 
GO
CREATE INDEX [IDX_UserActionGpsData_2] ON [dbo].[OP_UserActionGpsData]
([UserId] ASC, [ActionTypeId] ASC) 
INCLUDE ([Id], [Firm], [ClientId], [Latitude], [Longitude], [Subject], [Note], [GpsDate], [RegisteredDate], [SendDate]) 
GO

-- ----------------------------
-- Primary Key structure for table OP_UserActionGpsData
-- ----------------------------
ALTER TABLE [dbo].[OP_UserActionGpsData] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_UserGpsData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_UserGpsData
-- ----------------------------
ALTER TABLE [dbo].[OP_UserGpsData] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table OP_UserTaskExecutionLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table OP_UserTaskExecutionLog
-- ----------------------------
ALTER TABLE [dbo].[OP_UserTaskExecutionLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_AccountingPeriod
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_AccountingPeriod
-- ----------------------------
ALTER TABLE [dbo].[SYS_AccountingPeriod] ADD PRIMARY KEY ([FirmNr], [Period])
GO

-- ----------------------------
-- Indexes structure for table SYS_AppConfigParameter
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_AppConfigParameter
-- ----------------------------
ALTER TABLE [dbo].[SYS_AppConfigParameter] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_ConfigObject
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_ConfigObject
-- ----------------------------
ALTER TABLE [dbo].[SYS_ConfigObject] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_ConfigObjectValue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_ConfigObjectValue
-- ----------------------------
ALTER TABLE [dbo].[SYS_ConfigObjectValue] ADD PRIMARY KEY ([Value], [OperationId], [ObjectId])
GO

-- ----------------------------
-- Indexes structure for table SYS_DataExchangeMethod
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_DataExchangeMethod
-- ----------------------------
ALTER TABLE [dbo].[SYS_DataExchangeMethod] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_DataOperationMapping
-- ----------------------------
CREATE UNIQUE INDEX [IDX_DataType] ON [dbo].[SYS_DataOperationMapping]
([DataType] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table SYS_DataOperationMapping
-- ----------------------------
ALTER TABLE [dbo].[SYS_DataOperationMapping] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_DataType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_DataType
-- ----------------------------
ALTER TABLE [dbo].[SYS_DataType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_DeviceSyncSchedule
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_DeviceSyncSchedule
-- ----------------------------
ALTER TABLE [dbo].[SYS_DeviceSyncSchedule] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_EmailSetting
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_EmailSetting
-- ----------------------------
ALTER TABLE [dbo].[SYS_EmailSetting] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_Language
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_Language
-- ----------------------------
ALTER TABLE [dbo].[SYS_Language] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_LicenseInfo
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_LicenseInfo
-- ----------------------------
ALTER TABLE [dbo].[SYS_LicenseInfo] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_MethodPermission
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_MethodPermission
-- ----------------------------
ALTER TABLE [dbo].[SYS_MethodPermission] ADD PRIMARY KEY ([MethodId], [PermissionId])
GO

-- ----------------------------
-- Indexes structure for table SYS_ModuleConfigObject
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_ModuleConfigObject
-- ----------------------------
ALTER TABLE [dbo].[SYS_ModuleConfigObject] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_ModuleConfigObjectValue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_ModuleConfigObjectValue
-- ----------------------------
ALTER TABLE [dbo].[SYS_ModuleConfigObjectValue] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_PlanMethod
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_PlanMethod
-- ----------------------------
ALTER TABLE [dbo].[SYS_PlanMethod] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_PushType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_PushType
-- ----------------------------
ALTER TABLE [dbo].[SYS_PushType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_SetOperation
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_SetOperation
-- ----------------------------
ALTER TABLE [dbo].[SYS_SetOperation] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_SyncTimeTable
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_SyncTimeTable
-- ----------------------------
ALTER TABLE [dbo].[SYS_SyncTimeTable] ADD PRIMARY KEY ([Name])
GO

-- ----------------------------
-- Indexes structure for table SYS_TaskExecutionStatus
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_TaskExecutionStatus
-- ----------------------------
ALTER TABLE [dbo].[SYS_TaskExecutionStatus] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_TaskExecutionType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_TaskExecutionType
-- ----------------------------
ALTER TABLE [dbo].[SYS_TaskExecutionType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_TaskFormType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_TaskFormType
-- ----------------------------
ALTER TABLE [dbo].[SYS_TaskFormType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_TaskType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_TaskType
-- ----------------------------
ALTER TABLE [dbo].[SYS_TaskType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_Translation
-- ----------------------------
CREATE UNIQUE INDEX [İDX_ObjNameLang] ON [dbo].[SYS_Translation]
([ObjectName] ASC, [LanguageId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IDX_TranslationObj] ON [dbo].[SYS_Translation]
([ObjectName] ASC, [LanguageId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table SYS_Translation
-- ----------------------------
ALTER TABLE [dbo].[SYS_Translation] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_UserActionType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_UserActionType
-- ----------------------------
ALTER TABLE [dbo].[SYS_UserActionType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SYS_UserSettingObject
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SYS_UserSettingObject
-- ----------------------------
ALTER TABLE [dbo].[SYS_UserSettingObject] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table TDP_UserParam
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table TDP_UserParam
-- ----------------------------
ALTER TABLE [dbo].[TDP_UserParam] ADD PRIMARY KEY ([UserId])
GO

-- ----------------------------
-- Indexes structure for table TPD_ImportConfig
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table TPD_ImportConfig
-- ----------------------------
ALTER TABLE [dbo].[TPD_ImportConfig] ADD PRIMARY KEY ([Firm])
GO

-- ----------------------------
-- Indexes structure for table UID_UserPermissionBannedClients
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UID_UserPermissionBannedClients
-- ----------------------------
ALTER TABLE [dbo].[UID_UserPermissionBannedClients] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_AllowedDevice
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_AllowedDevice
-- ----------------------------
ALTER TABLE [dbo].[UIM_AllowedDevice] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_Device
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_Device
-- ----------------------------
ALTER TABLE [dbo].[UIM_Device] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_Faq
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_Faq
-- ----------------------------
ALTER TABLE [dbo].[UIM_Faq] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_FaqCategory
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_FaqCategory
-- ----------------------------
ALTER TABLE [dbo].[UIM_FaqCategory] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_NonLoggingDay
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[UIM_NonLoggingDay]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UIM_NonLoggingDay
-- ----------------------------
ALTER TABLE [dbo].[UIM_NonLoggingDay] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_Permission
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_Permission
-- ----------------------------
ALTER TABLE [dbo].[UIM_Permission] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_PermissionValue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_PermissionValue
-- ----------------------------
ALTER TABLE [dbo].[UIM_PermissionValue] ADD PRIMARY KEY ([Value])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserAppLoginAttempt
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_UserAppLoginAttempt
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserAppLoginAttempt] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserAuthToken
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_UserAuthToken
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserAuthToken] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserConfigParameter
-- ----------------------------
CREATE UNIQUE INDEX [IX_UIM_UserConfigParameter] ON [dbo].[UIM_UserConfigParameter]
([ObjectId] ASC, [UserId] ASC, [OperationId] ASC, [Firm] ASC, [Objectvalue] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IDX_UserIdOpId] ON [dbo].[UIM_UserConfigParameter]
([UserId] ASC, [OperationId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserConfigParameter
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserConfigParameter] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserContactData
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_UserContactData
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserContactData] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserDeviceLogHistory
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_UserDeviceLogHistory
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserDeviceLogHistory] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserDeviceLogin
-- ----------------------------
CREATE UNIQUE INDEX [IDX_UserDevice] ON [dbo].[UIM_UserDeviceLogin]
([UserId] ASC, [DeviceId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserDeviceLogin
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserDeviceLogin] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserEmployeeMapping
-- ----------------------------
CREATE INDEX [IX_UIM_UserEmployeeMapping_EmployeeId] ON [dbo].[UIM_UserEmployeeMapping]
([EmployeeId] ASC) 
GO
CREATE INDEX [IX_UIM_UserEmployeeMapping_UserId] ON [dbo].[UIM_UserEmployeeMapping]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserEmployeeMapping
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserEmployeeMapping] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table UIM_UserEmployeeMapping
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserEmployeeMapping] ADD UNIQUE ([UserId] ASC, [EmployeeId] ASC, [Firm] ASC)
GO

-- ----------------------------
-- Indexes structure for table UIM_UserModuleConfigParameter
-- ----------------------------
CREATE UNIQUE INDEX [IX_UIM_UserModuleConfigParameter] ON [dbo].[UIM_UserModuleConfigParameter]
([ObjectId] ASC, [UserId] ASC, [Firm] ASC, [ObjectValue] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IDX_UserIdOpId] ON [dbo].[UIM_UserModuleConfigParameter]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserModuleConfigParameter
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserModuleConfigParameter] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserPermission
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[UIM_UserPermission]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserPermission
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserPermission] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table UIM_UserPermission
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserPermission] ADD UNIQUE ([Firm] ASC, [UserId] ASC, [PermissionId] ASC)
GO

-- ----------------------------
-- Indexes structure for table UIM_UserProperty
-- ----------------------------
CREATE UNIQUE INDEX [IDX_UserFirm] ON [dbo].[UIM_UserProperty]
([UserId] ASC, [Firm] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserProperty
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserProperty] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserSetting
-- ----------------------------
CREATE INDEX [IDX_UserId] ON [dbo].[UIM_UserSetting]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserSetting
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserSetting] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Uniques structure for table UIM_UserSetting
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserSetting] ADD UNIQUE ([Firm] ASC, [UserId] ASC, [SettingId] ASC)
GO

-- ----------------------------
-- Indexes structure for table UIM_UserTask
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_UserTask
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserTask] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UIM_UserType
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UIM_UserTypeUserMapping
-- ----------------------------
CREATE UNIQUE INDEX [IX_UIM_UserTypeUserMapping_UserId_UserTypeId] ON [dbo].[UIM_UserTypeUserMapping]
([UserId] ASC, [UserTypeId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Primary Key structure for table UIM_UserTypeUserMapping
-- ----------------------------
ALTER TABLE [dbo].[UIM_UserTypeUserMapping] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpFeatures]
-- ----------------------------
ALTER TABLE [dbo].[AbpFeatures] ADD FOREIGN KEY ([EditionId]) REFERENCES [dbo].[AbpEditions] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpOrganizationUnits]
-- ----------------------------
ALTER TABLE [dbo].[AbpOrganizationUnits] ADD FOREIGN KEY ([ParentId]) REFERENCES [dbo].[AbpOrganizationUnits] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpPermissions]
-- ----------------------------
ALTER TABLE [dbo].[AbpPermissions] ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AbpRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpPermissions] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpRoleClaims]
-- ----------------------------
ALTER TABLE [dbo].[AbpRoleClaims] ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AbpRoles] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpRoles]
-- ----------------------------
ALTER TABLE [dbo].[AbpRoles] ADD FOREIGN KEY ([CreatorUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpRoles] ADD FOREIGN KEY ([DeleterUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpRoles] ADD FOREIGN KEY ([LastModifierUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpSettings]
-- ----------------------------
ALTER TABLE [dbo].[AbpSettings] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpTenants]
-- ----------------------------
ALTER TABLE [dbo].[AbpTenants] ADD FOREIGN KEY ([EditionId]) REFERENCES [dbo].[AbpEditions] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpTenants] ADD FOREIGN KEY ([CreatorUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpTenants] ADD FOREIGN KEY ([DeleterUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpTenants] ADD FOREIGN KEY ([LastModifierUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpUserClaims]
-- ----------------------------
ALTER TABLE [dbo].[AbpUserClaims] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpUserLogins]
-- ----------------------------
ALTER TABLE [dbo].[AbpUserLogins] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpUserRoles]
-- ----------------------------
ALTER TABLE [dbo].[AbpUserRoles] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpUsers]
-- ----------------------------
ALTER TABLE [dbo].[AbpUsers] ADD FOREIGN KEY ([CreatorUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpUsers] ADD FOREIGN KEY ([DeleterUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[AbpUsers] ADD FOREIGN KEY ([LastModifierUserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AbpUserTokens]
-- ----------------------------
ALTER TABLE [dbo].[AbpUserTokens] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[AppSubscriptionPayments]
-- ----------------------------
ALTER TABLE [dbo].[AppSubscriptionPayments] ADD FOREIGN KEY ([EditionId]) REFERENCES [dbo].[AbpEditions] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_InvoiceLine]
-- ----------------------------
ALTER TABLE [dbo].[DM_InvoiceLine] ADD FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[DM_Invoice] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_Order]
-- ----------------------------
ALTER TABLE [dbo].[DM_Order] ADD FOREIGN KEY ([Firm], [ClientId]) REFERENCES [dbo].[MD_Client] ([Firm], [TigerId]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_Order] ADD FOREIGN KEY ([Firm], [Warehouse]) REFERENCES [dbo].[MD_Warehouse] ([Firm], [Nr]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_OrderLine]
-- ----------------------------
ALTER TABLE [dbo].[DM_OrderLine] ADD FOREIGN KEY ([OrderId]) REFERENCES [dbo].[DM_Order] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_Setting]
-- ----------------------------
ALTER TABLE [dbo].[DM_Setting] ADD FOREIGN KEY ([DeviceId]) REFERENCES [dbo].[UIM_Device] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_TransportClient]
-- ----------------------------
ALTER TABLE [dbo].[DM_TransportClient] ADD FOREIGN KEY ([TransportPackageId]) REFERENCES [dbo].[DM_TransportPackage] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_TransportClient] ADD FOREIGN KEY ([ClientFirm], [ClientTigerId]) REFERENCES [dbo].[MD_Client] ([Firm], [TigerId]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_TransportOrder]
-- ----------------------------
ALTER TABLE [dbo].[DM_TransportOrder] ADD FOREIGN KEY ([OrderId]) REFERENCES [dbo].[DM_Order] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_TransportOrder] ADD FOREIGN KEY ([TransportClientId]) REFERENCES [dbo].[DM_TransportClient] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_TransportPackage]
-- ----------------------------
ALTER TABLE [dbo].[DM_TransportPackage] ADD FOREIGN KEY ([TransportStatusId]) REFERENCES [dbo].[DM_TransportStatus] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_TransportPackage] ADD FOREIGN KEY ([TruckId]) REFERENCES [dbo].[DM_Truck] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_TransportPackage] ADD FOREIGN KEY ([DepartureWarehouseGroupId]) REFERENCES [dbo].[MD_WarehouseGroup] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_TransportPackage] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[AbpUsers] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[DM_Truck]
-- ----------------------------
ALTER TABLE [dbo].[DM_Truck] ADD FOREIGN KEY ([TruckGroupId]) REFERENCES [dbo].[DM_TruckGroup] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_Truck] ADD FOREIGN KEY ([TruckTypeId]) REFERENCES [dbo].[DM_TruckType] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DM_Truck] ADD FOREIGN KEY ([AutoParkId]) REFERENCES [dbo].[DM_AutoPark] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[MD_Catalog]
-- ----------------------------
ALTER TABLE [dbo].[MD_Catalog] ADD FOREIGN KEY ([CatalogGroupId]) REFERENCES [dbo].[MD_CatalogGroup] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[MD_CatalogItemMapping]
-- ----------------------------
ALTER TABLE [dbo].[MD_CatalogItemMapping] ADD FOREIGN KEY ([CatalogId]) REFERENCES [dbo].[MD_Catalog] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[UIM_Faq]
-- ----------------------------
ALTER TABLE [dbo].[UIM_Faq] ADD FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[UIM_FaqCategory] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO




-- Functions
GO
/****** Object:  UserDefinedFunction [dbo].[F_GetPermittedClient]    Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[F_GetPermittedClient](@userId int) 
Returns @clients Table
(
	Firm smallint NOT NULL, 
	UserId int NOT NULL, 
	ClientId int NOT NULL, 
	RegisteredDate datetime NOT NULL,
	SyncFlag tinyint NULL
)
AS
BEGIN

	IF ISNULL(@userId, 0) > 0
	BEGIN
		INSERT INTO @clients
		SELECT Firm, UserId, ClientId, MAX (RegisteredDate) As RegisteredDate, SUM(SyncFlag) AS SyncFlag
		FROM
		(SELECT Firm, UserId, TigerClientId As ClientId, RegisteredDate, 1 AS SyncFlag
		FROM MD_PermittedClient WITH (NOLOCK) WHERE UserId = @userId

		UNION
		
		SELECT CMapping.Firm, EMapping.UserId, CMapping.ClientId, RegisteredDate, 2 AS SyncFlag
		FROM MD_SalesmanClientMapping CMapping WITH(NOLOCK)
		INNER JOIN UIM_UserEmployeeMapping EMapping WITH(NOLOCK) ON 
		(EMapping.EmployeeId=CMapping.SalesmanId AND EMapping.Firm=CMapping.Firm AND EMapping.UserId = @userId)) AS T
		GROUP BY T.Firm, UserId, ClientId
	END
	ELSE
	BEGIN
		INSERT INTO @clients
		SELECT Firm, UserId, ClientId, MAX (RegisteredDate) As RegisteredDate, SUM(SyncFlag) AS SyncFlag FROM
		(SELECT Firm, UserId, TigerClientId As ClientId, RegisteredDate, 1 AS SyncFlag
		FROM MD_PermittedClient WITH (NOLOCK)

		UNION
		
		SELECT CMapping.Firm, EMapping.UserId, CMapping.ClientId, RegisteredDate, 2 AS SyncFlag
		FROM MD_SalesmanClientMapping CMapping WITH(NOLOCK)
		INNER JOIN UIM_UserEmployeeMapping EMapping WITH(NOLOCK) ON 
		(EMapping.EmployeeId=CMapping.SalesmanId AND EMapping.Firm=CMapping.Firm)) AS T
		GROUP BY T.Firm, UserId, ClientId
	END

	RETURN
END

/****** Object: UserDefinedFunction [dbo].[F_SplitList] Script Date: 20.07.2019 16:01:16 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_SplitList] (@list VARCHAR(MAX), @separator VARCHAR(MAX) = ',')
RETURNS @table TABLE (Value VARCHAR(MAX))
AS BEGIN
DECLARE @position INT, @previous INT
SET @list = @list + @separator
SET @previous = 1
SET @position = CHARINDEX(@separator, @list)
WHILE @position > 0 
BEGIN
IF @position - @previous > 0
INSERT INTO @table VALUES (SUBSTRING(@list, @previous, @position - @previous))
IF @position >= LEN(@list) BREAK
SET @previous = @position + 1
SET @position = CHARINDEX(@separator, @list, @previous)
END
RETURN
END

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetClientsOrderLineSummary] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_DM_GetClientsOrderLineSummary]() 
Returns Table
AS
RETURN(
select tc.Id as ReferenceId, sum(iu.Volume * ol.Amount) as Volume, sum(iu.GrossWeight * ol.Amount) as Weight, sum((iu.Convfact2/iu.Convfact1) * ol.Amount) as Amount, 
sum(ol.Amount * 
CASE ol.IsPromo WHEN 1 THEN 0
ELSE 1 END * ol.Price) as Price,
count(ol.Id) as ItemCount
from DM_TransportClient tc
join DM_TransportOrder [to] on tc.Id=[to].TransportClientId
join DM_Order o on o.Id = [to].OrderId
join DM_OrderLine ol on ol.OrderId = o.Id
join MD_ItemUnit iu on (iu.TigerItemId = ol.ItemId and iu.Firm = tc.ClientFirm and iu.Code = ol.ItemUnitCode)
group by tc.Id
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetInvoiceInvoiceLines] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[F_DM_GetInvoiceInvoiceLines](@invoicesListStr VARCHAR(MAX)) 
Returns Table
AS
RETURN(
select il.ItemId as ReferenceId, il.ItemId, i.Code as ItemCode, i.Name as ItemName,
iuMain.Code as ItemUnitCode, il.IsPromo, 
sum(iu.Volume * il.Amount) as Volume,
sum(iu.GrossWeight * il.Amount) as Weight,
sum((iu.Convfact2/iu.Convfact1) * il.Amount) as Amount,
Case il.IsPromo When 1 then 0
Else 1 * sum(il.Price * il.Amount) End as Price
from DM_Invoice inv
join DM_InvoiceLine il on il.InvoiceId = inv.Id
join MD_ItemUnit iu on (iu.TigerItemId = il.ItemId and iu.Firm = inv.Firm and iu.Code = il.ItemUnitCode)
join MD_ItemUnit iuMain on (iuMain.TigerItemId = il.ItemId and iuMain.Firm = inv.Firm and iuMain.LineNr = 1)
join MD_Item i on il.ItemId =i.TigerId and inv.Firm = i.Firm
where inv.Id in (select [Value] from F_SplitList(@invoicesListStr, ','))
group by il.ItemId, i.Code, i.Name, iuMain.Code, il.IsPromo
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetInvoicesInvoiceLineSummary] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_DM_GetInvoicesInvoiceLineSummary]() 
Returns Table
AS
RETURN(
select inv.Id as ReferenceId, sum(iu.Volume * il.Amount) as Volume, sum(iu.GrossWeight * il.Amount) as Weight, sum((iu.Convfact2/iu.Convfact1) * il.Amount) as Amount, 
sum(il.Amount * 
CASE il.IsPromo WHEN 1 THEN 0
ELSE 1 END * il.Price) as Price,
count(il.Id) as ItemCount
from DM_Invoice inv
join DM_InvoiceLine il on il.InvoiceId = inv.Id
join MD_ItemUnit iu on (iu.TigerItemId = il.ItemId and iu.Firm = inv.Firm and iu.Code = il.ItemUnitCode)
group by inv.Id
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetItemStockLoadInfo] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_DM_GetItemStockLoadInfo](@packageId int) 

Returns Table
AS
RETURN(
select li.ItemId, li.ItemCode, li.ItemName, li.ItemUnitCode, li.Amount as LoadedAmount, 
ISNULL(di.Amount, 0) as DeliveredAmount
from 
(
select i.TigerId as ItemId, i.Code as ItemCode, i.Name as ItemName, iuMain.Code as ItemUnitCode,
sum((iu.Convfact2/iu.Convfact1) * os.Amount) as Amount from DM_OrderStock os join DM_TransportPackage tp
on os.PackageId = tp.Id
join MD_Item i on os.ItemId=i.TigerId and tp.Firm = i.Firm
join MD_ItemUnit iu on (iu.TigerItemId = os.ItemId and iu.Firm = tp.Firm and iu.Code = os.ItemUnitCode)
join MD_ItemUnit iuMain on (iuMain.TigerItemId = os.ItemId and iuMain.Firm = tp.Firm and iuMain.LineNr = 1)
where tp.id = @packageId
group by i.TigerId, i.Code, i.Name, iuMain.Code
) li 
left join 
(
select i.TigerId as ItemId, i.Code as ItemCode, i.Name as ItemName, sum((iu.Convfact2/iu.Convfact1) * il.Amount) as Amount from DM_TransportPackage tp 
join DM_TransportClient tc on tp.Id=tc.TransportPackageId
join DM_TransportOrder [to] on tc.Id=[to].TransportClientId
join DM_Invoice inv on [to].OrderId=inv.DeliveryOrderId
join DM_InvoiceLine il on inv.Id=il.InvoiceId
join MD_Item i on il.ItemId=i.TigerId and i.Firm = i.Firm
join MD_ItemUnit iu on (iu.TigerItemId = il.ItemId and iu.Firm = i.Firm and iu.Code = il.ItemUnitCode)
where tp.id = @packageId
group by i.TigerId, i.Code, i.Name
) di
on li.ItemId = di.ItemId
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetOrderInvoiceLines] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[F_DM_GetOrderInvoiceLines](@orderId int) 
Returns Table
AS
RETURN(
select il.ItemId as ReferenceId, il.ItemId, i.Code as ItemCode, i.Name as ItemName,
iuMain.Code as ItemUnitCode, il.IsPromo, sum(iu.Volume * il.Amount) as Volume,
sum(iu.GrossWeight * il.Amount) as Weight,
sum((iu.Convfact2/iu.Convfact1) * il.Amount) as Amount,
Case il.IsPromo When 1 then 0
Else 1 * sum(il.Price * il.Amount) End as Price
from DM_Invoice inv
join DM_InvoiceLine il on il.InvoiceId = inv.Id
join MD_ItemUnit iu on (iu.TigerItemId = il.ItemId and iu.Firm = inv.Firm and iu.Code = il.ItemUnitCode)
join MD_ItemUnit iuMain on (iuMain.TigerItemId = il.ItemId and iuMain.Firm = inv.Firm and iuMain.LineNr = 1)
join MD_Item i on il.ItemId =i.TigerId and inv.Firm = i.Firm
where inv.DeliveryOrderId =@orderId
group by il.ItemId, i.Code, i.Name, iuMain.Code, il.IsPromo
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetOrderInvoiceLineSummary] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[F_DM_GetOrderInvoiceLineSummary](@orderId int) 
Returns Table
AS
RETURN(
select inv.Id as ReferenceId, sum(iu.Volume * il.Amount) as Volume, sum(iu.GrossWeight * il.Amount) as Weight, sum((iu.Convfact2/iu.Convfact1) * il.Amount) as Amount, 
sum(il.Amount * 
CASE il.IsPromo WHEN 1 THEN 0
ELSE 1 END * il.Price) as Price,
count(il.Id) as ItemCount
from DM_Invoice inv
join DM_InvoiceLine il on il.InvoiceId = inv.Id
join MD_ItemUnit iu on (iu.TigerItemId = il.ItemId and iu.Firm = inv.Firm and iu.Code = il.ItemUnitCode)
where inv.DeliveryOrderId = @orderId
group by inv.Id
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetOrdersOrderLines] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[F_DM_GetOrdersOrderLines](@ordersListStr VARCHAR(MAX)) 
Returns Table
AS
RETURN(
select ol.ItemId as ReferenceId, ol.ItemId, i.Code as ItemCode, i.Name as ItemName, 
iuMain.Code ItemUnitCode, ol.IsPromo, 
sum(iu.Volume * ol.Amount) as Volume,
sum(iu.GrossWeight * ol.Amount) as Weight,
sum((iu.Convfact2/iu.Convfact1) * ol.Amount) as Amount,
Case ol.IsPromo When 1 then 0
Else 1 * sum(ol.Price * ol.Amount) End as Price
from DM_Order o
join DM_OrderLine ol on ol.OrderId = o.Id
join MD_ItemUnit iu on (iu.TigerItemId = ol.ItemId and iu.Firm = o.Firm and iu.Code = ol.ItemUnitCode)
join MD_ItemUnit iuMain on (iuMain.TigerItemId = ol.ItemId and iuMain.Firm = o.Firm and iuMain.LineNr = 1)
join MD_Item i on ol.ItemId=i.TigerId and o.Firm = i.Firm
where o.Id in (select [Value] from F_SplitList(@ordersListStr, ','))
group by ol.ItemId, i.Code, i.Name, iuMain.Code, ol.IsPromo
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetOrdersOrderLineSummary] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_DM_GetOrdersOrderLineSummary]() 
Returns Table
AS
RETURN(
select o.Id as ReferenceId, sum(iu.Volume * ol.Amount) as Volume, sum(iu.GrossWeight * ol.Amount) as Weight, sum((iu.Convfact2/iu.Convfact1) * ol.Amount) as Amount, 
sum(ol.Amount * 
CASE ol.IsPromo WHEN 1 THEN 0
ELSE 1 END * ol.Price) as Price,
count(ol.Id) as ItemCount
from DM_Order o
join DM_OrderLine ol on ol.OrderId = o.Id
join MD_ItemUnit iu on (iu.TigerItemId = ol.ItemId and iu.Firm = o.Firm and iu.Code = ol.ItemUnitCode)
group by o.Id
)

GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetPackageOrderLines] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_DM_GetPackageOrderLines](@packageId int) 
Returns Table
AS
RETURN(
select @packageId as ReferenceId, ol.ItemId, i.Code as ItemCode, i.Name as ItemName,
iuMain.Code ItemUnitCode, ol.IsPromo, 
sum(iu.Volume * ol.Amount) as Volume,
sum(iu.GrossWeight * ol.Amount) as Weight,
sum((iu.Convfact2/iu.Convfact1) * ol.Amount) as Amount,
Case ol.IsPromo When 1 then 0
Else 1 * sum(ol.Price * ol.Amount) End as Price
from DM_TransportPackage tp
join DM_TransportClient tc on tp.Id=tc.TransportPackageId
join DM_TransportOrder [to] on tc.Id=[to].TransportClientId
join DM_Order o on o.Id = [to].OrderId
join DM_OrderLine ol on ol.OrderId = o.Id
join MD_ItemUnit iu on (iu.TigerItemId = ol.ItemId and iu.Firm = tp.Firm and iu.Code = ol.ItemUnitCode)
join MD_ItemUnit iuMain on (iuMain.TigerItemId = ol.ItemId and iuMain.Firm = o.Firm and iuMain.LineNr = 1)
join MD_Item i on ol.ItemId =i.TigerId and tp.Firm = i.Firm
where tp.Id=@packageId
group by ol.ItemId, i.Code, i.Name, iuMain.Code, ol.IsPromo
)


GO
/****** Object: UserDefinedFunction [dbo].[F_DM_GetPackagesOrderLineSummary] Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_DM_GetPackagesOrderLineSummary]() 
Returns Table
AS
RETURN(
select tp.Id as ReferenceId, sum(iu.Volume * ol.Amount) as Volume, sum(iu.GrossWeight * ol.Amount) as Weight, sum((iu.Convfact2/iu.Convfact1) * ol.Amount) as Amount,
sum(ol.Amount * 
CASE ol.IsPromo WHEN 1 THEN 0
ELSE 1 END * ol.Price) as Price,
count(ol.Id) as ItemCount
from DM_TransportPackage tp
join DM_TransportClient tc on tp.Id=tc.TransportPackageId
join DM_TransportOrder [to] on tc.Id=[to].TransportClientId
join DM_Order o on o.Id = [to].OrderId
join DM_OrderLine ol on ol.OrderId = o.Id
join MD_ItemUnit iu on (iu.TigerItemId = ol.ItemId and iu.Firm = tp.Firm and iu.Code = ol.ItemUnitCode)
GROUP By tp.Id
)


GO
/****** Object:  UserDefinedFunction [dbo].[F_GetAllPermittedClient]    Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[F_GetAllPermittedClient]() 
Returns Table
AS
RETURN(
SELECT Firm, UserId, TigerClientId As ClientId
FROM MD_PermittedClient WITH (NOLOCK) 
UNION
SELECT CMapping.Firm, EMapping.UserId, CMapping.ClientId
FROM MD_SalesmanClientMapping CMapping WITH(NOLOCK)
INNER JOIN UIM_UserEmployeeMapping EMapping WITH(NOLOCK) ON (EMapping.EmployeeId=CMapping.SalesmanId AND EMapping.Firm=CMapping.Firm) 
)

GO
/****** Object:  UserDefinedFunction [dbo].[F_GetAllPermittedClientWithRegisteredDate]    Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_GetAllPermittedClientWithRegisteredDate]() 
Returns Table
AS
RETURN(
SELECT Firm, UserId, ClientId, MAX (RegisteredDate) As RegisteredDate, SUM(SyncFlag) AS SyncFlag
FROM
(
SELECT Firm, UserId, TigerClientId As ClientId, RegisteredDate, 1 As SyncFlag
FROM MD_PermittedClient WITH (NOLOCK) 
UNION
SELECT CMapping.Firm, EMapping.UserId, CMapping.ClientId, MAX ((CASE WHEN EMapping.CreatedDate>=CMapping.RegisteredDate THEN EMapping.CreatedDate ELSE CMapping.RegisteredDate END)) As RegisteredDate, 2 As SyncFlag
FROM MD_SalesmanClientMapping CMapping WITH(NOLOCK)
INNER JOIN UIM_UserEmployeeMapping EMapping WITH(NOLOCK) ON (EMapping.EmployeeId=CMapping.SalesmanId AND EMapping.Firm=CMapping.Firm)
GROUP BY CMapping.Firm, EMapping.UserId, CMapping.ClientId) AS T
GROUP BY T.Firm, UserId, ClientId
)


GO
/****** Object:  UserDefinedFunction [dbo].[F_GetItemAllPrices]    Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_GetItemAllPrices](@userId int, @currentDate datetime) 
RETURNS 
TABLE AS
RETURN (
WITH PermittedItems AS(
                                SELECT Distinct Cat.Firm, ItemMapping.TigerItemId,
                                (CASE WHEN ItemMapping.RegisteredDate>=PCatalog.RegisteredDate THEN ItemMapping.RegisteredDate ELSE PCatalog.RegisteredDate END) AS RegisteredDate 
                                FROM MD_CatalogItemMapping ItemMapping WITH (NOLOCK)
                                INNER JOIN MD_Catalog Cat WITH (NOLOCK) ON (Cat.Id=ItemMapping.CatalogId )
                                INNER JOIN MD_PermittedCatalog PCatalog WITH (NOLOCK) ON (PCatalog.CatalogId=Cat.Id AND PCatalog.UserId=@userId)),
              PermittedCurrencies As(
                                SELECT Nr, LocalCurrencyTypeId AS CurrencyTypeId FROM MD_Firm WITH (NOLOCK) WHERE Nr IN (SELECT NR FROM MD_PermittedFirm WHERE UserId=@userId)),
              PermittedClients AS (
                                 SELECT PClient.Firm, PClient.ClientId, PriceClientGroup.GroupId As PriceGroupId, SuggestedClientGroup.GroupId AS SuggestedPriceGroupId,
		                        (CASE WHEN (PClient.RegisteredDate>=Client.RegisteredDate AND PClient.RegisteredDate>=PriceClientGroup.RegisteredDate) THEN PClient.RegisteredDate
								WHEN (PriceClientGroup.RegisteredDate>=Client.RegisteredDate AND PriceClientGroup.RegisteredDate>=PClient.RegisteredDate) THEN PriceClientGroup.RegisteredDate
								ELSE Client.RegisteredDate END) AS RegisteredDate 
                                FROM F_GetPermittedClient(@userId) PClient 
                                INNER JOIN MD_Client Client WITH (NOLOCK) ON (Client.Firm=PClient.Firm AND Client.TigerId=PClient.ClientId) 
                                LEFT JOIN MD_ClientGroupData PriceClientGroup ON (PriceClientGroup.Firm=PClient.Firm AND PriceClientGroup.ClientId=PClient.ClientId AND PriceClientGroup.GroupType=1) 
								LEFT JOIN MD_ClientGroupData SuggestedClientGroup ON (SuggestedClientGroup.Firm=PClient.Firm AND SuggestedClientGroup.ClientId=PClient.ClientId AND SuggestedClientGroup.GroupType=4) 
                                WHERE UserId=@userId  )

                                SELECT Price.TigerId, Price.Firm, Price.TigerItemId, Price.TigerItemUnitId, Price.BeginDate, Price.EndDate,
                                Price.Price, Price.CurrencyTypeId,(CASE WHEN PriceMapping.DivisionNr=-1 THEN 100 ELSE 105 END) AS PriceType, 
                                PriceMapping.DivisionNr AS PriceTypeId, Price.OperationMask, Price.VatIncluded,
                                (CASE WHEN Price.RegisteredDate>=PermittedItems.RegisteredDate THEN Price.RegisteredDate ELSE PermittedItems.RegisteredDate END) AS RegisteredDate 
                                FROM [MD_ItemPrice] Price WITH (NOLOCK)
                                INNER JOIN PermittedCurrencies Currency WITH (NOLOCK) ON (Currency.Nr=Price.Firm AND Currency.CurrencyTypeId=Price.CurrencyTypeId)
                                INNER JOIN PermittedItems WITH (NOLOCK) ON (PermittedItems.Firm=Price.Firm AND PermittedItems.TigerItemId=Price.TigerItemId)
                                INNER JOIN MD_ItemPriceDivisionMapping PriceMapping WITH (NOLOCK) ON (PriceMapping.TigerId=Price.TigerId AND PriceMapping.Firm=Price.Firm)
                                WHERE Price.Status=0 AND Price.BeginDate<=@currentDate AND Price.EndDate>=@currentDate
                          UNION 
                                SELECT Price.TigerId, Price.Firm, Price.TigerItemId, Price.TigerItemUnitId, Price.BeginDate, Price.EndDate,
                                Price.Price, Price.CurrencyTypeId,  110 AS PriceType, Price.ClientGroupId AS PriceTypeId, Price.OperationMask, Price.VatIncluded,
                                (CASE WHEN (Price.RegisteredDate>=PermittedItems.RegisteredDate AND Price.RegisteredDate>=PClient.RegisteredDate) THEN Price.RegisteredDate
								WHEN (PermittedItems.RegisteredDate>=Price.RegisteredDate AND PermittedItems.RegisteredDate>=PClient.RegisteredDate) THEN PermittedItems.RegisteredDate
								ELSE PClient.RegisteredDate END) AS RegisteredDate  
                                FROM MD_ItemSpecificClientGroupPrice Price WITH (NOLOCK)
                                INNER JOIN PermittedCurrencies Currency WITH (NOLOCK) ON (Currency.Nr=Price.Firm AND Currency.CurrencyTypeId=Price.CurrencyTypeId)
                                INNER JOIN PermittedItems WITH (NOLOCK) ON (PermittedItems.Firm=Price.Firm AND PermittedItems.TigerItemId=Price.TigerItemId)
                                INNER JOIN PermittedClients PClient WITH (NOLOCK) ON (PClient.PriceGroupId=Price.ClientGroupId AND PClient.Firm=Price.Firm)                               
                                WHERE Price.BeginDate<=@currentDate AND Price.EndDate>=@currentDate  
                          UNION 
                                SELECT Price.TigerId, Price.Firm, Price.TigerItemId, Price.TigerItemUnitId,  Price.BeginDate, Price.EndDate,
                                Price.Price, Price.CurrencyTypeId, 115 AS PriceType, Price.ClientId AS PriceTypeId, Price.OperationMask, Price.VatIncluded,
                                (CASE WHEN (Price.RegisteredDate>=PermittedItems.RegisteredDate AND Price.RegisteredDate>=PClient.RegisteredDate) THEN Price.RegisteredDate
								WHEN (PermittedItems.RegisteredDate>=Price.RegisteredDate AND PermittedItems.RegisteredDate>=PClient.RegisteredDate) THEN PermittedItems.RegisteredDate
								ELSE PClient.RegisteredDate END) AS RegisteredDate  
                                FROM MD_ItemSpecificClientPrice Price WITH (NOLOCK)
                                INNER JOIN PermittedCurrencies Currency WITH (NOLOCK) ON (Currency.Nr=Price.Firm AND Currency.CurrencyTypeId=Price.CurrencyTypeId)
                                INNER JOIN PermittedItems WITH (NOLOCK) ON (PermittedItems.Firm=Price.Firm AND PermittedItems.TigerItemId=Price.TigerItemId)
                                INNER JOIN PermittedClients PClient WITH (NOLOCK) ON (PClient.ClientId=Price.ClientId AND PClient.Firm=Price.Firm)                               
                                WHERE Price.Status=0 AND Price.BeginDate<=@currentDate AND Price.EndDate>=@currentDate 
                          UNION 
								SELECT Price.Id As TigerId, Price.Firm, Price.ItemId, Price.ItemUnitId, '2019-01-01', '2030-01-01', Price.Price, Price.CurrencyTypeId, 
								200 AS PriceType, Price.ClientGroupId AS PriceTypeId, '1111100000', 0,
                                (CASE WHEN (Price.RegisteredDate>=PermittedItems.RegisteredDate AND Price.RegisteredDate>=PClient.RegisteredDate) THEN Price.RegisteredDate
								WHEN (PermittedItems.RegisteredDate>=Price.RegisteredDate AND PermittedItems.RegisteredDate>=PClient.RegisteredDate) THEN PermittedItems.RegisteredDate
								ELSE PClient.RegisteredDate END) AS RegisteredDate  
					            FROM MD_ItemSuggestedPrice Price WITH (NOLOCK)
					            INNER JOIN PermittedItems WITH (NOLOCK) ON (PermittedItems.Firm=Price.Firm AND PermittedItems.TigerItemId=Price.ItemId)                                
                                INNER JOIN PermittedClients PClient WITH (NOLOCK) ON (PClient.SuggestedPriceGroupId=Price.ClientGroupId AND PClient.Firm=Price.Firm)                               
					            
								)
GO
/****** Object:  UserDefinedFunction [dbo].[F_GetPermittedClientForUser]    Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[F_GetPermittedClientForUser](@userId int) 
Returns Table
AS
RETURN(
SELECT Firm, UserId, TigerClientId As ClientId
FROM MD_PermittedClient WITH (NOLOCK) WHERE UserId = @userId
UNION
SELECT CMapping.Firm, EMapping.UserId, CMapping.ClientId
FROM MD_SalesmanClientMapping CMapping WITH(NOLOCK)
INNER JOIN UIM_UserEmployeeMapping EMapping WITH(NOLOCK) ON (EMapping.EmployeeId=CMapping.SalesmanId AND EMapping.Firm=CMapping.Firm AND EMapping.UserId = @userId) 
)


GO
/****** Object:  UserDefinedFunction [dbo].[F_GetPermittedClientForUserWithRegisteredDate]    Script Date: 20.07.2019 16:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_GetPermittedClientForUserWithRegisteredDate](@userId int) 
Returns Table
AS
RETURN(
SELECT Firm, UserId, ClientId, MAX (RegisteredDate) As RegisteredDate, SUM(SyncFlag) AS SyncFlag
FROM
(
SELECT Firm, UserId, TigerClientId As ClientId, RegisteredDate, 1 As SyncFlag
FROM MD_PermittedClient WITH (NOLOCK) WHERE UserId = @userId
UNION
SELECT CMapping.Firm, EMapping.UserId, CMapping.ClientId, MAX ((CASE WHEN EMapping.CreatedDate>=CMapping.RegisteredDate THEN EMapping.CreatedDate ELSE CMapping.RegisteredDate END)) As RegisteredDate, 2 As SyncFlag
FROM MD_SalesmanClientMapping CMapping WITH(NOLOCK)
INNER JOIN UIM_UserEmployeeMapping EMapping WITH(NOLOCK) ON (EMapping.EmployeeId=CMapping.SalesmanId AND EMapping.Firm=CMapping.Firm AND EMapping.UserId = @userId)
GROUP BY CMapping.Firm, EMapping.UserId, CMapping.ClientId )AS T
GROUP BY T.Firm, UserId, ClientId
)
GO

CREATE SEQUENCE [dbo].[AuditSeq] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO

CREATE SEQUENCE [dbo].[GeneralSeq] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO

CREATE SEQUENCE [dbo].[InvoiceSeq] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO

CREATE SEQUENCE [dbo].[OrderSeq] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO

CREATE SEQUENCE [dbo].[RequestSeq] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO



