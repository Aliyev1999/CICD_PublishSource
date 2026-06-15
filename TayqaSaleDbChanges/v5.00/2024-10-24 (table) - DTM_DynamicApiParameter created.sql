if not exists (SELECT 1 
           FROM sys.tables 
           WHERE name = 'DTM_DynamicApiParameter' 
           AND schema_id = SCHEMA_ID('dbo'))
begin

	CREATE TABLE [dbo].[DTM_DynamicApiParameter](
		[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[DynamicApiId] [int] NOT NULL,
		[Name] [nvarchar](max) NOT NULL,
		[Description] [nvarchar](max) NULL,
		[Type] [tinyint] NOT NULL,
		[CreatorUserId] [bigint] NOT NULL,
		[CreationTime] [datetime] NULL,
		[SqlParameterName] [nvarchar](100) NULL,
	)

	ALTER TABLE [dbo].[DTM_DynamicApiParameter] ADD  DEFAULT ((1)) FOR [Type]

end

go
alter table DTM_DynamicApiParameter
add SqlParameterName nvarchar(100) null

go
