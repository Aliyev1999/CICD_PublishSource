
alter table DTM_DynamicComponent
add SelectType tinyint not null
constraint DTM_DynamicComponent_SelectType default 1
with values

go