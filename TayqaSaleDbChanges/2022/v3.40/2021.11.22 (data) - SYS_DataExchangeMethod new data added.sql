DECLARE @ipAndPort NVARCHAR(40) = (SELECT TOP 1 SUBSTRING(Url, 0, CHARINDEX('/', Url, 10))
FROM SYS_DataExchangeMethod
WHERE Name = 'SyncClient')

DECLARE @environment NVARCHAR(20) = (SELECT TOP 1 SUBSTRING(Url, CHARINDEX('/', Url, 10) + 1, CHARINDEX('/', Url, CHARINDEX('/', Url, 10) + 1) - CHARINDEX('/', Url, 10) - 1)
FROM SYS_DataExchangeMethod
WHERE Name = 'SyncClient')

insert into SYS_DataExchangeMethod(Id, Name, Source, Description, ExtraInfo, Url, DataTypeId, Status, CreatedUserId, CreatedDate)
values(88,'RefreshItemStockAndItemSerialNumber', 'RefreshItemStockAndItemSerialNumber', 'RefreshItemStockAndItemSerialNumber', 'POST', @ipAndPort + '/' + @environment + N'/v3.40/DataExchange/RefreshItemStockAndItemSerialNumber',2,1,1,getdate())