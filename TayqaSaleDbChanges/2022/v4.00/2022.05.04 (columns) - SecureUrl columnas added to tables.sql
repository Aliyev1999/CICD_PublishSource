--review
alter table WPM_Attachment
add SecureUrl as concat('NewImage-WPM-Attachment', '-', Id, reverse(left(reverse(Url), charindex('\', reverse(Url)))))
go

alter table Chl_Attachment
add SecureUrl as concat('NewImage-CHL-Attachment', '-', Id, reverse(left(reverse(Url), charindex('\', reverse(Url)))))

go

alter table IM_InventoryDemandImage
add SecureUrl as concat('NewImage-IM-InventoryDemandImage', '-', Id, reverse(left(reverse(ImagePath), charindex('\', reverse(ImagePath)))))

go

alter table OP_FileUploadLog
add SecureUrl as concat('NewImage-FileUploadLog', '-', Id, reverse(left(reverse(FilePath), charindex('\', reverse(FilePath)))))

go

alter table MSG_NotificationAttachment
add SecureUrl as concat('NewImage-MSG-NotificationAttachment', '-', Id, reverse(left(reverse(Url), charindex('\', reverse(Url)))))

go

alter table IM_InventoryStateHistoryImage
add SecureUrl as concat('NewImage-IM-InventoryStateHistoryImage', '-', Id, reverse(left(reverse(ImagePath), charindex('\', reverse(ImagePath)))))

go

alter table IM_InventoryNotFoundOperationImage
add SecureUrl as concat('NewImage-IM-InventoryNotFoundOperationImage', '-', Id, reverse(left(reverse(ImagePath), charindex('\', reverse(ImagePath)))))

