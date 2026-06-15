 create FUNCTION [dbo].[F_MD_GetSoldItemGroupAmountsWithLessUnit](@firm SMALLINT, @period SMALLINT,
                                                                          @requestId INT,
                                                                          @itemGroups NVARCHAR(MAX),
                                                                          @operationId TINYINT,
                                                                          @userId INT)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT GroupId, SUM(SoldQuantity) AS SoldQuantity
                FROM (
                         SELECT Items.GroupId,
                                Queue.Id,
                                SUM(((Lines.Amount * ItemUnit.Convfact2) / ItemUnit.Convfact1) /
                                    (MainUnit.Convfact2 / MainUnit.Convfact1)) as SoldQuantity
                         FROM OP_RequestQueue Queue WITH (NOLOCK)
                                  JOIN OP_RequestQueueCommonLineExtension Lines WITH (NOLOCK)
                                       ON Queue.Id = Lines.Id
                                           AND Queue.ProcessingStatus = 0
                                           AND Queue.DocType = @operationId
                                           AND Queue.Firm = @firm
                                           AND Queue.Id <> @requestId
                                           AND Queue.UserId = @userId
                                           AND Queue.[Period] = @period
                                  JOIN MD_ItemGroupItemMapping Items
                                       ON Items.ItemId = Lines.ItemId
                                           AND Items.Firm = Queue.Firm
                                  JOIN MD_UserItemGroupQuantityOperationRestriction Restriction
                                       ON Restriction.ItemGroupId = Items.GroupId
                                           AND Restriction.UserId = @userId
                                           AND Restriction.Firm = Queue.Firm AND Restriction.[Status] = 0
                                           AND Restriction.StartDate <= Queue.ProcessDate
                                           AND Restriction.EndDate >= Queue.ProcessDate
                                           AND Restriction.OperationId = @operationId + 1
                                  JOIN MD_ItemUnit ItemUnit WITH (NOLOCK)
                                       ON Lines.ItemUnitCode = ItemUnit.Code AND Lines.ItemId = ItemUnit.TigerItemId AND
                                          ItemUnit.Firm = Queue.Firm
                                  JOIN MD_ItemUnit MainUnit WITH (NOLOCK)
                                       ON Lines.ItemId = MainUnit.TigerItemId AND MainUnit.Firm = Queue.Firm AND
                                          MainUnit.LineNr = 1
                         WHERE Items.GroupId IN (SELECT [Value] FROM F_SplitList(@itemGroups, ', ')) --  AND Items.ItemId IN (SELECT [Value] FROM F_SplitList(@items, ', '))
                         GROUP BY Items.GroupId, Queue.Id

                         union

                         SELECT Items.GroupId,
                                IncomingLog.Id,
                                SUM(((LogLines.Amount * ItemUnit.Convfact2) / ItemUnit.Convfact1) /
                                    (MainUnit.Convfact2 / MainUnit.Convfact1)) as SoldQuantity
                         FROM OP_IncomingLog IncomingLog WITH (NOLOCK)
                                  JOIN OP_IncomingLogCommonLineExtension LogLines WITH (NOLOCK)
                                       ON IncomingLog.Id = LogLines.Id
                                           -- AND Queue.ProcessingStatus = 0
                                           AND IncomingLog.DocType = @operationId
                                           AND IncomingLog.Firm = @firm
                                           AND IncomingLog.Id <> @requestId
                                           AND IncomingLog.UserId = @userId
                                           AND IncomingLog.[Period] = @period
                                  JOIN MD_ItemGroupItemMapping Items
                                       ON Items.ItemId = LogLines.ItemId
                                           AND Items.Firm = IncomingLog.Firm
                                  JOIN MD_UserItemGroupQuantityOperationRestriction Restriction
                                       ON Restriction.ItemGroupId = Items.GroupId
                                           AND Restriction.UserId = @userId
                                           AND Restriction.Firm = IncomingLog.Firm AND Restriction.[Status] = 0
                                           AND Restriction.StartDate <= IncomingLog.ProcessDate
                                           AND Restriction.EndDate >= IncomingLog.ProcessDate
                                           AND Restriction.OperationId = @operationId + 1
                                  JOIN MD_ItemUnit ItemUnit WITH (NOLOCK)
                                       ON LogLines.ItemUnitCode = ItemUnit.Code AND
                                          LogLines.ItemId = ItemUnit.TigerItemId AND
                                          ItemUnit.Firm = IncomingLog.Firm
                                  JOIN MD_ItemUnit MainUnit WITH (NOLOCK)
                                       ON LogLines.ItemId = MainUnit.TigerItemId AND
                                          MainUnit.Firm = IncomingLog.Firm AND
                                          MainUnit.LineNr = 1
                                  JOIN OP_GeneralLog GenLog with (nolock)
                                       on GenLog.RequestId = IncomingLog.Id and GenLog.ImportResult = 0
                         WHERE Items.GroupId IN (SELECT [Value] FROM F_SplitList(@itemGroups, ', ')) --  AND Items.ItemId IN (SELECT [Value] FROM F_SplitList(@items, ', '))
                         GROUP BY Items.GroupId, IncomingLog.Id) T
                GROUP BY GroupId
            )
GO