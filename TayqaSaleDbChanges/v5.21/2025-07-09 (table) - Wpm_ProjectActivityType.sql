

CREATE TABLE [dbo].[WMM_ProjectActivityType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ProjectTaskTypeId] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[Icon] [nvarchar](1024) NOT NULL,
	[TimeTrackingIsRequired] [bit] NOT NULL,
 CONSTRAINT [PK_WMM_ProjectActionType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType] ADD  CONSTRAINT [DF_WMM_ProjectActionType_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType] ADD  CONSTRAINT [DF_WMM_ProjectActionType_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType] ADD  CONSTRAINT [DF_WMM_ProjectActionType_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType] ADD  DEFAULT ((0)) FOR [TimeTrackingIsRequired]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType]  WITH CHECK ADD  CONSTRAINT [FK_WMM_ProjectActionType_WMM_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[WMM_Project] ([Id])
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType] CHECK CONSTRAINT [FK_WMM_ProjectActionType_WMM_Project]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType]  WITH CHECK ADD  CONSTRAINT [FK_WMM_ProjectActionType_WMM_ProjectTaskType] FOREIGN KEY([ProjectTaskTypeId])
REFERENCES [dbo].[WMM_ProjectTaskType] ([Id])
GO

ALTER TABLE [dbo].[WMM_ProjectActivityType] CHECK CONSTRAINT [FK_WMM_ProjectActionType_WMM_ProjectTaskType]
GO


