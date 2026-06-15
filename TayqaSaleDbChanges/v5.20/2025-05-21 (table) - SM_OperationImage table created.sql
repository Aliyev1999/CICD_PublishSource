CREATE TABLE SM_OperationImage (
  Id INT IDENTITY (1, 1) PRIMARY KEY
 ,DocId NVARCHAR(50) NULL
 ,ReasonId INT NULL
 ,Note NVARCHAR(MAX) NULL
 ,Url nvarchar(MAX) NOT NULL
 ,SecureUrl  AS ((concat('NewImage-SM-OperationImage','-',[Id],reverse(left(reverse([Url]),charindex('\',reverse([Url])))))) collate SQL_Latin1_General_CP1_CI_AS)
 ,RegisteredDate DATETIME2 not null default(getdate())
 ,CreatorUserId INT NULL
)
