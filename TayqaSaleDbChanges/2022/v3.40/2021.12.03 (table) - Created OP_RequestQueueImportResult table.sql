/****** Object:  Table [dbo].[OP_RequestQueueImportResult]    Script Date: 12/3/2021 5:07:27 PM ******/
CREATE TABLE [dbo].[OP_RequestQueueImportResult](
	[RequestId] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[ImportResult] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_OP_RequestQueueImportResult_1] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_RequestQueueImportResult] ADD  CONSTRAINT [DF_OP_RequestQueueImportResult_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO


