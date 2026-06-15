
CREATE TABLE [dbo].[DTM_ExternalApiCallLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExternalApiId] [int] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[SendingScheduleTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DTM_ExternalApiCallLog] ADD  DEFAULT (getdate()) FOR [CreationTime]
GO

ALTER TABLE [dbo].[DTM_ExternalApiCallLog] ADD  DEFAULT (getdate()) FOR [SendingScheduleTime]
GO

alter table DTM_ExternalApiHeader 
add ParameterType tinyint not null default 1