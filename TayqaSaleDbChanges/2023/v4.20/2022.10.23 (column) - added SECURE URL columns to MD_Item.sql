
alter table MD_Item
add  SecureUrl5            as CONVERT([varchar](max), case
                                                         when [Image5] IS NULL then NULL
                                                         else (concat('NewImage-MD-Item-Image5', '-', [TigerId],
                                                                      reverse(left(reverse([Image5]), charindex('\', reverse([Image5])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS,
    SecureUrl4            as CONVERT([varchar](max), case
                                                         when [Image4] IS NULL then NULL
                                                         else (concat('NewImage-MD-Item-Image4', '-', [TigerId],
                                                                      reverse(left(reverse([Image4]), charindex('\', reverse([Image4])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS,
    SecureUrl3            as CONVERT([varchar](max), case
                                                         when [Image3] IS NULL then NULL
                                                         else (concat('NewImage-MD-Item-Image3', '-', [TigerId],
                                                                      reverse(left(reverse([Image3]), charindex('\', reverse([Image3])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS,
    SecureUrl2            as CONVERT([varchar](max), case
                                                         when [Image2] IS NULL then NULL
                                                         else (concat('NewImage-MD-Item-Image2', '-', [TigerId],
                                                                      reverse(left(reverse([Image2]), charindex('\', reverse([Image2])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS,
    SecureUrl1            as CONVERT([varchar](max), case
                                                         when [Image1] IS NULL then NULL
                                                         else (concat('NewImage-MD-Item-Image1', '-', [TigerId],
                                                                      reverse(left(reverse([Image1]), charindex('\', reverse([Image1])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS