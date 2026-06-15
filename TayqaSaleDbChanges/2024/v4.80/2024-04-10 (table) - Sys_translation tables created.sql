
CREATE TABLE [dbo].[SYS_PortalTranslation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](max) NULL,
	[Ru] [nvarchar](max) NULL,
	[En] [nvarchar](max) NULL,
	[Az] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))