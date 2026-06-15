/****** Object:  UserDefinedFunction [dbo].[F_MD_GetSoldGroupItemAmountsWithLessUnit]    Script Date: 10/25/2021 3:56:46 PM ******/

ALTER  FUNCTION [dbo].[F_MD_GetSoldGroupItemAmountsWithLessUnit](@firm SMALLINT, @requestId INT, @clientId INT, @itemIds NVARCHAR(MAX), @operationId TINYINT, @startDate DATE, @endDate DATE, @groupType smallint)
    RETURNS TABLE
        AS
        RETURN
            (
                WITH cte AS (
                    SELECT soldData.GroupId,
						   soldData.ItemId,
                           soldData.ProcessDate,
                           ((soldData.Amount * iu.Convfact2) / iu.Convfact1) /
                           (iuLnr.Convfact2 / iuLnr.Convfact1) AS AmountWithLessUnit
                    FROM (
                             SELECT cgd.GroupId, rq.Firm, rqclx.ItemId, rqclx.ItemUnitCode, rqclx.Amount, rq.ProcessDate
                             FROM OP_RequestQueue rq WITH (NOLOCK) JOIN OP_RequestQueueCommonLineExtension rqclx WITH (NOLOCK) ON rq.Id = rqclx.Id
							 JOIN MD_ClientGroupData cgd WITH (NOLOCK) ON cgd.ClientId = rq.ClientId AND cgd.Firm = rq.Firm
							 JOIN MD_ClientGroupData cgd2 WITH(NOLOCK) ON cgd.GroupId = cgd2.GroupId and cgd.Firm = cgd2.Firm and cgd.GroupType = cgd2.GroupType
                             WHERE ((rq.Step = 10 AND rq.ProcessingStatus = 1) OR (rq.Step = 20))
                               AND rq.Firm = @firm
                               AND rq.ProcessDate >= @startDate
                               AND rq.ProcessDate <= @endDate
                               AND rq.DocType = @operationId
                               AND rq.Id != @requestId
                               AND (rqclx.ItemId IN (SELECT * FROM F_SplitList(@itemIds, ',')))
                               AND cgd2.ClientId = @clientId
							   AND cgd.GroupType = @groupType

                             UNION ALL

                             SELECT cgd.GroupId, il.Firm, clx.ItemId, clx.ItemUnitCode, clx.Amount, il.ProcessDate
                             FROM OP_IncomingLog il WITH (NOLOCK)
                             JOIN OP_GeneralLog gl WITH (NOLOCK) ON gl.RequestId = il.Id
                             JOIN OP_IncomingLogCommonLineExtension clx WITH (NOLOCK) ON il.Id = clx.Id
							 JOIN MD_ClientGroupData cgd WITH (NOLOCK) ON cgd.ClientId = il.ClientId AND cgd.Firm = il.Firm
                             JOIN MD_ClientGroupData cgd2 WITH(NOLOCK) ON cgd.GroupId = cgd2.GroupId and cgd.Firm = cgd2.Firm and cgd.GroupType = cgd2.GroupType
                             WHERE gl.ImportResult = 0
                               AND il.Firm = @firm
                               AND il.ProcessDate >= @startDate
                               AND il.ProcessDate <= @endDate
                               AND il.DocType = @operationId
                               AND (clx.ItemId IN (SELECT * FROM F_SplitList(@itemIds, ',')))
                               AND cgd2.ClientId = @clientId
							   AND cgd.GroupType = @groupType

                         ) as soldData
                             JOIN MD_ItemUnit iu WITH (NOLOCK)
                                  ON soldData.ItemUnitCode = iu.Code AND soldData.ItemId = iu.TigerItemId AND iu.Firm = soldData.Firm and iu.IsDeleted = 0
                             JOIN MD_ItemUnit iuLnr WITH (NOLOCK)
                                  ON soldData.ItemId = iuLnr.TigerItemId AND iuLnr.Firm = soldData.Firm AND iuLnr.LineNr = 1 and iuLnr.IsDeleted = 0
                )

                SELECT GroupId, ItemId, ProcessDate, SUM(AmountWithLessUnit) AS TotalAmountWithLessUnit
                FROM cte
                GROUP BY GroupId, ItemId, ProcessDate
            )
GO
