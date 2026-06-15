
/****** Object:  Table [dbo].[CM_AlternativeItem]    Script Date: 7/15/2022 11:19:24 AM ******/

CREATE TABLE [dbo].[CM_AlternativeItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PromoLineId] [int] NOT NULL,
	[ItemTigerId] [int] NOT NULL,
	[ItemUnitCode] [nvarchar](10) NOT NULL,
	[ItemQuantity] [float] NOT NULL,
	[Priority] [int] NOT NULL,
 CONSTRAINT [CM_AlternativeItem_PKC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CM_AlternativeItem] ADD  CONSTRAINT [DF_CM_AlternativeItem_Priority]  DEFAULT ((1)) FOR [Priority]
GO
