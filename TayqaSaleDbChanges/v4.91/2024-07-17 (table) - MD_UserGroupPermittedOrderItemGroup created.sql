
CREATE TABLE [dbo].[MD_UserGroupPermittedOrderItemGroup](
	[UserGroupId] [int] NOT NULL,
	[OrderItemGroupId] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_UserGroupPermittedOrderItemGroup] PRIMARY KEY CLUSTERED 
(
	[UserGroupId] ASC,
	[OrderItemGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedOrderItemGroup] ADD  CONSTRAINT [DF_MD_UserGroupPermittedOrderItemGroup_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
