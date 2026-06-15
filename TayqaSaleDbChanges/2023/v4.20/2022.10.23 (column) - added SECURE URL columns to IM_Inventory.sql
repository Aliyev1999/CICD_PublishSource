


ALTER TABLE IM_Inventory
ADD   SecureUrl1            as CONVERT([varchar](max), case
                                                         when [Image1] IS NULL then NULL
                                                         else (concat('NewImage-IM-Image1', '-', [Id],
                                                                      reverse(left(reverse([Image1]), charindex('\', reverse([Image1])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS

  ALTER TABLE IM_Inventory
ADD  SecureUrl2            as CONVERT([varchar](max), case
                                                         when [Image2] IS NULL then NULL
                                                         else (concat('NewImage-IM-Image2', '-', [Id],
                                                                      reverse(left(reverse([Image2]), charindex('\', reverse([Image2])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS

ALTER TABLE IM_Inventory
ADD  SecureUrl3            as CONVERT([varchar](max), case
                                                         when [Image3] IS NULL then NULL
                                                         else (concat('NewImage-IM-Image3', '-', [Id],
                                                                      reverse(left(reverse([Image3]), charindex('\', reverse([Image3])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS
  ALTER TABLE IM_Inventory
ADD  SecureUrl4            as CONVERT([varchar](max), case
                                                         when [Image4] IS NULL then NULL
                                                         else (concat('NewImage-IM-Image4', '-', [Id],
                                                                      reverse(left(reverse([Image4]), charindex('\', reverse([Image4])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS
   ALTER TABLE IM_Inventory
ADD SecureUrl5            as CONVERT([varchar](max), case
                                                         when [Image5] IS NULL then NULL
                                                         else (concat('NewImage-IM-Image5', '-', [Id],
                                                                      reverse(left(reverse([Image5]), charindex('\', reverse([Image5])))))) collate SQL_Latin1_General_CP1_CI_AS end) collate SQL_Latin1_General_CP1_CI_AS
