
CREATE TABLE [dbo].[UIM_UserGroupEmployeeMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Password] [nvarchar](50) NULL,
	[ModifiedUserId] [int] NULL,
	[CreatedUserId] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ExtraFlagReturnLimit] [bit] NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.UIM_UserGroupEmployeeMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_UIM_UserGroupEmployeeMapping_UserGroupIdEmployyeIdFirm] UNIQUE NONCLUSTERED 
(
	[UserGroupId] ASC,
	[EmployeeId] ASC,
	[Firm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UIM_UserGroupEmployeeMapping] ADD  CONSTRAINT [DF__UIM_UserGroupEmployeeMapping__Creat__0A096455]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[UIM_UserGroupEmployeeMapping] ADD  DEFAULT ((0)) FOR [IsDefault]
GO
