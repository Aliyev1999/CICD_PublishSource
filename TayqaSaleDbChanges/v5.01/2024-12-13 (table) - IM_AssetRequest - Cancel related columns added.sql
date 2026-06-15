
alter table IM_AssetRequest
add CancelledDate datetime

go

alter table IM_AssetRequest
add CancelledUserId int

go

alter table IM_AssetRequest
add CancelledNote nvarchar(200)

go

alter table IM_AssetRequest
add CancelledReasonId int

go