

CREATE TABLE [dbo].[EDI_GeneralSettings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[EnableCustomPostProcessing] [bit] NOT NULL,
	[ApplyCampaign] [bit] NOT NULL,
	[ApplyStandardControls] [bit] NOT NULL,
	[IgnoreItemUnitOperationControl] [bit] NOT NULL,
	[AllowPartialOrderReceiving] [bit] NOT NULL,
	[IntegrationMode] [tinyint] NOT NULL,
	[EnableXmlLogging] [bit] NOT NULL,
	[DocType] [tinyint] NOT NULL,
	[DeviceIdForControls] [uniqueidentifier] NULL,
	[UserIdForControls] [bigint] NULL,
	[DivisionNr] [smallint] NULL,
	[WarehouseNr] [smallint] NULL,
	[DepartmentNr] [smallint] NULL,
	[FactoryNr] [smallint] NULL,
	[DocStatus] [tinyint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[ConvertPriceWithPackSize] [bit] NOT NULL,
	[IsActive] [bit] NULL,
	[IsInternalIntegration] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((0)) FOR [EnableCustomPostProcessing]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((0)) FOR [ApplyCampaign]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((1)) FOR [ApplyStandardControls]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((1)) FOR [IgnoreItemUnitOperationControl]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((1)) FOR [AllowPartialOrderReceiving]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((0)) FOR [IntegrationMode]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((1)) FOR [EnableXmlLogging]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((0)) FOR [DocType]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((0)) FOR [ConvertPriceWithPackSize]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((0)) FOR [IsActive]
GO

ALTER TABLE [dbo].[EDI_GeneralSettings] ADD  DEFAULT ((1)) FOR [IsInternalIntegration]
GO


CREATE TABLE [dbo].[EDI_IntegrationResultLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[TokenJson] [nvarchar](max) NULL,
	[ResultJson] [nvarchar](max) NULL,
	[FicheNo] [nvarchar](100) NULL,
	[RegisteredDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[EDI_IntegrationResultLog] ADD  DEFAULT (getdate()) FOR [RegisteredDate]
GO


CREATE TABLE [dbo].[EDI_PartnerMappings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SellerCode] [nvarchar](50) NOT NULL,
	[SellerName] [nvarchar](200) NOT NULL,
	[BuyerCode] [nvarchar](50) NOT NULL,
	[BuyerName] [nvarchar](200) NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[Firm] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EDI_PartnerMappings] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[EDI_PartnerMappings] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[EDI_PartnerMappings] ADD  DEFAULT ((0)) FOR [Firm]
GO



