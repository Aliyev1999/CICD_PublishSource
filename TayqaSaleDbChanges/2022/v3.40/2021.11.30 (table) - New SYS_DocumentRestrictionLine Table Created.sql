CREATE TABLE [dbo].[SYS_DocumentRestrictionLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentRestrictionId] [int] NOT NULL,
	[LineField] [tinyint] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[RegExFormat] [nvarchar](100) NULL,
	[Description] [nvarchar](250) NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SYS_DocumentRestrictionLine] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO
