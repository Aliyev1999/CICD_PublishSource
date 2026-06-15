
/****** Object:  Table [dbo].[CDE_ExternalIntegrationLogs_SerialNumbers]    Script Date: 4/21/2025 2:53:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CDE_ExternalIntegrationLogs_SerialNumbers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LogId] [int] NULL,
	[SerialNumber] [nvarchar](100) NULL,
	[ResultId] [smallint] NULL,
	[ResultDesc] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

