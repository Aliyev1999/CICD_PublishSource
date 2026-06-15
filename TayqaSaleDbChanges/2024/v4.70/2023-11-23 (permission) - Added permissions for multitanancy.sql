CREATE TABLE [dbo].[AbpOrganizationUnitRoles](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[TenantId] [int] NULL,
	[RoleId] [int] NOT NULL,
	[OrganizationUnitId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AbpOrganizationUnitRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))


go

alter table AbpAuditLogs
add ReturnValue nvarchar(max)

alter table AbpAuditLogs
add ExceptionMessage nvarchar(1024)

go

alter table abptenants
add
	[ReadonlyConnectionString] [nvarchar](1024) NULL,
	[ExecutorConnectionString] [nvarchar](1024) NULL

go