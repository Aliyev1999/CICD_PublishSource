
CREATE TABLE [dbo].[MSG_AutoGenerationReportEmailSendingLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AutoGenerationReportId] [int] NOT NULL,
	[EmailSendingId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[SendingScheduleTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

ALTER TABLE [dbo].[MSG_AutoGenerationReportEmailSendingLog] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[MSG_AutoGenerationReportEmailSendingLog] ADD  DEFAULT (getdate()) FOR [SendingScheduleTime]
GO


