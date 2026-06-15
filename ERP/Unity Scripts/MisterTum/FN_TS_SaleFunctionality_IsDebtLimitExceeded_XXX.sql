ALTER Function [dbo].[FN_TS_SaleFunctionality_IsDebtLimitExceeded_XXX](@salesmanId int, @total FLOAT, @docType tinyint)
-- checking salesman debt limit
    RETURNS TINYINT
    AS
    BEGIN
        DECLARE @notBilledOrders FLOAT=0;
        DECLARE @currentDebt FLOAT=0;
        DECLARE @debtLimit FLOAT;

--mister tum'da risk limiti oxunan yer SELECT RISK FROM LG_SLSMAN WHERE LOGICALREF=@salesmanId

        SELECT @debtLimit = RISK FROM LG_SLSMAN WHERE LOGICALREF = @salesmanId;

        IF (@debtLimit > 0)
            BEGIN
                IF (@docType = 0) -- IF order operation
                    BEGIN
                        SELECT @notBilledOrders = ISNULL(SUM(PRICE * (AMOUNT - SHIPPEDAMOUNT)), 0)
                        FROM LG_XXX_YY_ORFLINE ORFLINE WITH (NOLOCK)
                        WHERE ORFLINE.STATUS IN (4)
                          AND ORFLINE.DATE_ >= CONVERT(date, getdate())
                          AND CLIENTREF IN (
                            SELECT CLIENTREF
                            FROM LG_XXX_SLSCLREL WITH (NOLOCK)
                            WHERE SALESMANREF = @salesmanId)
                        HAVING SUM(AMOUNT - SHIPPEDAMOUNT) > 0
                    END

                SELECT @currentDebt = ISNULL(SUM(DEBIT - CREDIT), 0)
                FROM LG_XXX_YY_GNTOTCL GNTOTCL WITH (NOLOCK)
                WHERE TOTTYP = 1
                  AND CARDREF IN
                      (SELECT DISTINCT CLIENTREF
                       FROM LG_XXX_SLSCLREL SLCREL WITH (NOLOCK)
                       WHERE SALESMANREF = @salesmanId)

                IF @notBilledOrders + @currentDebt + @total > @debtLimit
                    RETURN 1
                ELSE
                    RETURN 0;
            END
        RETURN 0;
    END