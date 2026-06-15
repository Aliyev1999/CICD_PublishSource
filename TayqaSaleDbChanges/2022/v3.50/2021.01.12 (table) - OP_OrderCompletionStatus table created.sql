CREATE TABLE [dbo].[OP_OrderCompletionStatus](
	[ErpId] [bigint] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [UC_ErpId_Firm] UNIQUE NONCLUSTERED 
(
	[ErpId] ASC,
	[Firm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_OrderCompletionStatus] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO


