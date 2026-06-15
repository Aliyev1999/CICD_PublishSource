CREATE FUNCTION [dbo].[F_MD_GetSoldGroupItemAmountsWithLessUnit](@firm SMALLINT, @requestId INT, @clientId INT, @itemIds NVARCHAR(MAX), @operationId TINYINT, @startDate DATE, @endDate DATE, @groupType smallint)
    RETURNS TABLE
        AS
        RETURN
            (
                WITH cte AS (
                    SELECT soldData.ItemId,
                           soldData.ProcessDate,
                           ((soldData.Amount * iu.Convfact2) / iu.Convfact1) /
                           (iuLnr.Convfact2 / iuLnr.Convfact1) AS AmountWithLessUnit
                    FROM (
                             SELECT rq.Firm, rqclx.ItemId, rqclx.ItemUnitCode, rqclx.Amount, rq.ProcessDate
                             FROM OP_RequestQueue rq WITH (NOLOCK)
                                      JOIN OP_RequestQueueCommonLineExtension rqclx WITH (NOLOCK) ON rq.Id = rqclx.Id
                             WHERE ((rq.Step = 10 AND rq.ProcessingStatus = 1) OR (rq.Step = 20))
                               AND rq.Firm = @firm
                               AND rq.ProcessDate >= @startDate
                               AND rq.ProcessDate <= @endDate
                               AND rq.DocType = @operationId
                               AND rq.Id != @requestId
                               AND (rqclx.ItemId IN (SELECT * FROM F_SplitList(@itemIds, ',')))
                               AND rq.ClientId IN (select ClientId
                                                   from MD_ClientGroupData
                                                   where GroupId in (select GroupId
                                                                     from MD_ClientGroupData D1
                                                                     where D1.ClientId = @clientId))


                             UNION ALL

                             SELECT il.Firm, clx.ItemId, clx.ItemUnitCode, clx.Amount, il.ProcessDate
                             FROM OP_IncomingLog il WITH (NOLOCK)
                                      JOIN OP_GeneralLog gl WITH (NOLOCK) ON gl.RequestId = il.Id
                                      JOIN OP_IncomingLogCommonLineExtension clx WITH (NOLOCK) ON il.Id = clx.Id
                             WHERE gl.ImportResult = 0
                               AND il.Firm = @firm
                               AND il.ProcessDate >= @startDate
                               AND il.ProcessDate <= @endDate
                               AND il.DocType = @operationId
                               AND (clx.ItemId IN (SELECT * FROM F_SplitList(@itemIds, ',')))
                               AND ClientId IN (select ClientId
                                                from MD_ClientGroupData
                                                where GroupId in (select GroupId
                                                                  from MD_ClientGroupData D1
                                                                  where D1.ClientId = @clientId))
                         ) as soldData
                             JOIN MD_ItemUnit iu WITH (NOLOCK)
                                  ON soldData.ItemUnitCode = iu.Code AND soldData.ItemId = iu.TigerItemId AND
                                     iu.Firm = soldData.Firm and iu.IsDeleted = 0
                             JOIN MD_ItemUnit iuLnr WITH (NOLOCK)
                                  ON soldData.ItemId = iuLnr.TigerItemId AND iuLnr.Firm = soldData.Firm AND
                                     iuLnr.LineNr = 1 and iuLnr.IsDeleted = 0
                )

                SELECT ItemId, ProcessDate, SUM(AmountWithLessUnit) AS TotalAmountWithLessUnit
                FROM cte
                GROUP BY ItemId, ProcessDate
            )