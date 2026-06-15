
declare @id smallint = 48;
insert into SYS_ConfigObject (Id, Name, Description, ValueFromTable, AppRelevant, CreatedUserId, CreatedDate)
values (@id, 'QuantityRoundDigit', 'Quantity round digit', 0, 1, 2, GETDATE())
go

declare @id smallint = 49;
insert into SYS_ConfigObject (Id, Name, Description, ValueFromTable, AppRelevant, CreatedUserId, CreatedDate)
values (@id, 'AmountRoundDigit', 'Amount round digit', 0, 1, 2, GETDATE())
go
