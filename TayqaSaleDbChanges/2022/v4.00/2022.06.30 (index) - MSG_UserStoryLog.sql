ALTER TABLE MSG_UserStoryLog DROP CONSTRAINT UQ_UserId_ImageUrl;
go
ALTER TABLE [dbo].[MSG_UserStoryLog] ADD  CONSTRAINT [UQ_UserId_ImageUrl] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[ImageUrl] ASC,
	[SeenByUserId] ASC
)