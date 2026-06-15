

CREATE TABLE [dbo].[DTM_MobileScreenFilterMask](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScreenId] [int] NOT NULL,
	[FieldName] [nvarchar](100) NOT NULL,
	[FilterMask] [nvarchar](3) NOT NULL,
	[TenantId] [int] NOT NULL,
	[IsCascade] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DTM_MobileScreenFilterMask] ADD  CONSTRAINT [DF_SYS_MobileScreenFilterMask_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[DTM_MobileScreenFilterMask] ADD  DEFAULT ((0)) FOR [IsCascade]
GO

