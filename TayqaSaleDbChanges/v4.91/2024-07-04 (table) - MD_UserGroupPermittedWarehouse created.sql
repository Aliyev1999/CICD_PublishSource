
CREATE TABLE [dbo].[MD_UserGroupPermittedWarehouse](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[TigerWarehouseNr] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
	[IsDefault] [bit] NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_UserGroupPermittedWarehouse] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[TigerWarehouseNr] ASC,
	[OperationId] ASC,
	[DivisionNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedWarehouse] ADD  CONSTRAINT [DF__MD_UserGroupPermittedWarehouse__Regis__76026BA8]  DEFAULT (getdate()) FOR [RegisteredDate]
GO


