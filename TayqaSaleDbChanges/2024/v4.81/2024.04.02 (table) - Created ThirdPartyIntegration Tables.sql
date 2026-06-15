
IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyIncomingLogCommonExtension]') AND type in (N'U'))

CREATE TABLE [dbo].[OP_ThirdPartyIncomingLogCommonExtension](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[WhouseNr] [int] NOT NULL,
	[FactoryNr] [smallint] NOT NULL,
	[DoctrackingValue] [varchar](50) NULL,
	[DeliveryFirm] [varchar](100) NULL,
	[ProjectCode] [varchar](100) NULL,
	[DoReserve] [bit] NULL,
	[OptAffectCollatrl] [smallint] NULL,
	[RetCostType] [tinyint] NULL,
	[PaymentPlanId] [int] NULL,
	[DiscountAmount] [float] NULL,
	[DiscountPercent] [float] NULL,
	[DeliveryDate] [datetime] NULL,
	[PaymentPlanCode] [nvarchar](50) NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent3] [float] NULL,
	[ClientShipCode] [nvarchar](50) NULL,
	[CustomerOrderNo] [nvarchar](50) NULL,
 CONSTRAINT [PK_OP_ThirdPartyIncomingLogCommonExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
)) ON [PRIMARY]

END

GO

