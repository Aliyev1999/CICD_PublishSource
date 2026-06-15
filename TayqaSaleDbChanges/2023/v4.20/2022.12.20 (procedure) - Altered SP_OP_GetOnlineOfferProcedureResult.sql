ALTER proc [dbo].[SP_OP_GetOnlineOfferProcedureResult] (@clientId int, 
													@templateId int,
													@catalogIds nvarchar(MAX),
													@operationId tinyint,
													@date datetime = null, 
													@userId int)
AS
BEGIN 
SET NOCOUNT ON;

Declare @Query nvarchar(max);

select @Query = ProcedureName from OP_OnlineOfferTemplate
where Id = @templateId

SET @Query = CONCAT(@Query, ' @clientId, @catalogIds, @operationId, @date, @userId')

EXEC sp_executesql @Query, N'@clientId int, 
								@catalogIds nvarchar(MAX) = null,
								@operationId tinyint,
								@date datetime = null,
								@userId int',
								@clientId=@clientId,
								@catalogIds=@catalogIds,
								@operationId=@operationId,
								@date=@date,
								@userId = @userId

END