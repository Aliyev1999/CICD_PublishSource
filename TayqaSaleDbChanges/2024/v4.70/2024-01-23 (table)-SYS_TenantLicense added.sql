

CREATE TABLE [dbo].[SYS_TenantLicense](
	[Id] [smallint] NOT NULL,
	[TenantId] [int] NOT NULL,
	[ClientCode] [nvarchar](255) NOT NULL,
	[LicenseContent] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

