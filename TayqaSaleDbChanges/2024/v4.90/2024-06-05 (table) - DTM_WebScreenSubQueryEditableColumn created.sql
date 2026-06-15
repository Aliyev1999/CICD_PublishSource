
CREATE TABLE DTM_WebScreenSubQueryEditableColumn
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	ReferenceId INT NOT NULL,
	FieldName NVARCHAR(100) NOT NULL,
	ParameterName NVARCHAR(100) NOT NULL,
	DataType TINYINT NOT NULL,
	IsRequired BIT NOT NULL,
	ComponentId INT NULL
)
