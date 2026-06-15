
/****** Object:  Table [dbo].[CM_SalesmanOrganization]    Script Date: 7/15/2022 11:17:47 AM ******/

CREATE TABLE [dbo].[CM_SalesmanOrganization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[SalesmanTigerId] [int] NOT NULL,
	[SaleGroupStructureId] [int] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
