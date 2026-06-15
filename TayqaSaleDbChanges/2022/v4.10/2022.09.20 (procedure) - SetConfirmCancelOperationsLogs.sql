CREATE TABLE [dbo].[SetConfirmCancelOperationsLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ErpId] [int] NOT NULL,
	[DocId] [nvarchar](50) NULL,
	[CancelledUserId] [int] NULL,
	[ConfirmedUserId] [int] NULL,
	[CancelledTime] [datetime] NULL,
	[ConfirmedTime] [datetime] NULL,
	[ResponseBody] [nvarchar](max) NULL,
	[SourceType] [tinyint] NULL,
	[StatusCode] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SetConfirmCancelOperationsLogs] ADD  DEFAULT ((0)) FOR [ErpId]
GO


