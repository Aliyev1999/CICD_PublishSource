

CREATE TABLE [dbo].[IM_RepairConsumptionLines](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConsumptionId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
	[UnitCode] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_IM_REPAIRCONSUMPTIONLINES] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

ALTER TABLE [dbo].[IM_RepairConsumptionLines] ADD  DEFAULT ('AD') FOR [UnitCode]
GO


