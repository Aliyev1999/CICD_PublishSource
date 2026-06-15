CREATE TABLE [dbo].[AbpUserProfilePhoto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[UserId] [int] NOT NULL,
	[SecureUrl]  AS (concat('NewImage-AbpUserProfilePhoto','-',[Id],reverse(left(reverse([ImageUrl]),charindex('\',reverse([ImageUrl])))))),
	[CreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[AbpUserProfilePhoto] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO