
-- auto-generated definition
create table WPM_TaskTicketActionJsonLine
(
    TaskTicketActionId int                        not null,
    TaskTicketId       int                        not null,
    ReferenceId        uniqueidentifier,
    SurveyId           int,
    IsAccepted         bit,
    ActionType         smallint                   not null,
    RegisteredDate     datetime default getdate() not null
)
go

create index İX_WPM_TaskTicketActionJsonLine_RegisteredDate
    on WPM_TaskTicketActionJsonLine (RegisteredDate)
go

create index İX_WPM_TaskTicketActionJsonLine_TaskTicketActionId
    on WPM_TaskTicketActionJsonLine (TaskTicketActionId)
go

create index IX_WPM_TaskTicketActionJsonLine_ReferenceId
    on WPM_TaskTicketActionJsonLine (ReferenceId)
go

create index IX_WPM_TaskTicketActionJsonLine_TaskTicketId
    on WPM_TaskTicketActionJsonLine (TaskTicketId)
go

create index IX_WPM_TaskTicketActionJsonLine_SurveyId
    on WPM_TaskTicketActionJsonLine (SurveyId)
go

