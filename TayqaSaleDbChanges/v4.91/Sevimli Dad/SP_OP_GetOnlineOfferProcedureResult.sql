ALTER proc [dbo].[SP_OP_GetOnlineOfferProcedureResult](@clientId int,
                                                       @templateId int,
                                                       @catalogIds nvarchar(MAX),
                                                       @operationId tinyint,
                                                       @date datetime = null,
                                                       @userId int)
AS
BEGIN
    SET NOCOUNT ON;
    if @operationId = 2
        begin

            Declare @Query nvarchar(max);

            select @Query = ProcedureName
            from OP_OnlineOfferTemplate t
            where Id = 4


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


    if @operationId = 4
        begin
            select STOCKREF                               as ItemId,
                   'KQ'                                   as UnitCode,
                   sum(round(AMOUNT * Unit.CONVFACT2, 3)) as Quantity,
                   min(VATMATRAH)                         as Price,
                   1                                      as CanRemove,
                   1                                      as CanDecrease,
                   cast(1 as bit)                         as IsCampaignItem,
                   cast(0 as bit)                         as IsSpecialItem,
                   cast(0 as bit)                         as IsRecommendedItem,
                   cast(0 as bit)                         as IsBestSellingItem,
                   ''                                     as Note

            from LOGODB..LG_001_01_ORFLINE Line with (nolock)
                     left JOIN LOGODB..LG_001_ITMUNITA Unit with (nolock) on Unit.ITEMREF = Line.STOCKREF and Unit.LINENR = 2
            where cast(DATE_ as date) = cast(dateadd(day, iif(datepart(dw, getdate()) = 2, -2, -1), getdate()) as date) -- only yesterday's sales except Monday
              and LINETYPE <> 1                                                                                         -- non-promo lines
              and CLIENTREF = @ClientId                                                                                 -- selected client
            group by STOCKREF

        end

END