USE [TayqaSale]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpAuditLogs]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpAuditLogs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BrowserInfo] [nvarchar](256) NULL,
	[ClientIpAddress] [nvarchar](64) NULL,
	[ClientName] [nvarchar](128) NULL,
	[CustomData] [nvarchar](2000) NULL,
	[Exception] [nvarchar](2000) NULL,
	[ExecutionDuration] [int] NOT NULL,
	[ExecutionTime] [datetime2](7) NOT NULL,
	[ImpersonatorTenantId] [int] NULL,
	[ImpersonatorUserId] [bigint] NULL,
	[MethodName] [nvarchar](256) NULL,
	[Parameters] [nvarchar](1024) NULL,
	[ServiceName] [nvarchar](256) NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_AbpAuditLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpBackgroundJobs]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpBackgroundJobs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[IsAbandoned] [bit] NOT NULL,
	[JobArgs] [nvarchar](max) NOT NULL,
	[JobType] [nvarchar](512) NOT NULL,
	[LastTryTime] [datetime2](7) NULL,
	[NextTryTime] [datetime2](7) NOT NULL,
	[Priority] [tinyint] NOT NULL,
	[TryCount] [smallint] NOT NULL,
 CONSTRAINT [PK_AbpBackgroundJobs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpEditions]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpEditions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[DisplayName] [nvarchar](64) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[AnnualPrice] [decimal](18, 2) NULL,
	[ExpiringEditionId] [int] NULL,
	[MonthlyPrice] [decimal](18, 2) NULL,
	[TrialDayCount] [int] NULL,
	[WaitingDayAfterExpire] [int] NULL,
 CONSTRAINT [PK_AbpEditions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpFeatures]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpFeatures](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](2000) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[EditionId] [int] NULL,
	[TenantId] [int] NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_AbpFeatures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpLanguages]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpLanguages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[DisplayName] [nvarchar](64) NOT NULL,
	[Icon] [nvarchar](128) NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[Name] [nvarchar](10) NOT NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpLanguages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpLanguageTexts]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpLanguageTexts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[Key] [nvarchar](256) NOT NULL,
	[LanguageName] [nvarchar](10) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[Source] [nvarchar](128) NOT NULL,
	[TenantId] [int] NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_AbpLanguageTexts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpNotifications]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpNotifications](
	[Id] [uniqueidentifier] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[Data] [nvarchar](max) NULL,
	[DataTypeName] [nvarchar](512) NULL,
	[EntityId] [nvarchar](96) NULL,
	[EntityTypeAssemblyQualifiedName] [nvarchar](512) NULL,
	[EntityTypeName] [nvarchar](250) NULL,
	[ExcludedUserIds] [nvarchar](max) NULL,
	[NotificationName] [nvarchar](96) NOT NULL,
	[Severity] [tinyint] NOT NULL,
	[TenantIds] [nvarchar](max) NULL,
	[UserIds] [nvarchar](max) NULL,
 CONSTRAINT [PK_AbpNotifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpNotificationSubscriptions]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpNotificationSubscriptions](
	[Id] [uniqueidentifier] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[EntityId] [nvarchar](96) NULL,
	[EntityTypeAssemblyQualifiedName] [nvarchar](512) NULL,
	[EntityTypeName] [nvarchar](250) NULL,
	[NotificationName] [nvarchar](96) NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NOT NULL,
 CONSTRAINT [PK_AbpNotificationSubscriptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpOrganizationUnits]    Script Date: 15.01.2019 11:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpOrganizationUnits](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](95) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[DisplayName] [nvarchar](128) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[ParentId] [bigint] NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpOrganizationUnits] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpPermissions]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpPermissions](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[IsGranted] [bit] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[TenantId] [int] NULL,
	[RoleId] [int] NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_AbpPermissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpPersistedGrants]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpPersistedGrants](
	[Id] [nvarchar](200) NOT NULL,
	[ClientId] [nvarchar](200) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[Data] [nvarchar](max) NOT NULL,
	[Expiration] [datetime2](7) NULL,
	[SubjectId] [nvarchar](200) NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AbpPersistedGrants] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpRoleClaims]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpRoleClaims](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ClaimType] [nvarchar](450) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[RoleId] [int] NOT NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpRoles]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[DisplayName] [nvarchar](64) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsStatic] [bit] NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[Name] [nvarchar](32) NOT NULL,
	[NormalizedName] [nvarchar](32) NOT NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpSettings]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpSettings](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[Name] [nvarchar](256) NOT NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NULL,
	[Value] [nvarchar](2000) NULL,
 CONSTRAINT [PK_AbpSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpTenantNotifications]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpTenantNotifications](
	[Id] [uniqueidentifier] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[Data] [nvarchar](max) NULL,
	[DataTypeName] [nvarchar](512) NULL,
	[EntityId] [nvarchar](96) NULL,
	[EntityTypeAssemblyQualifiedName] [nvarchar](512) NULL,
	[EntityTypeName] [nvarchar](250) NULL,
	[NotificationName] [nvarchar](96) NOT NULL,
	[Severity] [tinyint] NOT NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpTenantNotifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpTenants]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpTenants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenancyName] [nvarchar](64) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[EditionId] [int] NULL,
	[ConnectionString] [nvarchar](1024) NULL,
	[CustomCssId] [uniqueidentifier] NULL,
	[LogoId] [uniqueidentifier] NULL,
	[LogoFileType] [nvarchar](64) NULL,
	[IsInTrialPeriod] [bit] NOT NULL,
	[SubscriptionEndDateUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_AbpTenants] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserAccounts]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserAccounts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NOT NULL,
	[UserLinkId] [bigint] NULL,
	[UserName] [nvarchar](450) NULL,
	[EmailAddress] [nvarchar](450) NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastLoginTime] [datetime2](7) NULL,
 CONSTRAINT [PK_AbpUserAccounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserClaims]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserClaims](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NOT NULL,
	[ClaimType] [nvarchar](450) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
 CONSTRAINT [PK_AbpUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserLoginAttempts]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserLoginAttempts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NULL,
	[TenancyName] [nvarchar](64) NULL,
	[UserId] [bigint] NULL,
	[UserNameOrEmailAddress] [nvarchar](255) NULL,
	[ClientIpAddress] [nvarchar](64) NULL,
	[ClientName] [nvarchar](128) NULL,
	[BrowserInfo] [nvarchar](256) NULL,
	[Result] [tinyint] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_AbpUserLoginAttempts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserLogins]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserLogins](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](256) NOT NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpUserLogins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserNotifications]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserNotifications](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[TenantNotificationId] [uniqueidentifier] NOT NULL,
	[State] [int] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpUserNotifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserOrganizationUnits]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserOrganizationUnits](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[OrganizationUnitId] [bigint] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[TenantId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AbpUserOrganizationUnits] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserRoles]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserRoles](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AbpUserRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUsers]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUsers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NULL,
	[Name] [nvarchar](32) NOT NULL,
	[Surname] [nvarchar](32) NOT NULL,
	[UserName] [nvarchar](32) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[EmailAddress] [nvarchar](256) NOT NULL,
	[IsEmailConfirmed] [bit] NOT NULL,
	[EmailConfirmationCode] [nvarchar](328) NULL,
	[PasswordResetCode] [nvarchar](328) NULL,
	[LastLoginTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[ShouldChangePasswordOnNextLogin] [bit] NOT NULL,
	[ProfilePictureId] [uniqueidentifier] NULL,
	[AuthenticationSource] [nvarchar](64) NULL,
	[LockoutEndDateUtc] [datetime2](7) NULL,
	[AccessFailedCount] [int] NOT NULL,
	[IsLockoutEnabled] [bit] NOT NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[IsPhoneNumberConfirmed] [bit] NOT NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[IsTwoFactorEnabled] [bit] NOT NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[GoogleAuthenticatorKey] [nvarchar](max) NULL,
	[NormalizedEmailAddress] [nvarchar](256) NOT NULL,
	[NormalizedUserName] [nvarchar](32) NOT NULL,
	[SignInToken] [nvarchar](max) NULL,
	[SignInTokenExpireTimeUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_AbpUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbpUserTokens]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbpUserTokens](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[LoginProvider] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AbpUserTokens] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppBinaryObjects]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppBinaryObjects](
	[Id] [uniqueidentifier] NOT NULL,
	[Bytes] [varbinary](max) NOT NULL,
	[TenantId] [int] NULL,
 CONSTRAINT [PK_AppBinaryObjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppChatMessages]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppChatMessages](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[ReadState] [int] NOT NULL,
	[Side] [int] NOT NULL,
	[TargetTenantId] [int] NULL,
	[TargetUserId] [bigint] NOT NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NOT NULL,
 CONSTRAINT [PK_AppChatMessages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppFriendships]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppFriendships](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[FriendProfilePictureId] [uniqueidentifier] NULL,
	[FriendTenancyName] [nvarchar](max) NULL,
	[FriendTenantId] [int] NULL,
	[FriendUserId] [bigint] NOT NULL,
	[FriendUserName] [nvarchar](32) NOT NULL,
	[State] [int] NOT NULL,
	[TenantId] [int] NULL,
	[UserId] [bigint] NOT NULL,
 CONSTRAINT [PK_AppFriendships] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppSubscriptionPayments]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppSubscriptionPayments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[DayCount] [int] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[EditionId] [int] NOT NULL,
	[Gateway] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[LastModifierUserId] [bigint] NULL,
	[PaymentId] [nvarchar](450) NULL,
	[PaymentPeriodType] [int] NULL,
	[Status] [int] NOT NULL,
	[TenantId] [int] NOT NULL,
 CONSTRAINT [PK_AppSubscriptionPayments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MC_ClientMediaInfo]    Script Date: 15.01.2019 11:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MC_ClientMediaInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[Url] [nvarchar](500) NULL,
	[Version] [nvarchar](50) NULL,
	[ContentType] [smallint] NULL,
	[Status] [bit] NULL,
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL,
	[PublishedDate] [datetime] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MC_ClientMediaInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_AuditCatalog]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_AuditCatalog](
	[Id] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[CatalogGroupId] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Specode] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_AuditCatalogGroup]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_AuditCatalogGroup](
	[Id] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[RegisteredDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_AuditCatalogItemMapping]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_AuditCatalogItemMapping](
	[CatalogId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[AvaliableFlag] [bit] NOT NULL,
	[PriceFlag] [bit] NOT NULL,
	[StockFlag] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_AuditPermitedCatalog]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_AuditPermitedCatalog](
	[UserId] [int] NOT NULL,
	[CatalogId] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Bank]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Bank](
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Branch] [nvarchar](100) NULL,
	[Specode] [nvarchar](100) NULL,
	[BranchNo] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[AddressExtension] [nvarchar](100) NULL,
	[Postcode] [nvarchar](50) NULL,
	[Telephone] [nvarchar](50) NULL,
	[FaxNo] [nvarchar](50) NULL,
	[Incharge] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[WebAddress] [nvarchar](50) NULL,
	[CorporateAccount] [nvarchar](50) NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MD_Bank] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_BankAccount]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_BankAccount](
	[Firm] [smallint] NOT NULL,
	[BankTigerId] [int] NOT NULL,
	[TigerId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[Type] [smallint] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Specode] [nvarchar](50) NULL,
	[CurrencyType] [smallint] NOT NULL,
	[AccountNo] [nvarchar](100) NULL,
	[Iban] [nvarchar](100) NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MD_BankAccount] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[BankTigerId] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_BannedClient]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_BannedClient](
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[CreatedUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_MD_BannedClient] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_BannedClientLog]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_BannedClientLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Action] [tinyint] NOT NULL,
	[OldStatus] [bit] NULL,
	[NewStatus] [bit] NOT NULL,
	[Note] [nvarchar](255) NULL,
	[CreatedUserId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_BannedClientLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_CashCard]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_CashCard](
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_CashCard] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Catalog]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Catalog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[CatalogGroupId] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Specode] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_Catalog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_CatalogCompetingItemMapping]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_CatalogCompetingItemMapping](
	[CatalogId] [int] NOT NULL,
	[CompetingItemId] [int] NOT NULL,
	[CanSell] [bit] NOT NULL,
	[CanReturn] [bit] NOT NULL,
	[IsSpecial] [bit] NOT NULL,
	[IsOffered] [bit] NOT NULL,
	[Mastock] [bit] NOT NULL,
	[ForAudit] [bit] NOT NULL,
	[MinStock] [int] NOT NULL,
 CONSTRAINT [PK_MD_CatalogCompetingItemMapping] PRIMARY KEY CLUSTERED 
(
	[CatalogId] ASC,
	[CompetingItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_CatalogGroup]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_CatalogGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_CatalogGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_CatalogItemMapping]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_CatalogItemMapping](
	[CatalogId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[CanSell] [bit] NOT NULL,
	[CanReturn] [bit] NOT NULL,
	[IsSpecial] [bit] NOT NULL,
	[IsOffered] [bit] NOT NULL,
	[Mastock] [bit] NOT NULL,
	[MinStock] [int] NOT NULL,
	[ForAudit] [bit] NULL,
	[CanPromote] [bit] NULL,
	[IsDecimal] [bit] NULL,
 CONSTRAINT [PK_MD_CatalogItemMapping] PRIMARY KEY CLUSTERED 
(
	[CatalogId] ASC,
	[TigerItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Client]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Client](
	[Status] [bit] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[CardType] [tinyint] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](400) NOT NULL,
	[AddressExtension] [nvarchar](400) NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Town] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[Telephone] [nvarchar](50) NULL,
	[Taxno] [nvarchar](50) NULL,
	[TradingGroupCode] [nvarchar](50) NULL,
	[Edino] [nvarchar](50) NULL,
	[InCharge] [nvarchar](50) NULL,
	[SpecialCode] [nvarchar](50) NULL,
	[SpecialCodeDesc] [nvarchar](50) NULL,
	[SpecialCode2] [nvarchar](50) NULL,
	[SpecialCode2Desc] [nvarchar](50) NULL,
	[SpecialCode3] [nvarchar](50) NULL,
	[SpecialCode3Desc] [nvarchar](50) NULL,
	[SpecialCode4] [nvarchar](50) NULL,
	[SpecialCode4Desc] [nvarchar](50) NULL,
	[SpecialCode5] [nvarchar](50) NULL,
	[SpecialCode5Desc] [nvarchar](50) NULL,
	[AuthorizationCode] [nvarchar](50) NULL,
	[AuthorizationCodeDesc] [nvarchar](50) NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[TigerParentId] [int] NULL,
	[IsDeleted] [bit] NULL,
	[IdentityNo] [nvarchar](50) NULL,
	[PaymentPlanId] [int] NULL,
	[SyncFlag] [bit] NULL,
 CONSTRAINT [PK_MD_Client] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ClientFinanceData]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ClientFinanceData](
	[TigerId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[AccumulatedRiskLimit] [float] NOT NULL,
	[SelfCheckVoucherRiskLimit] [float] NOT NULL,
	[ClientCheckVoucherRiskLimit] [float] NOT NULL,
	[CheckVoucherCirculationRiskLimit] [float] NOT NULL,
	[DispatchRiskLimit] [float] NOT NULL,
	[DispatchProposalRiskLimit] [float] NOT NULL,
	[OrderRiskLimit] [float] NOT NULL,
	[OrderProposalRiskLimit] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[TotalRisk] [float] NULL,
	[ClosedRisk] [float] NULL,
 CONSTRAINT [PK_MD_ClientFinanceData_1] PRIMARY KEY CLUSTERED 
(
	[TigerId] ASC,
	[Firm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ClientGpsData]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ClientGpsData](
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[Note] [nvarchar](400) NULL,
	[CreatedUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_MD_ClientGpsData] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ClientGroupData]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ClientGroupData](
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[GroupType] [smallint] NOT NULL,
	[GroupId] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_ClientGroupData] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[ClientId] ASC,
	[GroupType] ASC,
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ClientItemRestriction]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ClientItemRestriction](
	[Firm] [smallint] NOT NULL,
	[TigerClientId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[Min] [float] NOT NULL,
	[Max] [float] NOT NULL,
	[Status] [bit] NOT NULL,
	[IsForbidden] [bit] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_MD_ClientItemRestriction] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerClientId] ASC,
	[TigerItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ClientItemRestrictionLog]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ClientItemRestrictionLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[TigerClientId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[Min] [float] NOT NULL,
	[Max] [float] NOT NULL,
	[Status] [bit] NOT NULL,
	[IsForbidden] [bit] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[Action] [tinyint] NOT NULL,
	[Note] [nvarchar](255) NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_MD_ClientItemRestrictionLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ClientWarehouseRestriction]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ClientWarehouseRestriction](
	[Firm] [smallint] NOT NULL,
	[ClientWarehouseGroupId] [int] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_ClientWarehouseRestriction] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[ClientWarehouseGroupId] ASC,
	[WarehouseNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_CompetingItem]    Script Date: 15.01.2019 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_CompetingItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Status] [bit] NOT NULL,
	[GroupCode] [nvarchar](50) NULL,
	[GroupName] [nvarchar](50) NULL,
	[ProducerName] [nvarchar](50) NULL,
	[SpecialCode] [nvarchar](50) NULL,
	[SpecialCodeDesc] [nvarchar](50) NULL,
	[SpecialCode2] [nvarchar](50) NULL,
	[SpecialCode2Desc] [nvarchar](50) NULL,
 CONSTRAINT [PK_MD_CompetingItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Currency]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Currency](
	[Firm] [smallint] NOT NULL,
	[Type] [smallint] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_MD_Currency] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Department]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Department](
	[Firm] [smallint] NOT NULL,
	[Nr] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[Status] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_Department] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[Nr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Division]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Division](
	[Firm] [smallint] NOT NULL,
	[Nr] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[Status] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_Division] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[Nr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ExpenseCenter]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ExpenseCenter](
	[TigerId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_ExpenseCenter] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Factory]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Factory](
	[Firm] [smallint] NOT NULL,
	[Nr] [smallint] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_Factory] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[Nr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Firm]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Firm](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Status] [bit] NOT NULL,
	[Nr] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[LocalCurrencyTypeId] [smallint] NULL,
	[ExchangeCurrencyTypeId] [smallint] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.MD_Firm] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Item]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Item](
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[CardType] [tinyint] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[GroupCode] [nvarchar](50) NULL,
	[GroupName] [nvarchar](50) NULL,
	[ProducerCode] [nvarchar](50) NULL,
	[ProducerName] [nvarchar](50) NULL,
	[SpecialCode] [nvarchar](50) NULL,
	[SpecialCodeDesc] [nvarchar](50) NULL,
	[SpecialCode2] [nvarchar](50) NULL,
	[SpecialCode2Desc] [nvarchar](50) NULL,
	[SpecialCode3] [nvarchar](50) NULL,
	[SpecialCode3Desc] [nvarchar](50) NULL,
	[SpecialCode4] [nvarchar](50) NULL,
	[SpecialCode4Desc] [nvarchar](50) NULL,
	[SpecialCode5] [nvarchar](50) NULL,
	[SpecialCode5Desc] [nvarchar](50) NULL,
	[AuthorizationCode] [nvarchar](50) NULL,
	[AuthorizationCodeDesc] [nvarchar](50) NULL,
	[Vat] [float] NULL,
	[SellVat] [float] NULL,
	[ReturnVat] [float] NULL,
	[SellPRVat] [float] NULL,
	[ReturnPRVat] [float] NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[Image1] [nvarchar](100) NULL,
	[Image2] [nvarchar](100) NULL,
	[Image3] [nvarchar](100) NULL,
	[Image4] [nvarchar](100) NULL,
	[Image5] [nvarchar](100) NULL,
	[IsDeleted] [bit] NULL,
	[SyncFlag] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_Item] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemBarcode]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemBarcode](
	[Firm] [smallint] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[TigerItemUnitId] [int] NOT NULL,
	[Barcode] [varchar](20) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[LineNr] [smallint] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_MD_ItemBarcode] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerItemId] ASC,
	[TigerItemUnitId] ASC,
	[Barcode] ASC,
	[LineNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemCardType]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemCardType](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_dbo.MD_ItemCardType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemImageChangedCatalog]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemImageChangedCatalog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CatalogId] [int] NOT NULL,
	[ChangedTIme] [datetime] NULL,
 CONSTRAINT [PK_MD_ItemImageChangedCatalog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemPrice]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemPrice](
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[TigerItemUnitId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NULL,
	[BeginDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Price] [float] NOT NULL,
	[CurrencyTypeId] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
	[Status] [bit] NULL,
	[OperationMask] [varchar](10) NULL,
	[VatIncluded] [bit] NULL,
	[SyncFlag] [bit] NULL,
 CONSTRAINT [PK_MD_ItemPrice] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_MD_ItemPrice] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC,
	[TigerItemId] ASC,
	[TigerItemUnitId] ASC,
	[CurrencyTypeId] ASC,
	[BeginDate] ASC,
	[EndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemPriceDivisionMapping]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemPriceDivisionMapping](
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
 CONSTRAINT [PK_MD_ItemPriceDivisionMapping] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC,
	[DivisionNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemSpecificClientGroupPrice]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemSpecificClientGroupPrice](
	[Firm] [smallint] NOT NULL,
	[ClientGroupId] [int] NOT NULL,
	[TigerId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[TigerItemUnitId] [int] NOT NULL,
	[BeginDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Price] [float] NOT NULL,
	[CurrencyTypeId] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
	[Status] [bit] NULL,
	[OperationMask] [varchar](10) NULL,
	[VatIncluded] [bit] NULL,
 CONSTRAINT [PK_MD_ItemSpecificClientGroupPrice_1] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_MD_ItemSpecificClientGroupPrice] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC,
	[TigerItemId] ASC,
	[TigerItemUnitId] ASC,
	[ClientGroupId] ASC,
	[BeginDate] ASC,
	[EndDate] ASC,
	[CurrencyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemSpecificClientPrice]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemSpecificClientPrice](
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[TigerId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[TigerItemUnitId] [int] NOT NULL,
	[BeginDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Price] [float] NOT NULL,
	[CurrencyTypeId] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
	[OperationMask] [varchar](10) NOT NULL,
	[VatIncluded] [bit] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_MD_ItemSpecificClientPrice_1] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_MD_ItemSpecificClientPrice] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC,
	[TigerItemId] ASC,
	[TigerItemUnitId] ASC,
	[ClientId] ASC,
	[BeginDate] ASC,
	[EndDate] ASC,
	[CurrencyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemSuggestedPrice]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemSuggestedPrice](
	[Firm] [smallint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[ClientGroupId] [int] NOT NULL,
	[CurrencyTypeId] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_ItemSuggestedPrice] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC,
	[ClientGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ItemUnit]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ItemUnit](
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsMainUnit] [bit] NOT NULL,
	[LineNr] [tinyint] NOT NULL,
	[Widht] [float] NULL,
	[Length] [float] NULL,
	[Height] [float] NULL,
	[Area] [float] NULL,
	[Volume] [float] NULL,
	[GrossWeight] [float] NULL,
	[Convfact1] [float] NOT NULL,
	[Convfact2] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_MD_ItemUnit] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_NoVatCalculationList]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_NoVatCalculationList](
	[Firm] [smallint] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_NoVatCalculationList] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[WarehouseNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PaymentPlan]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PaymentPlan](
	[TigerId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
	[Specode] [nvarchar](50) NULL,
	[Cyphcode] [nvarchar](50) NULL,
	[WorkDays] [smallint] NULL,
	[Status] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[RegisteredDate] [datetime] NULL,
 CONSTRAINT [PK_MD_PaymentPlan] PRIMARY KEY CLUSTERED 
(
	[TigerId] ASC,
	[Firm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedBankAccount]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedBankAccount](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_PermittedBankAccount] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerId] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedCashCard]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedCashCard](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerCashCardId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedCashCard] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerCashCardId] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedCatalog]    Script Date: 15.01.2019 11:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedCatalog](
	[UserId] [int] NOT NULL,
	[CatalogId] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_PermittedCatalog] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[CatalogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedClient]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedClient](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerClientId] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[SyncFlag] [bit] NULL,
 CONSTRAINT [PK_PermittedClient] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedCurrency]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedCurrency](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[CurrencyType] [smallint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedCurrency] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[CurrencyType] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedDepartment]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedDepartment](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerDepartmentNr] [smallint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedDepartment] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerDepartmentNr] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedDivision]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedDivision](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerDivisionNr] [smallint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedDivision] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerDivisionNr] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedFactory]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedFactory](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerFactoryNr] [smallint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedFactory] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerFactoryNr] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedFirm]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedFirm](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedFirm] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedPaymentPlan]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedPaymentPlan](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerId] [int] NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_PermittedPaymentPlan] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedTradingGroup]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedTradingGroup](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerTradingGroupId] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedTradingGroup] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerTradingGroupId] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PermittedWarehouse]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PermittedWarehouse](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[TigerWarehouseNr] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.MD_PermittedWarehouse] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[TigerWarehouseNr] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PlanDistributedByClient]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PlanDistributedByClient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[Quantity] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_PlanDistributedByClients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_MD_PlanDistributedByClients] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC,
	[UserId] ASC,
	[Month] ASC,
	[Year] ASC,
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PlanDistributedByUser]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PlanDistributedByUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[Quantity] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_PlanDistributedByUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_MD_PlanDistributedByUser] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC,
	[Month] ASC,
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_PlanTotal]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PlanTotal](
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Plan] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_TotalPlan] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[Firm] ASC,
	[Month] ASC,
	[Year] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Project]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Project](
	[TigerId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[Status] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_MD_Project] PRIMARY KEY CLUSTERED 
(
	[TigerId] ASC,
	[Firm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_ReturnLimit]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ReturnLimit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Firm] [smallint] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[WarehouseGroupId] [smallint] NOT NULL,
	[ReturnLimit] [float] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_ReturnLimit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Route]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Route](
	[Status] [bit] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[TigerClientId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_MD_Route] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerClientId] ASC,
	[Date] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Salesman]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Salesman](
	[Firm] [smallint] NOT NULL,
	[TigerId] [int] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_MD_Salesman] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_TradingGroup]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_TradingGroup](
	[TigerId] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_TradingGroup] PRIMARY KEY CLUSTERED 
(
	[TigerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_UserPlanning]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_UserPlanning](
	[UserId] [bigint] NOT NULL,
	[PlanMethodId] [int] NOT NULL,
	[RegisteredDate] [datetime] NULL,
 CONSTRAINT [PK_MD_UserPlanning] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_Warehouse]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_Warehouse](
	[Firm] [smallint] NOT NULL,
	[Nr] [int] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CostGrp] [smallint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_dbo.MD_Warehouse] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[Nr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_WarehouseGroup]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_WarehouseGroup](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[RegisteredDate] [datetime] NULL,
 CONSTRAINT [PK_MD_WarehouseGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MD_WarehouseGroupWarehouseRelation]    Script Date: 15.01.2019 11:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_WarehouseGroupWarehouseRelation](
	[WarehouseGroupId] [smallint] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[RegisteredDate] [datetime] NULL,
 CONSTRAINT [PK_MD_WarehouseGroupWarehouseRelation] PRIMARY KEY CLUSTERED 
(
	[WarehouseGroupId] ASC,
	[WarehouseNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_AdministrativePushQueue]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_AdministrativePushQueue](
	[PushNotificationId] [bigint] IDENTITY(1,1) NOT NULL,
	[PushMethodId] [smallint] NOT NULL,
	[Message] [nvarchar](500) NULL,
	[Status] [bit] NOT NULL,
	[PushToken] [nvarchar](500) NOT NULL,
	[UserId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[RegisteredUserId] [int] NULL,
	[DeviceId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OP_AdministrativePushQueue] PRIMARY KEY CLUSTERED 
(
	[PushNotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_AdministrativePushLog]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_AdministrativePushLog](
	[PushNotificationId] [bigint] NOT NULL,
	[PushType] [nvarchar](50) NOT NULL,
	[MethodName] [nvarchar](100) NULL,
	[Message] [nvarchar](500) NULL,
	[SendDate] [datetime] NOT NULL,
	[DeliveryStatus] [tinyint] NULL,
	[MulticastId] [bigint] NULL,
	[PushToken] [nvarchar](500) NOT NULL,
	[UserId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[RegisteredUserId] [int] NULL,
	[ScheduleTime] [datetime] NULL,
	[DeviceId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OP_AdministrativePushLog] PRIMARY KEY CLUSTERED 
(
	[PushNotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_AuditOperation]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_AuditOperation](
	[Id] [int] NOT NULL,
	[DocId] [varchar](50) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_AuditClientData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_AuditOperationIsExistData]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_AuditOperationIsExistData](
	[OperationId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[IsExist] [bigint] NOT NULL,
 CONSTRAINT [PK_OP_AuditOperationIsExistData] PRIMARY KEY CLUSTERED 
(
	[OperationId] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_AuditOperationQuantityData]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_AuditOperationQuantityData](
	[OperationId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
 CONSTRAINT [PK_OP_AuditOperationQuantityData] PRIMARY KEY CLUSTERED 
(
	[OperationId] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_AuditOperationPriceData]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_AuditOperationPriceData](
	[OperationId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[Price] [float] NOT NULL,
 CONSTRAINT [PK_OP_AuditOperationPriceData] PRIMARY KEY CLUSTERED 
(
	[OperationId] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_ClientDebt]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_ClientDebt](
	[Firm] [smallint] NOT NULL,
	[TigerClientId] [int] NOT NULL,
	[CurrencyType] [smallint] NOT NULL,
	[Debit] [float] NOT NULL,
	[Credit] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[OrderNo] [tinyint] NOT NULL,
 CONSTRAINT [PK_OP_ClientDebt_1] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerClientId] ASC,
	[CurrencyType] ASC,
	[OrderNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_ClientImageUploadLog]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_ClientImageUploadLog](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientTigerId] [int] NOT NULL,
	[FileName] [nvarchar](100) NULL,
	[FilePath] [nvarchar](100) NULL,
	[Note] [nvarchar](500) NULL,
	[ImageCreatedDate] [datetime] NULL,
	[CreatedUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_ClientImageUploadLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_ClientVisitLog]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_ClientVisitLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Subject] [nvarchar](200) NOT NULL,
	[Note] [nvarchar](4000) NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[Date] [datetime] NOT NULL,
	[FileName] [nvarchar](100) NULL,
	[FilePath] [nvarchar](100) NULL,
	[CreatedUserId] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_OP_ClientVisitLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_DataExchangeSchedule]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_DataExchangeSchedule](
	[Id] [int] NOT NULL,
	[DataExchangeMethodId] [smallint] NOT NULL,
	[Parameters] [nvarchar](500) NULL,
	[ExtraInfo] [nvarchar](100) NULL,
	[Period] [int] NOT NULL,
	[Status] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[NextSyncTime] [datetime] NULL,
	[LastExecutionTime] [datetime] NOT NULL,
	[ExtraNote] [nvarchar](4000) NULL,
 CONSTRAINT [PK_dbo.OP_DataExchangeSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_DataExchangeStatus]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_DataExchangeStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LastSyncAt] [datetime] NOT NULL,
	[MethodId] [smallint] NOT NULL,
	[Note] [nvarchar](500) NULL,
	[RegisteredAt] [datetime] NOT NULL,
	[RegisteredUserId] [int] NULL,
	[Status] [bit] NULL,
	[ResponseStatus] [nvarchar](500) NULL,
	[Firm] [smallint] NOT NULL,
 CONSTRAINT [PK_OP_DataExchangeStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_DocStatus]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_DocStatus](
	[DocId] [varchar](50) NOT NULL,
	[Status] [smallint] NULL,
	[ReceivedDt] [datetime] NOT NULL,
	[ProcessedDt] [datetime] NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK__DOC_STAT__3EF188AD5D8FC46E] PRIMARY KEY CLUSTERED 
(
	[DocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_FactCalculatedTotal]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_FactCalculatedTotal](
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Fact] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_FactCalculatedTotal] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[Firm] ASC,
	[Month] ASC,
	[Year] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_FactDistributedByClient]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_FactDistributedByClient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[Quantity] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_FactDistributedByClient] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_OP_FactDistributedByClient] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC,
	[UserId] ASC,
	[Month] ASC,
	[Year] ASC,
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_FactDistributedByUser]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_FactDistributedByUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitId] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[Quantity] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_FactDistributedByUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_OP_FactDistributedByUser] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[ItemId] ASC,
	[ItemUnitId] ASC,
	[Year] ASC,
	[Month] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_GeneralLog]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_GeneralLog](
	[Id] [int] NOT NULL,
	[RequestId] [int] NOT NULL,
	[TigerId] [int] NOT NULL,
	[ImportResult] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK__GENERAL___3214EC07D60E134D] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_IncomingLog]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_IncomingLog](
	[Id] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Period] [smallint] NOT NULL,
	[ProcessDate] [date] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Division] [smallint] NOT NULL,
	[Department] [smallint] NOT NULL,
	[FillAccode] [bit] NOT NULL,
	[DocType] [tinyint] NOT NULL,
	[DocId] [varchar](50) NOT NULL,
	[DocCreatedTime] [datetime] NOT NULL,
	[GpsLatitude] [float] NULL,
	[GpsLongitude] [float] NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[Specode] [nvarchar](50) NULL,
	[TradingGroup] [varchar](100) NULL,
	[UserId] [int] NOT NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[DocStatus] [tinyint] NULL,
	[SalesmanRef] [int] NULL,
	[Note] [nvarchar](2000) NULL,
	[DocSavedTime] [datetime] NULL,
	[DocSavedGpsLongitude] [float] NULL,
	[DocSavedGpsLatitude] [float] NULL,
	[DocLastUpdatedStartTime] [datetime] NULL,
	[DocLastUpdatedEndTime] [datetime] NULL,
	[CurrencyType] [smallint] NULL,
	[OptAffectCollatrl] [bit] NULL,
	[DocNumber] [nvarchar](50) NULL,
	[AuthCode] [nvarchar](50) NULL,
	[IntegratorVersion] [varchar](50) NULL,
 CONSTRAINT [PK__INCOMING__3214EC078BFDB25B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_IncomingLogCashExtension]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_IncomingLogCashExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[CashCode] [varchar](50) NOT NULL,
	[TranGroupNo] [varchar](50) NULL,
	[MasterTitle] [varchar](100) NULL,
 CONSTRAINT [PK__INCOMING__3214EC07011FB9A8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_IncomingLogCheckPaymentExtension]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_IncomingLogCheckPaymentExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
	[SerialNumber] [varchar](100) NOT NULL,
	[Debtor] [varchar](100) NOT NULL,
	[BankName] [varchar](100) NOT NULL,
	[BankBranchCode] [varchar](100) NOT NULL,
	[BankAccountCode] [varchar](100) NOT NULL,
	[Giro] [bit] NULL,
	[TaxNo] [varchar](50) NULL,
	[PieceCount] [smallint] NULL,
	[DayCount] [smallint] NULL,
	[DayOfMonth] [tinyint] NULL,
 CONSTRAINT [PK_OP_IncomingLogCheckPaymentExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_IncomingLogCommonExtension]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_IncomingLogCommonExtension](
	[Id] [int] NOT NULL,
	[WhouseNr] [int] NOT NULL,
	[FactoryNr] [smallint] NOT NULL,
	[DoctrackingValue] [varchar](50) NULL,
	[DeliveryFirm] [varchar](100) NULL,
	[ProjectCode] [varchar](100) NULL,
	[DoReserve] [bit] NULL,
	[RetCostType] [tinyint] NULL,
	[PaymentPlanId] [int] NULL,
	[DiscountAmount] [float] NULL,
	[DiscountPercent] [float] NULL,
	[DeliveryDate] [datetime] NULL,
	[PaymentPlanCode] [nvarchar](50) NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent3] [float] NULL,
	[CalculateVat] [bit] NULL,
 CONSTRAINT [PK_OP_IncomingLogCommonExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_IncomingLogCommonLineExtension]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_IncomingLogCommonLineExtension](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[DiscountAmount] [float] NULL,
	[DiscountPercent] [float] NULL,
	[IsPromo] [bit] NULL,
	[IsCustomPrice] [bit] NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent3] [float] NULL,
	[VatAmount] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_IncomingLogCreditCardPaymentExtension]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_IncomingLogCreditCardPaymentExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[CreditCardNo] [varchar](100) NOT NULL,
	[PaymentPlanId] [int] NOT NULL,
	[BankAccountId] [int] NOT NULL,
 CONSTRAINT [PK_OP_IncomingLogCreditCardPaymentExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_IncomingLogVoucherPaymentExtension]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_IncomingLogVoucherPaymentExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
	[SerialNumber] [varchar](100) NOT NULL,
	[Debtor] [varchar](100) NOT NULL,
	[Guarantor] [varchar](100) NOT NULL,
	[PaymentPlace] [varchar](100) NOT NULL,
	[Stamp] [float] NOT NULL,
	[Giro] [bit] NULL,
	[TaxNo] [varchar](50) NULL,
 CONSTRAINT [PK_OP_IncomingLogVoucherPaymentExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_ItemStock]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_ItemStock](
	[Firm] [smallint] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[RealAmount] [float] NOT NULL,
	[ActualAmount] [float] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ItemStock_1] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[TigerItemId] ASC,
	[WarehouseNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_OutQueue]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_OutQueue](
	[GeneralId] [int] NOT NULL,
	[RequestId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[DocType] [tinyint] NOT NULL,
	[Result] [int] NOT NULL,
	[Note] [nvarchar](max) NOT NULL,
	[DocId] [varchar](50) NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK__OUT_QUEU__3214EC0764B13759] PRIMARY KEY CLUSTERED 
(
	[GeneralId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_PerformanceLog]    Script Date: 15.01.2019 11:28:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_PerformanceLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TestId] [uniqueidentifier] NULL,
	[UserId] [int] NULL,
	[UserName] [nvarchar](50) NULL,
	[Firm] [smallint] NULL,
	[ClientId] [int] NULL,
	[OperationName] [nvarchar](255) NULL,
	[LineCount] [int] NULL,
	[Url] [nvarchar](100) NULL,
	[RequestHeader] [nvarchar](max) NULL,
	[RequestBody] [nvarchar](max) NULL,
	[RequestQuery] [nvarchar](max) NULL,
	[WebMethod] [varchar](50) NULL,
	[Response] [nvarchar](max) NULL,
	[StatusCode] [varchar](50) NULL,
	[Note] [nvarchar](255) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_PerformanceLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_PushQueue]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_PushQueue](
	[DocId] [varchar](50) NOT NULL,
	[GeneralId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[PushToken] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_OP_PushQueue] PRIMARY KEY CLUSTERED 
(
	[DocId] ASC,
	[GeneralId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_PushLog]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_PushLog](
	[GeneralId] [int] NOT NULL,
	[DocId] [varchar](50) NOT NULL,
	[SendDate] [datetime] NOT NULL,
	[DeliveryStatus] [tinyint] NULL,
	[MulticastId] [bigint] NULL,
	[PushToken] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_OP_PushLog_1] PRIMARY KEY CLUSTERED 
(
	[GeneralId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_PushSchedule]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_PushSchedule](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[PushMethodId] [smallint] NOT NULL,
	[Period] [int] NOT NULL,
	[Status] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[NextPushSendTime] [datetime] NULL,
	[LastPushSendTime] [datetime] NOT NULL,
	[RegisteredUserId] [int] NULL,
 CONSTRAINT [PK_OP_PushSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_RequestQueue]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_RequestQueue](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[DocStatus] [tinyint] NOT NULL,
	[ProcessingStatus] [bit] NOT NULL,
	[Step] [tinyint] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Period] [smallint] NOT NULL,
	[ProcessDate] [date] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Division] [smallint] NOT NULL,
	[Department] [smallint] NOT NULL,
	[FillAccode] [bit] NOT NULL,
	[DocType] [tinyint] NOT NULL,
	[DocId] [varchar](50) NOT NULL,
	[DocCreatedTime] [datetime] NOT NULL,
	[GpsLatitude] [float] NULL,
	[GpsLongitude] [float] NULL,
	[UserId] [int] NOT NULL,
	[SalesmanRef] [int] NOT NULL,
	[Specode] [nvarchar](50) NULL,
	[TradingGroup] [varchar](100) NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[Note] [nvarchar](2000) NULL,
	[CurrencyType] [smallint] NULL,
	[OptAffectCollatrl] [bit] NULL,
	[DocNumber] [nvarchar](50) NULL,
	[AuthCode] [nvarchar](50) NULL,
	[IntegratorVersion] [varchar](50) NULL,
 CONSTRAINT [PK__REQUEST___3214EC076B8F90ED] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_RequestQueueCashExtension]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_RequestQueueCashExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[CashCode] [varchar](50) NOT NULL,
	[TranGroupNo] [varchar](50) NULL,
	[MasterTitle] [varchar](100) NULL,
 CONSTRAINT [PK__REQUEST___3214EC077B03BAE0] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_RequestQueueCheckPaymentExtension]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_RequestQueueCheckPaymentExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
	[SerialNumber] [nvarchar](100) NOT NULL,
	[Debtor] [nvarchar](100) NOT NULL,
	[BankName] [nvarchar](100) NOT NULL,
	[BankBranchCode] [nvarchar](100) NOT NULL,
	[BankAccountCode] [nvarchar](100) NOT NULL,
	[Giro] [bit] NULL,
	[TaxNo] [varchar](50) NULL,
	[PieceCount] [smallint] NULL,
	[DayCount] [smallint] NULL,
	[DayOfMonth] [tinyint] NULL,
 CONSTRAINT [PK_OP_RequestQueueCheckPaymentExtension_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_RequestQueueCommonExtension]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_RequestQueueCommonExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[WhouseNr] [int] NOT NULL,
	[FactoryNr] [smallint] NOT NULL,
	[DoctrackingValue] [varchar](50) NULL,
	[DeliveryFirm] [varchar](100) NULL,
	[ProjectCode] [varchar](100) NULL,
	[DoReserve] [bit] NULL,
	[RetCostType] [tinyint] NULL,
	[PaymentPlanId] [int] NULL,
	[DiscountAmount] [float] NULL,
	[DiscountPercent] [float] NULL,
	[DeliveryDate] [datetime] NULL,
	[PaymentPlanCode] [nvarchar](50) NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent3] [float] NULL,
 CONSTRAINT [PK__OP_RequestQueueCommonExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_RequestQueueCommonLineExtension]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_RequestQueueCommonLineExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[DiscountAmount] [float] NULL,
	[DiscountPercent] [float] NULL,
	[IsPromo] [bit] NULL,
	[IsCustomPrice] [bit] NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent3] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_RequestQueueCreditCardPaymentExtension]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_RequestQueueCreditCardPaymentExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[CreditCardNo] [nvarchar](100) NOT NULL,
	[PaymentPlanId] [int] NOT NULL,
	[BankAccountId] [int] NOT NULL,
 CONSTRAINT [PK_OP_RequestQueueCreditCardPaymentExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_RequestQueueVoucherPaymentExtension]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_RequestQueueVoucherPaymentExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
	[SerialNumber] [nvarchar](100) NOT NULL,
	[Debtor] [nvarchar](100) NOT NULL,
	[Guarantor] [nvarchar](100) NOT NULL,
	[PaymentPlace] [nvarchar](100) NOT NULL,
	[Stamp] [float] NOT NULL,
	[Giro] [bit] NULL,
	[TaxNo] [varchar](50) NULL,
 CONSTRAINT [PK_OP_RequestQueueVoucherPaymentExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_ReturnFact]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_ReturnFact](
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[TigerItemId] [int] NOT NULL,
	[WarehouseGroupId] [smallint] NOT NULL,
	[CurrentState] [float] NOT NULL,
	[TotalSaleAmount] [float] NOT NULL,
	[TotalReturnAmount] [float] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_ReturnFact] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[Firm] ASC,
	[TigerItemId] ASC,
	[WarehouseGroupId] ASC,
	[Year] ASC,
	[Month] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_SpecialSequence]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_SpecialSequence](
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[DocType] [tinyint] NOT NULL,
 CONSTRAINT [PK_OP_SpecialSequence_1] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[ClientId] ASC,
	[DocType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_SyncMethod]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_SyncMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Period] [int] NOT NULL,
	[Status] [bit] NULL,
	[LastPushSendTime] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_SyncMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_UserActionGpsData]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_UserActionGpsData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ActionTypeId] [smallint] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[Subject] [nvarchar](100) NULL,
	[Note] [nvarchar](500) NULL,
	[GpsDate] [datetime] NOT NULL,
	[SendDate] [datetime] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[ActionLogId] [int] NULL,
	[DocSavedTime] [datetime] NULL,
 CONSTRAINT [PK_OP_UserActionGpsData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_UserGpsData]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_UserGpsData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[GpsDate] [datetime] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_UserGpsData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OP_UserTaskExecutionLog]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_UserTaskExecutionLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
	[ExecutionStatusId] [tinyint] NULL,
	[Note] [nvarchar](500) NULL,
	[ExecutionDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OP_UserTaskExecutionLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_AccountingPeriod]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_AccountingPeriod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedUserId] [int] NOT NULL,
	[FirmNr] [smallint] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedUserId] [int] NULL,
	[Period] [smallint] NOT NULL,
	[Year] [smallint] NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_SYS_AccountingPeriod_1] PRIMARY KEY CLUSTERED 
(
	[FirmNr] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_AppConfigParameter]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_AppConfigParameter](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
	[Description] [nvarchar](50) NULL,
	[Value] [nvarchar](50) NOT NULL,
	[Status] [tinyint] NOT NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_SYS_AppConfigParameter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_ConfigObject]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_ConfigObject](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[ValueFromTable] [bit] NULL,
	[AppRelevant] [bit] NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.SYS_ConfigObject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_ConfigObjectValue]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_ConfigObjectValue](
	[Value] [nvarchar](10) NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[ObjectId] [smallint] NOT NULL,
	[TranslationObject] [nvarchar](30) NULL,
	[Description] [nvarchar](100) NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.SYS_ConfigObjectValue] PRIMARY KEY CLUSTERED 
(
	[Value] ASC,
	[OperationId] ASC,
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_DataExchangeMethod]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_DataExchangeMethod](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Source] [nvarchar](100) NULL,
	[Description] [nvarchar](100) NULL,
	[ExtraInfo] [nvarchar](100) NULL,
	[Url] [nvarchar](250) NULL,
	[DataTypeId] [smallint] NULL,
	[Status] [bit] NULL,
	[ModifiedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.SYS_DataExchangeMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_DataOperationMapping]    Script Date: 15.01.2019 11:28:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_DataOperationMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DataType] [nvarchar](50) NOT NULL,
	[OperationBitmask] [varchar](20) NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_DataOperationMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_DataType]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_DataType](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Status] [bit] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_DataType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_DeviceSyncSchedule]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_DeviceSyncSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[DeviceSyncTime] [time](7) NOT NULL,
	[MasterDataLastSyncDate] [datetime] NULL,
	[AppDataLastSyncDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_SYS_DeviceSyncSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_EmailSetting]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_EmailSetting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[SmtpServerName] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SYS_EmailSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_Language]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_Language](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Language] [varchar](10) NOT NULL,
	[Description] [nvarchar](20) NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_SYS_Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_LicenseInfo]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_LicenseInfo](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Client] [varchar](max) NOT NULL,
	[Info] [varchar](max) NOT NULL,
	[Data] [varchar](max) NOT NULL,
	[Data2] [varchar](max) NULL,
	[Type] [tinyint] NOT NULL,
 CONSTRAINT [PK_SYS_LicenseInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_MethodPermission]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_MethodPermission](
	[MethodId] [smallint] NOT NULL,
	[PermissionId] [smallint] NOT NULL,
	[PermissionValue] [tinyint] NULL,
	[Description] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_MethodPermission_1] PRIMARY KEY CLUSTERED 
(
	[MethodId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_PlanMethod]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_PlanMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedUserId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedUserId] [int] NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Type] [tinyint] NULL,
 CONSTRAINT [PK_SYS_PlanMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_PushMethod]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_PushMethod](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[ExtraInfo] [nvarchar](100) NULL,
	[Url] [nvarchar](250) NULL,
	[DataTypeId] [smallint] NULL,
	[PushTypeId] [smallint] NOT NULL,
	[Status] [bit] NULL,
	[ModifiedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_PushMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_PushType]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_PushType](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Status] [bit] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_PushType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_SetOperation]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_SetOperation](
	[Id] [tinyint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.SYS_SetOperation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_SyncTimeTable]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_SyncTimeTable](
	[Name] [varchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_SYNCTIMETABLE] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_TaskExecutionStatus]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_TaskExecutionStatus](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NULL,
	[Description] [nvarchar](50) NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_TaskExecutionStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_TaskExecutionType]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_TaskExecutionType](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NULL,
	[Description] [nvarchar](50) NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_TaskExecutionType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_TaskFormType]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_TaskFormType](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NULL,
	[Description] [nvarchar](50) NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_TaskFormType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_TaskType]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_TaskType](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NULL,
	[Description] [nvarchar](50) NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_TaskType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_Translation]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_Translation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ObjectName] [varchar](50) NOT NULL,
	[LanguageId] [tinyint] NOT NULL,
	[Type] [tinyint] NULL,
	[Value] [nvarchar](500) NOT NULL,
	[UserType] [tinyint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_SYS_Translation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_UserActionType]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_UserActionType](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Status] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_UserActionType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_UserSettingObject]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_UserSettingObject](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Status] [tinyint] NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_UserSettingObject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UID_UserPermissionBannedClients]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UID_UserPermissionBannedClients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[PermissionValue] [nvarchar](50) NULL,
	[FirmNr] [smallint] NOT NULL,
	[CreatedUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_UID_UserPermissionBannedClients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_AllowedDevice]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_AllowedDevice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Imei] [varchar](15) NULL,
	[Specode1] [varchar](50) NULL,
	[Specode2] [varchar](50) NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_Device]    Script Date: 15.01.2019 11:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_Device](
	[Id] [uniqueidentifier] NOT NULL,
	[UID] [varchar](50) NULL,
	[PushToken] [nvarchar](500) NULL,
	[PushPermission] [tinyint] NULL,
	[TotpSecret] [varchar](50) NOT NULL,
	[AppVersion] [varchar](50) NULL,
	[Brand] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[OS] [varchar](50) NULL,
	[OSVersion] [varchar](50) NULL,
	[Imei] [varchar](50) NULL,
	[Mac] [varchar](50) NULL,
	[ExtraInfo] [varchar](50) NULL,
	[Status] [tinyint] NOT NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_UIM_Device] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_NonLoggingDay]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_NonLoggingDay](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[FirmNr] [smallint] NULL,
	[UserId] [bigint] NOT NULL,
 CONSTRAINT [PK_UIM_NonLoggingDay] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_Permission]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_Permission](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[ParentId] [smallint] NULL,
	[ObjectName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_Permission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_PermissionValue]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_PermissionValue](
	[Value] [tinyint] NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.UIM_PermissionValue] PRIMARY KEY CLUSTERED 
(
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserAppLoginAttempt]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserAppLoginAttempt](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[AttemptsCount] [tinyint] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_UserAppLoginAttempt] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserAuthToken]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserAuthToken](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[AuthToken] [nvarchar](500) NOT NULL,
	[ValidFrom] [datetime] NOT NULL,
	[ValidTo] [datetime] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_UserAuthToken] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserConfigParameter]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserConfigParameter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[ObjectId] [smallint] NOT NULL,
	[Objectvalue] [nvarchar](50) NULL,
	[IsDefault] [bit] NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_UserConfigParameter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserContactData]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserContactData](
	[Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Street] [nvarchar](50) NULL,
	[AddressExtra] [nvarchar](50) NULL,
	[ZIP] [nvarchar](10) NULL,
	[City] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [varchar](20) NULL,
	[Mobile1] [varchar](20) NULL,
	[Mobile2] [varchar](20) NULL,
	[EmailPermission] [tinyint] NULL,
	[MobilePermission] [tinyint] NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_UIM_UserContactData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserDeviceLogHistory]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserDeviceLogHistory](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[DeviceId] [uniqueidentifier] NULL,
	[Login] [nvarchar](50) NULL,
	[UserType] [tinyint] NULL,
	[AuthToken] [varchar](500) NULL,
	[ActivityInfo] [nvarchar](100) NULL,
	[ExtraInfo] [nvarchar](500) NULL,
	[RegisteredDate] [datetime] NULL,
 CONSTRAINT [PK_UIM_UserDeviceLogHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserEmployeeMapping]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserEmployeeMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Password] [nvarchar](50) NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ExtraFlagReturnLimit] [bit] NULL,
 CONSTRAINT [PK_dbo.UIM_UserEmployeeMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_UIM_UserEmployeeMapping_UserIdEmployyeIdFirm] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[EmployeeId] ASC,
	[Firm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserPermission]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserPermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[PermissionId] [smallint] NOT NULL,
	[PermissionValue] [tinyint] NOT NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_UserPermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_UIM_UserPermission] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserProperty]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserProperty](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Specode1] [nvarchar](50) NULL,
	[Specode2] [nvarchar](50) NULL,
	[Specode3] [nvarchar](50) NULL,
	[ModifiedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedUserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UIM_UserProperty] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserSetting]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserSetting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NULL,
	[SettingId] [smallint] NOT NULL,
	[SettingValue] [nvarchar](50) NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_UserSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_UIM_UserSetting] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[SettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserTask]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserTask](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ErpClientId] [int] NULL,
	[Content] [nvarchar](500) NULL,
	[TypeId] [tinyint] NOT NULL,
	[ExecutionTypeId] [tinyint] NOT NULL,
	[FormTypeId] [tinyint] NOT NULL,
	[ExecutionStatusId] [tinyint] NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Note] [nvarchar](500) NULL,
	[ExecutionDate] [datetime] NULL,
	[ModifiedUserId] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedUserId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UIM_UserTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserType]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CanSelect] [bit] NOT NULL,
	[Level] [int] NOT NULL,
	[ParentId] [int] NULL,
	[Type] [nvarchar](100) NOT NULL,
	[Icon] [nvarchar](max) NULL,
 CONSTRAINT [PK_UIM_UserType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIM_UserTypeUserMapping]    Script Date: 15.01.2019 11:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIM_UserTypeUserMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[UserTypeId] [int] NOT NULL,
 CONSTRAINT [PK_UIM_UserTypeUserMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MC_ClientMediaInfo] ADD  CONSTRAINT [DF_MC_ClientMediaInfo_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Bank] ADD  CONSTRAINT [DF_MD_Bank_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MD_BankAccount] ADD  CONSTRAINT [DF_MD_BankAccount_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MD_CashCard] ADD  CONSTRAINT [DF_MD_CashCard_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Catalog] ADD  CONSTRAINT [DF_MD_Catalog_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_CatalogGroup] ADD  CONSTRAINT [DF_MD_CatalogGroup_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Client] ADD  CONSTRAINT [DF_Client_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Client] ADD  CONSTRAINT [DF_MD_Client_SyncFlag]  DEFAULT ((0)) FOR [SyncFlag]
GO
ALTER TABLE [dbo].[MD_ClientItemRestriction] ADD  CONSTRAINT [DF_MD_ClientItemRestriction_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_ClientWarehouseRestriction] ADD  CONSTRAINT [DF_MD_ClientWarehouseRestriction_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Currency] ADD  CONSTRAINT [DF_Currency_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Department] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Division] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_ExpenseCenter] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Factory] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Firm] ADD  CONSTRAINT [DF__MD_Firm__Registe__5A5A5133]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Firm] ADD  CONSTRAINT [DF_MD_Firm_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MD_Item] ADD  CONSTRAINT [DF__MD_Item__Registe__5F1F0650]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Item] ADD  CONSTRAINT [DF_MD_Item_SyncFlag]  DEFAULT ((0)) FOR [SyncFlag]
GO
ALTER TABLE [dbo].[MD_ItemBarcode] ADD  CONSTRAINT [DF_ItemBarcode_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_ItemImageChangedCatalog] ADD  CONSTRAINT [DF_MD_ItemImageChangedCatalog_ChangedTIme]  DEFAULT (getdate()) FOR [ChangedTIme]
GO
ALTER TABLE [dbo].[MD_ItemPrice] ADD  CONSTRAINT [DF_ItemPrice_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_ItemPrice] ADD  CONSTRAINT [DF_MD_ItemPrice_OperationMask]  DEFAULT ((1111100000)) FOR [OperationMask]
GO
ALTER TABLE [dbo].[MD_ItemPrice] ADD  CONSTRAINT [DF_MD_ItemPrice_SyncFlag]  DEFAULT ((0)) FOR [SyncFlag]
GO
ALTER TABLE [dbo].[MD_ItemSpecificClientGroupPrice] ADD  CONSTRAINT [DF_MD_ItemSpecificPriceClientGroup_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_ItemSpecificClientGroupPrice] ADD  CONSTRAINT [DF_MD_ItemSpecificClientGroupPrice_OperationMask]  DEFAULT ((1111100000)) FOR [OperationMask]
GO
ALTER TABLE [dbo].[MD_ItemSpecificClientPrice] ADD  CONSTRAINT [DF_MD_ItemSpecificClientPrice_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_ItemSpecificClientPrice] ADD  CONSTRAINT [DF_MD_ItemSpecificClientPrice_OperationMask]  DEFAULT ((1111100000)) FOR [OperationMask]
GO
ALTER TABLE [dbo].[MD_ItemSpecificClientPrice] ADD  CONSTRAINT [DF_MD_ItemSpecificClientPrice_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[MD_ItemUnit] ADD  CONSTRAINT [DF_ItemUnit_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_NoVatCalculationList] ADD  CONSTRAINT [DF_MD_NoVatCalculationList_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PaymentPlan] ADD  CONSTRAINT [DF_MD_PaymentPlan_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedBankAccount] ADD  CONSTRAINT [DF_MD_PermittedBankAccount_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedCashCard] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedCatalog] ADD  CONSTRAINT [DF_MD_PermittedCatalog_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedClient] ADD  CONSTRAINT [DF_PermittedClient_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedClient] ADD  CONSTRAINT [DF_MD_PermittedClient_SyncFlag]  DEFAULT ((0)) FOR [SyncFlag]
GO
ALTER TABLE [dbo].[MD_PermittedCurrency] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedDepartment] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedDivision] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedFactory] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedFirm] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedPaymentPlan] ADD  CONSTRAINT [DF_MD_PermittedPaymentPlan_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedTradingGroup] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PermittedWarehouse] ADD  CONSTRAINT [DF__MD_Permit__Regis__76026BA8]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PlanDistributedByClient] ADD  CONSTRAINT [DF_MD_PlanDistributedByClient_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PlanDistributedByUser] ADD  CONSTRAINT [DF_MD_PlanDistributedByUser_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_PlanTotal] ADD  CONSTRAINT [DF_MD_TotalPlan_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Project] ADD  CONSTRAINT [DF_Project_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_ReturnLimit] ADD  CONSTRAINT [DF_MD_ReturnLimit_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Route] ADD  CONSTRAINT [DF_MD_Route_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Salesman] ADD  CONSTRAINT [DF_Salesman_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_TradingGroup] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_UserPlanning] ADD  CONSTRAINT [DF_MD_UserPlanning_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_Warehouse] ADD  CONSTRAINT [DF__MD_Wareho__Regis__0CE5D100]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_WarehouseGroup] ADD  CONSTRAINT [DF_MD_WarehouseGroup_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[MD_WarehouseGroupWarehouseRelation] ADD  CONSTRAINT [DF_MD_WarehouseGroupWarehouseRelation_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_AdministrativePushQueue] ADD  CONSTRAINT [DF_OP_AdministrativePushQueue_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[OP_AdministrativePushQueue] ADD  CONSTRAINT [DF_OP_AdministrativePushQueue_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OP_AdministrativePushLog] ADD  CONSTRAINT [DF_OP_AdministrativePushLog_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OP_AuditOperation] ADD  CONSTRAINT [DF_OP_AuditClientData_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_ClientDebt] ADD  CONSTRAINT [DF_ClientDebt_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_ClientImageUploadLog] ADD  CONSTRAINT [DF_OP_ClientImageUploadLog_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OP_DataExchangeSchedule] ADD  CONSTRAINT [DF_OP_DataExchangeSchedule_LastExecutionTime]  DEFAULT (getdate()) FOR [LastExecutionTime]
GO
ALTER TABLE [dbo].[OP_DataExchangeStatus] ADD  CONSTRAINT [DF_OP_DataExchangeStatus_RegisteredAt]  DEFAULT (getdate()) FOR [RegisteredAt]
GO
ALTER TABLE [dbo].[OP_FactCalculatedTotal] ADD  CONSTRAINT [DF_OP_FactCalculatedTotal_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_FactDistributedByClient] ADD  CONSTRAINT [DF_OP_FactDistributedByClient_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_FactDistributedByUser] ADD  CONSTRAINT [DF_OP_FactDistributedByUser_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_IncomingLog] ADD  CONSTRAINT [DF_OP_IncomingLog_GpsLatitude]  DEFAULT ((0)) FOR [GpsLatitude]
GO
ALTER TABLE [dbo].[OP_IncomingLog] ADD  CONSTRAINT [DF_OP_IncomingLog_GpsLongitude]  DEFAULT ((0)) FOR [GpsLongitude]
GO
ALTER TABLE [dbo].[OP_IncomingLog] ADD  CONSTRAINT [DF__INCOMING___Regis__20C1E124]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_IncomingLog] ADD  CONSTRAINT [DF_OP_IncomingLog_DocSavedGpsLongitude]  DEFAULT ((0)) FOR [DocSavedGpsLongitude]
GO
ALTER TABLE [dbo].[OP_IncomingLog] ADD  CONSTRAINT [DF_OP_IncomingLog_DocSavedGpsLatitude]  DEFAULT ((0)) FOR [DocSavedGpsLatitude]
GO
ALTER TABLE [dbo].[OP_IncomingLogCommonLineExtension] ADD  CONSTRAINT [DF_OP_IncomingLogCommonLineExtension_IsCustomPrice]  DEFAULT ((0)) FOR [IsCustomPrice]
GO
ALTER TABLE [dbo].[OP_IncomingLogVoucherPaymentExtension] ADD  CONSTRAINT [DF_OP_IncomingLogVoucherPaymentExtension_Stamp]  DEFAULT ((0)) FOR [Stamp]
GO
ALTER TABLE [dbo].[OP_ItemStock] ADD  CONSTRAINT [DF_ItemStock_RegisterDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_OutQueue] ADD  CONSTRAINT [DF_OP_OutQueue_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[OP_PerformanceLog] ADD  CONSTRAINT [DF_OP_PerformanceLog_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_PushQueue] ADD  CONSTRAINT [DF_OP_PushQueue_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[OP_RequestQueue] ADD  CONSTRAINT [DF_OP_RequestQueue_PartNo]  DEFAULT ((0)) FOR [PartNo]
GO
ALTER TABLE [dbo].[OP_RequestQueue] ADD  CONSTRAINT [DF_OP_RequestQueue_Status]  DEFAULT ((0)) FOR [ProcessingStatus]
GO
ALTER TABLE [dbo].[OP_RequestQueue] ADD  CONSTRAINT [DF__REQUEST_Q__Statu__164452B1]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[OP_RequestQueueCommonExtension] ADD  CONSTRAINT [DF_OP_RequestQueueCommonExtension_PartNo]  DEFAULT ((0)) FOR [PartNo]
GO
ALTER TABLE [dbo].[OP_RequestQueueCommonExtension] ADD  CONSTRAINT [DF_OP_RequestQueueCommonExtension_DoReserve]  DEFAULT ((1)) FOR [DoReserve]
GO
ALTER TABLE [dbo].[OP_RequestQueueCommonLineExtension] ADD  CONSTRAINT [DF_OP_RequestQueueCommonLineExtension_PartNo]  DEFAULT ((0)) FOR [PartNo]
GO
ALTER TABLE [dbo].[OP_RequestQueueCommonLineExtension] ADD  CONSTRAINT [DF_OP_RequestQueueCommonLineExtension_IsCustomPrice]  DEFAULT ((0)) FOR [IsCustomPrice]
GO
ALTER TABLE [dbo].[OP_RequestQueueVoucherPaymentExtension] ADD  CONSTRAINT [DF_OP_RequestQueueVoucherPaymentExtension_Stamp]  DEFAULT ((0)) FOR [Stamp]
GO
ALTER TABLE [dbo].[OP_ReturnFact] ADD  CONSTRAINT [DF_OP_ReturnFact_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_SyncMethod] ADD  CONSTRAINT [DF_OP_SyncMethod_LastPushSendTime]  DEFAULT (getdate()) FOR [LastPushSendTime]
GO
ALTER TABLE [dbo].[OP_UserActionGpsData] ADD  CONSTRAINT [DF_OP_UserActionGpsData_SendDate]  DEFAULT (getdate()) FOR [SendDate]
GO
ALTER TABLE [dbo].[OP_UserActionGpsData] ADD  CONSTRAINT [DF__OP_UserAc__Regis__7B3C2211]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_UserGpsData] ADD  CONSTRAINT [DF_OP_UserGpsData_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[OP_UserTaskExecutionLog] ADD  CONSTRAINT [DF_OP_UserTaskExecutionLog_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_AccountingPeriod] ADD  CONSTRAINT [DF_SYS_AccountingPeriod_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_ConfigObject] ADD  CONSTRAINT [DF__SYS_Confi__Creat__492FC531]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_ConfigObjectValue] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_DataExchangeMethod] ADD  CONSTRAINT [DF_SYS_DataExchangeMethod_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_DataOperationMapping] ADD  CONSTRAINT [DF_SYS_DataOperationMapping_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[SYS_DataType] ADD  CONSTRAINT [DF_SYS_DataType_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_DeviceSyncSchedule] ADD  CONSTRAINT [DF_SYS_DeviceSyncSchedule_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_PlanMethod] ADD  CONSTRAINT [DF_SYS_PlanMethod_Type]  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [dbo].[SYS_PushMethod] ADD  CONSTRAINT [DF_SYS_PushMethod_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_PushType] ADD  CONSTRAINT [DF_SYS_PushType_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_SetOperation] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_TaskExecutionStatus] ADD  CONSTRAINT [DF_SYS_TaskExecutionStatus_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[SYS_TaskExecutionType] ADD  CONSTRAINT [DF_SYS_TaskExecutionType_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[SYS_TaskFormType] ADD  CONSTRAINT [DF_SYS_TaskFormType_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[SYS_TaskType] ADD  CONSTRAINT [DF_SYS_TaskType_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[SYS_Translation] ADD  CONSTRAINT [DF_SYS_Translation_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_UserActionType] ADD  CONSTRAINT [DF__SYS_UserA__Creat__785FB566]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SYS_UserSettingObject] ADD  CONSTRAINT [DF_SYS_UserSettingObject_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UID_UserPermissionBannedClients] ADD  CONSTRAINT [DF_UID_UserPermissionBannedClients_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UIM_Permission] ADD  CONSTRAINT [DF__UIM_Permi__Creat__3AE1A5DA]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UIM_UserAppLoginAttempt] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[UIM_UserAuthToken] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[UIM_UserConfigParameter] ADD  CONSTRAINT [DF__UIM_UserC__Creat__072CF7AA]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UIM_UserEmployeeMapping] ADD  CONSTRAINT [DF__UIM_UserE__Creat__0A096455]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UIM_UserPermission] ADD  CONSTRAINT [DF__UIM_UserP__Creat__01741E54]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UIM_UserProperty] ADD  CONSTRAINT [DF_UIM_UserProperty_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UIM_UserSetting] ADD  CONSTRAINT [DF_UIM_UserSetting_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UIM_UserTask] ADD  CONSTRAINT [DF_UIM_UserTask_ExecutionStatusId]  DEFAULT ((1)) FOR [ExecutionStatusId]
GO
ALTER TABLE [dbo].[UIM_UserTask] ADD  CONSTRAINT [DF_UIM_UserTask_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[AbpFeatures]  WITH CHECK ADD  CONSTRAINT [FK_AbpFeatures_AbpEditions_EditionId] FOREIGN KEY([EditionId])
REFERENCES [dbo].[AbpEditions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpFeatures] CHECK CONSTRAINT [FK_AbpFeatures_AbpEditions_EditionId]
GO
ALTER TABLE [dbo].[AbpOrganizationUnits]  WITH CHECK ADD  CONSTRAINT [FK_AbpOrganizationUnits_AbpOrganizationUnits_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[AbpOrganizationUnits] ([Id])
GO
ALTER TABLE [dbo].[AbpOrganizationUnits] CHECK CONSTRAINT [FK_AbpOrganizationUnits_AbpOrganizationUnits_ParentId]
GO
ALTER TABLE [dbo].[AbpPermissions]  WITH CHECK ADD  CONSTRAINT [FK_AbpPermissions_AbpRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AbpRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpPermissions] CHECK CONSTRAINT [FK_AbpPermissions_AbpRoles_RoleId]
GO
ALTER TABLE [dbo].[AbpPermissions]  WITH CHECK ADD  CONSTRAINT [FK_AbpPermissions_AbpUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AbpUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpPermissions] CHECK CONSTRAINT [FK_AbpPermissions_AbpUsers_UserId]
GO
ALTER TABLE [dbo].[AbpRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AbpRoleClaims_AbpRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AbpRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpRoleClaims] CHECK CONSTRAINT [FK_AbpRoleClaims_AbpRoles_RoleId]
GO
ALTER TABLE [dbo].[AbpRoles]  WITH CHECK ADD  CONSTRAINT [FK_AbpRoles_AbpUsers_CreatorUserId] FOREIGN KEY([CreatorUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpRoles] CHECK CONSTRAINT [FK_AbpRoles_AbpUsers_CreatorUserId]
GO
ALTER TABLE [dbo].[AbpRoles]  WITH CHECK ADD  CONSTRAINT [FK_AbpRoles_AbpUsers_DeleterUserId] FOREIGN KEY([DeleterUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpRoles] CHECK CONSTRAINT [FK_AbpRoles_AbpUsers_DeleterUserId]
GO
ALTER TABLE [dbo].[AbpRoles]  WITH CHECK ADD  CONSTRAINT [FK_AbpRoles_AbpUsers_LastModifierUserId] FOREIGN KEY([LastModifierUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpRoles] CHECK CONSTRAINT [FK_AbpRoles_AbpUsers_LastModifierUserId]
GO
ALTER TABLE [dbo].[AbpSettings]  WITH CHECK ADD  CONSTRAINT [FK_AbpSettings_AbpUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpSettings] CHECK CONSTRAINT [FK_AbpSettings_AbpUsers_UserId]
GO
ALTER TABLE [dbo].[AbpTenants]  WITH CHECK ADD  CONSTRAINT [FK_AbpTenants_AbpEditions_EditionId] FOREIGN KEY([EditionId])
REFERENCES [dbo].[AbpEditions] ([Id])
GO
ALTER TABLE [dbo].[AbpTenants] CHECK CONSTRAINT [FK_AbpTenants_AbpEditions_EditionId]
GO
ALTER TABLE [dbo].[AbpTenants]  WITH CHECK ADD  CONSTRAINT [FK_AbpTenants_AbpUsers_CreatorUserId] FOREIGN KEY([CreatorUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpTenants] CHECK CONSTRAINT [FK_AbpTenants_AbpUsers_CreatorUserId]
GO
ALTER TABLE [dbo].[AbpTenants]  WITH CHECK ADD  CONSTRAINT [FK_AbpTenants_AbpUsers_DeleterUserId] FOREIGN KEY([DeleterUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpTenants] CHECK CONSTRAINT [FK_AbpTenants_AbpUsers_DeleterUserId]
GO
ALTER TABLE [dbo].[AbpTenants]  WITH CHECK ADD  CONSTRAINT [FK_AbpTenants_AbpUsers_LastModifierUserId] FOREIGN KEY([LastModifierUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpTenants] CHECK CONSTRAINT [FK_AbpTenants_AbpUsers_LastModifierUserId]
GO
ALTER TABLE [dbo].[AbpUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AbpUserClaims_AbpUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AbpUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpUserClaims] CHECK CONSTRAINT [FK_AbpUserClaims_AbpUsers_UserId]
GO
ALTER TABLE [dbo].[AbpUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AbpUserLogins_AbpUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AbpUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpUserLogins] CHECK CONSTRAINT [FK_AbpUserLogins_AbpUsers_UserId]
GO
ALTER TABLE [dbo].[AbpUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AbpUserRoles_AbpUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AbpUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpUserRoles] CHECK CONSTRAINT [FK_AbpUserRoles_AbpUsers_UserId]
GO
ALTER TABLE [dbo].[AbpUsers]  WITH CHECK ADD  CONSTRAINT [FK_AbpUsers_AbpUsers_CreatorUserId] FOREIGN KEY([CreatorUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpUsers] CHECK CONSTRAINT [FK_AbpUsers_AbpUsers_CreatorUserId]
GO
ALTER TABLE [dbo].[AbpUsers]  WITH CHECK ADD  CONSTRAINT [FK_AbpUsers_AbpUsers_DeleterUserId] FOREIGN KEY([DeleterUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpUsers] CHECK CONSTRAINT [FK_AbpUsers_AbpUsers_DeleterUserId]
GO
ALTER TABLE [dbo].[AbpUsers]  WITH CHECK ADD  CONSTRAINT [FK_AbpUsers_AbpUsers_LastModifierUserId] FOREIGN KEY([LastModifierUserId])
REFERENCES [dbo].[AbpUsers] ([Id])
GO
ALTER TABLE [dbo].[AbpUsers] CHECK CONSTRAINT [FK_AbpUsers_AbpUsers_LastModifierUserId]
GO
ALTER TABLE [dbo].[AbpUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AbpUserTokens_AbpUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AbpUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AbpUserTokens] CHECK CONSTRAINT [FK_AbpUserTokens_AbpUsers_UserId]
GO
ALTER TABLE [dbo].[AppSubscriptionPayments]  WITH CHECK ADD  CONSTRAINT [FK_AppSubscriptionPayments_AbpEditions_EditionId] FOREIGN KEY([EditionId])
REFERENCES [dbo].[AbpEditions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AppSubscriptionPayments] CHECK CONSTRAINT [FK_AppSubscriptionPayments_AbpEditions_EditionId]
GO
ALTER TABLE [dbo].[MD_Catalog]  WITH CHECK ADD  CONSTRAINT [FK_MD_Catalog_MD_CatalogGroup_CatalogGroupId] FOREIGN KEY([CatalogGroupId])
REFERENCES [dbo].[MD_CatalogGroup] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MD_Catalog] CHECK CONSTRAINT [FK_MD_Catalog_MD_CatalogGroup_CatalogGroupId]
GO
ALTER TABLE [dbo].[MD_CatalogItemMapping]  WITH NOCHECK ADD  CONSTRAINT [FK_MD_CatalogItemMapping_MD_Catalog_CatalogId] FOREIGN KEY([CatalogId])
REFERENCES [dbo].[MD_Catalog] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MD_CatalogItemMapping] CHECK CONSTRAINT [FK_MD_CatalogItemMapping_MD_Catalog_CatalogId]
GO

/****** Object:  Sequence [dbo].[AuditSeq]    Script Date: 16.10.2018 18:41:26 ******/
CREATE SEQUENCE [dbo].[AuditSeq] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO


/****** Object:  Sequence [dbo].[GeneralSeq]    Script Date: 16.10.2018 18:41:32 ******/
CREATE SEQUENCE [dbo].[GeneralSeq] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO



/****** Object:  Sequence [dbo].[RequestSeq]    Script Date: 16.10.2018 18:41:41 ******/
CREATE SEQUENCE [dbo].[RequestSeq] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO