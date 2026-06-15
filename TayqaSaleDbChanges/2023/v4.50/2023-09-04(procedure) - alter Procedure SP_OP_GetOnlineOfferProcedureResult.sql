
ALTER proc [dbo].[SP_OP_GetOnlineOfferProcedureResult](@clientId int,
                                                       @templateId int,
                                                       @catalogIds nvarchar(MAX),
                                                       @operationId tinyint,
                                                       @date datetime = null,
                                                       @userId int)
AS
BEGIN
    SET NOCOUNT ON;

    if @operationId >= 20
        begin

            Declare @Query nvarchar(max);

            select @Query = ProcedureName
            from OP_OnlineOfferTemplate t
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
        end

    else
        select ItemId,
               ItemUnitCode   as UnitCode,
               Amount         as Quantity,
               Price          as Price,
               cast(0 as bit) as CanRemove,
               cast(0 as bit) as CanDecrease

        from OP_IncomingLogCommonLineExtension with (nolock)
        where Id = @templateId
END


