CREATE proc [dbo].[SP_MD_GetUserOperationalSettings](
    @userId INT,
    @status TINYINT
)
AS
begin
    if exists(select Id from UIM_UserSetting with (nolock) where UserId = @userId)
        begin
            select Setting.Firm         as Firm,
                   Objects.Name         as Name,
                   Setting.SettingValue as SettingValue
            from UIM_UserSetting Setting with (nolock)
                     join SYS_UserSettingObject Objects with (nolock) on Objects.Id = Setting.SettingId
            where Firm is not null
              and Objects.Status = @status
              and UserId = @userId
        end

    else
        begin

            declare @UserGroupId int = (select top 1 Mapping.GroupId
                                        from MD_UserGroupMapping Mapping with (nolock)
                                                 join MD_UserGroupInfo Groups with (nolock) on Groups.Id = Mapping.GroupId
                                        where UserId = @userId
                                          and Mapping.IsActive = 1
                                          and Groups.IsDeleted = 0
                                          and Groups.IsActive = 1)

            select Setting.Firm         as Firm,
                   Objects.Name         as Name,
                   Setting.SettingValue as SettingValue
            from UIM_UserGroupSetting Setting with (nolock)
                     join SYS_UserSettingObject Objects with (nolock) on Objects.Id = Setting.SettingId
            where Firm is not null
              and Objects.Status = @status
              and UserGroupId = @UserGroupId
        end
end
go