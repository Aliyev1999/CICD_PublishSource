
/****** Object:  Table [dbo].[SYS_NonGridRelatedActionInput]    Script Date: 12/15/2022 4:12:13 PM ******/

CREATE TABLE [dbo].[SYS_NonGridRelatedActionInput](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ActionId] [int] NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[SqlParameterName] [nvarchar](50) NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[DataType] [tinyint] NOT NULL,
	[TenantId] [int] NOT NULL,
 CONSTRAINT [PK__SYS_NonG__3214EC074BFD27A0] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
