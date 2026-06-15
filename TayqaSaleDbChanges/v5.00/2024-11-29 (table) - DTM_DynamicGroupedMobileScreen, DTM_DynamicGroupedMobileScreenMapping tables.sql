CREATE TABLE dbo.DTM_DynamicGroupedMobileScreen (
  Id int IDENTITY,
  Name nvarchar(100) NULL,
  Code nvarchar(100) NULL,
  CreatorUserId bigint NULL,
  CreationTime datetime NOT NULL,
  LastModifierUserId bigint NULL,
  LastModificationTime datetime NULL,
  TenantId int NOT NULL,
  CssClass nvarchar(50) NULL,
  DeleterUserId bigint NULL,
  DeletionTime datetime NULL,
  IsDeleted bit NOT NULL,
  IconId int NULL,
  Description nvarchar(1000) NULL,
  UserAssignType bit NOT NULL DEFAULT (0)
)

GO

CREATE TABLE dbo.DTM_DynamicGroupedMobileScreenMapping (
  Id bigint IDENTITY,
  ScreenId int NULL,
  ReferenceId int NULL,
  OrderNo tinyint NULL
)