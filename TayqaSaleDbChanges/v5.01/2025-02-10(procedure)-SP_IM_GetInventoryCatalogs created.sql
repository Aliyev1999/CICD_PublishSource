CREATE OR ALTER procedure [dbo].[SP_IM_GetInventoryCatalogs](
    @userId int
)
as
begin

    with UserGroupPermitted as (select PermittedCatalog.CatalogId,
                                       1 as Type
                                from IM_UserGroupPermittedCatalog PermittedCatalog with (nolock)
                                         join MD_UserGroupMapping Mapping with (nolock) on PermittedCatalog.UserGroupId = Mapping.GroupId
                                where Mapping.UserId = @userId

                                union all

                                select Permitted.CatalogId,
                                       2 as Type
                                from IM_PermittedCatalog Permitted with (nolock)
                                where Permitted.UserId = @userId),
         RankedPermissions as (select CatalogId,
                                      Type,
                                      row_number() over ( partition by CatalogId order by Type) as rn
                               from UserGroupPermitted)

    select distinct Catalog.Id,
                    mapping.TigerItemId,
                    Catalog.Firm,
                    Catalog.Code,
                    Catalog.Specode,
                    Catalog.Name,
                    CatalogGroup.Code as                                                                                            GroupCode,
                    CatalogGroup.Name as                                                                                            GroupName,

                    iif(Catalog.RegisteredDate >= CatalogGroup.RegisteredDate, Catalog.RegisteredDate, CatalogGroup.RegisteredDate) RegisteredDate
    from RankedPermissions
             join IM_Catalog Catalog with (nolock) on RankedPermissions.CatalogId = Catalog.Id and Catalog.Type = 1
             JOIN IM_CatalogGroup CatalogGroup with (nolock) on Catalog.CatalogGroupId = CatalogGroup.Id
             JOIN IM_CatalogItemMapping mapping with (nolock) on Catalog.Id = mapping.CatalogId
    where rn = 1
end