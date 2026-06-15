alter table IM_StaticContent
add Code nvarchar(50)

go

create unique nonclustered index UQ_Type_Code ON IM_StaticContent(Type, Code)
where Type is not null and Code is not null
