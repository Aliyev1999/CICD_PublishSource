alter table CHL_Question
add ReasonInputType tinyint not null default 1
go
alter table CHL_Answer
add ReasonInputType tinyint not null default 1