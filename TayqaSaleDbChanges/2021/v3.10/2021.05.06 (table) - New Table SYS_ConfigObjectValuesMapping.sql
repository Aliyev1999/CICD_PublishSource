CREATE TABLE [dbo].[SYS_ConfigObjectValuesMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[DocConfigObjectId] [smallint] NOT NULL,
	[DocConfigObjectValue] [nvarchar](50) NULL,
	[LineConfigObjectId] [smallint] NOT NULL,
	[LineConfigObjectValue] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
