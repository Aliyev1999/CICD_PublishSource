CREATE TABLE [dbo].[WPM_ActionGroupUserMapping](
	[UserId] [int] NOT NULL,
	[ActionGroupId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL DEFAULT (getdate()),
	[ModifiedDate] [datetime] NULL,
	[Id] [int] primary key identity,
) 