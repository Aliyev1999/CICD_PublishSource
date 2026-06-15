alter table SYS_ExcelTemplate
add   SecureUrl      as CONVERT([varchar](max), case
                                                  when [FilePath] IS NULL then NULL
                                                  else (concat('NewImage-SYS-ExcelTemplate', '-', [Id],
                                                               reverse(left(reverse([FilePath]), charindex('\', reverse([FilePath])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS