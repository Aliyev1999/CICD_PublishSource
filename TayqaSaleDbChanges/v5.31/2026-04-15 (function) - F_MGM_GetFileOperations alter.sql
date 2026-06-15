create or ALTER FUNCTION [dbo].[F_MGM_GetFileOperations](
    	@firm smallint,
	@UserId bigint,
    @ClientId bigint,
	@OperationType int,
    @OperationId int



)
RETURNS TABLE
AS
RETURN
(
select taskaction.Note          as Note,
       attachment.SecureUrl		as PhotoUrl,
	   attachment.Id			as Id,
	   CONCAT('Tapsiriq sekli ', ROW_NUMBER() OVER (ORDER BY attachment.Id)) AS FileName,
	   action.Message           as Message

                 FROM WPM_TaskTicket task with (nolock)
                          join WPM_TaskTicketAction taskaction with (nolock) on taskaction.TaskTicketId = task.Id
                          join WPM_TaskAction action with (nolock) on taskaction.ActionId = action.Id
                          join WPM_TaskActionType actiontype with (nolock) on action.ActionType = actiontype.Id
						  left join WPM_Attachment attachment with (nolock) on attachment.ReferenceId=taskaction.Id and attachment.Type=3
				where ActionType.Id =@operationType  and taskaction.Id=@OperationId and task.UserId=@userId and task.ClientId=@ClientId and task.firm=@firm

);
