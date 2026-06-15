CREATE TABLE [dbo].[CHL_NormativeForClient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NormativeId] [int] NOT NULL,
	[Firm] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Text] [nvarchar](250) NOT NULL,
	[Number] [float] NULL,
	[Minimum] [float] NULL,
	[Maximum] [float] NULL,
	[Point] [float] NULL,
	[Status] [bit] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueNormativeForClient] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[ClientId] ASC,
	[NormativeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHL_NormativeForClient] ADD  DEFAULT ((0)) FOR [Status]
GO
