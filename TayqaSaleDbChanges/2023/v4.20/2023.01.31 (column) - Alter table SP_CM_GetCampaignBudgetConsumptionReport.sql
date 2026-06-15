
ALTER   proc [dbo].[SP_CM_GetCampaignBudgetConsumptionReport] (
    @firm SMALLINT NULL,
    @startDate datetime NULL,
    @endDate datetime NULL,
    @docNumber NVARCHAR(50) NULL,
    @cmNameOrCode NVARCHAR(500) NULL,
    @targetAudienceType tinyint NULL,
    @targetAudience NVARCHAR(500) NULL,
    @promoType tinyint NULL,
    @promoItemNameCode nvarchar(200) null,
	@specodes nvarchar(200) null)
AS
BEGIN 
SET NOCOUNT ON;

Declare @Query nvarchar(max);

Set @Query='
select
cm.Id,
cm.Code,
cm.Name,
cm.StartDate,
cm.EndDate,
cm.BudgetType,
cm.Budget,
 ROUND(sum(promoCons.Consumption),2) Consumption,
count(distinct(promoCons.RequestId)) DocumentCount
from CM_Campaign cm with (nolock) 
join CM_CampaignBudgetPromoConsumption promoCons with (nolock) on cm.Id=promoCons.CampaignId
join CM_CampaignDiscountTermPromo promo with (nolock) on promo.Id =promoCons.PromoId 
join OP_IncomingLog iLog with (nolock) on promoCons.RequestId=iLog.Id
join OP_GeneralLog gLog with (nolock) on iLog.Id=gLog.RequestId and gLog.ImportResult=0
join  OP_ERPIntegrationtResultLog resultLog with (nolock) on resultLog.GeneralId=gLog.Id
left join MD_Item item with (nolock) on item.TigerId=promo.PromoValue and promo.PromoType=1 and item.Firm=@firm
'

IF @targetAudienceType IS NOT NULL
		SET @Query = CONCAT(@Query,' join (select cmCons.*  from CM_CampaignBudgetConsumption cmCons with (nolock) 
										   join CM_CampaignTargetAudiance audience with (nolock) on audience.CampaignId=cmCons.CampaignId and audience.AudianceType=cmCons.AudienceType ' )
--DIVISION
IF @targetAudienceType =8 and @targetAudience IS NOT NULL and TRY_PARSE(@targetAudience AS int) IS NULL
		SET @Query = CONCAT(@Query,' join MD_Division division with (nolock) on division.Nr=cmCons.ReferenceId and (division.Name like ''%''+@targetAudience+''%'')' )

IF @targetAudienceType =8 and @targetAudience IS NOT NULL and TRY_PARSE(@targetAudience AS int) IS NOT NULL
		SET @Query = CONCAT(@Query,' join MD_Division division with (nolock) on division.Nr=cmCons.ReferenceId and (division.Name like ''%''+@targetAudience+''%'' or division.Nr=@targetAudience)' )	

-- Clients
IF @targetAudienceType =9 and @targetAudience IS NOT NULL
		SET @Query = CONCAT(@Query,' join MD_Client client with (nolock) on client.TigerId=cmCons.ReferenceId and (client.Code like ''%''+@targetAudience+''%'' or client.Name like ''%''+@targetAudience+''%'')' )

-- Client groups
IF @targetAudienceType =10 and @targetAudience IS NOT NULL
		SET @Query = CONCAT(@Query,' join MD_ClientGroupInfo groups with (nolock) on groups.GroupId=cmCons.ReferenceId and groups.Firm=@firm and (groups.GroupCode like ''%''+@targetAudience+''%'' or groups.GroupName like ''%''+@targetAudience+''%'')' )

-- Salesman
IF @targetAudienceType =11 and @targetAudience IS NOT NULL
		SET @Query = CONCAT(@Query,' join MD_Salesman salesman with (nolock) on salesman.TigerId=cmCons.ReferenceId and (salesman.Code like ''%''+@targetAudience+''%'' or salesman.Name like ''%''+@targetAudience+''%'')' )

IF @targetAudienceType IS NOT NULL
		SET @Query = CONCAT(@Query,' where cmCons.AudienceType= @targetAudienceType')

IF @targetAudience IS NOT NULL and (@targetAudienceType=6 or @targetAudienceType=7)
		SET @Query = CONCAT(@Query,' and Value like ''%''+@targetAudience+''%''')

IF @targetAudienceType IS NOT NULL
		SET @Query = CONCAT(@Query,') bCons on bCons.CampaignId=promoCons.CampaignId 
									and bCons.RequestId =promoCons.RequestId')

SET @Query = CONCAT(@Query,' Where cm.Firm = @firm ')

IF @startDate IS NOT NULL and @endDate  IS NOT NULL
		SET @Query = CONCAT(@Query,' and ( @startDate <= promoCons.CreationDate and @endDate >= promoCons.CreationDate )' )

IF @cmNameOrCode IS NOT NULL
		SET @Query = CONCAT(@Query,' and (cm.Code like ''%''+@cmNameOrCode+''%'' or cm.Name like ''%''+@cmNameOrCode+''%'')' )

IF @promoType IS NOT NULL
		SET @Query = CONCAT(@Query,' and promo.PromoType = @promoType' )

IF @promoType =1 and @promoItemNameCode IS NOT NULL
		SET @Query = CONCAT(@Query,' and ( item.Code like ''%''+@promoItemNameCode+''%'' or item.Name like ''%''+@promoItemNameCode+''%'')' )


IF @specodes IS NOT NULL
		SET @Query = CONCAT(@Query,' and (cm.Specode like ''%''+@specodes+''%'' or cm.Specode2 like ''%''+@specodes+''%'' or cm.Specode3 like ''%''+@specodes+''%'')')

IF @docNumber IS NOT NULL
		SET @Query = CONCAT(@Query,' and (JSON_VALUE(resultLog.ImportResult,''$.ERPDocInfo.FicheNo'')  like ''%''+@docNumber+''%'')')

SET @Query = CONCAT(@Query,' 
group by 
cm.Code,
cm.Id,
cm.Name,
cm.StartDate,
cm.EndDate,
cm.BudgetType,
cm.Budget ')

  Print(@Query)

   EXEC sp_executesql @Query, N'
    @firm SMALLINT ,
    @startDate datetime ,
    @endDate datetime ,
    @docNumber NVARCHAR(50) ,
    @cmNameOrCode NVARCHAR(500) ,
    @targetAudienceType tinyint ,
    @targetAudience NVARCHAR(500) ,
    @promoType tinyint ,
    @promoItemNameCode nvarchar(200) ,
    @specodes nvarchar(200) ',
	@firm = @firm,
	@startDate = @startDate,
    @endDate = @endDate,
    @docNumber =@docNumber,
    @cmNameOrCode = @cmNameOrCode,
    @targetAudienceType = @targetAudienceType,
    @targetAudience = @targetAudience,
    @promoType = @promoType ,
    @promoItemNameCode = @promoItemNameCode,
	@specodes=@specodes

 END
