CREATE OR ALTER procedure [dbo].[SP_IM_GetInventoryAssetDemands] @startDate datetime,
                                                       @endDate datetime,
                                                       @firm smallint,
                                                       @demandType tinyint,
                                                       @demandNumber int,
                                                       @assetNumber nvarchar(50),
                                                       @equipmentNameOrCode nvarchar(100),
                                                       @bindDirection smallint,
                                                       @creatorUserIds nvarchar(max),
                                                       @userIds nvarchar(max),
                                                       @salesmanIds nvarchar(max),
                                                       @divisionNrs nvarchar(max),
                                                       @warehouseNrs nvarchar(max),
                                                       @departmentNrs nvarchar(max),
                                                       @clientCodeNameEdino nvarchar(100),
                                                       @customFilter nvarchar(max),
                                                       @status nvarchar(max),
                                                       @currentUserId bigint,
                                                       @sorting nvarchar(max),
                                                       @skipCount int = 0,
                                                       @maxResultCount int = 10,
                                                       @totalCount int output
as
begin

    declare @query nvarchar(max);
    declare @Result table
                    (
                        DemandNumber  int,
                        Firm          nvarchar(50),
                        Type          tinyint,
                        CreatedDate   datetime,
                        UserName      nvarchar(100),
                        UserFullName  nvarchar(50),
                        AssetNumber   nvarchar(50),
                        BindDirection tinyint,
                        BindingPlace  nvarchar(100),
                        EquipmentCode nvarchar(50),
                        EquipmentName nvarchar(100),
                        BindingReason        nvarchar(100),
                        Status        tinyint,
                        CancelReason  nvarchar(50)
                    )

    set @query =
            '
with LatestBinding as (select AssetId,
                              BindingType,
                              BindingReasonId,
                              CancelReasonId,
                              row_number() over (partition by AssetId order by CreationTime desc) as RowNum
                       from IM_AssetBinding with (nolock))
select request.Id                         as DemandNumber,
       Firm.Name                          as Firm,
       request.Type                       as Type,
       request.CreationTime               as CreatedDate,
       usr.UserName                       as UserName,
       concat(usr.Name, '' '', usr.Surname) as UserFullName,
       AssetNr                            as AssetNumber,
       asset.BindingType                  as BindDirection,
       case
           when asset.BindingType = 1 then concat(demandusr.Name, '' '', demandusr.Surname)
           when asset.BindingType = 2 then slsman.Name
           when asset.BindingType = 3 then division.Name
           when asset.BindingType = 4 then whouse.Name
           when asset.BindingType = 5 then dep.Name
           when asset.BindingType = 6 then Client.Name
           when asset.BindingType = 128 then ISNULL(asset.BindingReference, '''') collate SQL_Latin1_General_CP1_CI_AS
           ELSE ''''
           end                            as BindingPlace,
       item.Code                          as EquipmentCode,
       item.Name                          as EquipmentName,
       content.Name                       as BindingReason,
       request.Status                     as Status,
       cancelreason.Name                  as CancelReason
from IM_AssetRequest request with (nolock)
         join MD_Firm Firm with (nolock) on Firm.Nr = request.Firm
         left join AbpUsers usr with (nolock) on usr.Id = request.CreatorUserId
         left join IM_Asset asset with (nolock) on asset.Id = request.AssetId and Asset.IsDeleted = 0
         join MD_Item item with (nolock) on item.TigerId = asset.ItemId and item.Firm = request.Firm
         left join AbpUsers demandusr with (nolock) on cast(demandusr.Id as nvarchar(50)) = asset.BindingReference
         left join MD_Salesman slsman with (nolock)
                   on cast(slsman.Code as nvarchar(50)) collate SQL_Latin1_General_CP1_CI_AS = asset.BindingReference and slsman.Firm = asset.Firm and
                      asset.BindingType = 2
		 left join MD_Division division with (nolock)
                   on cast(division.Nr as nvarchar(50)) = asset.BindingReference and division.Firm = asset.Firm and asset.BindingType = 3
         left join MD_Warehouse whouse with (nolock)
                   on cast(whouse.Nr as nvarchar(50)) = asset.BindingReference and whouse.Firm = asset.Firm and asset.BindingType = 4
         left join MD_Department dep with (nolock)
                   on cast(dep.Nr as nvarchar(50)) = asset.BindingReference and dep.Firm = asset.Firm and asset.BindingType = 5
         left join MD_Client client with (nolock)
                   on cast(client.TigerId as nvarchar(50)) = asset.BindingReference and client.Firm = asset.Firm and asset.BindingType = 6
         left join LatestBinding binding on binding.AssetId = request.AssetId and binding.RowNum = 1
         left join IM_StaticContent content with (nolock) on content.Id = binding.BindingReasonId
         left join IM_StaticContent cancelreason with (nolock) on cancelreason.Id = request.CancelledReasonId

		 where 1=1
            '
    if (@startDate is not null and @endDate is not null)
        set @query = concat(@query, ' and request.CreationTime between  @startDate and @endDate')

    if @firm is not null
        set @query = concat(@query, ' and (request.Firm = @firm)')

    if @demandType is not null
        set @query = concat(@query, ' and (request.Type = @demandType)')

    if @demandNumber is not null
        set @query = concat(@query, ' and (request.Id = @demandNumber)')


    if @equipmentNameOrCode is not null
        set @query = concat(@query, ' and (item.Name like ''%''+@equipmentNameOrCode+''%'' or item.Code like ''%''+@equipmentNameOrCode+''%'' )')

    if @assetNumber is not null
        set @query = concat(@query, ' and (AssetNr = @assetNumber)')

    if @bindDirection is not null
        set @query = concat(@query, ' and (asset.BindingType = @bindDirection)')

    if @creatorUserIds is not null
        set @query = concat(@query, ' and (usr.Id in (select value from string_split(@creatorUserIds, '','')))')

    if @userIds is not null
        set @query = concat(@query, ' and (asset.BindingType = 1 and demandusr.Id in (select value from string_split(@userIds, '','')))')

    if @salesmanIds is not null
        set @query = concat(@query, ' and (asset.BindingType = 2 and slsman.Code collate SQL_Latin1_General_CP1_CI_AS in (select value from string_split(@salesmanIds, '','')))')

    if @divisionNrs is not null
        set @query = concat(@query, ' and (asset.BindingType = 3 and division.Nr in (select value from string_split(@divisionNrs, '','')))')

    if @warehouseNrs is not null
        set @query = concat(@query, ' and (asset.BindingType = 4 and whouse.Nr in (select value from string_split(@warehouseNrs, '','')))')

    if @departmentNrs is not null
        set @query = concat(@query, ' and (asset.BindingType = 5 and dep.Nr in (select value from string_split(@departmentNrs, '','')))')

    if @clientCodeNameEdino is not null
        set @query = concat(@query,
                            ' and (asset.BindingType = 6 and (client.Code like ''%''+@clientCodeNameEdino+''%'' or client.Name like ''%''+@clientCodeNameEdino+''%'' or client.Edino like ''%''+@clientCodeNameEdino+''%''))')
   
   if @customFilter is not null
       set @query = concat(@query, 'and (asset.BindingType = 128 and (asset.BindingReference like ''%'' + @customFilter + ''%'' ))')

    if @status is not null
        set @query = concat(@query, ' and (request.Status in (select value from string_split(@status, '','')))')

    if @sorting is null set @Query = concat(@Query, ' order by request.Id desc ')
    if @sorting is not null set @Query = concat(@Query, ' order by ' + @sorting)
    insert into @Result

    EXEC sp_executesql @query,
         N' @startDate datetime,
            @endDate datetime,
            @firm smallint,
            @demandType tinyint,
            @demandNumber int,
            @equipmentNameOrCode nvarchar(100),
            @assetNumber nvarchar(50),
            @bindDirection smallint,
            @creatorUserIds nvarchar(max),
            @userIds nvarchar(max),
            @salesmanIds nvarchar(max) ,
            @divisionNrs nvarchar(max),
            @warehouseNrs nvarchar(max),
            @departmentNrs nvarchar(max),
            @clientCodeNameEdino nvarchar(100),
            @customFilter nvarchar(max),
            @status nvarchar(max),
            @currentUserId bigint,
            @sorting nvarchar(max),
            @skipCount int = 0,
            @maxResultCount int = 10,
            @totalCount int output
			',
         @startDate =@startDate,
         @endDate=@endDate,
         @firm=@firm,
         @demandType=@demandType,
         @demandNumber=@demandNumber,
         @equipmentNameOrCode=@equipmentNameOrCode,
         @assetNumber=@assetNumber,
         @bindDirection=@bindDirection,
         @creatorUserIds=@creatorUserIds,
         @userIds=@userIds,
         @salesmanIds=@salesmanIds,
         @divisionNrs=@divisionNrs,
         @warehouseNrs=@warehouseNrs,
         @departmentNrs=@departmentNrs,
         @clientCodeNameEdino=@clientCodeNameEdino,
         @customFilter=@customFilter,
         @status=@status,
         @currentUserId=@currentUserId,
         @sorting=@sorting,
         @skipCount=@skipCount,
         @maxResultCount=@maxResultCount,
         @totalCount=@totalCount output

    set @TotalCount = (select count(DemandNumber) from @Result);

    select *
    from @Result
    order by coalesce(@sorting, 'DemandNumber') desc
    offset @skipCount rows fetch next @maxResultCount rows only

end