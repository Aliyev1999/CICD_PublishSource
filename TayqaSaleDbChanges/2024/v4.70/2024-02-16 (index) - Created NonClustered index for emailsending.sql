CREATE NONCLUSTERED INDEX [IX_MSG_EmailSending_Status_WaitingTime] ON [dbo].[MSG_EmailSending]
(
	[Status] ASC,
	[WaitingTime] ASC
)