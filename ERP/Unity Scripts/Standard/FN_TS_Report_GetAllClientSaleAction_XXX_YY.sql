CREATE Function [dbo].[FN_TS_Report_GetAllClientSaleAction_XXX_YY](@beginDate datetime, @endDate datetime)
RETURNS TABLE
AS RETURN
(
With Actionlines AS (
SELECT INVOICE.SOURCEINDEX AS ReturnWarehouse, CLFLINE.CLIENTREF As ClientId, 
IsNull(Round(Sum(AMOUNT * (Case When CLFLINE.SIGN =0 Then 1 Else -1 End)),4),0)  As ClientDebt,
IsNull(Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (37,38) Then 1 When CLFLINE.TRCODE In (32,33) Then -1 End) * 
(Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)),4),0) As NetSaleAmount ,
Round(Sum(INVOICE.NETTOTAL),2)  As ReturnAmount,
Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (1) Then 1 Else 0 End) * (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)),4) As CashAmount,
Round(Sum(AMOUNT * (Case When CLFLINE.TRCODE In (21) Then 1 Else 0 End) * (Case When CLFLINE.DATE_ Between @beginDate And @endDate Then 1 Else 0 End)),4) As BankAmount
FROM LG_XXX_YY_CLFLINE CLFLINE With (NoLock)
LEFT JOIN LG_XXX_YY_INVOICE INVOICE WITH (NOLOCK) ON (INVOICE.LOGICALREF=CLFLINE.SOURCEFREF AND CLFLINE.TRCODE IN (32,33) AND INVOICE.CANCELLED = 0 AND INVOICE.DATE_ Between @beginDate And @endDate)
WHERE CLFLINE.CANCELLED = 0
GROUP BY CLFLINE.CLIENTREF, INVOICE.SOURCEINDEX) 
                                                       
Select  CLIENTREL.SALESMANREF AS SalesmanId, CLCARD.CODE As ClientCode, CLCARD.DEFINITION_ As ClientName, PCLCARD.EDINO As Edino, Actionlines.BankAmount as BankAmount,
Actionlines.ClientId,Actionlines.ReturnWarehouse,  Actionlines.ClientDebt,  Actionlines.ClientDebt As Debt, 
Actionlines.NetSaleAmount, Actionlines.ReturnAmount As ReturnAmount, Actionlines.CashAmount, 'AZN' As CurrencyCode,
Actionlines.BankAmount as BankPayment, Actionlines.CashAmount as CashPayment
From Actionlines With (NoLock)
Inner Join LG_XXX_SLSCLREL CLIENTREL With (NoLock) On (CLIENTREL.CLIENTREF = Actionlines.ClientId )
Inner Join LG_XXX_CLCARD CLCARD With (NoLock) On CLCARD.LOGICALREF = Actionlines.ClientId
Left Join LG_XXX_CLCARD PCLCARD With (NoLock) On PCLCARD.LOGICALREF = CLCARD.PARENTCLREF
);
GO
