GO

CREATE TABLE [dbo].[SPEC_ExternalVisit]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditId] [bigint] NOT NULL,
	[SalesPointId] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

GO

CREATE TABLE [dbo].[SPEC_ProductInfo]
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductCode] [nvarchar](100) NOT NULL,
	[EnoughStock] [bit] NOT NULL,
	[AuditId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

GO