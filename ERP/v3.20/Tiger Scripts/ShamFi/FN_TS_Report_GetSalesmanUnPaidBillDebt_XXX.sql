USE [LOGODB_2021]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TS_Report_GetSalesmanUnPaidBillDebt_992]    Script Date: 23.06.2021 2:51:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[FN_TS_Report_GetSalesmanUnPaidBillDebt_992](@date datetime)
    RETURNS TABLE
        AS RETURN
            (

-- Originally written by Elnur Isayev, last modified on 23.06.2021 by Kanan Mammadov to remove inactive clients and rounding up 
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
                      and CLCARD.ACTIVE = 0
                ),
                     DebtData As (
                         SELECT Clfline.SalesmanId,
                                Clfline.ClientId,
                                Clfline.ClientCode,
                                Clfline.ClientName,
                                CONVERT(int, right(PAYPLAN.code, len(PAYPLAN.code) - 1)) AS PaymentPlanDay,
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
                       SLSMAN.LOGICALREF                                         AS SalesmanId,
                       SLSMAN.CODE                                               AS SalesmanCode,
                       SLSMAN.DEFINITION_                                        AS SalesmanName,
                       IIF(DebtData.ClientTotalDebt >
                           ROUND(DebtData.ClientTotalDebt, 2), ROUND(DebtData.ClientTotalDebt, 2) + 0.01,
                           ROUND(DebtData.ClientTotalDebt, 2))                   AS ClientTotalDebt,
                       IIF((DebtData.ClientPastDebt - DebtData.Payment) >
                           ROUND(DebtData.ClientPastDebt - DebtData.Payment, 2),
                           ROUND((DebtData.ClientPastDebt - DebtData.Payment), 2) + 0.01,
                           ROUND(DebtData.ClientPastDebt - DebtData.Payment, 2)) AS ClientUnPaidDebt,
                       DebtData.PaymentPlanDay
                FROM DebtData
                         LEFT JOIN LOGODB.dbo.LG_SLSMAN SLSMAN WITH (NOLOCK)
                                   ON (SLSMAN.LOGICALREF = DebtData.SalesmanId)
                WHERE DebtData.ClientPastDebt - DebtData.Payment > 0
            );