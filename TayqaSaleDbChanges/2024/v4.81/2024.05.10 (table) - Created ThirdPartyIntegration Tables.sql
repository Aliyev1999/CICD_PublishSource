IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyWarehouseOperationLineResultLog]') AND type in (N'U'))

BEGIN



CREATE TABLE [dbo].[OP_ThirdPartyWarehouseOperationLineResultLog](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
 CONSTRAINT [PK_OP_ThirdPartyWarehouseOperationLineResultLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ItemId] ASC
)) ON [PRIMARY]


END
GO