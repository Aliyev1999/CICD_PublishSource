ALTER TABLE WPM_TaskAction
    ADD ConditionalVisibility bit NOT NULL DEFAULT 0;
go
ALTER TABLE WPM_ActionGroupActionMapping
    ADD ConditionalVisibility bit NOT NULL DEFAULT 0;