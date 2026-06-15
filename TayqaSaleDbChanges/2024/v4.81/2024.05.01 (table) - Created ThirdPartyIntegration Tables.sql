IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyResultLog]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[OP_ThirdPartyResultLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NULL,
	[FeedbackStatus] [tinyint] NULL,
	[FeedbackUserId] [int] NULL,
	[FeedbackNote] [nvarchar](255) NULL,
	[FeedbackDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]

ALTER TABLE [dbo].[OP_ThirdPartyResultLog] ADD  DEFAULT (getdate()) FOR [FeedbackDate]
END
GO