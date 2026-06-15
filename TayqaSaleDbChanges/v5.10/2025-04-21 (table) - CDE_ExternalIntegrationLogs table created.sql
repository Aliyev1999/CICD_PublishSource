
/****** Object:  Table [dbo].[CDE_ExternalIntegrationLogs]    Script Date: 4/21/2025 2:52:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CDE_ExternalIntegrationLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Request] [nvarchar](max) NULL,
	[Response] [nvarchar](max) NULL,
	[RequestTime] [datetime] NULL,
	[RequestUserId] [bigint] NULL,
	[ResponseTime] [datetime] NULL,
	[Note] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[CDE_ExternalIntegrationLogs] ADD  DEFAULT (getdate()) FOR [RequestTime]
GO

