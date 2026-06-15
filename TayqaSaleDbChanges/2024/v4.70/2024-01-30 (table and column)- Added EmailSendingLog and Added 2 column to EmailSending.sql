

CREATE TABLE [dbo].[MSG_EmailSendingLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailSendingId] [int] NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Details] [nvarchar](max) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

go 

ALTER TABLE MSG_EmailSending
ADD [SourceType] [tinyint] NULL,
	[ReferenceId] [int] NULL
