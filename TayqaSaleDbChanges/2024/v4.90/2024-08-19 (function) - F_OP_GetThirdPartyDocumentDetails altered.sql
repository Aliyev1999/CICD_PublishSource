
ALTER function [dbo].[F_OP_GetThirdPartyDocumentDetails](@userId int, @type smallint, @id bigint)
    returns table
        return
            (
                select Item.TigerId                               as ItemId,
                       Item.Code                                  as ItemCode,
                       Item.Name                                  as ItemName,
                       Unit.Name                                  as UnitCode,
                       isnull(RequestQueue.Amount, Result.Amount) as Quantity,
                       round(Line.Price, 2)                       as Price,
                       round(Line.DiscountAmount, 2)              as DiscountAmount,
                       ''                                         as CashName,
                       ''                                         as CashCode,
                       cast(0 as float)                           as Amount,
					   Line.IsPromo								  as IsPromo
                from OP_ThirdPartyIncomingLog ILog with (nolock)
                         join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = ILog.UserId
                         join OP_ThirdPartyIncomingLogCommonLineExtension Line with (nolock) on ILog.Id = Line.Id
                         join MD_Item Item with (nolock) on Line.ItemId = Item.TigerId
                         join MD_ItemUnit Unit with (nolock)
                              on Line.ItemUnitCode COLLATE SQL_Latin1_General_CP1_CI_AS = Unit.Code and
                                 Unit.TigerItemId = Line.ItemId
                         left join OP_ThirdPartyRequestQueueCommonLineExtension RequestQueue with (nolock) on Line.Id = RequestQueue.Id
                    and Line.ItemId = RequestQueue.ItemId and Line.ItemUnitCode = RequestQueue.ItemUnitCode and RequestQueue.IsPromo = Line.IsPromo
                         left join OP_ThirdPartyCommonLineResultLog Result with (nolock)
                                   on Result.Id = Line.Id and Result.ItemId = Line.ItemId and Line.IsPromo = Result.IsPromo
                where Ilog.DocType in (0, 1, 2, 3, 4)
                  and ILog.DocType = @Type
                  and ILog.Id = @Id
                union
                select ''                                               as ItemId,
                       ''                                               as ItemCode,
                       ''                                               as ItemName,
                       ''                                               as UnitCode,
                       0                                                as Quantity,
                       0                                                as Price,
                       0                                                as DiscountAmount,
                       CashCard.Name                                    as CashName,
                       CashCard.Code                                    as CashCode,
                       coalesce(RequestQueue.Amount, CashTwo.Amount, 0) as Amount,
					   cast(0 as bit)								    as IsPromo
                from OP_ThirdPartyIncomingLog ILog with (nolock)
                         join AbpUsers Users with (nolock) on ILog.UserId = Users.Id
                         join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = ILog.UserId
                         left join OP_ThirdPartyRequestQueueCashExtension RequestQueue with (nolock) on RequestQueue.Id = ILog.Id
                         left join OP_ThirdPartyIncomingLogCashExtension Cash with (nolock) on Cash.Id = ILog.Id
                         left join OP_ThirdPartyCashResultLog CashTwo with (nolock) on ILog.Id = CashTwo.Id
                         left join MD_CashCard CashCard with (nolock) on CashCard.Code COLLATE SQL_Latin1_General_CP1_CI_AS = Cash.CashCode
                where ILog.DocType in (5, 6)
                  and ILog.DocType = @Type
                  and ILog.Id = @id

                union

                select Item.TigerId                                      as ItemId,
                       Item.Code                                         as ItemCode,
                       Item.Name                                         as ItemName,
                       Unit.Name                                         as UnitCode,
                       sum(isnull(RequestQueue.Quantity, Line.Quantity)) as Quantity,
                       0                                                 as Price,
                       0                                                 as DiscountAmount,
                       ''                                                as CashName,
                       ''                                                as CashCode,
                       cast(0 as float)                                  as Amount,
					   cast(0 as bit)									 as IsPromo
                from OP_ThirdPartyIncomingLog ILog with (nolock)
                         join F_UIM_GetOrganizationTreeUsers(@userId) ou on ou.UserId = ILog.UserId
                         join OP_ThirdPartyIncomingLogWarehouseOperationLineExtension Extension with (nolock) on Extension.Id = ILog.Id
                         join MD_Item Item with (nolock) on Extension.ItemId = Item.TigerId
                         join MD_ItemUnit Unit with (nolock)
                              on Extension.ItemUnitCode COLLATE SQL_Latin1_General_CP1_CI_AS = Unit.Code and Unit.TigerItemId = Extension.ItemId
                         left join OP_ThirdPartyRequestQueueWarehouseOperationLineExtension RequestQueue with (nolock)
                                   on RequestQueue.Id = Extension.Id and RequestQueue.ItemId = Extension.ItemId
                                       and RequestQueue.ItemUnitCode = Extension.ItemUnitCode
                         left join OP_ThirdPartyWarehouseOperationLineResultLog Line with (nolock)
                                   on Extension.Id = Line.Id and Extension.ItemId = Line.ItemId

                where ILog.DocType = @Type
                  and ILog.Id = @Id
                  and ILog.DocType in (21, 22, 23, 24)
                group by Item.Code, Item.Name, Unit.Name, Item.TigerId

            )