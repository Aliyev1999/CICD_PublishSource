CREATE TABLE [dbo].[ERP_FinanceOperation](
	[Firm] [smallint] NOT NULL,
	[Period] [smallint] NOT NULL,
	[ERPId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[SalesmanId] [int] NULL,
	[ERPSourceFicheId] [int] NULL,
	[Date] [datetime] NOT NULL,
	[Type] [tinyint] NULL,
	[Division] [smallint] NULL,
	[Department] [smallint] NULL,
	[Specode] [nvarchar](50) NULL,
	[Specode2] [nvarchar](50) NULL,
	[Specode3] [nvarchar](50) NULL,
	[Docode] [nvarchar](50) NULL,
	[Sign] [bit] NOT NULL,
	[Amount] [float] NOT NULL,
	[IsCancelled] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ERP_FinanceOperation] PRIMARY KEY CLUSTERED
(
	[Firm] ASC,
	[Period] ASC,
	[ERPId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ERP_OperationType](
	[Type] [tinyint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_ERP_OperationType] PRIMARY KEY CLUSTERED
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

insert into [ERP_OperationType] (type, name, Description)
values
(2, 'ReturnInvoice', 'Return Invoice'),
(4, 'SaleInvoice', 'Sale Invoice'),
(5, 'CashPayment', 'Cash Payment'),
(51, 'BankPayment', 'Bank Payment');

