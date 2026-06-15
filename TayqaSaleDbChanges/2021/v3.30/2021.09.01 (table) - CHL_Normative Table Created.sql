CREATE TABLE [dbo].[CHL_Normative](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Text] [nvarchar](250) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Number] [float] NULL,
	[Minimum] [float] NULL,
	[Maximum] [float] NULL,
	[Point] [float] NULL,
	[CreatorUserId] [bigint] NULL,
	[Status] [bit] NOT NULL,
	[Type] [smallint] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueNormative] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHL_Normative] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[CHL_Normative] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO
