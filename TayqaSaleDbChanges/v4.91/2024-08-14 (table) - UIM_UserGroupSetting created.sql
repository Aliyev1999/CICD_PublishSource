
CREATE TABLE [dbo].[UIM_UserGroupSetting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[Firm] [smallint] NULL,
	[SettingId] [smallint] NOT NULL,
	[SettingValue] [nvarchar](100) NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_UserGroupSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_UIM_UserGroupSetting] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[SettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UIM_UserGroupSetting] ADD  CONSTRAINT [DF_UIM_UserGroupSetting_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
