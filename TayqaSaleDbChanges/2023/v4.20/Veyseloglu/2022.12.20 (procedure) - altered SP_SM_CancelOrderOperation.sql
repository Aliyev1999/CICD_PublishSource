ALTER procedure [dbo].[SP_SM_CancelOrderOperation] @erpId bigint, @firm smallint, @period smallint, @userId int
as
begin
    declare @RequestId int = (select RequestId from OP_GeneralLog with (nolock) where TigerId = @erpId)
    declare @DocType tinyint = (select DocType from OP_IncomingLog with (nolock) where Id = @RequestId and Firm = @firm)
    declare @RegisteredDate datetime = (select RegisteredDate from OP_IncomingLog with (nolock) where Id = @RequestId and Firm = @firm)

    insert into OP_OperationCompletionStatus (ErpId, Firm, Status, RegisteredDate, RequestId, DocType, CanceledUserId, CanceledDate)
    values (@erpId, @firm, 0, @RegisteredDate, @RequestId, @DocType, @userId, GETDATE())
end