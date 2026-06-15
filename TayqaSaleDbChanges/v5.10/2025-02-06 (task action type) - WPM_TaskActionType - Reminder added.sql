
declare @Id smallint = 48;
insert into WPM_TaskActionType (Id, Name, Description, CreatedDate, Template, IsActive)
values (@Id, 'Reminder', 'Reminder', GETDATE(), '{"minCommentLength": 4, "maxCommentLength": 200}', 1)

go