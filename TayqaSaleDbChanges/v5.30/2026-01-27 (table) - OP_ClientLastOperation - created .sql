CREATE TABLE [dbo].[OP_ClientLastOperation](
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[OperationType] [tinyint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[DocNumber] [nvarchar](50) NULL,
	[EmployeeId] [int] NULL,
	[Description] [nvarchar](500) NULL,
	[Amount] [float] NULL,
	[RegisteredDate] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OP_ClientLastOperation] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO