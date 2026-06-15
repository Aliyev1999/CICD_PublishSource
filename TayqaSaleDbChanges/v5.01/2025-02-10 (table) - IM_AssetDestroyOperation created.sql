
CREATE TABLE [dbo].[IM_AssetDestroyOperation](
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
    [FirmNr] SMALLINT NOT NULL,
    [AssetId] INT NOT NULL,
    [ActNumber] NVARCHAR(50) NULL,
    [ReasonId] INT NOT NULL,
    [Note] NVARCHAR(500) NULL,
    [CreationTime] DATETIME NOT NULL DEFAULT GETDATE(),
    [CreatorUserId] BIGINT NOT NULL,
    CONSTRAINT [FK_IM_AssetDestroyOperation_Asset] FOREIGN KEY ([AssetId]) 
        REFERENCES [dbo].[IM_Asset]([Id]),
    CONSTRAINT [FK_IM_AssetDestroyOperation_Reason] FOREIGN KEY ([ReasonId]) 
        REFERENCES [dbo].[IM_StaticContent]([Id])
);