IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyIncomingLogWarehouseOperationLineExtension]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[OP_ThirdPartyIncomingLogWarehouseOperationLineExtension](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[Quantity] [float] NOT NULL,
	[BeepCount] [int] NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[OP_ThirdPartyIncomingLogWarehouseOperationLineExtension] ADD  DEFAULT ((0)) FOR [BeepCount]

END
GO