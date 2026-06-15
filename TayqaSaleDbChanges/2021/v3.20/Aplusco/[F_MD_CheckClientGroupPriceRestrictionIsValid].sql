CREATE OR ALTER function [dbo].[F_MD_CheckClientGroupPriceRestrictionIsValid](
    @firm smallint,
    @groupType tinyint,
    @groupId int,
    @tigerClientId int,
    @requestId int,
    @operationId tinyint,
    @processDate date,
    @totalPrice float,
    @restrictionTypes tinyint)
    returns @T Table
               (
                   IsValid       bit NOT NULL,
                   Code          nvarchar(50),
                   [Description] nvarchar(50)
               )
as
begin

    declare @min float
    declare @max float
    declare @soldPrice float
    declare @Restrictions Table
                          (
                              Min  float,
                              Max  float,
                              Type tinyint
                          )

    INSERT INTO @Restrictions
    SELECT Min,
           Max,
           Type
    FROM MD_ClientGroupPriceRestriction WITH (NOLOCK)
    WHERE Firm = @firm
      AND Status = 0
      AND GroupType = @groupType
      AND GroupId = @groupId
      AND OperationId = @operationId
      AND (Type & @restrictionTypes) = Type

    declare @ShouldCheck bit = 0
    set @ShouldCheck =
            (SELECT dbo.[FN_ShouldCheckClientGroupPriceRestriction](@firm, @groupType, @groupId, @requestId))

    declare @ExceptionItemsFailure int = 0

    if @ShouldCheck = 1
        set @ExceptionItemsFailure = (select SUM(IIF(Items.Amount <= (Line.Amount * Line.Price), 0, 1))
                                      FROM OP_IncomingLogCommonLineExtension Line
                                               JOIN OP_IncomingLogCommonExtension Ext on Line.Id = Ext.Id
                                               JOIN OP_IncomingLog IncLog on IncLog.Id = Ext.Id
                                               JOIN MD_ClientGroupData GrpData
                                                    on GrpData.ClientId = IncLog.ClientId and
                                                       GrpData.Firm = IncLog.Firm and
                                                       GrpData.GroupType = 3
                                               JOIN MD_ClientGroupPriceRestriction PrcRes
                                                    on PrcRes.Firm = IncLog.Firm and
                                                       PrcRes.OperationId = IncLog.DocType + 1 and
                                                       IncLog.ClientId = GrpData.ClientId and
                                                       PrcRes.Firm = GrpData.Firm and
                                                       PrcRes.GroupType = GrpData.GroupType and
                                                       PrcRes.GroupId = GrpData.GroupId
                                                        and PrcRes.Status = 0
                                               JOIN ADD_ClientGroupPriceRestrictionItemExceptions Items
                                                    on Items.ItemId = Line.ItemId
                                      WHERE IncLog.Firm = @firm
                                        and PrcRes.GroupType = @groupType
                                        and GrpData.GroupId = @groupId
                                        and IncLog.Id = @requestId)

    IF @ShouldCheck = 1 and @ExceptionItemsFailure = 0
        begin
            INSERT INTO @T VALUES (1, NULL, NULL)
        end
    else
        begin
            --Check operationally begin
            if ((@restrictionTypes & 1) = 1)
                BEGIN
                    select @min = min, @max = max FROM @Restrictions WHERE Type = 1

                    if (@totalPrice > @max)
                        BEGIN
                            INSERT INTO @T VALUES (0, 'Operationally', 'MaximumLimit')
                            return
                        END
                    else
                        If (@operationId NOT IN (2, 3) AND @totalPrice < @min)
                            BEGIN
                                INSERT INTO @T VALUES (0, 'Operationally', 'MinumumLimit')
                                return
                            END
                END
            --Check operationally end


--Check daily begin
            if ((@restrictionTypes & 2) = 2)
                BEGIN
                    select @min = min, @max = max FROM @Restrictions WHERE Type = 2

                    SELECT @soldPrice = TotalSoldPrice
                    FROM F_MD_GetClientSoldItemTotalPrice(@firm, @tigerClientId, @requestId, (@operationId - 1),
                                                          @processDate, @processDate)

                    if ((@totalPrice + @soldPrice) > @max)
                        BEGIN
                            INSERT INTO @T VALUES (0, 'Daily', 'MaximumLimit')
                            return
                        END
                    else
                        If (@operationId NOT IN (2, 3) AND (@totalPrice + @soldPrice) < @min)
                            BEGIN
                                INSERT INTO @T VALUES (0, 'Daily', 'MinumumLimit')
                                return
                            END
                END
            --Check daily end


--Check weekly begin
            if ((@restrictionTypes & 4) = 4)
                BEGIN
                    declare @weekStartDate date
                    declare @weekEndDate date

                    select @min = min, @max = max FROM @Restrictions WHERE Type = 4

                    SET @weekStartDate =
                            DATEADD(DAY, 2 - DATEPART(WEEKDAY, @processDate), CAST(@processDate AS DATE))
                    SET @weekEndDate =
                            DATEADD(DAY, 8 - DATEPART(WEEKDAY, @processDate), CAST(@processDate AS DATE))

                    SELECT @soldPrice = TotalSoldPrice
                    FROM F_MD_GetClientSoldItemTotalPrice(@firm, @tigerClientId, @requestId, (@operationId - 1),
                                                          @weekStartDate, @weekEndDate)

                    if ((@totalPrice + @soldPrice) > @max)
                        BEGIN
                            INSERT INTO @T VALUES (0, 'Weekly', 'MaximumLimit')
                            return
                        END
                    else
                        If (@operationId NOT IN (2, 3) AND (@totalPrice + @soldPrice) < @min)
                            BEGIN
                                INSERT INTO @T VALUES (0, 'Weekly', 'MinumumLimit')
                                return
                            END
                END
            --Check weekly end


--Check monthly begin
            if ((@restrictionTypes & 8) = 8)
                BEGIN
                    declare @monthStartDate date
                    declare @monthEndDate date

                    select @min = min, @max = max FROM @Restrictions WHERE Type = 8

                    SET @monthStartDate = DATEADD(month, DATEDIFF(month, 0, @processDate), 0)
                    SET @monthEndDate = DATEADD(dd, -1, DATEADD(mm, DATEDIFF(mm, 0, @processDate) + 1, 0))

                    SELECT @soldPrice = TotalSoldPrice
                    FROM F_MD_GetClientSoldItemTotalPrice(@firm, @tigerClientId, @requestId, (@operationId - 1),
                                                          @monthStartDate, @monthEndDate)

                    if ((@totalPrice + @soldPrice) > @max)
                        BEGIN
                            INSERT INTO @T VALUES (0, 'Monthly', 'MaximumLimit')
                            return
                        END
                    else
                        If (@operationId NOT IN (2, 3) AND (@totalPrice + @soldPrice) < @min)
                            BEGIN
                                INSERT INTO @T VALUES (0, 'Monthly', 'MinumumLimit')
                                return
                            END
                END
            --Check monthly end


--Check yearly begin
            if ((@restrictionTypes & 16) = 16)
                BEGIN
                    declare @yearStartDate date
                    declare @yearEndDate date

                    select @min = min, @max = max FROM @Restrictions WHERE Type = 16

                    SET @yearStartDate = DATEFROMPARTS(YEAR(@processDate), 1, 1)
                    SET @yearEndDate = DATEFROMPARTS(YEAR(@processDate), 12, 31)

                    SELECT @soldPrice = TotalSoldPrice
                    FROM F_MD_GetClientSoldItemTotalPrice(@firm, @tigerClientId, @requestId, (@operationId - 1),
                                                          @yearStartDate, @yearEndDate)

                    if ((@totalPrice + @soldPrice) > @max)
                        BEGIN
                            INSERT INTO @T VALUES (0, 'Yearly', 'MaximumLimit')
                            return
                        END
                    else
                        If (@operationId NOT IN (2, 3) AND (@totalPrice + @soldPrice) < @min)
                            BEGIN
                                INSERT INTO @T VALUES (0, 'Yearly', 'MinumumLimit')
                                return
                            END
                END
        end
--Check yearly end


    INSERT INTO @T VALUES (1, NULL, NULL)
    return
end
GO
