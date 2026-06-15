CREATE TABLE [dbo].[IM_TransferDemand](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[DivisionNr] [smallint] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[FromClientId] [int] NOT NULL,
	[ToClientId] [int] NOT NULL,
	[ReasonId] [int] NOT NULL,
	[IsDeliveryRequired] [bit] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [int] NULL,
	[CreatedUserNote] [nvarchar](1000) NULL,
	[ConfirmedUserId] [int] NULL,
	[ConfirmedDate] [datetime] NULL,
	[ConfirmedUserDescription] [nvarchar](max) NULL,
	[RejectedUserId] [int] NULL,
	[RejectedDate] [datetime] NULL,
	[RejectedUserDescription] [nvarchar](max) NULL,
	[DeliveredUserId] [int] NULL,
	[DeliveredDate] [datetime] NULL,
	[PlannedDate] [datetime] NULL,
	[PlannedUserId] [int] NULL,
	[CancelledUserId] [int] NULL,
	[CancelledDate] [datetime] NULL,
	[CancelledUserDescription] [nvarchar](max) NULL,
	[IsDocumented] [bit] NOT NULL,
	[DocumentedDate] [datetime] NULL,
	[DocumentedUserId] [int] NULL,
	[Status] [tinyint] NOT NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[PrintStatus] [tinyint] NOT NULL,
	[CompletedDate] [datetime] NULL,
	[CompletedUserId] [bigint] NULL,
 CONSTRAINT [PK_IM_TransferDemand] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_TransferDemand] ADD  CONSTRAINT [DF_IM_TransferDemand_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[IM_TransferDemand] ADD  CONSTRAINT [DF_IM_TransferDemand_IsDocumented]  DEFAULT ((0)) FOR [IsDocumented]
GO

ALTER TABLE [dbo].[IM_TransferDemand] ADD  CONSTRAINT [DF_IM_TransferDemand_PrintStatus]  DEFAULT ((0)) FOR [PrintStatus]
GO


CREATE TABLE [dbo].[IM_TransferDemandImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[SecureUrl]  AS (concat('NewImage-IM-TransferDemandImages','-',[Id],reverse(left(reverse([ImageUrl]),charindex('\',reverse([ImageUrl])))))),
	[TransferDemandId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedUserId] [int] NULL,
 CONSTRAINT [PK__IM_Trans__3214EC0734708839] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[IM_TransferDemandImages] ADD  CONSTRAINT [DF__IM_Transf__Creat__6ECE8B90]  DEFAULT (getdate()) FOR [CreatedDate]
GO