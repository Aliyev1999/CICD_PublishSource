alter table CRM_Attachment
add SecureUrl  AS ((concat('NewImage-CRM-Attachment','-',[Id],reverse(left(reverse([Url]),charindex('\',reverse([Url])))))) collate SQL_Latin1_General_CP1_CI_AS)