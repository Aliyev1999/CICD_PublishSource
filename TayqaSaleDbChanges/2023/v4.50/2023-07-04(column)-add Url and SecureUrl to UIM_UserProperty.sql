ALTER TABLE UIM_UserProperty
ADD FileName nvarChar(50) Default Null,
Url nvarchar(1024) Default Null,
SecureUrl AS (CONVERT([varchar](max),case when [Url] IS NULL then NULL else (concat('NewFile-UIM-UserProperty','-',[Id],reverse(left(reverse([Url]),charindex('\',reverse([Url])))))) collate SQL_Latin1_General_CP1_CI_AS end))