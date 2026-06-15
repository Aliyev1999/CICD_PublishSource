alter table PN_Attachment
add  SecureUrl   as CONVERT([varchar](max), case
                                               when [Url] IS NULL then NULL
                                               else (concat('NewImage-PN-Attachment', '-', [Id],
                                                            reverse(left(reverse([Url]), charindex('\', reverse([Url])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS