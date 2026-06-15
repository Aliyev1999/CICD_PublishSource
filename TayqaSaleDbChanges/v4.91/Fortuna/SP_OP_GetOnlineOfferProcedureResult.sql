alter proc [dbo].[SP_OP_GetOnlineOfferProcedureResult](@clientId int,
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
        select ln.LineReferenceId as ItemId,
               'PK'               as UnitCode,
               Quantity           as Quantity,
               Price              as Price,
               cast(1 as bit)     as CanRemove,
               cast(1 as bit)     as CanDecrease,
               cast(1 as bit)     as IsCampaignItem,
               cast(0 as bit)     as IsSpecialItem,
               cast(0 as bit)     as IsRecommendedItem,
               cast(0 as bit)     as IsBestSellingItem,
               ''                 as Note

        from DigiTayqaNCC..OP_SaleOrderLine ln with (nolock)
        where SaleOrderId = @templateId

    insert into OrderTemplateLog
    select @templateId,
           ln.LineReferenceId as ItemId,
           'PK'               as UnitCode,
           Quantity           as Quantity,
           Price              as Price,
           @userId,
           @clientId,
           GETDATE()

    from DigiTayqaNCC..OP_SaleOrderLine ln with (nolock)
    where SaleOrderId = @templateId
END


go