
create or alter function [dbo].[FN_GetClientDebt](@clientId int, @firm smallint)
returns table as 
return select top 1 Debit, Credit from OP_ClientDebt where (OrderNo=0 or OrderNo=1)
and TigerClientId = @clientId and Firm = @firm
GO


