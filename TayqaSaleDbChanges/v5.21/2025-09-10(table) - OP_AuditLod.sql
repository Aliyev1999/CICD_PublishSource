

CREATE TABLE [dbo].[OP_AppAuditLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](300) NOT NULL,
	[QueryString] [nvarchar](500) NULL,
	[HttpMethod] [nvarchar](10) NOT NULL,
	[InputObj] [nvarchar](2000) NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[DeviceId] [uniqueidentifier] NULL,
	[UserId] [int] NULL,
	[TenantId] [int] NULL,
	[StatusCode] [int] NOT NULL,
	[DurationMs] [bigint] NOT NULL,
	[ClientIpAddress] [nvarchar](50) NULL,
	[BrowserInfo] [nvarchar](500) NULL,
	[Exception] [nvarchar](4000) NULL,
	[ResponseContentType] [nvarchar](100) NULL,
	[ResponseBodyLength] [int] NULL,
	[ResponseBodySample] [nvarchar](max) NULL,
	[ResponseBodyTruncated] [bit] NOT NULL,
 CONSTRAINT [PK_OP_AppAuditLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_AppAuditLog] ADD  CONSTRAINT [DF_AuditLog_CreationTime]  DEFAULT (sysutcdatetime()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[OP_AppAuditLog] ADD  CONSTRAINT [DF_AuditLog_ResponseBodyTruncated]  DEFAULT ((0)) FOR [ResponseBodyTruncated]
GO


