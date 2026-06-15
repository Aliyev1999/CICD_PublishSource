CREATE TABLE WPM_Task_Raw
(
    Id                   INT IDENTITY
        CONSTRAINT PK_WPM_Task_Raw
            PRIMARY KEY,
    Name                 NVARCHAR(70)                                   NOT NULL,
    Message              NVARCHAR(800),
    Firm                 SMALLINT                                       NOT NULL,
    Type                 TINYINT                                        NOT NULL,
    IsOptional           BIT                                            NOT NULL,
    IsPassive            BIT
        CONSTRAINT DF__WPM_Task_Raw__IsActive__405B5365 DEFAULT 1       NOT NULL,
    Priority             SMALLINT                                       NOT NULL,
    Note                 VARCHAR(200),
    ClientListType       TINYINT                                        NOT NULL,
    CreatedDate          DATETIME
        CONSTRAINT DF__WPM_Task_Raw__Create__7993D0C1 DEFAULT getdate() NOT NULL,
    IsIgnored            BIT
        CONSTRAINT DF_WPM_Task_Raw_IsIgnored DEFAULT 0                  NOT NULL,
    AllowOfflineActions  BIT
        CONSTRAINT DF_WPM_Task_Raw_AllowOfflineActions DEFAULT 0        NOT NULL,
    ClientOrderMandatory BIT
        CONSTRAINT DF_WPM_Task_Raw_ClientOrderMandatory DEFAULT 0       NOT NULL,
    AssignmentType       TINYINT DEFAULT 1                              NOT NULL,
    FormType             TINYINT DEFAULT 3                              NOT NULL,
    Result               NVARCHAR(MAX),
    ResultStatusCode     INT,
    ResultDate           DATETIME
)
GO

CREATE TABLE WPM_TaskAction_Raw
(
    Id                 INT IDENTITY
        CONSTRAINT PK_WPM_TaskAction_Raw
            PRIMARY KEY,
    TaskId             INT           NOT NULL
        CONSTRAINT FK_WPM_TaskAction_Raw__TaskId__WPM_Task_Raw__Id
            REFERENCES WPM_Task_Raw,
    ActionType         SMALLINT      NOT NULL,
    Params             VARCHAR(500),
    OrderNo            INT           NOT NULL,
    Priority           INT           NOT NULL,
    IsOptional         BIT           NOT NULL,
    Message            NVARCHAR(200),
    IsGpsRestricted    BIT DEFAULT 0 NOT NULL,
    ClientId           INT,
    StartActionGroupId SMALLINT,
    IsPassive          BIT DEFAULT 0 NOT NULL
)
GO

CREATE TABLE WPM_TaskClient_Raw
(
    Id                 INT IDENTITY
        CONSTRAINT PK_WPM_TaskClient_Raw
            PRIMARY KEY,
    TaskId             INT               NOT NULL
        CONSTRAINT FK_WPM_TaskClient_Raw__TaskId__WPM_Task_Raw__Id
            REFERENCES WPM_Task_Raw,
    ClientId           INT               NOT NULL,
    OrderNumber        INT
        CONSTRAINT DF_WPM_TaskClient_Raw_OrderNumber DEFAULT 0,
    SpecialActionsType TINYINT DEFAULT 0 NOT NULL
)
GO

CREATE TABLE WPM_TaskSchedule_Raw
(
    Id          INT IDENTITY
        CONSTRAINT PK__WPM_TaskSchedule_Raw
            PRIMARY KEY,
    TaskId      INT           NOT NULL
        CONSTRAINT FK_WPM_TaskSchedule_Raw__TaskId__WPM_Task_Raw__Id
            REFERENCES WPM_Task_Raw,
    StartDate   DATETIME      NOT NULL,
    EndDate     DATETIME      NOT NULL,
    StartTime   TIME(2)       NOT NULL,
    EndTime     TIME(2)       NOT NULL,
    PeriodType  TINYINT       NOT NULL,
    PeriodStep  VARCHAR(20),
    AlarmPeriod SMALLINT,
    IsPassive   BIT DEFAULT 0 NOT NULL
)
GO

CREATE TABLE WPM_UserTask_Raw
(
    Id         INT IDENTITY
        CONSTRAINT PK_WPM_UserTask_Raw
            PRIMARY KEY,
    TaskId     INT           NOT NULL
        CONSTRAINT FK_WPM_UserTask_Raw__TaskId__WPM_Task_Raw__Id
            REFERENCES WPM_Task_Raw,
    UserId     INT           NOT NULL,
    OrderNo    SMALLINT      NOT NULL,
    IsOptional BIT           NOT NULL,
    Priority   SMALLINT      NOT NULL,
    IsPassive  BIT DEFAULT 0 NOT NULL
)
GO