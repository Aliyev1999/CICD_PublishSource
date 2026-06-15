CREATE TABLE DTM_MobileReportUserGroupMapping(
  Id INT primary KEY identity,
  ReportId INT NOT NULL,
  GroupId INT not NULL,
  ToolType TINYINT not null,
  TenantId int
)