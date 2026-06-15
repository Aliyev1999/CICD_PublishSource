
ALTER PROCEDURE [dbo].[SP_WPM_GetWorkExecutionPhotoGalleryReport]
	@userId INT,
	@beginDate DATE,
	@endDate DATE,
	@firm SMALLINT
AS
BEGIN
	select cast(Tickets.Id as int)                  as TaskTicketId,
       Tasks.Name                                   as TaskName,
	   Executor.Id                                  as UserId,
       Executor.UserName                            as UserName,
       concat(Executor.Name, ' ', Executor.Surname) as UserFullName,
       Tasks.CreatedDate                            as ExecutionTime,
       Client.Code                                  as ClientCode,
       Client.Name                                  as ClientName,
       CategoryReason.Name                          as TaskCategory,
       SubcategoryReason.Name                       as TaskSubCategory,
       GroupReason.Name                             as TaskGroup,
       cast(Mapping.SourceType as tinyint)          as TaskSource,
       cast(Images.Type as tinyint)                 as PhotoType,
       Images.SecureUrl                             as SecureUrl
from (select Tasks.Id as TaskId, Image.SecureUrl, 1 as Type
      from WPM_Task Tasks with (nolock)
               join WPM_Attachment Image on Image.ReferenceId = Tasks.Id and Image.Type=1
      where Tasks.Firm = @firm
      union
      select Ticket.TaskId as TaskId, Image.SecureUrl, 3 as Type
      from WPM_TaskTicket Ticket
               join WPM_TaskTicketAction Action on Action.TaskTicketId = Ticket.Id
               join WPM_Attachment Image on Image.ReferenceId = Action.Id 
      where Ticket.Firm = @firm) Images

         join WPM_Task Tasks with (nolock) on Tasks.Id = Images.TaskId and Tasks.IsDeleted = 0 and Tasks.Firm = @firm
         join (select distinct TaskId, max(SourceType) as SourceType
                                 from WPM_PhotoTaskMapping with (nolock)
                                 group by TaskId) Mapping on Mapping.TaskId = Tasks.Id
         left join WPM_TaskSchedule Schedule with (nolock) on Schedule.TaskId = Tasks.Id
         join WPM_TaskClient TaskClient with (nolock) on TaskClient.TaskId = Tasks.Id
         join WPM_UserTask TaskUser with (nolock) on TaskUser.TaskId = Tasks.Id
         join AbpUsers Executor with (nolock) on Executor.Id = TaskUser.UserId and Executor.IsDeleted = 0 and Executor.IsActive = 1
         --join F_GetAllPermittedUsersPermittedClients(@UserId) Permitted
             -- on Permitted.ClientId = TaskClient.ClientId and Permitted.Firm = Tasks.Firm
         join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers on TreeUsers.UserId = Executor.Id
         join MD_Client Client with (nolock) on Client.TigerId = TaskClient.ClientId and Client.Firm = Tasks.Firm and Client.IsDeleted = 0
         join WPM_TaskTicket Tickets with (nolock)
                   on Tickets.TaskId = TaskClient.TaskId and Tickets.ClientId = TaskClient.ClientId and Tickets.UserId = Executor.Id
		 left join MD_StopReason GroupReason with(nolock) on  GroupReason.Id=Tasks.GroupReason
		 left join MD_StopReason CategoryReason with(nolock) on  CategoryReason.Id=Tasks.CategoryReason
		 left join MD_StopReason SubcategoryReason with(nolock) on  SubcategoryReason.Id=Tasks.SubcategoryReason
where Tasks.Firm = @firm
  and (cast(Tasks.CreatedDate as date) between cast(@beginDate as date) and cast(@endDate as date))
END
