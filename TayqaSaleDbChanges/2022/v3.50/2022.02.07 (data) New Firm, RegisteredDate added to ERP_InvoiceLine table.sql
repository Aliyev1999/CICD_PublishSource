alter table ERP_InvoiceLine
add RegisteredDate datetime not null default(getdate())
go
alter table ERP_InvoiceLine
add Firm smallint not null default(0)
go
ALTER TABLE ERP_InvoiceLine DROP CONSTRAINT PK_ERP_InvoiceLine
go
ALTER TABLE [dbo].[ERP_InvoiceLine] ADD  CONSTRAINT [PK_ERP_InvoiceLine] PRIMARY KEY CLUSTERED 
(
	[ERPLineId] ASC,
	[InvoiceId] ASC,
	Firm ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


