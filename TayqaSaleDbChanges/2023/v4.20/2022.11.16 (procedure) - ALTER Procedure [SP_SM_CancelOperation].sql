create or alter procedure [dbo].[SP_SM_CancelOperation] @erpId bigint, @firm smallint, @period smallint, @userId int, @docType tinyint, @reasonId int, @reasonDescription nvarchar(255)
as
begin
		 if EXISTS (SELECT ErpId FROM OP_OperationCompletionStatus WHERE ErpId = @erpId and Firm = @firm and DocType = @docType)
			begin
				 update OP_OperationCompletionStatus
				 set Status = 0
				 where ErpId = @erpId
				   and Firm = @firm
				   and DocType = @docType
				   and ReasonId=@reasonId
			end
		else
			begin
			declare @requestId int=(SELECT il.Id FROM OP_GeneralLog gl WITH(NOLOCK) 
									JOIN OP_IncomingLog il WITH(NOLOCK) on gl.RequestId = il.Id
									WHERE 
									gl.TigerId =@erpId AND
									il.Firm = @firm AND
									il.Period = @period AND
									il.DocType = @docType)

			 INSERT OP_OperationCompletionStatus(ErpId,
												 Firm, 
												 Status, 
												 RegisteredDate, 
												 CanceledUserId, 
												 CanceledDate, 
												 RequestId, 
												 DocType,
												 ReasonId,
												 ReasonDescription)
									  	  VALUES(@erpId, 
												 @firm, 
												 0, 
												 GETDATE(), 
												 @userId, 
												GETDATE(),
												 @requestId,
												 @docType,
												 @reasonId,
												 @reasonDescription)
			end
end