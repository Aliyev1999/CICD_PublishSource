
CREATE TABLE [dbo].[WMM_TaskPosition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StatusId] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
	[Position] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

