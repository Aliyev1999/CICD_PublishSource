CREATE TABLE [dbo].[OP_ErpSmartExceptionHandlerLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ServiceDownErrorCount] [int] NOT NULL,
	[ServiceDownIntervalInMinutes] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[Exception] [nvarchar](max) NULL,
 CONSTRAINT [PK_OP_ErpSmartExceptionHandlerLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_ErpSmartExceptionHandlerLog] ADD  CONSTRAINT [DF_OP_ErpSmartExceptionHandlerLog_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO


