CREATE TABLE [dbo].[MD_ClientSimilarityMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firm] [smallint] NOT NULL,
	[MainClientId] [int] NOT NULL,
	[SimilarClientId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[SimilarityTypeId] [int] NOT NULL,
 CONSTRAINT [PK_MD_ClientSimilarityMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Index [IX_MD_ClientSimilarityMapping_Firm_MainCLientId_SimilarClientId]    Script Date: 03.10.2022 15:59:04 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MD_ClientSimilarityMapping_Firm_MainCLientId_SimilarClientId] ON [dbo].[MD_ClientSimilarityMapping]
(
	[Firm] ASC,
	[MainClientId] ASC,
	[SimilarClientId] ASC,
	[SimilarityTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MD_ClientSimilarityMapping] ADD  CONSTRAINT [DF_MD_ClientSimilarityMapping_CreationTime]  DEFAULT (getdate()) FOR [CreationTime]
GO


