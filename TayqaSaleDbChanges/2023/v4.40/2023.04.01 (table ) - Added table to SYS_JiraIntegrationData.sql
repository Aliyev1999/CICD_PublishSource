create table SYS_JiraIntegrationData
(
    Id           int identity
        primary key,
    UserId       bigint not null,
    JiraUsername nvarchar(50),
    Token        nvarchar(max)
)
go