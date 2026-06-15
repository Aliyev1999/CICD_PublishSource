CREATE TABLE [dbo].[WPM_PhotoFeedbackCommentAndReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LikeStatus] [bit] NOT NULL,
	[ReasonId] [int] NULL,
	[Comment] [nvarchar](1000) NULL,
	[UserId] [int] NOT NULL,
	[AttachmentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WPM_PhotoFeedbackCommentAndReason] ADD  DEFAULT ((0)) FOR [LikeStatus]
GO

ALTER TABLE [dbo].[WPM_PhotoFeedbackCommentAndReason] ADD  DEFAULT ((0)) FOR [UserId]
GO

ALTER TABLE [dbo].[WPM_PhotoFeedbackCommentAndReason]  WITH CHECK ADD FOREIGN KEY([AttachmentId])
REFERENCES [dbo].[WPM_Attachment] ([Id])
GO