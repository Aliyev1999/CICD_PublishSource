ALTER FUNCTION [dbo].[FN_TS_Report_GetSalesmanUnPaidBillDebt_XXX](@date DATETIME)
    RETURNS TABLE
        AS RETURN
            (
                SELECT CLCARD.LOGICALREF AS ClientId, CLCARD.CODE AS ClientCode, CLCARD.DEFINITION_ AS ClientName,
                       SLSMAN.LOGICALREF AS SalesmanId, SLSMAN.CODE AS SalesmanCode, SLSMAN.DEFINITION_ AS SalesmanName,
                       ISNULL(SUM((CASE WHEN CLFLINE.SIGN = 0 THEN 1 ELSE -1 END) * CLFLINE.AMOUNT), 0) AS ClientTotalDebt,
                       ISNULL(SUM((CASE
                                       WHEN CLFLINE.SIGN = 1 THEN -1
                                       WHEN CLFLINE.SIGN = 0 AND CLFLINE.DATE_ < DATEADD(DAY, ISNULL(PAYPLAN.WRKDAYS, 0), @date) THEN 1 END) * CLFLINE.AMOUNT),
                              0) AS ClientUnPaidDebt,
                       3 AS PaymentPlanDay
                FROM LG_XXX_YY_CLFLINE CLFLINE WITH (NOLOCK)
                         INNER JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON (CLCARD.LOGICALREF = CLFLINE.CLIENTREF)
                         LEFT JOIN LG_XXX_PAYPLANS PAYPLAN WITH (NOLOCK) ON (PAYPLAN.LOGICALREF = CLCARD.PAYMENTREF)
                         LEFT JOIN LG_SLSMAN SLSMAN WITH (NOLOCK) ON (SLSMAN.LOGICALREF = CLFLINE.SALESMANREF)
                WHERE CLFLINE.CANCELLED = 0
                  AND CLFLINE.STATUS = 0
                GROUP BY CLCARD.LOGICALREF, CLCARD.CODE, CLCARD.DEFINITION_, SLSMAN.LOGICALREF, SLSMAN.CODE, SLSMAN.DEFINITION_
            );
GO