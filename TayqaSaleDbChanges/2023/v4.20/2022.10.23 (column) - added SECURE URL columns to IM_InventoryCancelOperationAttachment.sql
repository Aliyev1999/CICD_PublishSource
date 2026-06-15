alter table IM_InventoryCancelOperationAttachment
add  SecureUrl                  as CONVERT([varchar](max), case
                                                              when [Path] IS NULL then NULL
                                                              else (concat('NewImage-IM-InventoryCancelOperationAttachment', '-', [Id],
                                                                           reverse(left(reverse([Path]), charindex('\', reverse([Path])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS