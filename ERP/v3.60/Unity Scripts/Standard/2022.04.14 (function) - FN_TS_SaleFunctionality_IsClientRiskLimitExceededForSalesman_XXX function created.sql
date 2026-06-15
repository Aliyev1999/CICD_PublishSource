create Function [dbo].[FN_TS_SaleFunctionality_IsClientRiskLimitExceededForSalesman_XXX](@clientId int, @salesmanId int, @total float, @docType tinyint, @requestId int)
    RETURNS TINYINT
    AS
    BEGIN
        declare @notBilledOrders float=0;
        declare @currentDebt float=0;
        declare @riskLimit float = 0;
        declare @shouldCheckRiskLimit bit = 1;
        declare @result tinyint=1;

        -- select @shouldCheckRiskLimit = dbo.[FN_TS_SpecSaleFunctionality_ShouldCheckRiskLimit_XXX](@clientId);

        if (@shouldCheckRiskLimit = 1) -- should check risk limit
            begin
                select @riskLimit = ROUND(RISKLIMIT, 2)
                FROM VW_TS_Spec_GetSalesmanClientRiskLimit_XXX WITH (NOLOCK)
                WHERE CLIENTREF = @clientId
                  AND SALESMANREF = @salesmanId

                if (@riskLimit > 0)
                    begin
                        -- checking risk limit
                        if (@docType = 0)
                            begin
                                -- if order operation
                                select @notBilledOrders = ISNULL(ROUND(SUM(PRICE * (AMOUNT - SHIPPEDAMOUNT)), 2), 0)
                                from LG_XXX_YY_ORFLINE ORFLINE WITH (NOLOCK)
                                WHERE ORFLINE.CLIENTREF = @clientId
                                  AND ORFLINE.STATUS IN (4)
                                  and DATE_ >= CONVERT(date, Getdate())
                                  and ORFLINE.LINETYPE IN (0, 1, 6)
                                  AND ORFLINE.SALESMANREF = @salesmanId
                                HAVING SUM(AMOUNT - SHIPPEDAMOUNT) > 0
                            end -- order opration end

                        SELECT @currentDebt = isnull((select round(Debit - Credit, 2)
                                                      from FN_TS_Report_GetSalesmanDebt_XXX_YY()
                                                      where SalesmanId = @salesmanId
                                                        and ClientId = @clientId), 0)

                        IF @notBilledOrders + @currentDebt + @total > @riskLimit
                            set @result = 1;
                        ELSE
                            set @result = 0;
                    end -- end checking risk limit
            end -- end should check risk limit
        RETURN @result;
    end -- function end
