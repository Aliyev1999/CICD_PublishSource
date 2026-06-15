IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyIncomingLogCommonLineExtension]') AND type in (N'U'))

BEGIN


CREATE TABLE [dbo].[OP_ThirdPartyIncomingLogCommonLineExtension](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[IsPromo] [bit] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[Amount] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[ItemUnitCode] [nvarchar](50) NOT NULL,
	[DiscountAmount] [float] NULL,
	[DiscountPercent] [float] NULL,
	[IsCustomPrice] [bit] NULL,
	[DiscountAmount2] [float] NULL,
	[DiscountPercent2] [float] NULL,
	[DiscountAmount3] [float] NULL,
	[DiscountPercent3] [float] NULL,
	[BeepCount] [smallint] NULL,
	[VatAmount] [float] NULL,
	[VatRate] [float] NULL,
	[DeliveryDate] [datetime] NULL,
	[ActionSpecode] [nvarchar](255) NULL,
	[ReturnCostType] [tinyint] NULL,
	[InvoiceId] [int] NULL,
	[InvoiceNo] [nvarchar](50) NULL,
 CONSTRAINT [PK_OP_ThirdPartyIncomingLogCommonLineExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ItemId] ASC,
	[IsPromo] ASC
)) ON [PRIMARY]

END
GO