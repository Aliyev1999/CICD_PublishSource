go

alter table MSG_Notification
add IsClickable bit

go

alter table MSG_Notification
add TransitionType tinyint

go

alter table MSG_Notification
add TransitionLocation nvarchar(255)

go