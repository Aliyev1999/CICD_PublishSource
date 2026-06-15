CREATE TABLE [dbo].[MD_SpecodeClientOperationRestrictionClient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[UserId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[Specode] [nvarchar](100) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[Banned] [bit] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK__MD_Speco__3214EC07D3128AF5] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Frm_Usr_Clt_Spc_SDate_EDate_Opr] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[UserId] ASC,
	[ClientId] ASC,
	[Specode] ASC,
	[StartDate] ASC,
	[EndDate] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_SpecodeClientOperationRestrictionClient] ADD  CONSTRAINT [DF__MD_Specod__Banne__48F23014]  DEFAULT ((0)) FOR [Banned]
GO

ALTER TABLE [dbo].[MD_SpecodeClientOperationRestrictionClient] ADD  DEFAULT ((0)) FOR [Status]
GO


CREATE TABLE [dbo].[MD_SpecodeClientOperationRestrictionGeneral](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[Specode] [nvarchar](100) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[OperationId] [tinyint] NOT NULL,
	[Banned] [bit] NOT NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK__MD_Speco_General] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Frm_Usr_Clt_Spc_SDate_EDate_OprForGeneral] UNIQUE NONCLUSTERED 
(
	[Firm] ASC,
	[Specode] ASC,
	[StartDate] ASC,
	[EndDate] ASC,
	[OperationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO