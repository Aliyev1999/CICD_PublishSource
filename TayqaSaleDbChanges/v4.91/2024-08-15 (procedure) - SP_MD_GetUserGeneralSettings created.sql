CREATE PROCEDURE [dbo].[SP_MD_GetUserGeneralSettings](
    @userId INT,
    @status TINYINT
)
AS
BEGIN

    if exists(select Id from UIM_UserSetting with (nolock) where UserId = @userId)
        begin
            select Objects.Name         as Name,

                   Setting.SettingValue as SettingValue
            from UIM_UserSetting Setting with (nolock)
                     join SYS_UserSettingObject Objects with (nolock) on Objects.Id = Setting.SettingId
            where Firm is null
              and Objects.Status = @status
              and UserId = @userId

            union

            select 'NonLoggingDay'                                                                                                as Name,
                   cast(datediff(second, '1970-01-01', dateadd(hour, -datediff(hour, getutcdate(), getdate()), Date)) as varchar) as SettingValue
            from UIM_NonLoggingDay NonLogging with (nolock)
            where UserId = @userId
        end

    else
        begin

            declare @UserGroupId int = (select top 1 Mapping.GroupId
                                        from MD_UserGroupMapping Mapping with (nolock)
                                                 join MD_UserGroupInfo Groups with (nolock) on Groups.Id = Mapping.GroupId
                                        where UserId = @userId
                                          and Groups.IsActive = 1
                                          and Groups.IsDeleted = 0
                                          and Mapping.IsActive = 1)

            select Objects.Name         as Name,
                   Setting.SettingValue as SettingValue
            from UIM_UserGroupSetting Setting with (nolock)
                     join SYS_UserSettingObject Objects with (nolock) on Objects.Id = Setting.SettingId
            where Firm is null
              and Objects.Status = @status
              and UserGroupId = @UserGroupId

            union

            select 'NonLoggingDay'                                                                                                as Name,
                   cast(datediff(second, '1970-01-01', dateadd(hour, -datediff(hour, getutcdate(), getdate()), Date)) as varchar) as SettingValue
            from UIM_UserGroupNonLoggingDay NonLogging with (nolock)
            where UserGroupId = @UserGroupId
        end

END
go