CREATE TABLE DTM_WebReportSummarias(
	Id int IDENTITY(1,1) NOT NULL,
	ReferenceId int NOT NULL,
	ColumnName nvarchar(50) NOT NULL,
	AggregationType tinyint,
	DynamicToolType tinyint NOT NUll
)
