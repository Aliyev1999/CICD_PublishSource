CREATE TABLE [dbo].[SYS_ExcelTemplate](
	[Id] [smallint] NOT NULL IDENTITY(1, 1),
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[FilePath] [nvarchar](250) NOT NULL,
	[ModuleId] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO