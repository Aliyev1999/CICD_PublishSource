ALTER TABLE SYS_DynamicWebToolNonHeaderFilter
        ADD NonHeaderFilterType tinyint not null default(1)
go
ALTER TABLE SYS_DynamicWebToolNonHeaderFilter
        ADD DefaultValue nvarchar(50) NULL
