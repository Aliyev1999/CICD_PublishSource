create procedure dbo.SP_EDI_CustomProcessAfterPost @ediOrderId int, @generalId int = null, @erpId bigint
as
begin
select @ediOrderId, @erpId
end

GO