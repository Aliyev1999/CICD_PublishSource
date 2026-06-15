CREATE TABLE DTM_DynamicScreenInnerQueryColumnMapping(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	ReferenceId INT NOT NULL, 
	FieldName NVARCHAR(100) NOT NULL,
	InnerQueryIndex TINYINT NOT NULL
)
 