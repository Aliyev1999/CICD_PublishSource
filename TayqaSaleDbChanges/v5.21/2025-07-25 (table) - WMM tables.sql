


CREATE TABLE [dbo].[WMM_Permission](
	[Id] [int] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
 CONSTRAINT [PK_WMM_Permission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_Permission] ADD  CONSTRAINT [DF_WMM_Permission_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_Permission]  WITH CHECK ADD  CONSTRAINT [FK_WMM_Permission_Id_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[WMM_Permission] ([Id])
GO

ALTER TABLE [dbo].[WMM_Permission] CHECK CONSTRAINT [FK_WMM_Permission_Id_ParentId]
GO

ALTER TABLE [dbo].[WMM_Permission]  WITH CHECK ADD  CONSTRAINT [FK_WMM_Permission_WMM_Permission] FOREIGN KEY([ParentId])
REFERENCES [dbo].[WMM_Permission] ([Id])
GO

ALTER TABLE [dbo].[WMM_Permission] CHECK CONSTRAINT [FK_WMM_Permission_WMM_Permission]
GO



CREATE TABLE [dbo].[WMM_Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK_WMM_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_Role] ADD  CONSTRAINT [DF_WMM_Role_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_Role] ADD  CONSTRAINT [DF_WMM_Role_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[WMM_Role] ADD  CONSTRAINT [DF_WMM_Role_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO




CREATE TABLE [dbo].[WMM_RolePermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[PermissionId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
 CONSTRAINT [PK_WMM_RolePermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_RolePermission] ADD  CONSTRAINT [DF_WMM_RolePermission_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_WMM_RolePermission_WMM_Permission_Id] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[WMM_Permission] ([Id])
GO

ALTER TABLE [dbo].[WMM_RolePermission] CHECK CONSTRAINT [FK_WMM_RolePermission_WMM_Permission_Id]
GO

ALTER TABLE [dbo].[WMM_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_WMM_RolePermission_WMM_Role_Id] FOREIGN KEY([RoleId])
REFERENCES [dbo].[WMM_Role] ([Id])
GO

ALTER TABLE [dbo].[WMM_RolePermission] CHECK CONSTRAINT [FK_WMM_RolePermission_WMM_Role_Id]
GO






CREATE TABLE [dbo].[WMM_Attachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[Url] [nvarchar](max) NOT NULL,
	[ReferenceType] [tinyint] NOT NULL,
	[ReferenceId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[SecureUrl]  AS (concat(N'NewFile-WMM-Attachment',N'-',[Id],reverse(left(reverse([Url]),charindex(N'\',reverse([Url])))))),
 CONSTRAINT [PK__WMM_Atta__3214EC07157325D7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_Attachment] ADD  CONSTRAINT [DF_WMM_Attachment_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO



CREATE TABLE [dbo].[WMM_ProjectAccess](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ReferenceType] [tinyint] NOT NULL,
	[ReferenceId] [bigint] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK_WMM_ProjectAccess] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_ProjectAccess] ADD  CONSTRAINT [DF_WMM_ProjectAccess_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_ProjectAccess] ADD  CONSTRAINT [DF_WMM_ProjectAccess_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[WMM_ProjectAccess]  WITH CHECK ADD  CONSTRAINT [FK_WMM_ProjectAccess_WMM_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[WMM_Project] ([Id])
GO

ALTER TABLE [dbo].[WMM_ProjectAccess] CHECK CONSTRAINT [FK_WMM_ProjectAccess_WMM_Project]
GO

ALTER TABLE [dbo].[WMM_ProjectAccess]  WITH CHECK ADD  CONSTRAINT [FK_WMM_ProjectAccess_WMM_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[WMM_Role] ([Id])
GO

ALTER TABLE [dbo].[WMM_ProjectAccess] CHECK CONSTRAINT [FK_WMM_ProjectAccess_WMM_Role]
GO



CREATE TABLE [dbo].[WMM_ProjectActivityTypeField](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectActivityTypeId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsMandatory] [bit] NOT NULL,
	[InputType] [tinyint] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[ExtraInfo] [nvarchar](max) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK_WMM_ProjectActionTypeField] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityTypeField] ADD  CONSTRAINT [DF_WMM_ProjectActionTypeField_IsMandatory]  DEFAULT ((0)) FOR [IsMandatory]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityTypeField] ADD  CONSTRAINT [DF_WMM_ProjectActionTypeField_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityTypeField] ADD  CONSTRAINT [DF_WMM_ProjectActionTypeField_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityTypeField] ADD  CONSTRAINT [DF_WMM_ProjectActionTypeField_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[WMM_ProjectActivityTypeField]  WITH CHECK ADD  CONSTRAINT [FK_WMM_ProjectActionTypeField_WMM_ProjectActionType] FOREIGN KEY([ProjectActivityTypeId])
REFERENCES [dbo].[WMM_ProjectActivityType] ([Id])
GO

ALTER TABLE [dbo].[WMM_ProjectActivityTypeField] CHECK CONSTRAINT [FK_WMM_ProjectActionTypeField_WMM_ProjectActionType]
GO




CREATE TABLE [dbo].[WMM_ProjectComponent](
	[Id] [int] NULL,
	[ProjectId] [int] NULL,
	[ComponentId] [int] NULL,
	[CreationTime] [datetime] NULL,
	[CreatorUserId] [bigint] NULL
) ON [PRIMARY]
GO



CREATE TABLE [dbo].[WMM_ProjectContent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[Type] [tinyint] NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[DeleterUserId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_ProjectContent] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[WMM_ProjectContent] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_ProjectContent] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO


CREATE TABLE [dbo].[WMM_ProjectTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[Color] [nvarchar](20) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[DeletionTime] [datetime] NULL,
	[DeleterUserId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_ProjectTag] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO



CREATE TABLE [dbo].[WMM_ProjectTaskStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Category] [tinyint] NOT NULL,
	[OrderNo] [tinyint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK_WMM_ProjectTaskStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_ProjectTaskStatus] ADD  CONSTRAINT [DF_WMM_ProjectTaskStatus_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_ProjectTaskStatus] ADD  CONSTRAINT [DF_WMM_ProjectTaskStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[WMM_ProjectTaskStatus] ADD  CONSTRAINT [DF_WMM_ProjectTaskStatus_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO




CREATE TABLE [dbo].[WMM_SelectComponent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[SourceType] [tinyint] NOT NULL,
	[SelectType] [tinyint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK__WMM_Comp__3214EC07784FF1EF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_SelectComponent] ADD  CONSTRAINT [DF__WMM_Compo__Creat__0C454D9E]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_SelectComponent] ADD  CONSTRAINT [DF__WMM_Compo__IsAct__0D3971D7]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[WMM_SelectComponent] ADD  CONSTRAINT [DF__WMM_Compo__IsDel__0E2D9610]  DEFAULT ((0)) FOR [IsDeleted]
GO



CREATE TABLE [dbo].[WMM_SelectComponentCustomOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
	[SelectComponentId] [int] NOT NULL,
 CONSTRAINT [PK__WMM_Sele__3214EC07169B9ADE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_SelectComponentCustomOption] ADD  CONSTRAINT [DF_WMM_SelectComponentCustomOption_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO



CREATE TABLE [dbo].[WMM_SelectComponentTableDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SelectComponentId] [int] NOT NULL,
	[TableName] [nvarchar](250) NOT NULL,
	[ValueColumn] [nvarchar](100) NULL,
	[Separator] [char](1) NOT NULL,
	[Condition] [nvarchar](max) NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeleterUserId] [bigint] NULL,
	[DeletionTime] [datetime] NULL,
 CONSTRAINT [PK_WMM_SelectComponentTableDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_SelectComponentTableDetail] ADD  CONSTRAINT [DF_WMM_SelectComponentTableDetail_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[WMM_SelectComponentTableDetail]  WITH CHECK ADD  CONSTRAINT [FK_WMM_SelectComponentTableDetail_WMM_SelectComponent] FOREIGN KEY([SelectComponentId])
REFERENCES [dbo].[WMM_SelectComponent] ([Id])
GO

ALTER TABLE [dbo].[WMM_SelectComponentTableDetail] CHECK CONSTRAINT [FK_WMM_SelectComponentTableDetail_WMM_SelectComponent]
GO



CREATE TABLE [dbo].[WMM_SelectComponentTableDisplayColumn](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SelectComponentTableDetailId] [int] NOT NULL,
	[ColumnName] [nvarchar](100) NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
 CONSTRAINT [PK_WMM_SelectComponentTableDisplayColumn] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_SelectComponentTableDisplayColumn]  WITH CHECK ADD  CONSTRAINT [FK_WMM_SelectComponentTableDisplayColumn_WMM_SelectComponentTableDetail] FOREIGN KEY([SelectComponentTableDetailId])
REFERENCES [dbo].[WMM_SelectComponentTableDetail] ([Id])
GO

ALTER TABLE [dbo].[WMM_SelectComponentTableDisplayColumn] CHECK CONSTRAINT [FK_WMM_SelectComponentTableDisplayColumn_WMM_SelectComponentTableDetail]
GO




CREATE TABLE [dbo].[WMM_TaskActivityDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskActivityId] [int] NOT NULL,
	[FieldId] [int] NOT NULL,
	[Value] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_TaskActivityDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_WMM_TaskActivityDetail_TaskActivity] FOREIGN KEY([TaskActivityId])
REFERENCES [dbo].[WMM_TaskActivity] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[WMM_TaskActivityDetail] CHECK CONSTRAINT [FK_WMM_TaskActivityDetail_TaskActivity]
GO


CREATE TABLE [dbo].[WMM_TaskComment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NULL,
	[ParentId] [int] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_TaskComment] ADD  CONSTRAINT [DF_WMM_TaskComment_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO



CREATE TABLE [dbo].[WMM_TaskHistory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[FieldType] [tinyint] NOT NULL,
	[OldValue] [nvarchar](100) NULL,
	[OldString] [nvarchar](max) NULL,
	[NewValue] [nvarchar](100) NULL,
	[NewString] [nvarchar](max) NULL,
	[CreationTime] [datetime] NOT NULL,
	[TaskId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_TaskHistory] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[WMM_TaskHistory] ADD  DEFAULT ((0)) FOR [TaskId]
GO



CREATE TABLE [dbo].[WMM_TaskStatusChange](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NULL,
	[StatusId] [int] NULL,
	[CreatorUserId] [bigint] NULL,
	[ReasonId] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[CreationTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WMM_TaskStatusChange] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO


CREATE TABLE [dbo].[WMM_TaskWatch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


