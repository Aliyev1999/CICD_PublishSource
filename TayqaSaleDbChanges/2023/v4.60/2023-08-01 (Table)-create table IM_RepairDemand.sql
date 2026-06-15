

CREATE TABLE [dbo].[IM_RepairDemand](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[Status] [tinyint] NOT NULL,
	[RejectReasonId] [int] NULL,
	[CancelReasonId] [int] NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[ConfirmingUserId] [bigint] NULL,
	[ConfirmationTime] [datetime] NULL,
	[RejectedUserId] [bigint] NULL,
	[RejectionTime] [datetime] NULL,
	[CancelledUserId] [bigint] NULL,
	[CancelledDate] [datetime] NULL,
	[ActTime] [datetime] NULL,
	[ConfirmedUserDescription] [nvarchar](max) NULL,
	[RejectedUserDescription] [nvarchar](max) NULL,
	[CancelledUserDescription] [nvarchar](max) NULL,
	[IsPrinted] [bit] NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[DocumentedUserId] [bigint] NULL,
	[DocumentedDate] [datetime] NULL,
	[IsDocumented] [bit] NOT NULL,
	[ActNo] [nvarchar](max) NULL,
	[DocumentationNote] [nvarchar](max) NULL,
 CONSTRAINT [PK_IM_REPAIRDEMAN] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

ALTER TABLE [dbo].[IM_RepairDemand] ADD  CONSTRAINT [DF__IM_Repair__IsPri__72ABA01A]  DEFAULT ((0)) FOR [IsPrinted]
GO

ALTER TABLE [dbo].[IM_RepairDemand] ADD  DEFAULT ((0)) FOR [IsDocumented]
GO


