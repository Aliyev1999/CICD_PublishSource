ALTER TABLE DM_Invoice 
ALTER COLUMN ERPId bigint not null;

GO


Alter table ERP_FinanceOperation drop constraint PK_ERP_FinanceOperation;

Go

ALTER TABLE ERP_FinanceOperation
ALTER COLUMN ERPId bigint not null;

Go

Alter table ERP_FinanceOperation add constraint PK_ERP_FinanceOperation primary key (Firm, Period, ERPId);