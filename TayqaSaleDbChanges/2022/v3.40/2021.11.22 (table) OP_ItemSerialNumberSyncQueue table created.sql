CREATE TABLE [dbo].[OP_ItemSerialNumberSyncQueue](
	[Id]  AS (concat([UserId],'-',[ItemId],'-',[WarehouseNr],'-',[Firm],'-',[Period])),
	[UserId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Period] [smallint] NOT NULL,
	[ProcessingStatus] [bit] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_ItemSerialNumberSyncQueue] ADD  DEFAULT ((0)) FOR [ProcessingStatus]
GO

ALTER TABLE [dbo].[OP_ItemSerialNumberSyncQueue] ADD  CONSTRAINT [DF__OP_Serial__Regis__6EA3A307]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
