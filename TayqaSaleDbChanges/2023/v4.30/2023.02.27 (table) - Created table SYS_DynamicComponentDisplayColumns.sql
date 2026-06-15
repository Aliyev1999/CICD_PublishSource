create table SYS_DynamicComponentDisplayColumns
(
    Id          int identity
        primary key,
    ComponentId int not null,
    ColumnName  nvarchar(200),
    TenantId    int not null
)
go