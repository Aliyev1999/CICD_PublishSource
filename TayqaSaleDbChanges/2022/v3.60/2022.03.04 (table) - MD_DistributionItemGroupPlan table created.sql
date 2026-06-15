CREATE TABLE [dbo].MD_DistributionItemGroupPlan(
	[Id] [int] IDENTITY(1,1) primary key,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NULL,
	[Year] [smallint] NULL,
	[Month] tinyint NULL,
	[RegisteredDate] [datetime] NOT NULL default (getdate()),
	[Amount] [float] NULL,
	[Quantity] [float] NULL,
	[ItemGroupId] [int] NULL,
	[TargetClientCount] [float] NOT NULL,
	[ClientGroupId] [int] NULL)