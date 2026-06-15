
CREATE TABLE [dbo].[MD_UserGroupPermittedTransferWarehouses](
	[Firm] [smallint] NOT NULL,
	[UserGroupId] [int] NOT NULL,
	[EnteranceWarehouseNr] [int] NOT NULL,
	[ExitWarehouseNr] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_UserGroupPermittedTransferWarehouses] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserGroupId] ASC,
	[EnteranceWarehouseNr] ASC,
	[ExitWarehouseNr] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_UserGroupPermittedTransferWarehouses] ADD  CONSTRAINT [DF_MD_UserGroupPermittedTransferWarehouses_Regis_Date]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
