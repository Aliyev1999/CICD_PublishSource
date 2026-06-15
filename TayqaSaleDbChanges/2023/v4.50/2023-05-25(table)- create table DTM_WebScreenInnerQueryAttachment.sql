CREATE TABLE DTM_WebScreenInnerQueryAttachment(
	Id int IDENTITY(1,1) NOT NULL,
	WebScreenId int Not Null,
	SubQueryId int Not Null,
	Url nvarchar(max) NOT NULL,
	CreatorUserId bigint NOT NULL,
	CreationTime datetime Not Null,
	SecureUrl  AS (concat('NewFile-DTM-WebScreenInnerQueryAttachment','-',[Id],reverse(left(reverse([Url]),charindex('\',reverse([Url]))))))
)

