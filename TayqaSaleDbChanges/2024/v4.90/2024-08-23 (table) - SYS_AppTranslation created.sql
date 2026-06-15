
CREATE TABLE [dbo].[SYS_AppTranslation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ActualString] [nvarchar](500) NULL,
	[NewStringAz] [nvarchar](500) NULL,
	[NewStringRu] [nvarchar](500) NULL,
	[NewStringEn] [nvarchar](500) NULL,
	[NewStringTr] [nvarchar](500) NULL
) ON [PRIMARY]
GO
