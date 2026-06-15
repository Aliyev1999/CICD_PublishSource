
CREATE TABLE [dbo].[MGM_UserPermission](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PermissionId] [smallint] NOT NULL,
	[PermissionValue] [tinyint] NOT NULL,
	[CreatedUserId] [bigint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK__MGM_User__3214EC077424D79C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MGM_UserPermission] ADD  CONSTRAINT [DF__MGM_UserP__Creat__7DD7FE0D]  DEFAULT (getdate()) FOR [CreatedDate]
GO
