CREATE OR ALTER procedure [dbo].[SP_IM_GetAssetCountPerBindingForApp](
    @firm smallint,
    @userId bigint
)
AS
BEGIN

    with AssetCount as (select asset.Id          as AssetId,
                               asset.BindingType as BindingType,
                               CASE
                                   WHEN asset.BindingType = 1 THEN ISNULL(usr.Name + ' ' + usr.Surname, 'adsiz')
                                   WHEN asset.BindingType = 2 THEN ISNULL(slsman.Name, 'adsiz')
                                   WHEN asset.BindingType = 3 THEN ISNULL(division.Name, 'adsiz')
                                   WHEN asset.BindingType = 4 THEN ISNULL(whouse.Name, 'adsiz')
                                   WHEN asset.BindingType = 5 THEN ISNULL(dep.Name, 'adsiz')
                                   WHEN asset.BindingType = 6 THEN ISNULL(client.Name, 'adsiz')
                                   when asset.BindingType = 128 then ISNULL(asset.BindingReference, 'adsiz') collate SQL_Latin1_General_CP1_CI_AS
                                   ELSE '''' END as BindingReference
                        from IM_Asset asset
                                 with (nolock)
                                 left join AbpUsers usr
                            with (nolock) on cast(usr.Id as nvarchar(50)) = asset.BindingReference and asset.BindingType = 1
                                 left join MD_Salesman slsman
                            with (nolock) on cast(slsman.Code as nvarchar(200)) collate SQL_Latin1_General_CP1_CI_AS = asset.BindingReference and
                                             slsman.Firm = asset.Firm and asset.BindingType = 2
                                 left join MD_Division division
                            with (nolock) on cast(division.Nr as nvarchar(50)) = asset.BindingReference and division.Firm = asset.Firm and
                                             asset.BindingType = 3
                                 left join MD_Warehouse whouse
                            with (nolock) on cast(whouse.Nr as nvarchar(50)) = asset.BindingReference and whouse.Firm = asset.Firm and asset.BindingType = 4
                                 left join MD_Department dep
                            with (nolock) on cast(dep.Nr as nvarchar(50)) = asset.BindingReference and dep.Firm = asset.Firm and asset.BindingType = 5
                                 left join MD_Client client
                            with (nolock) on cast(client.TigerId as nvarchar(50)) = asset.BindingReference and client.Firm = asset.Firm and
                                             asset.BindingType = 6
                        where asset.Firm = @firm
                          and Asset.IsDeleted = 0
                          and asset.BindingType > 0)
    select cast(count(AssetId) as tinyint) as AssetCount,
           BindingType,
           BindingReference

    from AssetCount
    group by BindingType, BindingReference

End