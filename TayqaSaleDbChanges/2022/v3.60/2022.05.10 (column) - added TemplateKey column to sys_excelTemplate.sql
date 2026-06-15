
 alter table SYS_ExcelTemplate
 add TemplateKey nvarchar(100)
 go
 update SYS_ExcelTemplate set TemplateKey='ClientSpecificPricing' where Id=28
 update SYS_ExcelTemplate set TemplateKey='ClientGroupSpecificPricing' where Id=29
 update SYS_ExcelTemplate set TemplateKey='ImportClientRoutesWeekDays' where Id=36
 update SYS_ExcelTemplate set TemplateKey='ImportClientRoutesDate' where Id=37