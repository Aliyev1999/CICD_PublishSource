
alter table dbo.WPM_TaskAction
    add NonActionReasonsEnabled bit default 0 not null
go

alter table dbo.WPM_TaskAction
    add NonActionReasonInputType tinyint
go

alter table dbo.WPM_TaskAction
    add NonActionReasonNoteEnabled bit
go

alter table dbo.WPM_ActionGroupActionMapping
    add NonActionReasonsEnabled bit default 0 not null
go

alter table dbo.WPM_ActionGroupActionMapping
    add NonActionReasonInputType tinyint
go

alter table dbo.WPM_ActionGroupActionMapping
    add NonActionReasonNoteEnabled bit
go
