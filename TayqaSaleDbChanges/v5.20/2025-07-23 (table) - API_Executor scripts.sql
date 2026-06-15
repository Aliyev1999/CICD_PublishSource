create table API_RequestQueueLog
(
    Id                     int,
    Url                    nvarchar(max),
    HttpMethod             nvarchar(10) default 'GET',
    RequestBody            nvarchar(max),
    ContentType            tinyint      default 0         not null,
    Headers                nvarchar(max),
    PostExecutionProcedure nvarchar(max),
    ExecutionStartTime     datetime,
    ExecutionEndTime       datetime,
    Result                 nvarchar(200),
    ResultDescription      nvarchar(max),
    CreatedTime            datetime     default getdate() not null
)
go

create table API_RequestQueue
(
    Id                     int identity
        primary key,
    Url                    nvarchar(max),
    HttpMethod             nvarchar(10) default 'GET'     not null,
    RequestBody            nvarchar(max),
    ContentType            tinyint      default 0         not null,
    Headers                nvarchar(max),
    PostExecutionProcedure nvarchar(max),
    Status                 tinyint      default 0         not null,
    RetryCount             int          default 0         not null,
    NextTryTime            datetime     default getdate() not null,
    CreatedTime            datetime     default getdate() not null,
    AuthorizationId        smallint
)
go

create table dbo.API_Authorization
(
    Id                 smallint identity
        primary key,
    AuthorizationType  tinyint default 0,
    AuthorizationToken nvarchar(max)
)
go

CREATE PROCEDURE GetAndUpdateAPIRequestQueue @getAll BIT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TempQueue TABLE
                       (
                           Id                     int,
                           Url                    nvarchar(max),
                           HttpMethod             nvarchar(10),
                           AuthorizationType      tinyint,
                           AuthorizationToken     nvarchar(max),
                           RequestBody            nvarchar(max),
                           Status                 tinyint,
                           RetryCount             int,
                           NextTryTime            datetime,
                           CreatedTime            datetime,
                           ContentType            tinyint,
                           Headers                nvarchar(max),
                           PostExecutionProcedure nvarchar(max)
                       );

    IF @getAll = 1
        BEGIN
            INSERT INTO @TempQueue
            SELECT q.Id,
                   Url,
                   HttpMethod,
                   AuthorizationType,
                   AuthorizationToken,
                   RequestBody,
                   Status,
                   RetryCount,
                   NextTryTime,
                   GETDATE(),
                   ContentType,
                   Headers,
                   PostExecutionProcedure
            FROM API_RequestQueue q WITH (NOLOCK)
                    left join API_Authorization a on a.Id = q.AuthorizationId
                 WHERE Status = 0 AND NextTryTime <= GETDATE()
            ORDER BY CreatedTime;
        END
    ELSE
        BEGIN
            INSERT INTO @TempQueue
            SELECT q.Id,
                   Url,
                   HttpMethod,
                   AuthorizationType,
                   AuthorizationToken,
                   RequestBody,
                   Status,
                   RetryCount,
                   NextTryTime,
                   GETDATE() AS CreatedTime,
                   ContentType,
                   Headers,
                   PostExecutionProcedure
            FROM API_RequestQueue q WITH (NOLOCK)
                     left join API_Authorization a on a.Id = q.AuthorizationId
            WHERE Status = 0
              AND NextTryTime <= GETDATE()
            ORDER BY CreatedTime;
        END

    IF EXISTS (SELECT 1 FROM @TempQueue)
        BEGIN
            SELECT * FROM @TempQueue;
        END
END;
go

