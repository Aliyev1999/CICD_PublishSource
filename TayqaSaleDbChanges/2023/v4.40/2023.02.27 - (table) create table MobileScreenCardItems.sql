go

create table dbo.SYS_MobileScreenCardItems
(
    Id                 int identity
        primary key,
    MobileScreenId     int               not null,
    Label              nvarchar(50)      not null,
    ItemKey            nvarchar(50)      not null,
    ColorHex           nvarchar(20),
    FontSize           tinyint           not null,
    FontStyle          tinyint           not null,
    ShowLabel          bit               not null,
    TenantId           int     default 1 not null,
    PositionVertical   tinyint default 0 not null,
    PositionHorizontal tinyint default 0 not null
)
go
