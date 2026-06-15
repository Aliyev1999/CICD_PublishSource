CREATE FUNCTION dbo.F_WPM_UserAndUserGroupTaskTicketStatus(@id int, @userId int)
    Returns Table
        AS
        RETURN(select Users.Status
               from WPM_Task Task with (nolock)
                        join WPM_UserTask Users with (nolock) on Task.Id = Users.TaskId
                        join WPM_TaskTicket TaskTicket with (nolock) on Task.Id = TaskTicket.TaskId
               where TaskTicket.Id = @id
                 and Task.IsDeleted = 0
                 and Users.UserId = @userId
               UNION
               SELECT Task.Status AS Status
               from WPM_Task Task with (nolock)
                        join WPM_TaskUserGroups UserGroup with (nolock) on Task.Id = UserGroup.TaskId
                        join WPM_TaskTicket TaskTicket with (nolock) on Task.Id = TaskTicket.TaskId
                        JOIN MD_UserGroupMapping Mapping with (nolock) ON Mapping.GroupId = UserGroup.UserGroupId
               where TaskTicket.Id = @id
                 and Task.IsDeleted = 0
                 and Mapping.UserId = @userId
                 and Mapping.IsActive = 1)
go