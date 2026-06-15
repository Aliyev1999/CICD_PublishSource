
CREATE TABLE [dbo].[IM_RepairConsumption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[WarehouseNr] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[FeedbackUserId] [bigint] NULL,
	[FeedbackDate] [datetime] NULL,
	[ReasonId] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[IsPrinted] [bit] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
 CONSTRAINT [PK_IM_REPAIRCONSUMPTION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
go
ALTER TABLE [dbo].[IM_RepairConsumption] ADD  CONSTRAINT [DF__IM_Repair__IsPri__739FC453]  DEFAULT ((0)) FOR [IsPrinted]
GO


