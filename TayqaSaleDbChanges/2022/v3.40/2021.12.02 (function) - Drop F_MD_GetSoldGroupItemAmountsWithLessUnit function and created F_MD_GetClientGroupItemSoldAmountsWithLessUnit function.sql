DROP FUNCTION [dbo].[F_MD_GetSoldGroupItemAmountsWithLessUnit];

GO

CREATE FUNCTION [dbo].[F_MD_GetClientGroupItemSoldAmountsWithLessUnit](@firm SMALLINT, @requestId INT, @clientId INT, @itemIds NVARCHAR(MAX), @groupIds NVARCHAR(MAX), @operationId TINYINT, @startDate DATE, @endDate DATE, @groupType smallint)
    RETURNS TABLE
        AS
        RETURN
            (
                WITH cte AS (
                    SELECT soldData.GroupId,
						   soldData.ItemId,
                           soldData.ProcessDate,
                           ((soldData.Amount * soldData.iuConvfact2) / soldData.iuConvfact1) /
                           (soldData.Convfact2 / soldData.Convfact1) AS AmountWithLessUnit
                    FROM (
                             SELECT cgd.GroupId,
									rq.Firm, 
									rqclx.ItemId, 
									rqclx.ItemUnitCode, 
									rqclx.Amount, 
									iu.Convfact1 AS iuConvfact1, 
									iu.Convfact2 AS iuConvfact2, 
									iuLnr.Convfact1, 
									iuLnr.Convfact2, 
									rq.ProcessDate
                             FROM OP_RequestQueue rq WITH (NOLOCK) JOIN OP_RequestQueueCommonLineExtension rqclx WITH (NOLOCK) ON rq.Id = rqclx.Id
							 JOIN MD_ClientGroupData cgd WITH (NOLOCK) ON cgd.ClientId = rq.ClientId AND cgd.Firm = rq.Firm  AND cgd.GroupType = @groupType
							 JOIN MD_ClientGroupData cgd2 WITH(NOLOCK) ON cgd.GroupId = cgd2.GroupId and cgd.Firm = cgd2.Firm and cgd.GroupType = cgd2.GroupType

							 JOIN MD_ItemUnit iu WITH (NOLOCK)
                                  ON rqclx.ItemUnitCode = iu.Code AND rqclx.ItemId = iu.TigerItemId AND iu.Firm = rq.Firm and iu.IsDeleted = 0
                             JOIN MD_ItemUnit iuLnr WITH (NOLOCK)
                                  ON rqclx.ItemId = iuLnr.TigerItemId AND iuLnr.Firm = rq.Firm AND iuLnr.LineNr = 1 and iuLnr.IsDeleted = 0

                             WHERE ((rq.Step = 10 AND rq.ProcessingStatus = 1) OR (rq.Step = 20))
                               AND rq.Firm = @firm
                               AND rq.ProcessDate >= @startDate
                               AND rq.ProcessDate <= @endDate
                               AND rq.DocType = @operationId
                               AND rq.Id != @requestId
                               AND (rqclx.ItemId IN (SELECT * FROM F_SplitList(@itemIds, ',')))
                               AND cgd2.ClientId = @clientId
							  							   
							    --Performans problemine gore elave edilib. RAMIL
							    AND cgd2.GroupId IN (SELECT *FROM F_SplitList(@groupIds,','))
                             UNION ALL

                             SELECT cgd.GroupId, 
									 il.Firm, 
									 clx.ItemId, 
									 clx.ItemUnitCode, 
									 clx.Amount, 
									 iu.Convfact1 AS iuConvfact1, 
									 iu.Convfact2 AS iuConvfact2, 
									 iuLnr.Convfact1, 
									 iuLnr.Convfact2, 
									 il.ProcessDate
                             FROM OP_IncomingLog il WITH (NOLOCK)
                             JOIN OP_GeneralLog gl WITH (NOLOCK) ON gl.RequestId = il.Id
                             JOIN OP_IncomingLogCommonLineExtension clx WITH (NOLOCK) ON il.Id = clx.Id
							 JOIN MD_ClientGroupData cgd WITH (NOLOCK) ON cgd.ClientId = il.ClientId AND cgd.Firm = il.Firm  AND cgd.GroupType = @groupType
                             JOIN MD_ClientGroupData cgd2 WITH(NOLOCK) ON cgd.GroupId = cgd2.GroupId and cgd.Firm = cgd2.Firm and cgd.GroupType = cgd2.GroupType

							 JOIN MD_ItemUnit iu WITH (NOLOCK)
                                  ON clx.ItemUnitCode = iu.Code AND clx.ItemId = iu.TigerItemId AND iu.Firm = il.Firm and iu.IsDeleted = 0
                             JOIN MD_ItemUnit iuLnr WITH (NOLOCK)
                                  ON clx.ItemId = iuLnr.TigerItemId AND iuLnr.Firm = il.Firm AND iuLnr.LineNr = 1 and iuLnr.IsDeleted = 0

                             WHERE gl.ImportResult = 0
                               AND il.Firm = @firm
                               AND il.ProcessDate >= @startDate
                               AND il.ProcessDate <= @endDate
                               AND il.DocType = @operationId
                               AND (clx.ItemId IN (SELECT * FROM F_SplitList(@itemIds, ',')))
                               AND cgd2.ClientId = @clientId
							
							   -- Performans problemine gore elave edilib. RAMIL
							   AND cgd2.GroupId IN (SELECT *FROM F_SplitList(@groupIds,','))

                         ) AS soldData
                )

                SELECT GroupId, ItemId, ProcessDate, SUM(AmountWithLessUnit) AS TotalAmountWithLessUnit
                FROM cte
                GROUP BY GroupId, ItemId, ProcessDate
            )
GO


