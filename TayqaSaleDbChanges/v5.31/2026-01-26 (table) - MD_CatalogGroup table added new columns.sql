alter table MD_CatalogGroup
add Path nvarchar(500) NOT NULL default('')
go
alter table MD_CatalogGroup
add FileName nvarchar(100)
go
alter table MD_CatalogGroup
add SecureUrl  AS (concat('NewFile-MD_CatalogGroup','-',[Id],reverse(left(reverse([Path]),charindex('\',reverse([Path]))))))