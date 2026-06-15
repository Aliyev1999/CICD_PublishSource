CREATE OR ALTER   FUNCTION [dbo].[F_CheckSpecialRulesByRequestId](@requestId int) 
Returns  @TResult TABLE(Code nvarchar(max),
						Name nvarchar(max),
						Description nvarchar(max))
AS
BEGIN

--CHECK TOTAL AMOUNT BEGIN

DECLARE @totalAmount float;

SET @totalAmount = (SELECT SUM(Price*Amount) FROM OP_RequestQueueCommonLineExtension WITH(NOLOCK) WHERE Id = @requestId)

IF @totalAmount > 300
	BEGIN
		INSERT INTO @TResult VALUES('ErrTotalDocAmount', N'Toplam məbləğ', N'Sənədin toplam məbləği 300 AZN-i keçməməlidir');
	    return;
	END

--CHECK TOTAL AMOUNT END


--CHECK LINE PRICE GREATER 100 BEGIN

INSERT INTO @TResult
SELECT
CAST(clx.ItemId as nvarchar),
CAST(clx.IsPromo as nvarchar),
'100AZN'
FROM
OP_RequestQueue rq WITH(NOLOCK)
JOIN OP_RequestQueueCommonLineExtension clx WITH(NOLOCK) ON rq.Id = clx.Id
JOIN MD_Item item WITH(NOLOCK) ON CLX.ItemId = item.TigerId AND rq.Firm = item.Firm
WHERE rq.Id = @requestId AND clx.Price > 100;

--CHECK LINE PRICE GREATER 100 END

--CHECK ITEM SOLD LAST 8 DAYS BEGIN

INSERT INTO @TResult
 
SELECT CAST(rqclx.ItemId as nvarchar) +':' + CAST(rqclx.IsPromo as nvarchar), rqclsrx.SerialNumber, '8DAYS'
FROM OP_RequestQueue rq
JOIN OP_RequestQueueCommonLineExtension rqclx WITH(NOLOCK) ON rq.Id = rqclx.Id
LEFT JOIN OP_RequestQueueCommonLineSerialNumberExtension rqclsrx WITH(NOLOCK) ON rqclx.Id = rqclsrx.Id AND rqclx.ItemId = rqclsrx.ItemId AND rqclx.IsPromo = rqclsrx.IsPromo AND rqclx.PartNo = rqclsrx.PartNo
JOIN MD_Item item WITH(NOLOCK) ON rqclx.ItemId = item.TigerId AND item.Firm = rq.Firm
WHERE rq.Id = @requestId

EXCEPT

SELECT CAST(ilclx.ItemId as nvarchar) +':' + CAST(ilclx.IsPromo as nvarchar), ilclsrx.SerialNumber, '8DAYS'
FROM OP_RequestQueue rq
JOIN OP_RequestQueueCommonLineExtension rqclx WITH(NOLOCK) ON rq.Id = rqclx.Id
JOIN OP_IncomingLogCommonLineExtension ilclx WITH(NOLOCK) ON rqclx.ItemId = ilclx.ItemId
LEFT JOIN OP_IncomingLogCommonLineSerialNumberExtension ilclsrx WITH(NOLOCK) ON ilclx.Id = ilclsrx.Id AND ilclx.ItemId = ilclsrx.ItemId AND ilclx.IsPromo = ilclsrx.IsPromo
JOIN MD_Item item WITH(NOLOCK) ON rqclx.ItemId = item.TigerId AND item.Firm = rq.Firm
JOIN OP_IncomingLog il WITH(NOLOCK) ON ilclx.Id = il.Id AND il.ClientId =  rq.ClientId AND il.Firm = rq.Firm
JOIN OP_GeneralLog gl WITH(NOLOCK) ON il.Id = gl.RequestId and gl.ImportResult = 0
WHERE il.ProcessDate >= DATEADD(day,-8, GETDATE()) AND rqclx.Id = @requestId AND il.DocType = 4
 
--CHECK ITEM SOLD LAST 8 DAYS END
 
 return;
END



