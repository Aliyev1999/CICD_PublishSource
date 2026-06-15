ALTER function [dbo].[FN_TS_Report_GetSalesmanUnPaidBillDebt_992](@date datetime)
    RETURNS TABLE
        AS RETURN
            (
-- CLCARD.DUEDATECOUNT may be updated on customer

-- Last modified on 14.06.2021 by Kanan due to column addition in the version upgrade to 3.1.
-- Query returns the report of unpaid debts of the clients.

                WITH Clfline AS (
                    Select (CASE
                                WHEN SubString(CLCARD.SPECODE5, 1, 2) != 'AU' -- non combine, let's replace
                                    THEN (SELECT TOP 1 SALESMANREF
                                          FROM LG_992_SLSCLREL WITH (NOLOCK)
                                          WHERE CLIENTREF = CLFLINE.CLIENTREF
                                            AND SALESMANREF > 0)
                                ELSE CLFLINE.SALESMANREF END) AS SalesmanId,
                           CLFLINE.CLIENTREF                  As ClientId,
                           CLCARD.CODE                        AS ClientCode,
                           CLCARD.DEFINITION_                 AS ClientName,
                           CLCARD.PAYMENTREF                     ClientPaymentId,
                           CLFLINE.DATE_                      AS Date_,
                           CLFLINE.AMOUNT                     AS Amount,
                           CLFLINE.SIGN                       AS Sign_
                    FROM LG_992_01_CLFLINE CLFLINE WITH (NOLOCK)
                             Inner Join LG_992_CLCARD CLCARD WITH (NOLOCK) ON CLFLINE.CLIENTREF = CLCARD.LOGICALREF
                    WHERE CLFLINE.CANCELLED = 0
                ),
                     DebtData As (
                         SELECT Clfline.SalesmanId,
                                Clfline.ClientId,
                                Clfline.ClientCode,
                                Clfline.ClientName,
                                convert(int, right(PAYPLAN.code, len(PAYPLAN.code) - 1)) AS PaymentPlanDay,
                                ISNULL(SUM((CASE WHEN Clfline.Sign_ = 0 THEN 1 ELSE -1 END) * Clfline.Amount),
                                       0)                                                AS ClientTotalDebt,
                                ISNULL(SUM((CASE
                                                WHEN Clfline.Date_ <= DATEADD(DAY,
                                                                              -convert(int, right(PAYPLAN.code, len(PAYPLAN.code) - 1)),
                                                                              CONVERT(date, @date)) THEN 1
                                                ELSE 0 END) * (CASE WHEN Clfline.Sign_ = 0 THEN 1 ELSE -1 END) *
                                           Clfline.Amount), 0)                           AS ClientPastDebt,
                                ISNULL(SUM((CASE
                                                WHEN Clfline.Date_ > DATEADD(DAY,
                                                                             -convert(int, right(PAYPLAN.code, len(PAYPLAN.code) - 1)),
                                                                             CONVERT(date, @date)) AND
                                                     Clfline.Sign_ = 1
                                                    THEN 1
                                                ELSE 0 END) * Clfline.Amount), 0)        AS Payment
                         FROM Clfline
                                  INNER JOIN LG_992_PAYPLANS PAYPLAN WITH (NOLOCK)
                                             ON (PAYPLAN.LOGICALREF = Clfline.ClientPaymentId)
                         GROUP BY Clfline.SalesmanId, Clfline.ClientId, Clfline.ClientCode, Clfline.ClientName,
                                  PAYPLAN.code
                     )
                SELECT DebtData.ClientId,
                       DebtData.ClientCode,
                       DebtData.ClientName,
                       SLSMAN.LOGICALREF                                    AS SalesmanId,
                       SLSMAN.CODE                                          AS SalesmanCode,
                       SLSMAN.DEFINITION_                                   AS SalesmanName,
                       ROUND(DebtData.ClientTotalDebt, 2)                   AS ClientTotalDebt,
                       ROUND(DebtData.ClientPastDebt - DebtData.Payment, 2) AS ClientUnPaidDebt,
                       DebtData.PaymentPlanDay
                FROM DebtData
                         LEFT JOIN LOGODB.dbo.LG_SLSMAN SLSMAN WITH (NOLOCK)
                                   ON (SLSMAN.LOGICALREF = DebtData.SalesmanId)
                WHERE ROUND(DebtData.ClientPastDebt - DebtData.Payment, 2) > 0.01
            );