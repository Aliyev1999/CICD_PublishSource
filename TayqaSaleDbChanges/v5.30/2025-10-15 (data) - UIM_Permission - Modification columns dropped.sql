ALTER TABLE UIM_Permission
ADD CONSTRAINT DF_OnlyHybridUser
    DEFAULT (0) FOR OnlyHybridUser;

go

alter table UIM_UserPermission
drop column ModifiedDate

go

alter table UIM_UserPermission
drop column ModifiedUserId