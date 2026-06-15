-- Sale action report updated due to multiply client - salesman mapping
ALTER   Function [dbo].[FN_TS_Report_GetAllClientSaleAction_XXX_YY](@beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
With 
Clfline AS (
SELECT 
(CASE WHEN SubString(CLCARD.SPECODE5,1,2)!='AU' -- non combine, let's replace
THEN (SELECT TOP 1 SALESMANREF FROM LG_XXX_SLSCLREL WITH (NOLOCK) WHERE CLIENTREF=CLFLINE.CLIENTREF AND SALESMANREF>0) 
ELSE CLFLINE.SALESMANREF END) AS SalesmanId, INVOICE.SOURCEINDEX AS ReturnWarehouse, CLFLINE.CLIENTREF As ClientId, 
CLFLINE.AMOUNT As Amount, CLFLINE.SIGN AS Sign_, CLFLINE.TRCODE AS Trcode, CLFLINE.DATE_ AS Date_,
INVOICE.NETTOTAL AS ReturnAmount
FROM LG_XXX_YY_CLFLINE CLFLINE With (NoLock)
INNER JOIN LG_XXX_CLCARD CLCARD WITH (NOLOCK) ON CLCARD.LOGICALREF=CLFLINE.CLIENTREF
LEFT JOIN LG_XXX_YY_INVOICE INVOICE WITH (NOLOCK) ON (INVOICE.LOGICALREF=CLFLINE.SOURCEFREF AND CLFLINE.TRCODE IN (32,33) AND INVOICE.CANCELLED = 0 AND INVOICE.DATE_ Between @beginDate And @endDate)
WHERE CLFLINE.CANCELLED = 0
),

Actionlines AS (
SELECT Clfline.SalesmanId, Clfline.ReturnWarehouse, Clfline.ClientId, 
IsNull(Round(Sum(AMOUNT * (Case When Clfline.Sign_ =0 Then 1 Else -1 End)),4),0)  As ClientDebt,
IsNull(Round(Sum(AMOUNT * (Case When Clfline.Trcode In (37,38) Then 1 When Clfline.Trcode In (32,33) Then -1 End) * 
(Case When Clfline.Date_ Between @beginDate And @endDate Then 1 Else 0 End)),4),0) As NetSaleAmount ,
Round(Sum(Clfline.ReturnAmount),2)  As ReturnAmount,
Round(Sum(AMOUNT * (Case When Clfline.Trcode In (1) Then 1 Else 0 End) * (Case When Clfline.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)),4) As CashAmount,
Round(Sum(AMOUNT * (Case When Clfline.Trcode In (21) Then 1 Else 0 End) * (Case When Clfline.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)),4) As BankAmount
FROM Clfline
GROUP BY Clfline.SalesmanId, Clfline.ClientId, Clfline.ReturnWarehouse) 
                                                       
Select  Actionlines.SalesmanId, CLCARD.CODE As ClientCode, CLCARD.DEFINITION_ As ClientName, SLSMAN.CODE As Edino, Actionlines.BankAmount as BankAmount,
Actionlines.ClientId,Actionlines.ReturnWarehouse,  Actionlines.ClientDebt,  Actionlines.ClientDebt As Debt, 
Actionlines.NetSaleAmount, Actionlines.ReturnAmount As ReturnAmount, Actionlines.CashAmount, 'AZN' As CurrencyCode,
Actionlines.BankAmount as BankPayment, Actionlines.CashAmount as CashPayment
From Actionlines With (NoLock)
Inner Join LG_XXX_CLCARD CLCARD With (NoLock) On CLCARD.LOGICALREF = Actionlines.ClientId
INNER JOIN LOGODB.dbo.LG_SLSMAN SLSMAN WITH (NOLOCK) ON Actionlines.SalesmanId = SLSMAN.LOGICALREF
--Left Join LG_XXX_CLCARD PCLCARD With (NoLock) On PCLCARD.LOGICALREF = CLCARD.PARENTCLREF
);