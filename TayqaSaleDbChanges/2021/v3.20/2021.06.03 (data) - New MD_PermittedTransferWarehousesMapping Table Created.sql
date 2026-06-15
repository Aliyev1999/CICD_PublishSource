/****** Object:  Table [dbo].[MD_PermittedTransferWarehousesMapping]    Script Date: 6/30/2021 12:48:27 PM ******/

CREATE TABLE [dbo].[MD_PermittedTransferWarehousesMapping](
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[EnteranceWarehouseNr] [int] NOT NULL,
	[ExitWarehouseNr] [int] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MD_PermittedTransferWarehousesMapping] PRIMARY KEY CLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[EnteranceWarehouseNr] ASC,
	[ExitWarehouseNr] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_PermittedTransferWarehousesMapping] ADD  CONSTRAINT [DF_MD_Permit_Regis_Date]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
