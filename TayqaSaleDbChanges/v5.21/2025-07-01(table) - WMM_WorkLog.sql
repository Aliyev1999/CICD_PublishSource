CREATE TABLE [dbo].[WMM_WorkLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[ReferenceId] [int] NOT NULL,
	[ReferenceType] [tinyint] NOT NULL,
	[TimeSpentMinutes] [int] NOT NULL,
	[Description] [nvarchar](2048) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_WMM_WorkLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_WorkLog] ADD  CONSTRAINT [DF_WMM_WorkLog_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_WorkLog] ADD  CONSTRAINT [DF_WMM_WorkLog_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
