CREATE OR ALTER PROCEDURE [dbo].[SP_IM_GetAssetsBySelectedBindingForApp](@firm SMALLINT,
                                                               @bindingType TINYINT,
                                                               @bindingReference NVARCHAR(250),
                                                               @userId BIGINT)
AS
BEGIN

    with types as (select asset.Id          as AssetId,
                          asset.BindingType as BindingType,

                          CASE
                              WHEN asset.BindingType = 1 THEN ISNULL(usr.Name + ' ' + usr.Surname, 'adsiz')
                              WHEN asset.BindingType = 2 THEN ISNULL(slsman.Name, 'adsiz')
                              WHEN asset.BindingType = 3 THEN ISNULL(division.Name, 'adsiz')
                              WHEN asset.BindingType = 4 THEN ISNULL(whouse.Name, 'adsiz')
                              WHEN asset.BindingType = 5 THEN ISNULL(dep.Name, 'adsiz')
                              WHEN asset.BindingType = 6 THEN ISNULL(client.Name, 'adsiz')
                              when asset.BindingType = 128 then ISNULL(asset.BindingReference, 'adsiz') collate SQL_Latin1_General_CP1_CI_AS
                              ELSE ''''
                              END           as BindingReference

                   from IM_Asset asset with (nolock)
                            left join AbpUsers usr with (nolock) on cast(usr.Id as nvarchar(50)) = asset.BindingReference and asset.BindingType = 1
                            left join MD_Salesman slsman with (nolock)
                                      on cast(slsman.Code as nvarchar(50)) COLLATE SQL_Latin1_General_CP1_CI_AS = asset.BindingReference and
                                         slsman.Firm = asset.Firm and asset.BindingType = 2
                            left join MD_Division division with (nolock)
                                      on cast(division.Nr as nvarchar(50)) = asset.BindingReference and division.Firm = asset.Firm and asset.BindingType = 3
                            left join MD_Warehouse whouse with (nolock)
                                      on cast(whouse.Nr as nvarchar(50)) = asset.BindingReference and whouse.Firm = asset.Firm and asset.BindingType = 4
                            left join MD_Department dep with (nolock)
                                      on cast(dep.Nr as nvarchar(50)) = asset.BindingReference and dep.Firm = asset.Firm and asset.BindingType = 5
                            left join MD_Client client with (nolock)
                                      on cast(client.TigerId as nvarchar(50)) = asset.BindingReference and client.Firm = asset.Firm and asset.BindingType = 6
                   where asset.BindingType > 0
                     and asset.IsDeleted = 0),

Data as(  select    binding.ActNo                           as ActNo,
					asset.Id                                as AssetId,
					AssetNr                                 as AssetNr,
					binding.AuditDayCount                   as AuditDayCount,
					binding.PlannedHandoverDate             as BindingDate,
					item.Code                               as ItemCode,
					item.TigerId                            as ItemId,
					item.Name                               as ItemName,
					isnull(binding.Note, '')                as Note,
					cast(asset.Status as tinyint)           as Status,
					binding.PlannedReturnDate               as PlannedReturnDate,
					isnull((select string_agg(SecureUrl, ',')
							from IM_AssetAttachment
							where ReferenceId = binding.Id
								and attachment.Type = 1), '') as Files,
					row_number() over (partition by asset.Id order by binding.ActNo desc) as RowNum


    from IM_Asset asset with (nolock)
             join MD_Item item with (nolock) on item.TigerId = asset.ItemId
             join types on types.AssetId = asset.Id
             left join IM_AssetBinding binding with (nolock) on asset.Id = binding.AssetId and asset.IsDeleted = 0
             left join IM_StaticContent content with (nolock) on content.Id = binding.BindingReasonId
             left join IM_AssetAttachment attachment with (nolock) on attachment.Id = asset.Id

    where asset.Firm = @firm
      and types.BindingType = @bindingType
      and types.BindingReference = @bindingReference COLLATE SQL_Latin1_General_CP1_CI_AS
	  and asset.Status in (3,5)
)
select 
		ActNo,
		AssetId,
		AssetNr,
		AuditDayCount,
		BindingDate,
		ItemCode,
		ItemId,
		ItemName,
		Note,
		Status,
		PlannedReturnDate,
		Files
from Data
where RowNum = 1;
END

