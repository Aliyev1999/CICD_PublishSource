CREATE TABLE IM_Attachment(
	[Id] [int] IDENTITY(1,1) PRIMARY KEY,
	[ReferenceId] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Url] [nvarchar](max) NOT NULL,
	[SecureUrl]  AS (concat('NewImage-IM_Attachment','-',[Id],reverse(left(reverse(Url),charindex('\',reverse(Url)))))),
	[CreationTime] [datetime] NOT NULL DEFAULT (getdate()))