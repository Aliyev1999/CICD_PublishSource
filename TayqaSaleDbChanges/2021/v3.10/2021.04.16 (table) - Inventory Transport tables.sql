CREATE TABLE [dbo].[IM_InventoryTransportPackage]
(
    [Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    CreationTime DATETIME NOT NULL DEFAULT(GETDATE()),
    CreatorUserId BIGINT NULL,
    LastModificationTime DATETIME NULL,
    LastModifierUserId BIGINT NULL,
    PackageStatus TINYINT NOT NULL DEFAULT(0),
    [Status] BIT NOT NULL DEFAULT(0),
    [Firm] SMALLINT NOT NULL,
    [TruckId] INT NOT NULL,
    [DriverUserId] BIGINT NOT NULL
);

GO

CREATE TABLE [dbo].[IM_TransportPackageDemandMapping]
(
    [TransportPackageId] INT NOT NULL,
    [InventoryDemandId] INT NOT NULL,
    CreationTime DATETIME NOT NULL DEFAULT(GETDATE()),
    CreatorUserId BIGINT NULL,
    OrderNo SMALLINT not NULL DEFAULT(0)
    PRIMARY KEY (TransportPackageId,InventoryDemandId)
);

GO

ALTER TABLE DM_Truck ADD DefaultDriverId BIGINT NULL