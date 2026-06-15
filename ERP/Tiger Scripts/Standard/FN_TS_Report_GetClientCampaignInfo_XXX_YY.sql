CREATE Function [dbo].[FN_TS_Report_GetClientCampaignInfo_XXX_YY](@clientId int, @salesmanId int, @edino nvarchar(100))
RETURNS TABLE
AS RETURN
(
select CODE as Name,NAME as Description,BEGDATE as BeginDate,ENDDATE as EndDate from LG_XXX_CAMPAIGN
where BEGDATE<=getdate() and ENDDATE>=getdate()
and left(CLIENTCODE,1)=(select left(code,1) from LG_XXX_CLCARD where LOGICALREF=160477)
);
GO
