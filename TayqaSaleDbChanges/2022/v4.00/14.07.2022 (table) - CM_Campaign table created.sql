
/****** Object:  Table [dbo].[CM_Campaign]    Script Date: 7/15/2022 10:55:52 AM ******/

CREATE TABLE [dbo].[CM_Campaign](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Code] [nvarchar](100) NOT NULL,
	[Budget] [float] NULL,
	[Description] [nvarchar](max) NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[SyncType] [tinyint] NOT NULL,
	[ApplyingCondition] [tinyint] NOT NULL,
	[OperationsBitmask] [nvarchar](100) NOT NULL,
	[DocOperationType] [bit] NOT NULL,
	[Priority] [nvarchar](10) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[BudgetType] [tinyint] NULL,
	[ApplyingDate] [tinyint] NOT NULL,
	[TargetaAudiancesSimpleRelationType] [tinyint] NULL,
	[TargetaAudiancesComplexRelationString] [nvarchar](100) NULL,
	[DiscountTermsSimpleRelationType] [tinyint] NULL,
	[DiscountTermsComplexRelationString] [nvarchar](100) NULL,
	[BudgetForEachClient] [float] NULL,
	[BudgetForEachClientGroup] [float] NULL,
	[BudgetForEachSaleChannel] [float] NULL,
	[LastModifierUserId] [bigint] NULL,
	[LastModificationTime] [datetime] NULL,
 CONSTRAINT [CM_Campaign_PKC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
