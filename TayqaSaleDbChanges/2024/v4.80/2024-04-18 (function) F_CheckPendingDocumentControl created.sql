CREATE function [dbo].[F_CheckPendingDocumentControl](@requestId int )
	Returns Table
    AS
	return(select case 
	when WarehouseIn = 0 then CAST( 1 AS BIT)
	when WarehouseOut = 0 then CAST( 1 AS BIT)
	else CAST( 0 AS BIT)  end as results
	from OP_IncomingLogWarehouseOperationExtension a
	join OP_IncomingLog b on a.Id=b.Id
	where b.Id=@requestId and DocType in (21,22,23,24)

	union  

	select case 
	when c.Name like 'A%' then CAST( 1 AS BIT)
	else CAST( 0 AS BIT)  end as results
	from OP_IncomingLog b 
	join MD_Client c on b.ClientId=c.TigerId
	where b.Id=@requestId  and c.Firm=9
	)