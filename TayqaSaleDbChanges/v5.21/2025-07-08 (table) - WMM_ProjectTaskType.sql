
CREATE TABLE [dbo].[WMM_ProjectTaskType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Icon] [nvarchar](500) NOT NULL,
	[Functionalities] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK_WMM_ProjectTaskType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_ProjectTaskType] ADD  CONSTRAINT [DF_WMM_ProjectTaskType_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_ProjectTaskType] ADD  CONSTRAINT [DF_WMM_ProjectTaskType_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[WMM_ProjectTaskType] ADD  CONSTRAINT [DF_WMM_ProjectTaskType_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[WMM_ProjectTaskType]  WITH CHECK ADD  CONSTRAINT [FK_WMM_ProjectTaskType_WMM_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[WMM_Project] ([Id])
GO

ALTER TABLE [dbo].[WMM_ProjectTaskType] CHECK CONSTRAINT [FK_WMM_ProjectTaskType_WMM_Project]
GO

