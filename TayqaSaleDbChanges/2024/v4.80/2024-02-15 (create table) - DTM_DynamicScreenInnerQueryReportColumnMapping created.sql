
CREATE TABLE [dbo].[DTM_DynamicScreenInnerQueryReportColumnMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceId] [int] NOT NULL,
	[FieldName] [nvarchar](100) NOT NULL,
	[InnerQueryIndex] [tinyint] NOT NULL,
	[Label] [nvarchar](100) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
