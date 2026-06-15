/****** Object:  Table [dbo].[MD_ItemGroupPlanExtension]    Script Date: 10/19/2021 11:15:23 AM ******/

CREATE TABLE [dbo].[MD_ItemGroupPlanExtension](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemGroupId] [int] NOT NULL UNIQUE,
	[LineNr] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


