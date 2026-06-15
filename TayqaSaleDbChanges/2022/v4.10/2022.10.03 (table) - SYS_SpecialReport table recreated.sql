DROP TABLE SYS_SpecialReport

CREATE TABLE [dbo].[SYS_SpecialReport](
	[Id] [int] primary key IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Code] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[Module] [tinyint] NOT NULL,
	[SqlQuery] [varchar](max) NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[VisualElementsBitmask] [nchar](5) NULL,
	[GridStateJson] [nvarchar](max) NULL,
	[ParentId] [int] NULL)
GO
