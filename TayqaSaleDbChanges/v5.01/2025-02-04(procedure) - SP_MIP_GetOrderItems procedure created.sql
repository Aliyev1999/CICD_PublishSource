CREATE OR ALTER PROCEDURE [dbo].[SP_MIP_GetOrderItems] @firm smallint,
                                              @clientId int,
                                              @currentUserId int,
                                              @divisionNr int,
                                              @itemCodeOrName nvarchar(200),
                                              @catalogCodes nvarchar(200),
                                              @catalogGroupCodes nvarchar(200),
                                              @itemIds nvarchar(200),
                                              @sorting nvarchar(200),
                                              @maxResultCount int,
                                              @skipCount int,
                                              @totalCount int output
AS
BEGIN
    SET NOCOUNT ON;

	declare @totalCountQuery nvarchar(max);
    declare @query nvarchar(max);


    set @query = '
select distinct item.TigerId                  as Id,
                item.Firm                     as Firm,
                item.Code                     as Code,
                item.Name                     as Name,
                unit.Name                     as Unit,
                (select top 1 price.Price
                 from MD_ItemPrice price
                 where price.TigerItemId = item.TigerId
                   and price.Firm = @Firm
                   and price.OperationMask like ''1%''
                 order by price.EndDate desc) as Price,
                isnull(item.SellVat, 0)       as SellVat,
                item.BrendCode                as BrandCode,
                item.BrendName                as BrandName,
                item.SpecialCode              as SpecialCode1,
                item.SpecialCode2             as SpecialCode2,
                item.SpecialCode3             as SpecialCode3,
                item.SpecialCode4             as SpecialCode4,
                item.SpecialCode5             as SpecialCode5

from MD_Item item with (nolock)
         join MD_ItemUnit unit with (nolock) on item.TigerId = unit.TigerItemId AND item.Firm = unit.Firm and unit.IsDeleted = 0 and unit.IsMainUnit=1
         join MD_CatalogItemMapping mapping with (nolock) on item.TigerId = mapping.TigerItemId
         join MD_Catalog catalog with (nolock) on mapping.CatalogId = catalog.Id
         join MD_CatalogGroup cgroup with (nolock) on catalog.CatalogGroupId = cgroup.Id
		 join F_GetAllPermittedItems() permitteditems on item.TigerId=permitteditems.TigerItemId and item.Firm=permitteditems.Firm and permitteditems.UserId=@currentUserId
		 
	WHERE  item.IsDeleted = 0 and item.Status = 0
'
    if @firm is not null
        set @query = CONCAT(@query, ' and item. Firm = @firm');

    if @itemIds is not null
        set @query = concat(@query, ' and (item.TigerId not in (select value from string_split(@itemIds, '','')))')

    if @itemCodeOrName is not null
        set @query = concat(@query, ' and  (item.Code like ''%'' + @itemCodeOrName + ''%'' or item.Name like ''%'' + @itemCodeOrName + ''%'')')

    if @catalogGroupCodes is not null
        set @query = concat(@query, ' and (cgroup.Code in (select value from string_split(@catalogGroupCodes, '','')))')

    if @catalogCodes is not null
        set @query = concat(@query, ' and (catalog.Code in (select value from string_split(@catalogCodes, '','')))')

set @totalCountQuery = concat('select @totalCount = count(1) from (', @query, ' ) t');

exec sp_executesql @totalCountQuery,
         N'@firm smallint,
           @itemCodeOrName nvarchar(200),
           @itemIds nvarchar(200),
           @catalogGroupCodes nvarchar(200),
           @catalogCodes nvarchar(200),
           @clientId int,
           @divisionNr int,
           @currentUserId int,
           @totalCount int output',
         @firm = @firm,
         @itemCodeOrName = @itemCodeOrName,
         @itemIds = @itemIds,
         @catalogGroupCodes = @catalogGroupCodes,
         @catalogCodes = @catalogCodes,
         @clientId = @clientId,
         @divisionNr = @divisionNr,
         @currentUserId = @currentUserId,
         @totalCount = @totalCount output;

 if @sorting is null
    set @query = concat(@query, ' order by Id  ' + '  offset @skipCount rows fetch next @maxResultCount rows only')

 if @sorting is not null
    set @query = concat(@query, ' order by  ' + @sorting + '  offset @skipCount rows fetch next @maxResultCount rows only')

    exec sp_executesql @query,
         N'@firm smallint,
           @itemCodeOrName nvarchar(200),
           @sorting nvarchar(200),
           @maxResultCount int,
           @skipCount int,
           @itemIds nvarchar(200),
           @catalogGroupCodes nvarchar(200),
           @catalogCodes nvarchar(200),
           @clientId int,
           @divisionNr int,
           @currentUserId int,
           @totalCount int output',
         @firm = @firm,
         @itemCodeOrName = @itemCodeOrName,
         @sorting = @sorting,
         @maxResultCount = @maxResultCount,
         @skipCount = @skipCount,
         @itemIds = @itemIds,
         @catalogGroupCodes = @catalogGroupCodes,
         @catalogCodes = @catalogCodes,
         @clientId = @clientId,
         @divisionNr = @divisionNr,
         @currentUserId = @currentUserId,
         @totalCount = @totalCount output;
END;