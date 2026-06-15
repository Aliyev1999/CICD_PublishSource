alter table DTM_MobileReport
    add ViewType tinyint default 1 not null
go
alter table DTM_MobileReport
    add CardRowCount tinyint
go
alter table DTM_MobileReport
    add CardColumnCount tinyint
go