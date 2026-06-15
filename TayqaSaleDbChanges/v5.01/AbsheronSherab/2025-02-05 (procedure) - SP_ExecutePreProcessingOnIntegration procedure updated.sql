ALTER procedure dbo.SP_ExecutePreProcessingOnIntegration @requestId int
as
begin 
update OP_RequestQueue set ClientId=192346,Note='ceka test integrator' where Id=@requestId;

UPDATE OP_RequestQueueCommonLineExtension
SET TaxCode = mi.TaxCode
FROM OP_RequestQueueCommonLineExtension orqcle WITH(NOLOCK)
JOIN OP_RequestQueue orq WITH(NOLOCK) ON orq.Id = orqcle.Id
JOIN MD_Item mi WITH(NOLOCK) ON mi.TigerId = orqcle.ItemId AND orq.Firm = mi.Firm
WHERE orq.Id = @requestId;

end
GO

ALTER Procedure dbo.SP_ExecuteCustomProcessAfterPost @generalId int
as
begin

UPDATE erp
SET erp.CUSTTITLE = mc.Code
FROM TestTigerEnt_db..LG_009_06_KSLINES erp WITH (NOLOCK)
INNER JOIN OP_ERPIntegrationtResultQueue erq WITH (NOLOCK) ON erp.LOGICALREF = erq.ERPTransactionId
INNER JOIN OP_RequestQueue rq WITH (NOLOCK) ON erq.RequestId = rq.Id
INNER JOIN MD_Client mc WITH (NOLOCK) ON mc.TigerId = rq.ClientId
WHERE erq.GeneralId = @generalId;

end