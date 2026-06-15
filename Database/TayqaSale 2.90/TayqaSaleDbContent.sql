USE [TayqaSale]

Declare @environment nvarchar(50)=''
Declare @firmNr smallint = 1
Declare @firmName nvarchar(255) = ''
Declare @downloadIp nvarchar(255) = '11.22.33.44:1111'
Declare @apkName nvarchar(255) = 'tayqasale-apk' 
Declare @logoIp nvarchar(255) = 'http://12.18.32.513:11101/'+@environment
Declare @syncIp nvarchar(255) = 'http://12.18.32.513:1110/'+@environment+'/v2.00'
Declare @activePeriod smallint = 1
Declare @clientCode nvarchar(MAX) = ''
Declare @licenseInfo nvarchar(MAX) = 'test license info'
Declare @licenseData nvarchar(MAX) = 'test license data'
Declare @licenseData2 nvarchar(255) = 'test license data 2'
Declare @defaultMethodPermissionId int = 67
Declare @migrationName nvarchar(255) = '20181016072529_Added_first_migration'
Declare @year smallint = 2018
Declare @uidIp nvarchar(255) = 'http://12.18.32.513:1102/tayqa/tiger/api/'+@environment+'/V4.20'

--************************** Sequences**********************

USE [NewTestDb]


SET IDENTITY_INSERT [dbo].[AbpEditions] ON 

INSERT [dbo].[AbpEditions] ([Id], [Name], [DisplayName], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [Discriminator], [AnnualPrice], [ExpiringEditionId], [MonthlyPrice], [TrialDayCount], [WaitingDayAfterExpire]) VALUES (1, N'Standard', N'Standard', 0, NULL, NULL, NULL, NULL, GetDate(), NULL, N'', NULL, NULL, NULL, NULL, NULL)

INSERT [dbo].[AbpEditions] ([Id], [Name], [DisplayName], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [Discriminator], [AnnualPrice], [ExpiringEditionId], [MonthlyPrice], [TrialDayCount], [WaitingDayAfterExpire]) VALUES (3, N'Standard', N'Standard', 0, NULL, NULL, NULL, NULL, GetDate(), NULL, N'SubscribableEdition', NULL, NULL, NULL, NULL, NULL)

SET IDENTITY_INSERT [dbo].[AbpEditions] OFF

SET IDENTITY_INSERT [dbo].[AbpTenants] ON 

INSERT [dbo].[AbpTenants] ([Id], [TenancyName], [Name], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [IsDeleted], [DeleterUserId], [DeletionTime], [EditionId], [ConnectionString], [CustomCssId], [LogoId], [LogoFileType], [IsInTrialPeriod], [SubscriptionEndDateUtc]) VALUES (1, N'Default', N'Default', NULL, NULL, GetDate(), NULL, 1, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, NULL)

SET IDENTITY_INSERT [dbo].[AbpTenants] OFF


SET IDENTITY_INSERT [dbo].[AbpRoles] ON 

INSERT [dbo].[AbpRoles] ([Id], [ConcurrencyStamp], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [IsDefault], [IsDeleted], [IsStatic], [LastModificationTime], [LastModifierUserId], [Name], [NormalizedName], [TenantId]) VALUES (1, N'bfb5aedb-393d-47c4-b678-d88ac21f06bc', GetDate(), NULL, NULL, NULL, N'Admin', 1, 0, 1, NULL, NULL, N'Admin', N'ADMIN', NULL)

INSERT [dbo].[AbpRoles] ([Id], [ConcurrencyStamp], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [IsDefault], [IsDeleted], [IsStatic], [LastModificationTime], [LastModifierUserId], [Name], [NormalizedName], [TenantId]) VALUES (2, N'6c0e4e31-153e-481e-bf49-5e5220957a0b', GetDate(), NULL, NULL, NULL, N'Admin', 0, 0, 1, NULL, NULL, N'Admin', N'ADMIN', 1)

INSERT [dbo].[AbpRoles] ([Id], [ConcurrencyStamp], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [IsDefault], [IsDeleted], [IsStatic], [LastModificationTime], [LastModifierUserId], [Name], [NormalizedName], [TenantId]) VALUES (3, N'f6e5ed67-565e-4517-a546-73d9ed570f19', GetDate(), NULL, NULL, NULL, N'User', 1, 0, 1, NULL, NULL, N'User', N'USER', 1)

SET IDENTITY_INSERT [dbo].[AbpRoles] OFF

SET IDENTITY_INSERT [dbo].[AbpUsers] ON 

INSERT [dbo].[AbpUsers] ([Id], [TenantId], [Name], [Surname], [UserName], [Password], [EmailAddress], [IsEmailConfirmed], [EmailConfirmationCode], [PasswordResetCode], [LastLoginTime], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [ShouldChangePasswordOnNextLogin], [ProfilePictureId], [AuthenticationSource], [LockoutEndDateUtc], [AccessFailedCount], [IsLockoutEnabled], [PhoneNumber], [IsPhoneNumberConfirmed], [SecurityStamp], [IsTwoFactorEnabled], [ConcurrencyStamp], [GoogleAuthenticatorKey], [NormalizedEmailAddress], [NormalizedUserName], [SignInToken], [SignInTokenExpireTimeUtc]) VALUES (1, NULL, N'admin', N'admin', N'admin', N'ABOSLExhA1dWtSCKQ5PUWdonoOdIK0H+RvLhPDUggwGkLn9bHLylFzEke0OtKhkM6A==', N'admin@aspnetzero.com', 1, NULL, NULL, GetDate(), 0, NULL, NULL, GetDate(), NULL, GetDate(), NULL, 1, 0, NULL, NULL, NULL, 0, 1, NULL, 0, N'071c6b47-06d4-0b5f-dc4f-39ddb7299278', 1, NULL, NULL, N'ADMIN@ASPNETZERO.COM', N'ADMIN', NULL, NULL)

INSERT [dbo].[AbpUsers] ([Id], [TenantId], [Name], [Surname], [UserName], [Password], [EmailAddress], [IsEmailConfirmed], [EmailConfirmationCode], [PasswordResetCode], [LastLoginTime], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [ShouldChangePasswordOnNextLogin], [ProfilePictureId], [AuthenticationSource], [LockoutEndDateUtc], [AccessFailedCount], [IsLockoutEnabled], [PhoneNumber], [IsPhoneNumberConfirmed], [SecurityStamp], [IsTwoFactorEnabled], [ConcurrencyStamp], [GoogleAuthenticatorKey], [NormalizedEmailAddress], [NormalizedUserName], [SignInToken], [SignInTokenExpireTimeUtc]) VALUES (2, 1, N'admin', N'admin', N'admin', N'AQAAAAEAACcQAAAAEDamYhbjh6V4ne9YAdJMuZ8s2NEowet15XT6w3U8E47x/eWovkUsuVCDGXm4VgzdzA==', N'admin@defaulttenant.com', 1, NULL, NULL, GetDate(), 0, NULL, NULL, GetDate(), NULL, GetDate(), NULL, 1, 0, NULL, NULL, NULL, 0, 1, NULL, 0, N'144654ab-f8d7-4231-b1ae-8701e2a2ca99', 1, N'052fe4ff-5e7a-43e3-a557-14c8cf7e3d71', NULL, N'ADMIN@DEFAULTTENANT.COM', N'ADMIN', NULL, NULL)

INSERT [dbo].[AbpUsers] ([Id], [TenantId], [Name], [Surname], [UserName], [Password], [EmailAddress], [IsEmailConfirmed], [EmailConfirmationCode], [PasswordResetCode], [LastLoginTime], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [IsActive], [ShouldChangePasswordOnNextLogin], [ProfilePictureId], [AuthenticationSource], [LockoutEndDateUtc], [AccessFailedCount], [IsLockoutEnabled], [PhoneNumber], [IsPhoneNumberConfirmed], [SecurityStamp], [IsTwoFactorEnabled], [ConcurrencyStamp], [GoogleAuthenticatorKey], [NormalizedEmailAddress], [NormalizedUserName], [SignInToken], [SignInTokenExpireTimeUtc]) VALUES (3, 1, N'Service', N'User', N'service_user', N'AQAAAAEAACcQAAAAELoXvfcuFdp14U4iGXuN23RHt6rSWv5RKTnXRY4CHhi4TrUvRjwEyovY/eIjtiNfKw==', N'support@tayqatech.com', 0, NULL, NULL, NULL, 0, NULL, NULL, GetDate(), 2, GetDate(), 2, 1, 0, NULL, NULL, NULL, 0, 1, N'', 0, N'5IAHMBSZSV5RXYWKTWSSF6ZHEQCOON4M', 0, N'2fb50942-701d-4843-b13f-5861bb020326', NULL, N'SUPPORT@TAYQATECH.COM', N'SERVICE_USER', NULL, NULL)

SET IDENTITY_INSERT [dbo].[AbpUsers] OFF

SET IDENTITY_INSERT [dbo].[AbpUserRoles] ON 

INSERT [dbo].[AbpUserRoles] ([Id], [UserId], [RoleId], [CreationTime], [CreatorUserId], [TenantId]) VALUES (1, 1, 1, GetDate(), NULL, NULL)

INSERT [dbo].[AbpUserRoles] ([Id], [UserId], [RoleId], [CreationTime], [CreatorUserId], [TenantId]) VALUES (2, 2, 2, GetDate(), NULL, 1)

INSERT [dbo].[AbpUserRoles] ([Id], [UserId], [RoleId], [CreationTime], [CreatorUserId], [TenantId]) VALUES (3, 3, 2, GetDate(), NULL, 1)

SET IDENTITY_INSERT [dbo].[AbpUserRoles] OFF

SET IDENTITY_INSERT [dbo].[AbpPermissions] ON 

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (1, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (2, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.CatalogGroups.Create', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (3, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.CatalogGroups', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (4, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Tenant.Dashboard', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (5, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.HangfireDashboard', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (6, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Host.Maintenance', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (7, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Tenant.SubscriptionManagement', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (8, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Tenant.Settings', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (9, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.OrganizationUnits.ManageMembers', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (10, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.OrganizationUnits.ManageOrganizationTree', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (11, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.OrganizationUnits', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (12, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.AuditLogs', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (13, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Languages.ChangeTexts', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (14, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Languages.Delete', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (15, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Catalogs', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (16, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Languages.Edit', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (17, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Languages', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (18, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Users.Impersonation', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (19, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Users.ChangePermissions', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (20, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Users.Delete', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (21, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Users.Edit', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (22, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Users.Create', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (23, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Users', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (24, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Roles.Delete', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (25, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Roles.Edit', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (26, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Roles.Create', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (27, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Roles', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (28, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (29, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.DemoUiComponents', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (30, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.Languages.Create', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (31, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Catalogs.Create', 1, 2, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (37, GetDate(), 2, N'RolePermissionSetting', 1, N'Pages.Mip', 1, 2, NULL)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (152, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.DeviceManagement', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (153, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.ItemManagement', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (154, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Clients.ClientData.ItemRestriction', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (155, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Clients.ClientData.ClientRoute', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (156, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Clients.ClientData', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (157, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Clients.BannedClients', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (158, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Clients', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (159, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Users.Tasks', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (160, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Users.SpecReturnLimit', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (161, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Users.SetPlanMethod', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (162, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Users.PlanConfig', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (163, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Users', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (164, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Tasks.Create', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (165, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Tasks', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (166, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement.Plans', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (167, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.AppUserManagement', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (168, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Reporting.SalesmanStats', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (169, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Reporting.SalesmanActions', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (170, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Reporting.PlanFact', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (171, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Reporting.Penetration', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (172, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Reporting.ExpeditorWorkFlow', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (173, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.Reporting', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (174, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Licensing', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (175, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.DeviceManagement.ChangeStatus', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (176, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.ItemManagement.ReturnLimits', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (177, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Mip.UserTracking', 1, NULL, 2)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (178, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages', 1, 2, 3)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (179, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration.AuditLogs', 1, 2, 3)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (180, GetDate(), NULL, N'RolePermissionSetting', 1, N'Pages.Administration', 1, 2, 3)

INSERT [dbo].[AbpPermissions] ([Id], [CreationTime], [CreatorUserId], [Discriminator], [IsGranted], [Name], [TenantId], [RoleId], [UserId]) VALUES (181, GetDate(), 2, N'UserPermissionSetting', 1, N'Pages.Licensing', 1, NULL, 3)

SET IDENTITY_INSERT [dbo].[AbpPermissions] OFF

SET IDENTITY_INSERT [dbo].[AbpSettings] ON 

INSERT [dbo].[AbpSettings] ([Id], [CreationTime], [CreatorUserId], [LastModificationTime], [LastModifierUserId], [Name], [TenantId], [UserId], [Value]) VALUES (1, GetDate(), NULL, NULL, NULL, N'Abp.Net.Mail.DefaultFromAddress', NULL, NULL, N'admin@mydomain.com')

INSERT [dbo].[AbpSettings] ([Id], [CreationTime], [CreatorUserId], [LastModificationTime], [LastModifierUserId], [Name], [TenantId], [UserId], [Value]) VALUES (2, GetDate(), NULL, NULL, NULL, N'Abp.Net.Mail.DefaultFromDisplayName', NULL, NULL, N'mydomain.com mailer')

INSERT [dbo].[AbpSettings] ([Id], [CreationTime], [CreatorUserId], [LastModificationTime], [LastModifierUserId], [Name], [TenantId], [UserId], [Value]) VALUES (3, GetDate(), NULL, NULL, NULL, N'Abp.Localization.DefaultLanguageName', NULL, NULL, N'en')

INSERT [dbo].[AbpSettings] ([Id], [CreationTime], [CreatorUserId], [LastModificationTime], [LastModifierUserId], [Name], [TenantId], [UserId], [Value]) VALUES (4, GetDate(), 2, NULL, NULL, N'Abp.Localization.DefaultLanguageName', 1, 2, N'az')

SET IDENTITY_INSERT [dbo].[AbpSettings] OFF

SET IDENTITY_INSERT [dbo].[AbpFeatures] ON 

INSERT [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (1, N'App.ChatFeature', N'True', GetDate(), NULL, 1, NULL, N'EditionFeatureSetting')

INSERT [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (2, N'App.ChatFeature.TenantToTenant', N'True', GetDate(), NULL, 1, NULL, N'EditionFeatureSetting')

INSERT [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (3, N'App.ChatFeature.TenantToHost', N'True', GetDate(), NULL, 1, NULL, N'EditionFeatureSetting')

INSERT [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (4, N'App.ChatFeature', N'True', GetDate(), NULL, 3, NULL, N'EditionFeatureSetting')

INSERT [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (5, N'App.ChatFeature.TenantToTenant', N'True', GetDate(), NULL, 3, NULL, N'EditionFeatureSetting')

INSERT [dbo].[AbpFeatures] ([Id], [Name], [Value], [CreationTime], [CreatorUserId], [EditionId], [TenantId], [Discriminator]) VALUES (6, N'App.ChatFeature.TenantToHost', N'True', GetDate(), NULL, 3, NULL, N'EditionFeatureSetting')

SET IDENTITY_INSERT [dbo].[AbpFeatures] OFF

INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (@migrationName, N'1.1.2')

SET IDENTITY_INSERT [dbo].[AbpLanguages] ON 

INSERT [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (1, GetDate(), NULL, NULL, NULL, N'English', N'famfamfam-flags gb', 0, 0, NULL, NULL, N'en', NULL)

INSERT [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (2, GetDate(), NULL, NULL, NULL, N'Azərbaycanca', N'famfamfam-flags az', 0, 0, NULL, NULL, N'az', NULL)

INSERT [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (3, GetDate(), NULL, NULL, NULL, N'Türkçe', N'famfamfam-flags tr', 0, 0, NULL, NULL, N'tr', NULL)

INSERT [dbo].[AbpLanguages] ([Id], [CreationTime], [CreatorUserId], [DeleterUserId], [DeletionTime], [DisplayName], [Icon], [IsDeleted], [IsDisabled], [LastModificationTime], [LastModifierUserId], [Name], [TenantId]) VALUES (4, GetDate(), NULL, NULL, NULL, N'Pусский', N'famfamfam-flags ru', 0, 0, NULL, NULL, N'ru', NULL)

SET IDENTITY_INSERT [dbo].[AbpLanguages] OFF

SET IDENTITY_INSERT [dbo].[AbpLanguageTexts] ON 

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (1, GetDate(), 2, N'AreYouSure', N'az', NULL, NULL, N'AbpWeb', 1, N'Əminsinizmi?')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (2, GetDate(), 2, N'Yes', N'az', NULL, NULL, N'AbpWeb', 1, N'Hə')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (3, GetDate(), 2, N'Cancel', N'az', NULL, NULL, N'AbpWeb', 1, N'İmtina')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (4, GetDate(), 2, N'DefaultError', N'az', NULL, NULL, N'AbpWeb', 1, N'Xəta baş verdi!')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (5, GetDate(), 2, N'ValidationError', N'az', NULL, NULL, N'AbpWeb', 1, N'Müraciətiniz xətalıdır!')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (6, GetDate(), 2, N'DefaultError404', N'az', NULL, NULL, N'AbpWeb', 1, N'Resurs tapılmadı!')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (7, GetDate(), 2, N'DefaultError403', N'az', NULL, 2, N'AbpWeb', 1, N'Sistemə daxil olmamısınız!')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (8, GetDate(), 2, N'DefaultErrorDetail403', N'az', NULL, 2, N'AbpWeb', 1, N'Bu əməliyyatı icra etməyə icazəniz yoxdur.')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (9, GetDate(), 2, N'DefaultErrorDetail404', N'az', NULL, NULL, N'AbpWeb', 1, N'Axtarılan resurs serverdə tapılmadı.')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (10, GetDate(), 2, N'EntityNotFound', N'az', NULL, NULL, N'AbpWeb', 1, N'id = {1} olan {0} element tapılmadı!')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (11, GetDate(), 2, N'InternalServerError', N'az', NULL, NULL, N'AbpWeb', 1, N'Sorğu icra edilərkən daxili xəta baş verdi!')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (12, GetDate(), 2, N'ValidationNarrativeTitle', N'az', NULL, NULL, N'AbpWeb', 1, N'Yoxlama zamanı aşağıdakı xətalar aşkarlandı.')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (13, GetDate(), 2, N'DefaultErrorDetail', N'az', NULL, NULL, N'AbpWeb', 1, N'Server tərəfindən xətanın təfərrüatları göndəriməmişdir.')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (14, GetDate(), 2, N'DefaultErrorDetail401', N'az', NULL, 2, N'AbpWeb', 1, N'Bu əməliyyatı həyata keçirmək üçün sistemə daxil olmalısınız.')

INSERT [dbo].[AbpLanguageTexts] ([Id], [CreationTime], [CreatorUserId], [Key], [LanguageName], [LastModificationTime], [LastModifierUserId], [Source], [TenantId], [Value]) VALUES (15, GetDate(), 2, N'DefaultError401', N'az', NULL, 2, N'AbpWeb', 1, N'Sistemə daxil olmamısınız!')

SET IDENTITY_INSERT [dbo].[AbpLanguageTexts] OFF

SET IDENTITY_INSERT [dbo].[AbpUserAccounts] ON 

INSERT [dbo].[AbpUserAccounts] ([Id], [TenantId], [UserId], [UserLinkId], [UserName], [EmailAddress], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [LastLoginTime]) VALUES (1, NULL, 1, NULL, N'admin', N'admin@aspnetzero.com', 0, NULL, NULL, GetDate(), NULL, GetDate(), NULL, GetDate())

INSERT [dbo].[AbpUserAccounts] ([Id], [TenantId], [UserId], [UserLinkId], [UserName], [EmailAddress], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [LastLoginTime]) VALUES (2, 1, 2, NULL, N'admin', N'admin@defaulttenant.com', 0, NULL, NULL, GetDate(), NULL, GetDate(), NULL, GetDate())

INSERT [dbo].[AbpUserAccounts] ([Id], [TenantId], [UserId], [UserLinkId], [UserName], [EmailAddress], [IsDeleted], [DeleterUserId], [DeletionTime], [LastModificationTime], [LastModifierUserId], [CreationTime], [CreatorUserId], [LastLoginTime]) VALUES (3, 1, 3, NULL, N'service_user', N'support@tayqatech.com', 0, NULL, NULL, GetDate(), 2, GetDate(), 2, NULL)

SET IDENTITY_INSERT [dbo].[AbpUserAccounts] OFF

SET IDENTITY_INSERT [dbo].[MD_Firm] ON 

INSERT [dbo].[MD_Firm] ([Id], [Status], [Nr], [Name], [RegisteredDate], [LocalCurrencyTypeId], [ExchangeCurrencyTypeId], [IsActive]) VALUES (1, 0, @firmNr, @firmName, GetDate(), 162, 1, 1)

SET IDENTITY_INSERT [dbo].[MD_Firm] OFF

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (1, 4, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (5, 6, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (6, 7, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (7, 8, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (8, 9, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (9, 10, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (10, 11, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (11, 12, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (12, 13, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (13, 14, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (14, 15, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (15, 16, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (16, 17, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (17, 18, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (18, 19, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (19, 20, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 1800, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (20, 23, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (21, 21, N'{"Firms":[{"Nr":' + Cast(@firmNr As Nvarchar) + ', "ActivePeriod":' + Cast(@activePeriod As Nvarchar) + '}]}', NULL, 300, 1, N'Ok', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (22, 22, N'{"Firms":[{"Nr":' + Cast(@firmNr As Nvarchar) + ', "ActivePeriod":' + Cast(@activePeriod As Nvarchar) + '}]}', NULL, 300, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (25, 5, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (27, 24, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (28, 25, N'', N'AuthToken', 2592000, 1, N'OK', NULL, GetDate(), N'{"authToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIzIiwidW5pcXVlX25hbWUiOiJlbG51ci5pIiwibmJmIjoxNTI2NDU4MjM5LCJleHAiOjE1NTc1NjIyMzksImlhdCI6MTUyNjQ1ODIzOSwiaXNzIjoid3d3LnRheXFhdGVjaC5jb20iLCJhdWQiOiJ3d3cudGF5cWF0ZWNoLmNvbSJ9.uzlwmoBEpS5P_dyRGV0hfpj3q4nvt5gfMvODuhGRO8I","message":"msgNewToken","date":1526458239}')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (30, 100, N'', NULL, 86400, 1, N'OK', NULL, GetDate(), N'{"resultCode":0,"resultDescription":"Ok"}')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (31, 31, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + '] }', NULL, 86400, 1, N'Forbidden', NULL, GetDate(), '')

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (32, 51, N'{"Firms":[{"Nr":' + Cast(@firmNr As Nvarchar) + ', "ActivePeriod":' + Cast(@activePeriod As Nvarchar) + '}]}', NULL, 300, 1, NULL, NULL, GetDate(), NULL)

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (33, 32, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, NULL, NULL, GetDate(), NULL)

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (34, 33, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, NULL, NULL, GetDate(), NULL)

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (35, 34, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, NULL, NULL, GetDate(), NULL)

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (36, 35, N'{"Firms": [' + Cast(@firmNr As Nvarchar) + ']}', NULL, 86400, 1, NULL, NULL, GetDate(), NULL)

INSERT [dbo].[OP_DataExchangeSchedule] ([Id], [DataExchangeMethodId], [Parameters], [ExtraInfo], [Period], [Status], [Note], [NextSyncTime], [LastExecutionTime], [ExtraNote]) VALUES (37, 36, N'{"Firms":[{"Nr":' + Cast(@firmNr As Nvarchar) + ', "ActivePeriod":' + Cast(@activePeriod As Nvarchar) + '}]}', NULL, 86400, 1, NULL, NULL, GetDate(), NULL)

SET IDENTITY_INSERT [dbo].[OP_DataExchangeStatus] ON 

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (1, GetDate(), 4, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (2, GetDate(), 5, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (3, GetDate(), 6, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (4, GetDate(), 7, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (5, GetDate(), 8, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (6, GetDate(), 9, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (7, GetDate(), 10, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (8, GetDate(), 11, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (9, GetDate(), 12, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (10, GetDate(), 13, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (11, GetDate(), 14, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (12, GetDate(), 15, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (13, GetDate(), 16, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (14, GetDate(), 17, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (15, GetDate(), 18, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (16, GetDate(), 19, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (17, GetDate(), 20, N'', GetDate(), 13, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (18, GetDate(), 21, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (19, GetDate(), 22, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (20, GetDate(), 23, N'', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (21, GetDate(), 24, NULL, GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (22, GetDate(), 26, N'paymentplan', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (23, GetDate(), 27, N'paymentplan', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (25, GetDate(), 100, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (27, GetDate(), 31, N'clientroute', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (28, GetDate(), 51, N'', GetDate(), 2, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (30, GetDate(), 32, N' sync bank', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (32, GetDate(), 33, N'refresh bank', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (34, GetDate(), 34, N'sync banc account', GetDate(), 579, 1, NULL, @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (35, GetDate(), 35, N'refresh bank account', GetDate(), 2, 1, N'Ok', @firmNr)

INSERT [dbo].[OP_DataExchangeStatus] ([Id], [LastSyncAt], [MethodId], [Note], [RegisteredAt], [RegisteredUserId], [Status], [ResponseStatus], [Firm]) VALUES (36, GetDate(), 36, N'sync client finance data', GetDate(), 2, 1, NULL, @firmNr)

SET IDENTITY_INSERT [dbo].[OP_DataExchangeStatus] OFF

SET IDENTITY_INSERT [dbo].[OP_PushSchedule] ON 

INSERT [dbo].[OP_PushSchedule] ([Id], [PushMethodId], [Period], [Status], [Note], [NextPushSendTime], [LastPushSendTime], [RegisteredUserId]) VALUES (1, 1, 30, 1, NULL, NULL, GetDate(), NULL)

INSERT [dbo].[OP_PushSchedule] ([Id], [PushMethodId], [Period], [Status], [Note], [NextPushSendTime], [LastPushSendTime], [RegisteredUserId]) VALUES (2, 2, 360, 1, NULL, NULL, GetDate(), NULL)

INSERT [dbo].[OP_PushSchedule] ([Id], [PushMethodId], [Period], [Status], [Note], [NextPushSendTime], [LastPushSendTime], [RegisteredUserId]) VALUES (3, 3, 360, 1, NULL, NULL, GetDate(), NULL)

SET IDENTITY_INSERT [dbo].[OP_PushSchedule] OFF

SET IDENTITY_INSERT [dbo].[SYS_AccountingPeriod] ON 

INSERT [dbo].[SYS_AccountingPeriod] ([Id], [CreatedDate], [CreatedUserId], [FirmNr], [ModifiedDate], [ModifiedUserId], [Period], [Year], [IsActive]) VALUES (1, GetDate(), 2, @firmNr, NULL, NULL, @activePeriod, @year, 1)

SET IDENTITY_INSERT [dbo].[SYS_AccountingPeriod] OFF

SET IDENTITY_INSERT [dbo].[SYS_AppConfigParameter] ON 

INSERT [dbo].[SYS_AppConfigParameter] ([Id], [Name], [Description], [Value], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (2, N'SyncTimeDefault', N'Random sync time from', N'21:00:00', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_AppConfigParameter] ([Id], [Name], [Description], [Value], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (3, N'SyncScheduleUntil', N'Random sync time until', N'07:00:00', 1, NULL, 2, NULL, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_AppConfigParameter] OFF

SET IDENTITY_INSERT [dbo].[SYS_ConfigObject] ON 

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (1, N'Specode', N'Special code', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (2, N'OptAffectCollatrl', N'Opt affect collatrl', 1, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (3, N'OperationStatus', N'Operation status', 1, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (4, N'DoReserve', N'Ammount do reserve', 1, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (5, N'FillAccode', N'Fill accounting code', 1, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (6, N'RetCostType', N'Return cost type', 1, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (7, N'TranGroupPrefix', N'Tran group prefix', 0, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (8, N'ShouldGroupPayments', N'Should group payments', 1, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (9, N'ExpenseCenter', N'Expense center', 1, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (10, N'DocTrackingNr', N'Document tracking number', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (11, N'GroupPaymentPrefix', N'Group payment prefix', 0, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (12, N'Firm', N'Firm', 1, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (13, N'MinimumOrderLimit', N'Minimum order limit ', 0, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (14, N'MaximumOrderLimit', N'Maximum order limit', 0, 0, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (15, N'MaxLineExpensePercent', N'Maximum line expense percent', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (16, N'MaxLineDiscountAmount', N'Maximum line discount amount', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (17, N'MaxTotalExpensePercent', N'Maximum total expense percent', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (18, N'MaxTotalDiscountAmount', N'Maximum total discount amount', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (19, N'ItemPriceEditUpperLimit', N'Item price edit upper limit', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (20, N'ItemPriceEditLowerLimit', N'Item price edit lower limit', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (21, N'MaxLineDiscountPercent', N'Maximum line discount percent', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (22, N'MaxTotalDiscountPercent', N'Maximum total discount percent', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (23, N'NegativeControl', N'Negative control check', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (24, N'Note', N'Note', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (25, N'DecimalQuantities', N'Decimal quantities', 0, 1, NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (26, N'DocNumber', N'Document number', 0, 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObject] ([Id], [Name], [Description], [ValueFromTable], [AppRelevant], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (27, N'AuthCode', N'Authentication code', 0, 1, NULL, 2, NULL, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_ConfigObject] OFF

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 1, 2, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 1, 4, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 1, 5, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 2, 2, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 2, 3, N'Truth', N'Gerçək', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 2, 5, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 3, 2, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 3, 3, N'Truth', N'Gerçək', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 3, 5, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 4, 2, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 4, 3, N'Truth', N'Gerçək', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 4, 5, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 5, 2, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 5, 3, N'Truth', N'Gerçək', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 5, 5, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 6, 2, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 6, 3, N'Truth', N'Gerçək', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 6, 5, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'0', 6, 8, N'No', N'No', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 1, 2, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 1, 3, N'Oneri', N'Önəri', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 1, 4, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 1, 5, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 2, 2, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 2, 3, N'Oneri', N'Önəri', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 2, 5, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 2, 6, N'CurrentCost', N'Current cost', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 3, 2, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 3, 3, N'Oneri', N'Önəri', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 3, 5, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 3, 6, N'CurrentCost', N'Current cost', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 4, 2, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 4, 3, N'Oneri', N'Önəri', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 4, 5, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 5, 2, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 5, 3, N'Oneri', N'Önəri', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 5, 5, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 6, 2, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 6, 3, N'Oneri', N'Önəri', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 6, 5, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'1', 6, 8, N'Yes', N'Yes', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', 1, 3, N'NoPortable', N'Daşınıla Bilməz', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', 2, 6, N'ReturnCost', N'Return cost', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'2', 3, 6, N'ReturnCost', N'Return cost', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', 2, 6, N'InputOutputCost', N'Input/output cost', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'3', 3, 6, N'InputOutputCost', N'Input/output cost', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_ConfigObjectValue] ([Value], [OperationId], [ObjectId], [TranslationObject], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (N'4', 1, 3, N'Portable', N'Daşınıla Bilər', NULL, 1, NULL, GetDate())


INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (4, N'SyncSalesMan', N'SalesMan', N'Sync SalesMan', N'POST', @syncIp + '/MasterData/SyncSalesMan', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (5, N'RefreshSalesMan', N'SalesMan', N'Refresh SalesMan', N'POST', @syncIp +'/MasterData/RefreshSalesMan', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (6, N'RefreshDivision', N'Division', N'Refresh Division', N'POST', @syncIp +'/MasterData/RefreshDivision', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (7, N'RefreshWareHouse', N'Warehouse', N'Refresh Warehouse', N'POST', @syncIp +'/MasterData/RefreshWarehouse', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (8, N'SyncExpenseCenter', N'ExpenseCenter', N'Sync Expense Center', N'POST', @syncIp +'/MasterData/SyncExpenseCenter', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (9, N'RefreshExpenseCenter', N'ExpenseCenter', N'Refresh Expense Center', N'POST', @syncIp +'/MasterData/RefreshExpenseCenter', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (10, N'RefreshFactory', N'Factory', N'Refresh Factory', N'POST', @syncIp +'/MasterData/RefreshFactory', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (11, N'RefreshCurrency', N'Currency', N'Refresh Currency', N'POST', @syncIp +'/MasterData/RefreshCurrency', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (12, N'SyncProject', N'Project', N'Sync Project', N'POST', @syncIp +'/MasterData/SyncProject', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (13, N'RefreshProject', N'Project', N'Refresh Project', N'POST', @syncIp +'/MasterData/RefreshProject', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (14, N'SyncCashCard', N'CashCard', N'Sync Cash Card', N'POST', @syncIp +'/MasterData/SyncCashCard', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (15, N'RefreshCashCard', N'CashCard', N'Refresh Cash Card', N'POST', @syncIp +'/MasterData/RefreshCashCard', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (16, N'SyncClient', N'Client', N'Sync Client', N'POST', @syncIp +'/MasterData/SyncClient', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (17, N'RefreshClient', N'Client', N'Refresh Client', N'POST', @syncIp +'/MasterData/RefreshClient', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (18, N'SyncItemAll', N'Item', N'Sync Item', N'POST', @syncIp +'/MasterData/SyncItemAll', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (19, N'RefreshItemAll', N'Item', N'Refresh Item', N'POST', @syncIp +'/MasterData/RefreshItemAll', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (20, N'RefreshPermittedClient', N'PermittedClient', N'Refresh Permitted Client', N'POST', @syncIp +'/MasterData/RefreshSlsClrel', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (21, N'RefreshItemStock', N'ItemStock', N'Refresh Item Stock', N'POST', @syncIp +'/MasterData/RefreshItemStock', 2, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (22, N'RefreshClientDebt', N'ClientDebt', N'Refresh Client Debt', N'POST', @syncIp +'/MasterData/RefreshClientDebt', 2, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (23, N'RefreshDepartment', N'Department', N'Refresh Department', N'POST', @syncIp +'/MasterData/RefreshDepartment', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (24, N'RefreshTradingGroup', N'TradingGroup', N'Refresh Trading Group', N'POST', @syncIp +'/MasterData/RefreshTradingGroup', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (25, N'RefreshAuthToken', N'AuthToken', N'Refhresh Auth Token', N'GET', @uidIp + '/uid/RefreshAuthToken', 5, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (26, N'SyncPaymentPlan', N'PaymentPlan', N'Sync Payment Plan', N'POST', @syncIp +'/MasterData/SyncPaymentPlan', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (27, N'RefreshPaymentPlan', N'PaymentPlan', N'Refresh Payment Plan', N'POST', @syncIp +'/MasterData/RefreshPaymentPlan', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (28, N'RefreshClientFinanceData', N'ClientFinanceData', N'Refresh Client Finance Data', N'POST', @syncIp +'/MasterData/RefreshClientFinance', 2, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (31, N'RefreshClientRoute', N'ClientRoute', N'Refresh Client Route', N'POST', @syncIp +'/MasterData/RefreshClientRoute', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (32, N'SyncBank', N'Bank', N'Sync Bank', N'POST', @syncIp +'/MasterData/SyncBank', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (33, N'RefreshBank', N'Bank', N'Refresh Bank', N'POST', @syncIp +'/MasterData/RefreshBank', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (34, N'SyncBankAccount', N'BankAccount', N'Sync Bank Account', N'POST', @syncIp +'/MasterData/SyncBankAccount', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (35, N'RefreshBankAccount', N'BankAccount', N'Refresh Bank Account', N'POST', @syncIp +'/MasterData/RefreshBankAccount', 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (36, N'SyncClientFinance', N'ClientFinanceData', N'Syn Client Finance data', N'POST', @syncIp +'/MasterData/SyncClientFinance', 2, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (51, N'RefreshOprFactDistributedByClient', N'OprFactDistributedByClient', N'Refresh Opr Fact Distributed Client', N'POST', @syncIp +'/MasterData/RefreshOprFactDistributedByClient', 2, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_DataExchangeMethod] ([Id], [Name], [Source], [Description], [ExtraInfo], [Url], [DataTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (100, N'ReconnectToLogo', N'ReconnectToLogo', N'Integration Reconnect To Logo', N'POST', @logoIp + '/Integration/ReconnectToLogo/', 3, 1, NULL, NULL, 1, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_DataOperationMapping] ON 

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (1, N'Division', N'1111111111', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (2, N'Department', N'1111111111', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (3, N'Warehouse', N'1111100000', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (4, N'TradingGroup', N'1111111111', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (5, N'Factory', N'1111100000', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (6, N'CashCard', N'0000011000', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (7, N'PaymentPlan', N'1111100000', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (8, N'Bank', N'0000000001', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (9, N'BankAccount', N'0000000001', GetDate())

INSERT [dbo].[SYS_DataOperationMapping] ([Id], [DataType], [OperationBitmask], [RegisteredDate]) VALUES (10, N'Currency', N'1111111111', GetDate())

SET IDENTITY_INSERT [dbo].[SYS_DataOperationMapping] OFF

SET IDENTITY_INSERT [dbo].[SYS_DataType] ON 

INSERT [dbo].[SYS_DataType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (1, N'MasterData', N'Master data', 1, GetDate())

INSERT [dbo].[SYS_DataType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (2, N'OperationalData', N'Operational data', 1, GetDate())

INSERT [dbo].[SYS_DataType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (3, N'Integration', N'Integration related operations', 1, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_DataType] OFF

SET IDENTITY_INSERT [dbo].[SYS_Language] ON 

INSERT [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (1, N'az', N'Azərbaycan dili', 1, 1, GetDate(), GetDate())

INSERT [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (2, N'tr', N'Türkçe', 1, 1, GetDate(), GetDate())

INSERT [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (3, N'en', N'English', 1, 1, GetDate(), GetDate())

INSERT [dbo].[SYS_Language] ([Id], [Language], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (4, N'ru', N'Русский', 1, 1, GetDate(), GetDate())

SET IDENTITY_INSERT [dbo].[SYS_Language] OFF

SET IDENTITY_INSERT [dbo].[SYS_LicenseInfo] ON 

INSERT [dbo].[SYS_LicenseInfo] ([Id], [Client], [Info], [Data], [Data2], [Type]) VALUES (1, @clientCode, @licenseInfo, @licenseData, @licenseData2, 0)

SET IDENTITY_INSERT [dbo].[SYS_LicenseInfo] OFF

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (1, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (2, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (3, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (4, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (5, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (6, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (7, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (8, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (9, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (10, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (11, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (12, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (13, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (14, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (15, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (16, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (17, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (18, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (19, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (20, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (21, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (22, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (23, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (24, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (25, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (26, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (27, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (28, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (29, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (30, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (31, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (32, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (33, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (34, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (35, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (36, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (37, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (38, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (39, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (40, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (41, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (42, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (43, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (44, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (45, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (46, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (47, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (48, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (49, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (50, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (51, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (52, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (53, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (54, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (55, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (56, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (61, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (62, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (81, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (82, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (83, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (100, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (101, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (102, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (103, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (104, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (105, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (106, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (107, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (108, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (109, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (110, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (111, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (112, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (113, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (114, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (115, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (116, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (117, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (118, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (119, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (121, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (122, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (123, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (124, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (125, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (126, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (127, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (200, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (201, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (202, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (203, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (204, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (205, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (206, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (207, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (208, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (209, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (210, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (211, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (212, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (213, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (214, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (215, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (300, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (301, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (302, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (401, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (402, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (403, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (404, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (405, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (406, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (407, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (501, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (502, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (503, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (504, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (505, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (506, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (507, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (508, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (509, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (510, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (511, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (512, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (513, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (601, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (602, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (603, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (604, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (605, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (606, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (607, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (701, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (702, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (751, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (752, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (753, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (801, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (802, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (851, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (870, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (871, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (872, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (873, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (900, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (901, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (902, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (930, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (931, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (932, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (933, @defaultMethodPermissionId, 1, NULL, GetDate())

INSERT [dbo].[SYS_MethodPermission] ([MethodId], [PermissionId], [PermissionValue], [Description], [CreatedDate]) VALUES (960, @defaultMethodPermissionId, 1, NULL, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_PlanMethod] ON 

INSERT [dbo].[SYS_PlanMethod] ([Id], [CreatedDate], [CreatedUserId], [IsActive], [ModifiedDate], [ModifiedUserId], [Name], [Type]) VALUES (1, GetDate(), 2, 1, NULL, NULL, N'UserBased', 1)

INSERT [dbo].[SYS_PlanMethod] ([Id], [CreatedDate], [CreatedUserId], [IsActive], [ModifiedDate], [ModifiedUserId], [Name], [Type]) VALUES (2, GetDate(), 2, 0, NULL, NULL, N'ClientBased', 2)

SET IDENTITY_INSERT [dbo].[SYS_PlanMethod] OFF

SET IDENTITY_INSERT [dbo].[SYS_PushMethod] ON 

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (1, N'GetItemStock', N'Gets item stock', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (2, N'GetClientDebt', N'Gets clients debt', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (3, N'GetAllMasterData', N'Gets all master data', NULL, NULL, 3, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (4, N'AppLogOut', N'Log out for app', NULL, NULL, NULL, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (5, N'Update 1.1.5', N'App update v 1.1.5', NULL, NULL, NULL, 2, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (6, N'Update 1.1.6', N'App update v 1.1.6', NULL, NULL, NULL, 2, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (8, N'GetUserGeneralSettings', N'Gets user general settings', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (13, N'GetReturnLimitData', N'GetReturnLimitData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (14, N'GetPlanData', N'GetPlanData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (15, N'SetGpsData', N'SetGpsData', NULL, NULL, 2, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (16, N'SetGpsCurrentLocation', N'SetGpsCurrentLocation', NULL, NULL, 2, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (17, N'GetItemUnitData', N'GetItemUnitData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (18, N'GetTradgrpData', N'GetTradgrpData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (19, N'GetFirmData', N'GetFirmData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (20, N'GetCurrencyData', N'GetCurrencyData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (21, N'GetDepartmentData', N'GetDepartmentData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (22, N'GetDivisionData', N'GetDivisionData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (23, N'GetExpenseCenterData', N'GetExpenseCenterData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (24, N'GetProjectCodeData', N'GetProjectCodeData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (25, N'GetFactoryData', N'GetFactoryData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (26, N'GetWarehouseData', N'GetWarehouseData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (27, N'GetCashCardData', N'GetCashCardData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (28, N'GetClientData', N'GetClientData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (29, N'ClientData', N'ClientData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (30, N'GetItemData', N'GetItemData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (31, N'ItemData', N'ItemData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (32, N'GetItemStandardPriceData', N'GetItemStandardPriceData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (33, N'GetItemBarcodeData', N'GetItemBarcodeData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (34, N'GetItemCatalogData', N'GetItemCatalogData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (35, N'GetSalesmanRefData', N'GetSalesmanRefData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (36, N'GetClientItemRestrictionData', N'GetClientItemRestrictionData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (37, N'GetClientRouteDatesData', N'GetClientRouteDatesData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (38, N'GetWarehouseGroupData', N'GetWarehouseGroupData', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (39, N'GetUserOperationHistoryData', N'GetUserOperationHistoryData', NULL, NULL, 2, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (40, N'GetAppConfig', N'GetAppConfig', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (41, N'GetAppTranslations', N'GetAppTranslations', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (42, N'GetServerTime', N'GetServerTime', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (43, N'GetTasks', N'Get tasks', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (44, N'GetUserConfigs', N'GetUserConfigs', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (45, N'GetUserPermissions', N'GetUserPermissions', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (46, N'Tasks', N'Task notification', NULL, NULL, 1, 3, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (47, N'UpdateLicense', N'Updates license data in device', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (48, N'ClearLicenseData', N'Clear license data in device', NULL, NULL, 1, 3, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (49, N'GetItemImages', N'Gets item images', NULL, NULL, 1, 1, 1, NULL, NULL, 2, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (50, N'UploadLogFiles', N'Upload app log files', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (51, N'RestoreOperations', N'Restore operations', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (52, N'CheckLicense', N'Check Liencese', NULL, NULL, 1, 1, 1, NULL, NULL, 1, GetDate())

INSERT [dbo].[SYS_PushMethod] ([Id], [Name], [Description], [ExtraInfo], [Url], [DataTypeId], [PushTypeId], [Status], [ModifiedUserId], [ModifiedDate], [CreatedUserId], [CreatedDate]) VALUES (53, N'Update 2.9.0', N'App update 2.9.0', NULL, @downloadIp + '/download/getappapk?apkname=' + @apkName, NULL, 2, 1, NULL, NULL, 1, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_PushMethod] OFF

SET IDENTITY_INSERT [dbo].[SYS_PushType] ON 

INSERT [dbo].[SYS_PushType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (1, N'CallMethod', N'Call method', 1, GetDate())

INSERT [dbo].[SYS_PushType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (2, N'Update', N'Update app', 1, GetDate())

INSERT [dbo].[SYS_PushType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (3, N'Info', N'Info message', 1, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_PushType] OFF

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (1, N'Order', N'Order', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (2, N'ReturnDispatch', N'Return dispatch', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (3, N'ReturnInvoice', N'Return invoice', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (4, N'SaleDispatch', N'Sale dispatch', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (5, N'SaleInvoice', N'Sale invoice', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (6, N'Cash', N'Cash', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (7, N'CashOut', N'Cash out', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (8, N'CheckPayment', N'Check payment', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (9, N'VoucherPayment', N'Voucher payment', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SetOperation] ([Id], [Name], [Description], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (10, N'CreditCardPayment', N'Credit card payment', NULL, 1, NULL, GetDate())

INSERT [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'LastChangeDate', GetDate())

INSERT [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'SyncExtraReportingData', GetDate())

INSERT [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'SyncMasterData', GetDate())

INSERT [dbo].[SYS_SyncTimeTable] ([Name], [Date]) VALUES (N'SyncOperationData', GetDate())

SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionStatus] ON 

INSERT [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (1, N'NotDone', N'Not done', GetDate())

INSERT [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (2, N'Ok', N'Ok', GetDate())

INSERT [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (3, N'Yes', N'Yes', GetDate())

INSERT [dbo].[SYS_TaskExecutionStatus] ([Id], [Name], [Description], [RegisteredDate]) VALUES (4, N'No', N'No', GetDate())

SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionStatus] OFF

SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionType] ON 

INSERT [dbo].[SYS_TaskExecutionType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (1, N'Important', N'Important', GetDate())

INSERT [dbo].[SYS_TaskExecutionType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (2, N'Routine', N'Routine', GetDate())

SET IDENTITY_INSERT [dbo].[SYS_TaskExecutionType] OFF

SET IDENTITY_INSERT [dbo].[SYS_TaskFormType] ON 

INSERT [dbo].[SYS_TaskFormType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (1, N'Ok', N'Only Ok button', GetDate())

INSERT [dbo].[SYS_TaskFormType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (2, N'YesNo', N'Yes and No buttons', GetDate())

SET IDENTITY_INSERT [dbo].[SYS_TaskFormType] OFF

SET IDENTITY_INSERT [dbo].[SYS_TaskType] ON 

INSERT [dbo].[SYS_TaskType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (1, N'General', N'General', GetDate())

INSERT [dbo].[SYS_TaskType] ([Id], [Name], [Description], [RegisteredDate]) VALUES (2, N'Special', N'Client special', GetDate())

SET IDENTITY_INSERT [dbo].[SYS_TaskType] OFF

SET IDENTITY_INSERT [dbo].[SYS_UserActionType] ON 

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (1, N'Order', N'Order', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (2, N'ReturnDispatch', N'Return Dispatch', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (3, N'ReturnInvoice', N'Return Invoice', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (4, N'SaleDispatch', N'Sale Dispatch', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (5, N'SaleInvoice', N'Sale Invoice', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (6, N'Cash', N'Cash', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (7, N'CashOut', N'CashOut', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (8, N'CheckPayment', N'Check payment', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (9, N'VoucherPayment', N'Voucher payment', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (10, N'CreditCardPayment', N'Credit card payment', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (11, N'Empty', N'Empty', 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (12, N'Empty', N'Empty', 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (13, N'Empty', N'Empty', 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (14, N'Empty', N'Empty', 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (15, N'Empty', N'Empty', 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (16, N'Empty', N'Empty', 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (17, N'Empty', NULL, 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (18, N'Empty', NULL, 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (19, N'Empty', NULL, 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (20, N'Empty', NULL, 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (21, N'Empty', NULL, 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (22, N'Empty', NULL, 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (23, N'Empty', NULL, 0, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (24, N'Delivery', N'Delivery', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (25, N'Standard Form', N'Standard form (blank)', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (26, N'Free survey', N'Free survey', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (27, N'Checklist', N'Checklist', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (28, N'Photo', N'Photo taking', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (29, N'Video', N'Video record', 1, GetDate())

INSERT [dbo].[SYS_UserActionType] ([Id], [Type], [Description], [Status], [CreatedDate]) VALUES (30, N'Visit', N'Visit', 1, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_UserActionType] OFF

SET IDENTITY_INSERT [dbo].[SYS_UserSettingObject] ON 

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (1, N'RouteRestriction', N'Route restriction', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (2, N'GpsRestriction', N'Gps restriction', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (3, N'GpsDistance', N'Gps distance', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (4, N'GpsLogEnabled', N'Flag for Gps log enabling', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (5, N'GpsLogSize', N'Gps log size', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (6, N'GpsLogSubmitPeriod', N'Gps log submit period', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (7, N'GpsLogFetchPeriod', N'Gps log fetch period', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (8, N'GpsLogStartTime', N'Gps log start time', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (9, N'GpsLogEndTime', N'Gps log end time', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (10, N'OperationsStartTime', N'Operations start time', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (11, N'OperationsEndTime', N'Operations end time', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (12, N'PlanDistributionType', N'Plan distribution type', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (13, N'ItemsSaleDaysCount', N'Items sale days count  for color changing in App', 1, NULL, 2, NULL, GetDate())

INSERT [dbo].[SYS_UserSettingObject] ([Id], [Name], [Description], [Status], [ModifiedUserId], [CreatedUserId], [ModifiedDate], [CreatedDate]) VALUES (14, N'MaxDiscounts', N'Max discounts', 1, NULL, 2, NULL, GetDate())

SET IDENTITY_INSERT [dbo].[SYS_UserSettingObject] OFF

SET IDENTITY_INSERT [dbo].[UIM_Permission] ON 

INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (1,NULL,'Cash','Cash', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (2,1,'Cash.CashCardCode','Cash cashcard code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (3,1,'Cash.Date','Cash time', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (4,1,'Cash.Department','Cash department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (5,1,'Cash.Division','Cash division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (6,1,'Cash.SpeCode','Cash special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (7,1,'Cash.Status','Cash status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (8,1,'Cash.TradingGroup','Cash trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (9,NULL,'Order','Order', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (10,9,'Order.Date','Order time', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (11,9,'Order.Department','Order department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (12,9,'Order.Division','Order division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (13,9,'Order.DocTrackingNr','Order document tracking number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (14,9,'Order.Factory','Order factory', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (15,9,'Order.OptAffectCollatrl','Order opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (16,9,'Order.SpeCode','Order special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (17,9,'Order.Status','Order status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (18,9,'Order.TradingGroup','Order trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (19,9,'Order.Warehouse','Order warehouse', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (20,NULL,'Report','Report', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (21,20,'Report.ClientExtension','Report client extension', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (22,20,'Report.SalesmanDebt','Report salesman debt', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (23,NULL,'ReturnDispatch','ReturnDispatch', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (24,23,'ReturnDispatch.Date','ReturnDispatch time', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (25,23,'ReturnDispatch.Department','ReturnDispatch department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (26,23,'ReturnDispatch.Division','ReturnDispatch division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (27,23,'ReturnDispatch.DocTrackingNr','ReturnDispatch document tracking number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (28,23,'ReturnDispatch.Factory','ReturnDispatch factory', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (29,23,'ReturnDispatch.OptAffectCollatrl','Return dispatch OptAffectCollatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (30,23,'ReturnDispatch.SpeCode','ReturnDispatch special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (31,23,'ReturnDispatch.Status','ReturnDispatch status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (32,23,'ReturnDispatch.TradingGroup','ReturnDispatch trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (33,23,'ReturnDispatch.Warehouse','ReturnDispatch warehouse', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (34,NULL,'ReturnInvoice','Return invoice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (35,34,'ReturnInvoice.Date','ReturnInvoice time', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (36,34,'ReturnInvoice.Department','ReturnInvoice department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (37,34,'ReturnInvoice.Division','ReturnInvoice division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (38,34,'ReturnInvoice.DocTrackingNr','ReturnInvoice document tracking number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (39,34,'ReturnInvoice.Factory','ReturnInvoice factory', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (40,34,'ReturnInvoice.OptAffectCollatrl','ReturnInvoice opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (41,34,'ReturnInvoice.SpeCode','ReturnInvoice special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (42,34,'ReturnInvoice.Status','ReturnInvoice status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (43,34,'ReturnInvoice.TradingGroup','ReturnInvoice trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (44,34,'ReturnInvoice.Warehouse','ReturnInvoice warehouse', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (45,NULL,'SaleDispatch','Sale dispatch', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (46,45,'SaleDispatch.Date','SaleDispatchInvoice time', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (47,45,'SaleDispatch.Department','SaleDispatch department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (48,45,'SaleDispatch.Division','SaleDispatch division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (49,45,'SaleDispatch.DocTrackingNr','SaleDispatch document tracking number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (50,45,'SaleDispatch.Factory','SaleDispatch factory', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (51,45,'SaleDispatch.OptAffectCollatrl','SaleDispatch opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (52,45,'SaleDispatch.SpeCode','SaleDispatch special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (53,45,'SaleDispatch.Status','SaleDispatch status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (54,45,'SaleDispatch.TradingGroup','SaleDispatch trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (55,45,'SaleDispatch.Warehouse','SaleDispatch warehouse', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (56,NULL,'SaleInvoice','Sale invoice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (57,56,'SaleInvoice.Date','SaleInvoice time', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (58,56,'SaleInvoice.Department','SaleInvoice department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (59,56,'SaleInvoice.Division','SaleInvoice division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (60,56,'SaleInvoice.DocTrackingNr','SaleInvoice document tracking number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (61,56,'SaleInvoice.Factory','SaleInvoice factory', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (62,56,'SaleInvoice.OptAffectCollatrl','SaleInvoice opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (63,56,'SaleInvoice.SpeCode','SaleInvoice special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (64,56,'SaleInvoice.Status','SaleInvoice status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (65,56,'SaleInvoice.TradingGroup','SaleInvoice trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (66,56,'SaleInvoice.Warehouse','SaleInvoice warehouse', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (67,NULL,'View','Menu/View in App', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (68,67,'View.Accounting','Acconuting menu', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (69,67,'View.GeneralExtension','General extension menu', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (70,67,'View.Sale','Sale menu', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (71,67,'View.Task','Task menu', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (79,NULL,'DownloadOverCellular','Download over cellular', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (80,79,'DownloadOverCellular.Images','Download item images over cellular', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (81,NULL,'Audit','Audit Operations', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (89,NULL,'Sync','Sync', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (90,89,'Sync.Operational','Sync.Operational', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (91,90,'Sync.Operational.ItemStocks','Sync.Operational.ItemStocks', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (92,90,'Sync.Operational.ClientDebitsCredits','Sync.Operational.ClientDebitsCredits', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (93,90,'Sync.Operational.ItemRestrictions','Sync.Operational.ItemRestrictions', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (94,89,'Sync.ClientData','Sync.ClientData', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (95,94,'Sync.ClientData.Clients','Sync.ClientData.Clients', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (96,94,'Sync.ClientData.RouteDates','Sync.ClientData.RouteDates', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (97,94,'Sync.ClientData.PenetrationClients','Sync.ClientData.PenetrationClients', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (98,94,'Sync.ClientData.CheckListClients','Sync.ClientData.CheckListClients', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (99,89,'Sync.ItemCards','Sync.ItemCards', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (100,99,'Sync.ItemCards.Items','Sync.ItemCards.Items', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (101,99,'Sync.ItemCards.ItemCatalogs','Sync.ItemCards.ItemCatalogs', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (102,99,'Sync.ItemCards.ItemUnits','Sync.ItemCards.ItemUnits', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (103,99,'Sync.ItemCards.ItemPrices','Sync.ItemCards.ItemPrices', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (104,99,'Sync.ItemCards.ItemBarcodes','Sync.ItemCards.ItemBarcodes', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (105,89,'Sync.OtherProperties','Sync.OtherProperties', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (106,105,'Sync.OtherProperties.Warehouses','Sync.OtherProperties.Warehouses', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (107,105,'Sync.OtherProperties.CashCards','Sync.OtherProperties.CashCards', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (108,105,'Sync.OtherProperties.TradingGroups','Sync.OtherProperties.TradingGroups', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (109,105,'Sync.OtherProperties.Firms','Sync.OtherProperties.Firms', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (110,105,'Sync.OtherProperties.Departments','Sync.OtherProperties.Departments', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (111,105,'Sync.OtherProperties.Divisions','Sync.OtherProperties.Divisions', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (112,105,'Sync.OtherProperties.Factories','Sync.OtherProperties.Factories', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (113,105,'Sync.OtherProperties.Currencies','Sync.OtherProperties.Currencies', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (114,89,'Sync.OtherOperations','Sync.OtherOperations', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (115,114,'Sync.OtherOperations.UpdateOperationStatus','Sync.OtherOperations.UpdateOperationStatus', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (116,114,'Sync.OtherOperations.DownloadImage','Sync.OtherOperations.DownloadImage', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (117,116,'Sync.OtherOperations.DownloadImage.OverCellular','Sync.OtherOperations.DownloadImage.OverCellular', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (118,NULL,'Reports','Reports', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (119,118,'Reports.General','Reports.General', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (120,119,'Reports.General.SalesmanDebt','Reports.General.SalesmanDebt', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (121,119,'Reports.General.SaleActions','Reports.General.SaleActions', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (122,119,'Reports.General.ItemStock','Reports.General.ItemStock', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (123,119,'Reports.General.ItemPrices','Reports.General.ItemPrices', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (124,118,'Reports.Client','Reports.Client', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (125,124,'Reports.Client.StatementsSpecial','Reports.Client.StatementsSpecial', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (126,124,'Reports.Client.Statements','Reports.Client.Statements', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (127,124,'Reports.Client.ItemCirculationFinalized','Reports.Client.ItemCirculationFinalized', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (128,124,'Reports.Client.TopSoldItems','Reports.Client.TopSoldItems', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (129,NULL,'Sale','Sale', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (130,NULL,'Statements','Statements', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (131,NULL,'Penetration','Penetration', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (132,NULL,'Tasks','Tasks', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (133,NULL,'Checklist','Checklist', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (134,9,'Order.ManualPromo','Order.ManualPromo', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (135,23,'ReturnDispatch.ManualPromo','ReturnDispatch.ManualPromo', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (136,34,'ReturnInvoice.ManualPromo','ReturnInvoice.ManualPromo', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (137,45,'SaleDispatch.ManualPromo','SaleDispatch.ManualPromo', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (138,56,'SaleInvoice.ManualPromo','SaleInvoice.ManualPromo', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (149,9,'Order.EditItemPrice','Order.EditItemPrice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (150,23,'ReturnDispatch.EditItemPrice','ReturnDispatch.EditItemPrice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (151,34,'ReturnInvoice.EditItemPrice','ReturnInvoice.EditItemPrice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (152,45,'SaleDispatch.EditItemPrice','SaleDispatch.EditItemPrice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (153,56,'SaleInvoice.EditItemPrice','SaleInvoice.EditItemPrice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (154,NULL,'Gps','Gps', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (159,NULL,'Print','Print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (160,159,'Print.Cash','Print.Cash', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (161,160,'Print.Cash.BeforeErp','Print.Cash.BeforeErp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (162,159,'Print.Order','Print.Order', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (163,162,'Print.Order.BeforeErp','Print.Order.BeforeErp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (164,159,'Print.ReturnDispatch','Print.ReturnDispatch', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (165,164,'Print.ReturnDispatch.BeforeErp','Print.ReturnDispatch.BeforeErp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (166,159,'Print.ReturnInvoice','Print.ReturnInvoice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (167,166,'Print.ReturnInvoice.BeforeErp','Print.ReturnInvoice.BeforeErp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (168,159,'Print.SaleDispatch','Print.SaleDispatch', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (169,168,'Print.SaleDispatch.BeforeErp','Print.SaleDispatch.BeforeErp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (170,159,'Print.SaleInvoice','Print.SaleInvoice', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (171,170,'Print.SaleInvoice.BeforeErp','Print.SaleInvoice.BeforeErp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (183,9,'Order.ManualLineExpensePercent','Order.ManualLineExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (184,23,'ReturnDispatch.ManualLineExpensePercent','ReturnDispatch.ManualLineExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (185,34,'ReturnInvoice.ManualLineExpensePercent','ReturnInvoice.ManualLineExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (186,45,'SaleDispatch.ManualLineExpensePercent','SaleDispatch.ManualLineExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (187,56,'SaleInvoice.ManualLineExpensePercent','SaleInvoice.ManualLineExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (188,9,'Order.ManualTotalExpensePercent','Order.ManualTotalExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (189,23,'ReturnDispatch.ManualTotalExpensePercent','ReturnDispatch.ManualTotalExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (190,34,'ReturnInvoice.ManualTotalExpensePercent','ReturnInvoice.ManualTotalExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (191,45,'SaleDispatch.ManualTotalExpensePercent','SaleDispatch.ManualTotalExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (192,56,'SaleInvoice.ManualTotalExpensePercent','SaleInvoice.ManualTotalExpensePercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (193,9,'Order.PaymentPlan','Order.PaymentPlan', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (194,23,'ReturnDispatch.PaymentPlan','ReturnDispatch.PaymentPlan', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (195,34,'ReturnInvoice.PaymentPlan','ReturnInvoice.PaymentPlan', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (196,45,'SaleDispatch.PaymentPlan','SaleDispatch.PaymentPlan', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (197,56,'SaleInvoice.PaymentPlan','SaleInvoice.PaymentPlan', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (198,9,'Order.ManualLineDiscountAmount','Order.ManualLineDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (199,9,'Order.ManualLineDiscountPercent','Order.ManualLineDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (200,9,'Order.ManualTotalDiscountAmount','Order.ManualTotalDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (201,9,'Order.ManualTotalDiscountPercent','Order.ManualTotalDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (202,23,'ReturnDispatch.ManualLineDiscountAmount','ReturnDispatch.ManualLineDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (203,23,'ReturnDispatch.ManualLineDiscountPercent','ReturnDispatch.ManualLineDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (204,23,'ReturnDispatch.ManualTotalDiscountAmount','ReturnDispatch.ManualTotalDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (205,23,'ReturnDispatch.ManualTotalDiscountPercent','ReturnDispatch.ManualTotalDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (206,34,'ReturnInvoice.ManualLineDiscountAmount','ReturnInvoice.ManualLineDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (207,34,'ReturnInvoice.ManualLineDiscountPercent','ReturnInvoice.ManualLineDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (208,34,'ReturnInvoice.ManualTotalDiscountAmount','ReturnInvoice.ManualTotalDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (209,34,'ReturnInvoice.ManualTotalDiscountPercent','ReturnInvoice.ManualTotalDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (210,45,'SaleDispatch.ManualLineDiscountAmount','SaleDispatch.ManualLineDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (211,45,'SaleDispatch.ManualLineDiscountPercent','SaleDispatch.ManualLineDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (212,45,'SaleDispatch.ManualTotalDiscountAmount','SaleDispatch.ManualTotalDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (213,45,'SaleDispatch.ManualTotalDiscountPercent','SaleDispatch.ManualTotalDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (214,56,'SaleInvoice.ManualLineDiscountAmount','SaleInvoice.ManualLineDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (215,56,'SaleInvoice.ManualLineDiscountPercent','SaleInvoice.ManualLineDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (216,56,'SaleInvoice.ManualTotalDiscountAmount','SaleInvoice.ManualTotalDiscountAmount', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (217,56,'SaleInvoice.ManualTotalDiscountPercent','SaleInvoice.ManualTotalDiscountPercent', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (218,9,'Order.Note','Order.Note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (219,23,'ReturnDispatch.Note','ReturnDispatch.Note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (220,34,'ReturnInvoice.Note','ReturnInvoice.Note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (221,45,'SaleDispatch.Note','SaleDispatch.Note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (222,56,'SaleInvoice.Note','SaleInvoice.Note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (223,1,'Cash.Note','Cash.Note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (225,9,'Order.DeliveryDate','Delivery date', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (226,NULL,'SendClientLocation','Send client location', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (228,NULL,'CashOut','Cash out', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (229,NULL,'CheckPayment','Check payment', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (230,NULL,'VoucherPayment','Voucher payment', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (231,NULL,'CreditCardPayment','Credit card payment', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (232,228,'CashOut.CashCardCode','Cash card code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (233,228,'CashOut.Date','Cash out time', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (234,228,'CashOut.Department','Cash out department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (235,228,'CashOut.Division','Cash out division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (236,228,'CashOut.SpeCode','Cash out special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (237,228,'CashOut.Status','Cash out status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (238,228,'CashOut.TradingGroup','Cash out trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (239,228,'CashOut.Note','Cash out note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (241,229,'CheckPayment.Date','Check payment date', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (242,229,'CheckPayment.Division','Check payment division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (243,229,'CheckPayment.Department','Check payment department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (244,229,'CheckPayment.TradingGroup','Check payment trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (246,229,'CheckPayment.SpeCode','Check payment special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (247,229,'CheckPayment.Note','Check payment note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (248,230,'VoucherPayment.Date','Voucher payment date', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (249,230,'VoucherPayment.Division','Voucher payment division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (250,230,'VoucherPayment.Department','Voucher payment department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (251,230,'VoucherPayment.TradingGroup','Voucher payment trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (252,230,'VoucherPayment.SpeCode','Voucher payment special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (253,230,'VoucherPayment.Note','Voucher payment note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (254,231,'CreditCardPayment.Status','Credit card payment status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (255,231,'CreditCardPayment.Division','Credit card payment division', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (256,231,'CreditCardPayment.Department','Credit card payment department', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (257,231,'CreditCardPayment.TradingGroup','Credit card payment trading group', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (258,231,'CreditCardPayment.SpeCode','Credit card payment special code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (259,231,'CreditCardPayment.Note','Credit card payment note', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (260,230,'VoucherPayment.Status','Voucher payment status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (261,229,'CheckPayment.Status','Check payment status', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (271,231,'CreditCardPayment.Date','Credit card payment date', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (273,231,'CreditCardPayment.PaymentPlan','Credit card payment payment plan', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (275,NULL,'Client','Client', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (276,275,'Client.Info','Client info general data', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (277,276,'Client.Info.GeneralData','Client info general data', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (278,276,'Client.Info.ContactData','Client info contact data', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (279,276,'Client.Info.FinanceData','Client info finance data', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (280,276,'Client.Info.RiskData','Client info risk data', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (281,275,'Client.Balance','Client info balance', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (282,275,'Client.Edino','Client info edino', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (283,275,'Client.Code','Client info code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (284,275,'Client.UploadShowCasePhoto','Client upload show case photo', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (285,275,'Client.ShowCasePhoto','Client show case photo', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (286,276,'Client.Info.MediaData','Client info media data', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (288,9,'Order.EditDocument','Order edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (289,9,'Order.GpsRestriction','Order Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (290,289,'Order.GpsRestriction.CreateEdit','Order Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (291,289,'Order.GpsRestriction.Edit','Order Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (292,9,'Order.Print','Order print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (293,9,'Order.Print.BeforeErp','Order print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (294,9,'Order.RouteRestriction','Order route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (296,294,'Order.RouteRestriction.CreateEdit','Order route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (298,154,'Gps.Operation','Gps operation', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (299,154,'Gps.Incorrectness','Gps incorrectness', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (301,154,'Gps.AppStart','Gps app start', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (302,45,'SaleDispatch.EditDocument','Sale dispatch edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (303,45,'SaleDispatch.GpsRestriction','Sale dispatch Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (304,303,'SaleDispatch.GpsRestriction.CreateEdit','Sale dispatch Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (305,303,'SaleDispatch.GpsRestriction.Edit','Sale dispatch Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (306,45,'SaleDispatch.Print','Sale dispatch print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (307,45,'SaleDispatch.Print.BeforeErp','Sale dispatch print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (308,45,'SaleDispatch.RouteRestriction','Sale dispatch route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (309,308,'SaleDispatch.RouteRestriction.CreateEdit','Sale dispatch route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (310,56,'SaleInvoice.EditDocument','Sale invoice edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (311,56,'SaleInvoice.GpsRestriction','Sale invoice Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (312,311,'SaleInvoice.GpsRestriction.CreateEdit','Sale invoice Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (313,311,'SaleInvoice.GpsRestriction.Edit','Sale invoice Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (314,56,'SaleInvoice.Print','Sale invoice print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (315,56,'SaleInvoice.Print.BeforeErp','Sale invoice print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (316,56,'SaleInvoice.RouteRestriction','Sale invoice route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (317,316,'SaleInvoice.RouteRestriction.CreateEdit','Sale invoice route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (318,23,'ReturnDispatch.EditDocument','Return dispatch edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (319,23,'ReturnDispatch.GpsRestriction','Return dispatch Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (320,319,'ReturnDispatch.GpsRestriction.CreateEdit','Return dispatch Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (321,319,'ReturnDispatch.GpsRestriction.Edit','Return dispatch Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (322,23,'ReturnDispatch.Print','Return dispatch print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (323,23,'ReturnDispatch.Print.BeforeErp','Return dispatch print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (324,23,'ReturnDispatch.RouteRestriction','Return dispatch route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (325,324,'ReturnDispatch.RouteRestriction.CreateEdit','Return dispatch route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (326,34,'ReturnInvoice.EditDocument','Return invoice edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (327,34,'ReturnInvoice.GpsRestriction','Return invoice Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (328,327,'ReturnInvoice.GpsRestriction.CreateEdit','Return invoice Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (329,327,'ReturnInvoice.GpsRestriction.Edit','Return invoice Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (330,34,'ReturnInvoice.Print','Return invoice print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (331,34,'ReturnInvoice.Print.BeforeErp','Return invoice print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (332,34,'ReturnInvoice.RouteRestriction','Return invoice route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (333,332,'ReturnInvoice.RouteRestriction.CreateEdit','Return invoice route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (334,1,'Cash.EditDocument','Cash edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (335,1,'Cash.GpsRestriction','Cash Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (336,335,'Cash.GpsRestriction.CreateEdit','Cash Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (337,335,'Cash.GpsRestriction.Edit','Cash Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (338,1,'Cash.Print','Cash print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (339,1,'Cash.Print.BeforeErp','Cash print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (340,1,'Cash.RouteRestriction','Cash route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (341,340,'Cash.RouteRestriction.CreateEdit','Cash route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (342,228,'CashOut.EditDocument','Cash out edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (343,228,'CashOut.GpsRestriction','Cash out Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (344,343,'CashOut.GpsRestriction.CreateEdit','Cash out Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (345,343,'CashOut.GpsRestriction.Edit','Cash out Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (346,228,'CashOut.Print','Cash out print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (347,228,'CashOut.Print.BeforeErp','Cash out print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (348,228,'CashOut.RouteRestriction','Cash out route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (349,348,'CashOut.RouteRestriction.CreateEdit','Cash out route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (350,229,'CheckPayment.EditDocument','Check payment edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (351,229,'CheckPayment.GpsRestriction','Check payment Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (352,351,'CheckPayment.GpsRestriction.CreateEdit','Check payment Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (353,351,'CheckPayment.GpsRestriction.Edit','Check payment Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (354,229,'CheckPayment.Print','Check payment print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (355,229,'CheckPayment.Print.BeforeErp','Check payment print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (356,229,'CheckPayment.RouteRestriction','Check payment route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (357,356,'CheckPayment.RouteRestriction.CreateEdit','Check payment route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (358,230,'VoucherPayment.EditDocument','Voucher payment edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (359,230,'VoucherPayment.GpsRestriction','Voucher payment Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (360,359,'VoucherPayment.GpsRestriction.CreateEdit','Voucher payment Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (361,359,'VoucherPayment.GpsRestriction.Edit','Voucher payment Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (362,230,'VoucherPayment.Print','Voucher payment print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (363,230,'VoucherPayment.Print.BeforeErp','Voucher payment print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (364,230,'VoucherPayment.RouteRestriction','Voucher payment route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (365,364,'VoucherPayment.RouteRestriction.CreateEdit','Voucher payment route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (366,231,'CreditCardPayment.EditDocument','Credit card payment edit document', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (367,231,'CreditCardPayment.GpsRestriction','Credit card payment Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (368,367,'CreditCardPayment.GpsRestriction.CreateEdit','Credit card payment Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (369,367,'CreditCardPayment.GpsRestriction.Edit','Credit card payment Gps restriction edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (370,231,'CreditCardPayment.Print','Credit card payment print', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (371,231,'CreditCardPayment.Print.BeforeErp','Credit card payment print before Erp', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (372,231,'CreditCardPayment.RouteRestriction','Credit card payment route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (373,372,'CreditCardPayment.RouteRestriction.CreateEdit','Credit card payment route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (374,NULL,'Visit','Visit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (376,374,'Visit.GpsRestriction','Visit Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (378,376,'Visit.GpsRestriction.CreateEdit','Visit Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (379,298,'Gps.Operation.CreateEdit','Gps operation create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (380,81,'Audit.GpsRestriction','Audit Gps restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (381,380,'Audit.GpsRestriction.CreateEdit','Audit Gps restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (382,81,'Audit.RouteRestriction','Audit route restriction', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (384,382,'Audit.RouteRestriction.CreateEdit','Audit route restriction create edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (385,275,'Client.Map','Client map', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (386,275,'Client.Navigation','Client navigation', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (387,298,'Gps.Operation.Edit','Gps operation edit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (388,230,'VoucherPayment.Giro','Voucher payment giro', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (389,230,'VoucherPayment.TaxNr','Voucher tax nr', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (390,229,'CheckPayment.Giro','Check payment giro', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (391,229,'CheckPayment.TaxNr','Check tax nr', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (392,229,'CheckPayment.PieceCount','Check payment piece count', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (393,229,'CheckPayment.DayCount','Check payment day count', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (394,229,'CheckPayment.DayOfMonth','Check payment day of month', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (395,9,'Order.SuggestedPrice','Order suggested price', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (396,56,'SaleInvoice.SuggestedPrice','Sale invoice suggested price', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (397,45,'SaleDispatch.SuggestedPrice','Sale dispatch suggested price', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (398,23,'ReturnDispatch.SuggestedPrice','Return dispatch suggested price', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (399,34,'ReturnInvoice.SuggestedPrice','Return invoice suggested price', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (400,9,'Order.DocNumber','Order document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (401,23,'ReturnDispatch.DocNumber','Return dispatch document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (402,45,'SaleDispatch.DocNumber','Sale dispatch document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (403,34,'ReturnInvoice.DocNumber','Return invoice document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (404,56,'SaleInvoice.DocNumber','Sale dispatch document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (405,1,'Cash.DocNumber','Cash document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (406,228,'CashOut.DocNumber','Cash out document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (407,229,'CheckPayment.DocNumber','Check payment document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (408,230,'VoucherPayment.DocNumber','Voucher payment document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (409,231,'CreditCardPayment.DocNumber','Credit card payment document number', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (410,1,'Cash.OptAffectCollatrl','Cash opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (411,228,'CashOut.OptAffectCollatrl','Cash out opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (412,229,'CheckPayment.OptAffectCollatrl','Check payment opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (413,230,'VoucherPayment.OptAffectCollatrl','Voucher payment opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (414,231,'CreditCardPayment.OptAffectCollatrl','Credit card payment opt affect collatrl', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (415,9,'Order.AuthCode','Order authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (416,23,'ReturnDispatch.AuthCode','Return dispatch authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (417,45,'SaleDispatch.AuthCode','Sale dispatch authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (418,34,'ReturnInvoice.AuthCode','Return invoice authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (419,56,'SaleInvoice.AuthCode','Sale dispatch authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (420,1,'Cash.AuthCode','Cash authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (421,228,'CashOut.AuthCode','Cash out authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (422,229,'CheckPayment.AuthCode','Check payment authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (423,230,'VoucherPayment.AuthCode','Voucher payment authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (424,231,'CreditCardPayment.AuthCode','Credit card payment authentication code', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (427,NULL,'Item','Item', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (428,427,'Item.Plan','Item.Plan', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (429,427,'Item.Limit','Item.Limit', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (430,427,'Item.Image','Item.Image', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (431,427,'Item.OperationHistory','Item.OperationHistory', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (433,119,'Reports.General.ItemOperationHistory','Reports.General.ItemOperationHistory', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (438,1,'Cash.Currency','Cash payment currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (439,9,'Order.Currency','Order currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (440,23,'ReturnDispatch.Currency','Return dispatch currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (441,34,'ReturnInvoice.Currency','Return invoice currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (442,45,'SaleDispatch.Currency','Sale dispatch currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (443,56,'SaleInvoice.Currency','Sale invoice currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (444,228,'CashOut.Currency','Cash expense currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (445,229,'CheckPayment.Currency','Check payment currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (446,230,'VoucherPayment.Currency','Voucher payment currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (447,231,'CreditCardPayment.Currency','Credit card payment currency', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (448,NULL,'Delivery','Delivery', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (498,289,'Order.GpsRestriction.IgnoreRouteOutside','Order gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (499,303,'SaleDispatch.GpsRestriction.IgnoreRouteOutside','Sale dispatch gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (500,311,'SaleInvoice.GpsRestriction.IgnoreRouteOutside','Sale invoice gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (501,319,'ReturnDispatch.GpsRestriction.IgnoreRouteOutside','Return dispatch gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (502,327,'ReturnInvoice.GpsRestriction.IgnoreRouteOutside','Return invoice gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (503,335,'Cash.GpsRestriction.IgnoreRouteOutside','Cash gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (504,343,'CashOut.GpsRestriction.IgnoreRouteOutside','Cash out gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (505,351,'CheckPayment.GpsRestriction.IgnoreRouteOutside','Check payment out gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (506,359,'VoucherPayment.GpsRestriction.IgnoreRouteOutside','Voucher payment out gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (507,367,'CreditCardPayment.GpsRestriction.IgnoreRouteOutside','Credit card payment out gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (508,376,'Visit.GpsRestriction.IgnoreRouteOutside','Visit card payment out gps restriction ignore route outside', 2, GetDate())
INSERT [dbo].[UIM_Permission] ([Id], [ParentId], [ObjectName], [Description], [CreatedUserId], [CreatedDate]) VALUES (509,380,'Audit.GpsRestriction.IgnoreRouteOutside','Audit card payment out gps restriction ignore route outside', 2, GetDate())

SET IDENTITY_INSERT [dbo].[UIM_Permission] OFF

INSERT [dbo].[UIM_PermissionValue] ([Value], [Description]) VALUES (0, N'No visible/disabled')

INSERT [dbo].[UIM_PermissionValue] ([Value], [Description]) VALUES (1, N'Modify/Click')

INSERT [dbo].[UIM_PermissionValue] ([Value], [Description]) VALUES (2, N'Read/Visible Only')

SET IDENTITY_INSERT [dbo].[UIM_UserType] ON 

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (1, 0, 0, NULL, N'App', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (2, 0, 0, NULL, N'Web', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (3, 1, 1, 1, N'SalePerson', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (4, 1, 1, 1, N'Audit', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (5, 1, 1, 2, N'TDP', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (6, 0, 1, 2, N'MİP', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (7, 1, 2, 6, N'General', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (8, 1, 2, 6, N'AppRelated', N'fa fa-user')

INSERT [dbo].[UIM_UserType] ([Id], [CanSelect], [Level], [ParentId], [Type], [Icon]) VALUES (9, 0, 0, NULL, N'Hybrid', N'fa fa-user')

SET IDENTITY_INSERT [dbo].[UIM_UserType] OFF

SET IDENTITY_INSERT [dbo].[UIM_UserTypeUserMapping] ON 

INSERT [dbo].[UIM_UserTypeUserMapping] ([Id], [UserId], [UserTypeId]) VALUES (1, 1, 5)

INSERT [dbo].[UIM_UserTypeUserMapping] ([Id], [UserId], [UserTypeId]) VALUES (2, 2, 5)

INSERT [dbo].[UIM_UserTypeUserMapping] ([Id], [UserId], [UserTypeId]) VALUES (3, 3, 5)

SET IDENTITY_INSERT [dbo].[UIM_UserTypeUserMapping] OFF


SET IDENTITY_INSERT [dbo].[UIM_FaqCategory] ON 
GO
INSERT [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (1, N'TDP', CAST(N'2018-12-27T19:15:10.1530000' AS DateTime2))
GO
INSERT [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (2, N'MIP', CAST(N'2018-12-28T00:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (3, N'Delivery Management', CAST(N'2018-12-28T13:21:40.8530000' AS DateTime2))
GO
INSERT [dbo].[UIM_FaqCategory] ([Id], [Name], [CreationTime]) VALUES (4, N'CheckList', CAST(N'2018-12-28T13:21:48.3100000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[UIM_FaqCategory] OFF


GO
INSERT [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (1, N'Price Group')
GO
INSERT [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (2, N'Warehouse Group')
GO
INSERT [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (3, N'Catalog Group')
GO
INSERT [dbo].[DF_ClientGroupType] ([Type], [Name]) VALUES (4, N'Suggested Price Group')
GO
