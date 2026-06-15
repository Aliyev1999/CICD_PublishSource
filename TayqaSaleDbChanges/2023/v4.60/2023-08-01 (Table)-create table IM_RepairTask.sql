

CREATE TABLE [dbo].[IM_RepairTask](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DemandId] [int] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[Priority] [bit] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[Status] [tinyint] NOT NULL,
	[PauseTime] [datetime] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[ReasonId] [int] NULL,
	[RejectedUserId] [bigint] NULL,
	[RejectionDate] [datetime] NULL,
	[ConfirmedUserId] [bigint] NULL,
	[ConfirmationDate] [datetime] NULL,
	[AssignedUserId] [bigint] NULL,
	[AssignerUserId] [bigint] NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
	[ConfirmationNote] [nvarchar](max) NULL,
	[RejectionNote] [nvarchar](max) NULL,
	[RepairedUserNote] [nvarchar](max) NULL,
	[RepairResultDate] [datetime] NULL,
	[RepairedUserReasonId] [int] NULL,
	[RepairStatus] [tinyint] NULL,
 CONSTRAINT [PK_IM_REPAIRTASK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO


