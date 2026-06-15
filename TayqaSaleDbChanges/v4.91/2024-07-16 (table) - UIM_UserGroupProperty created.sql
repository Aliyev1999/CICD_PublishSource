
CREATE TABLE [dbo].[UIM_UserGroupProperty](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Specode1] [nvarchar](200) NULL,
	[Specode2] [nvarchar](50) NULL,
	[Specode3] [nvarchar](50) NULL,
	[Specode4] [nvarchar](50) NULL,
	[Specode5] [nvarchar](50) NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
 CONSTRAINT [PK_UIM_UserGroupProperty] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UIM_UserGroupProperty] ADD  CONSTRAINT [DF_UIM_UserGroupProperty_CreatedDate]  DEFAULT (getdate()) FOR [CreationTime]
GO
