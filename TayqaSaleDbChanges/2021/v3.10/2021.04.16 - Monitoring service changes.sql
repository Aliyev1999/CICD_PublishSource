alter table MN_HttpRequestQueue
	add RegisteredDate DATETIME default getdate() not null
go

alter table DM_ProcessingQueue
	add RegisteredDate DATETIME default getdate() not null
go

alter table DM_ProcessingQueue
	add IgnoreSuspended bit default 0 not null
go