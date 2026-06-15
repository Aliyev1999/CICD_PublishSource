update SYS_DataExchangeMethod set Url=REPLACE(Url, 'v3.60', 'v4.30') WHERE [Source] NOT IN ('SapInventories','SapDestroyedInventories')
GO
update SYS_DataExchangeMethod set Url=REPLACE(Url, 'v4.00', 'v4.30') WHERE [Source] NOT IN ('SapInventories','SapDestroyedInventories')
GO
update SYS_DataExchangeMethod set Url=REPLACE(Url, 'v4.10', 'v4.30') WHERE [Source] NOT IN ('SapInventories','SapDestroyedInventories')
GO
update SYS_DataExchangeMethod set Url=REPLACE(Url, 'v4.20', 'v4.30') WHERE [Source] NOT IN ('SapInventories','SapDestroyedInventories')
GO