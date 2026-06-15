create table AO_AuditOperationLineAttachment
(
Id                   int identity
constraint PK_AO_AuditOperationLineAttachment
primary key,
AuditOperationLineId int      not null,
Url                  nvarchar(250),
CreatedTime          datetime not null,
SecureUrl            as (CONVERT([varchar](max), case
when [Url] IS NULL then NULL
else (concat('NewImage-AO-AuditOperationLineAttachment', '-', [Id],
reverse(left(reverse([Url]), charindex('\', reverse([Url])))))) end))
)
go