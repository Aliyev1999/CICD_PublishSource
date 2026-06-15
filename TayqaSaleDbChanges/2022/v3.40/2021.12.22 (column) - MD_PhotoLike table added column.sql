ALTER TABLE MD_PhotoLike
ADD Comment nvarchar(500)
go
ALTER TABLE MD_PhotoLike
ADD ReasonId int

go

drop table WPM_PhotoFeedbackCommentAndReason
