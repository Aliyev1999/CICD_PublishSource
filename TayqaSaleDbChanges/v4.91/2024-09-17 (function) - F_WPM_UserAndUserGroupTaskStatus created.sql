CREATE FUNCTION dbo.F_WPM_UserAndUserGroupTaskStatus(@id int, @userId int)
    Returns Table
        AS
        RETURN(select Users.Status
               from WPM_Task Task with (nolock)
                        join WPM_UserTask Users with (nolock) on Task.Id = Users.TaskId
               where Task.Id = @id
                 and Task.IsDeleted = 0
                 and Users.UserId = @userId
               UNION
               SELECT Task.Status AS Status
               from WPM_Task Task
                        join WPM_TaskUserGroups UserGroup with (nolock) on Task.Id = UserGroup.TaskId
                        JOIN MD_UserGroupMapping Mapping with (nolock) ON Mapping.GroupId = UserGroup.UserGroupId
               where Task.Id = @id
                 and Task.IsDeleted = 0
                 and Mapping.UserId = @userId
                 and Mapping.IsActive = 1)
go