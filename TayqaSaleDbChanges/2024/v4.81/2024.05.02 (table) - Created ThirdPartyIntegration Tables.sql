IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[OP_ThirdPartyIncomingLog]') AND type in (N'U'))

BEGIN


CREATE TABLE [dbo].[OP_ThirdPartyIncomingLog](
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
 CONSTRAINT [PK_ThirdPartyIncomingLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[PartNo] ASC
))

ALTER TABLE [dbo].[OP_ThirdPartyIncomingLog] ADD  CONSTRAINT [DF_OP_ThirdPartyIncomingLog_ProcessingStatus]  DEFAULT ((0)) FOR [ProcessingStatus]


ALTER TABLE [dbo].[OP_ThirdPartyIncomingLog] ADD  CONSTRAINT [DF_OP_ThirdPartyIncomingLog_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]


END
GO