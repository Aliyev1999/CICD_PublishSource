CREATE TABLE [dbo].[CHL_UserSurveyResponseDetailAttachmentReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserSurveyResponseDetailId] [int] NOT NULL,
	[AttachmentId] [int] NOT NULL,
	[ReasonId] [int] NULL,
	[ReasonValue] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedUserId] [int] NULL,
 CONSTRAINT [PK_CHL_UserSurveyResponseDetailQuestionAttachmentReason] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CHL_UserSurveyResponseDetailAttachmentReason] ADD  CONSTRAINT [DF_CHL_UserSurveyResponseDetailQuestionAttachmentReason_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO


