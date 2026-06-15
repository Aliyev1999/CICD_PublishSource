alter table CM_Campaign
alter column StartDate datetime not null

go

alter table CM_Campaign
alter column EndDate datetime not null

go

CREATE NONCLUSTERED INDEX StarAndEndDates   
    ON CM_Campaign (StartDate,EndDate);