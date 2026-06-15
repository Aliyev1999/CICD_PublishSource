

CREATE TABLE [dbo].[SYS_HiddenComponent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Route] [varchar](255) NOT NULL,
	[ElementId] [nvarchar](255) NOT NULL,
	[IsHidden] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
go
ALTER TABLE [dbo].[SYS_HiddenComponent] ADD  DEFAULT ((0)) FOR [IsHidden]
GO


