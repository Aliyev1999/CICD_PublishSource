ALTER TABLE IM_InventoryTransportPackage
ADD PackageDemandType tinyint;

GO

UPDATE IM_InventoryTransportPackage SET PackageDemandType = 1 WHERE PackageDemandType IS NULL;

GO

ALTER TABLE IM_InventoryTransportPackage
ALTER COLUMN PackageDemandType tinyint not null


CREATE TABLE [dbo].[IM_TransportPackageTransferDemandMapping](
	[TransportPackageId] [int] NOT NULL,
	[TransferDemandId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[OrderNo] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TransportPackageId] ASC,
	[TransferDemandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_TransportPackageTransferDemandMapping] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[IM_TransportPackageTransferDemandMapping] ADD  DEFAULT ((0)) FOR [OrderNo]
GO