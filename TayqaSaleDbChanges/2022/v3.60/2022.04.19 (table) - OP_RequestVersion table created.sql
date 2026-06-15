if not exists (select * from sysobjects where name='OP_RequestVersion' and xtype='U')
begin
   CREATE TABLE [dbo].[OP_RequestVersion](
	[AppVersion] [varchar](50) NULL,
	[BackendVersion] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserId] [int] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[OP_RequestVersion] ADD  CONSTRAINT [DF_OP_RequestVersion_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate];

end
ELSE

begin
	delete OP_RequestVersion
end