CREATE TABLE MSG_ShakeReportAttachments (
Id int IDENTITY(1,1) PRIMARY KEY,
    ReferenceId int,
	Url nvarchar(250),
	CreatedDate datetime default getdate()
);