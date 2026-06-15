CREATE TABLE DTM_WebScreenConditionalFormatting(
Id INT IDENTITY(1,1) PRIMARY KEY,
WebReportId INT Not Null,
FieldName nvarchar(50),
Condition nvarchar (max) Not Null,
BackGroundColor nvarchar(50),
FontColor nvarchar(50)
)