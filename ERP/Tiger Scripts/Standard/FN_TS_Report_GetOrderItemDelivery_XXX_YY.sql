CREATE Function [dbo].[FN_TS_Report_GetOrderItemDelivery_XXX_YY]()
RETURNS TABLE
AS RETURN
(
select  Client.CODE AS ClientCode, OrfLine.DATE_  AS OrderDate, Orfiche.FICHENO AS  OrderNo, 
null AS DeliveryDate, Item.NAME As ItemName,  Item.CODE  AS ItemCode, 
OrfLine.AMOUNT*(OrfLine.UINFO2/(case when OrfLine.UINFO1=0 then 1 else OrfLine.UINFO1 end))  AS OrderAmount,
OrfLine.SHIPPEDAMOUNT*(OrfLine.UINFO2/(case when OrfLine.UINFO1=0 then 1 else OrfLine.UINFO1 end)) AS DeliveredAmount,
OrfLine.AMOUNT*(OrfLine.UINFO2/(case when OrfLine.UINFO1=0 then 1 else OrfLine.UINFO1 end))- OrfLine.SHIPPEDAMOUNT*(OrfLine.UINFO2/(case when OrfLine.UINFO1=0 then 1 else OrfLine.UINFO1 end)) AS WaitingAmount,
(CASE WHEN ((OrfLine.AMOUNT*(OrfLine.UINFO2/(case when OrfLine.UINFO1=0 then 1 else OrfLine.UINFO1 end))- OrfLine.SHIPPEDAMOUNT*(OrfLine.UINFO2/(case when OrfLine.UINFO1=0 then 1 else OrfLine.UINFO1 end)))=0 OR OrfLine.Closed =2) THEN 1 ELSE 0 end) AS Status,
Orfiche.SALESMANREF AS SalesmanId, Orfiche.CLIENTREF AS ClientId
FROM LG_XXX_YY_ORFLINE OrfLine WITH (NOLOCK)
INNER JOIN LG_XXX_YY_ORFICHE Orfiche WITH (NOLOCK) on Orfiche.LOGICALREF=OrfLine.ORDFICHEREF
INNER JOIN lg_XXX_ITEMS Item WITH (NOLOCK) on ITEM.LOGICALREF=OrfLine.STOCKREF
INNER JOIN lg_XXX_CLCARD Client WITH (NOLOCK) on Client.LOGICALREF=OrfLine.CLIENTREF
WHERE OrfLine.TRCODE=1 AND OrfLine.LINETYPE IN (0,1,6)
);
GO
