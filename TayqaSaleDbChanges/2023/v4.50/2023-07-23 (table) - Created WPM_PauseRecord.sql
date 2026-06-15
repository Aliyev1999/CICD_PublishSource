create table WPM_PauseRecord
(
    Id        int identity,
    UserId    int      not null,
    ReasonId  int,
    Longitude float,
    Latitude  float,
    PauseTime datetime not null
)
go