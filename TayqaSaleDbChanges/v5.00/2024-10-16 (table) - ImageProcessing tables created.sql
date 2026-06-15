CREATE TABLE IP_IncomingLog (
  Id int NOT NULL,
  ImageId int NOT NULL,
  ImageUrl nvarchar(500) NULL,
  PlanogramId int NULL,
  AnalysisTypes nvarchar(200) NULL,
  RequestMethod tinyint NULL,
  SourceType tinyint NULL
)
GO

CREATE TABLE IP_Queue (
  Id int IDENTITY,
  ImageId int NOT NULL,
  ImageUrl nvarchar(500) NULL,
  PlanogramId int NULL,
  AnalysisTypes nvarchar(200) NULL,
  RequestMethod tinyint NULL,
  IsProcessing bit NOT NULL DEFAULT (0),
  CreatedTime datetime2 NOT NULL DEFAULT (getdate()),
  SourceType tinyint NOT NULL DEFAULT (0),
  PRIMARY KEY CLUSTERED (Id)
)

GO

CREATE TABLE IP_ResultLog (
  Id INT NOT NULL
 ,PostBody NVARCHAR(MAX) NULL
 ,StartDate DATETIME2 NULL
 ,FinishDate DATETIME2 NULL
 ,ResponseStatusCode VARCHAR(50) NULL
 ,Response NVARCHAR(MAX) NULL
 ,SourceType TINYINT NULL DEFAULT (0)
)