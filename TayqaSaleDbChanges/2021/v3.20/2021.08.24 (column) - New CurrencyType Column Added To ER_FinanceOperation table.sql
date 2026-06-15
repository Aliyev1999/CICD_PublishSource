ALTER TABLE ERP_FinanceOperation ADD CurrencyType SMALLINT NULL;

GO

DECLARE @currencyType SMALLINT = (SELECT TOP 1 LocalCurrencyTypeId FROM MD_Firm F WHERE F.Status = 0 AND F.IsActive = 1)

UPDATE ERP_FinanceOperation SET CurrencyType = @currencyType;

ALTER TABLE ERP_FinanceOperation ALTER COLUMN CurrencyType SMALLINT NOT NULL;
