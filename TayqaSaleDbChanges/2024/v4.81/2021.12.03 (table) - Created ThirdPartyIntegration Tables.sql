/****** Object:  Table [dbo].[OP_ThirdPartyImportResult]    Script Date: 12/3/2021 5:05:30 PM ******/
CREATE TABLE [dbo].[OP_ThirdPartyImportResult](
	[RequestId] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[ImportResultId] [int] NOT NULL,
	[ImportResultDesc] [nvarchar](250) NULL,
 CONSTRAINT [PK_OP_ThirdPartyImportResult_1] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[OP_ThirdPartyImportResultFailureArgLineInfo]    Script Date: 12/3/2021 5:05:30 PM ******/
CREATE TABLE [dbo].[OP_ThirdPartyImportResultFailureArgLineInfo](
	[RequestId] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Code] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[CreationTime] [datetime] NOT NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[OP_ThirdPartyRequestQueue]    Script Date: 12/3/2021 5:05:30 PM ******/
CREATE TABLE [dbo].[OP_ThirdPartyRequestQueue](
	[Id] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[ProcessingStatus] [bit] NOT NULL,
	[DocStatus] [tinyint] NOT NULL,
	[Step] [tinyint] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Period] [smallint] NOT NULL,
	[ProcessDate] [date] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Division] [smallint] NOT NULL,
	[Department] [smallint] NOT NULL,
	[FillAccode] [bit] NOT NULL,
	[DocType] [tinyint] NOT NULL,
	[DocId] [varchar](50) NOT NULL,
	[DocCreatedTime] [datetime] NOT NULL,
	[GpsLatitude] [float] NULL,
	[GpsLongitude] [float] NULL,
	[UserId] [int] NOT NULL,
	[SalesmanRef] [int] NULL,
	[Specode] [nvarchar](50) NULL,
	[TradingGroup] [varchar](100) NULL,
	[DeviceId] [uniqueidentifier] NOT NULL,
	[Note] [nvarchar](2000) NULL,
	[CurrencyType] [smallint] NULL,
	[OptAffectCollatrl] [bit] NULL,
	[DocNumber] [nvarchar](50) NULL,
	[AuthCode] [nvarchar](50) NULL,
	[IntegratorVersion] [varchar](50) NULL,
	[ChannelType] [tinyint] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[IgnoreSuspended] [bit] NULL,
	[SaleChannelType] [tinyint] NULL,
	[OperationType] [nvarchar](50) NULL,
	[RequestQueueStep] [tinyint] NOT NULL,
 CONSTRAINT [PK_ThirdPartyRequestQueue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[OP_ThirdPartyRequestQueueCashExtension]    Script Date: 12/3/2021 5:05:30 PM ******/
CREATE TABLE [dbo].[OP_ThirdPartyRequestQueueCashExtension](
	[Id] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[CashCode] [varchar](50) NOT NULL,
	[TranGroupNo] [varchar](50) NULL,
	[MasterTitle] [varchar](100) NULL,
 CONSTRAINT [PK_OP_ThirdPartyRequestQueueCashExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[OP_ThirdPartyRequestQueueCommonExtension]    Script Date: 12/3/2021 5:05:30 PM ******/
CREATE TABLE [dbo].[OP_ThirdPartyRequestQueueCommonExtension](
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
 CONSTRAINT [PK_OP_ThirdPartyRequestQueueCommonExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[OP_ThirdPartyRequestQueueCommonLineExtension]    Script Date: 12/3/2021 5:05:30 PM ******/
CREATE TABLE [dbo].[OP_ThirdPartyRequestQueueCommonLineExtension](
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
 CONSTRAINT [PK_OP_ThirdPartyRequestQueueCommonLineExtension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ItemId] ASC,
	[IsPromo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[OP_ThirdPartyRequestQueueCommonLineSerialNumberExtension]    Script Date: 12/3/2021 5:05:30 PM ******/
CREATE TABLE [dbo].[OP_ThirdPartyRequestQueueCommonLineSerialNumberExtension](
	[Id] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[PartNo] [tinyint] NOT NULL,
	[IsPromo] [bit] NULL,
	[SerialNumber] [nvarchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OP_ThirdPartyImportResult] ADD  CONSTRAINT [DF_OP_ThirdPartyImportResult_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
ALTER TABLE [dbo].[OP_ThirdPartyImportResultFailureArgLineInfo] ADD  CONSTRAINT [DF_OP_ThirdPartyFailureArgLineInfo_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO
ALTER TABLE [dbo].[OP_ThirdPartyRequestQueue] ADD  CONSTRAINT [DF_OP_ThirdPartyRequestQueue_ProcessingStatus]  DEFAULT ((0)) FOR [ProcessingStatus]
GO
ALTER TABLE [dbo].[OP_ThirdPartyRequestQueue] ADD  CONSTRAINT [DF_OP_ThirdPartyRequestQueue_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
