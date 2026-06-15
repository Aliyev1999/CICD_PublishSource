
alter table SYS_MobileReportFilterMask
add TenantId   int
        constraint DF_SYS_MobileReportFilterMask_TenantId default 1 not null