CREATE OR ALTER procedure [dbo].[SP_IM_GetInventoryAssetBindings] @startDate datetime,
														@endDate datetime,
														@dateType tinyint,-- 1 - CreationDate, 2 - BindDate
														@firmNr smallint,
														@assetNumber nvarchar(50),
														@bindDirection tinyint,             -- 1 - All,2 - User,3 - Salesman,4 - Division, 5 - Warehouse, 6 - Department, 7 - Client, 128 - Other
														@userIds nvarchar(max),				-- comma seperated user ids
														@salesmanCodes nvarchar(max),		-- comma seperated salesman codes
														@divisionIds nvarchar(max),			-- comma seperated division nr
														@warehouseIds nvarchar(max),		-- comma seperated warehouse nr
														@departmentIds nvarchar(max),		-- comma seperated department nr
														@clientCodeNameEdino nvarchar(200),  
														@customFilter nvarchar(200),		-- digər filter`i
														@actNumber nvarchar(50),			 
														@operationStatus nvarchar(max),		-- comma seperated,Pending = 1,Rejected = 2,Completed= 3,Cancelled= 4
														@assetStatus nvarchar(max),			-- comma seperated, InWarehouse = 2, InUse = 3, InReturn = 5, Cancelled = 4
														@bindedUser nvarchar(200),
														@bindedReasonIds nvarchar(max),		-- comma seperated
														@currentUserId int,
														@sorting nvarchar(100),
														@skipCount int,
														@maxResultCount int,
														@totalCount int output
as
begin

    declare @query nvarchar(max);
    declare @Result table
                    (
                        
                        Firm					nvarchar(50),
                        FirmNr					smallint,  
                        AssetNumber				nvarchar(50),
                        AssetBindingId			int,
                        BindDirection			tinyint,
                        BindedPlace				nvarchar(100),
                        BindDate				datetime,
						ReturnDate				datetime,
						CheckPeriodInDays		int,
						BindReason				nvarchar(100),
						Status					tinyint,
						ActNumber				nvarchar(100),
						Note					nvarchar(500),
						Attachment				nvarchar(max),
                        PlannedReceivingPerson  nvarchar(100)
                    )

    set @query =
    '
	with unique_attachments as (select ReferenceId,
                                   string_agg(SecureUrl, '', '') as Files
                            from IM_AssetAttachment with (nolock)
                            where Type in (1, 2, 3)
                            group by ReferenceId)

select isnull(Firm.Name, '''')                       as Firm,
       isnull(binding.Firm, '''')                    as FirmNr,
       isnull(AssetNr, '''')                         as AssetNumber,
       isnull(binding.Id, '''')                      as AssetBindingId,
       isnull(binding.BindingType, '''')             as BindDirection,
       CASE
           WHEN binding.BindingType = 1 THEN ISNULL(usr.Name + '' '' + usr.Surname, '''')
           WHEN binding.BindingType = 2 THEN ISNULL(slsman.Name, '''')
           WHEN binding.BindingType = 3 THEN ISNULL(division.Name, '''')
           WHEN binding.BindingType = 4 THEN ISNULL(whouse.Name, '''')
           WHEN binding.BindingType = 5 THEN ISNULL(dep.Name, '''')
           WHEN binding.BindingType = 6 THEN ISNULL(client.Name, '''')
           when binding.BindingType = 128 then ISNULL(binding.BindingReference, '''') collate SQL_Latin1_General_CP1_CI_AS
           ELSE ''''
           END                                       as BindedPlace,
       isnull(binding.PlannedHandoverDate, '''')     as BindDate,
       isnull(binding.PlannedReturnDate, '''')       as ReturnDate,
       isnull(binding.AuditDayCount, '''')           as CheckPeriodInDays,
       isnull(content.Name, '''')                    as BindReason,
       isnull(binding.Status, '''')                  as Status,
       isnull(binding.ActNo, '' '')                  as ActNumber,
       isnull(binding.Note, '' '')                   as Note,
       isnull(attachments.Files, '''')               as Attachment,
       isnull(binding.PlannedReceivingPerson, '' '') as PlannedReceivingPerson
from IM_AssetBinding binding with (nolock)
         join IM_Asset asset with (nolock) on asset.Id = binding.AssetId and Asset.IsDeleted = 0
         join F_GetAllPermittedUsers(@currentUserId) Permitted on Permitted.UserId = binding.CreatorUserId
         join MD_Firm Firm with (nolock) on Firm.Nr = binding.Firm
         left join AbpUsers usr with (nolock) on cast(usr.Id as nvarchar(50)) = binding.BindingReference and binding.BindingType = 1
         left join MD_Salesman slsman with (nolock)
                   on cast(slsman.Code as nvarchar(50)) collate SQL_Latin1_General_CP1_CI_AS = binding.BindingReference and slsman.Firm = binding.Firm and
                      binding.BindingType = 2
         left join MD_Division division with (nolock)
                   on cast(division.Nr as nvarchar(50)) = binding.BindingReference and division.Firm = binding.Firm and binding.BindingType = 3
         left join MD_Warehouse whouse with (nolock)
                   on cast(whouse.Nr as nvarchar(50)) = binding.BindingReference and whouse.Firm = binding.Firm and binding.BindingType = 4
         left join MD_Department dep with (nolock)
                   on cast(dep.Nr as nvarchar(50)) = binding.BindingReference and dep.Firm = binding.Firm and binding.BindingType = 5
         left join MD_Client client with (nolock)
                   on cast(client.TigerId as nvarchar(50)) = binding.BindingReference and client.Firm = binding.Firm and binding.BindingType = 6
         left join IM_StaticContent content with (nolock) on content.Id = binding.BindingReasonId
         left join unique_attachments attachments on attachments.ReferenceId = binding.Id
where 1 = 1


            '
    if   @startDate is not null and @endDate is not null and @dateType=1
       set @query = concat(@query,' and binding.CreationTime between @startDate and @endDate')

    if   @startDate is not null and @endDate is not null and @dateType=2
		set @query = concat(@query, ' and binding.PlannedHandoverDate between @startDate and @endDate')
			

    if @firmNr is not null
        set @query = concat(@query, ' and (binding.Firm = @firmNr)')

    if @assetNumber is not null
        set @query = concat(@query, ' and (AssetNr = @assetNumber)')

	if @actNumber is not null
        set @query = concat(@query, ' and (binding.ActNo = @actNumber)')

    if @bindDirection is not null and @bindDirection != 0
        set @query = concat(@query, ' and (binding.BindingType = @bindDirection)')

    if @userIds is not null
        set @query = concat(@query, ' and (binding.BindingType = 1 and usr.Id in (select value from string_split(@userIds, '','')))')

    if @salesmanCodes is not null
        set @query = concat(@query, ' and (binding.BindingType = 2 and slsman.Code collate SQL_Latin1_General_CP1_CI_AS in (select value from string_split(@salesmanCodes, '','')))')

    if @divisionIds is not null
        set @query = concat(@query, ' and (binding.BindingType = 3 and division.Nr in (select value from string_split(@divisionIds, '','')))')

    if @warehouseIds is not null
        set @query = concat(@query, ' and (binding.BindingType = 4 and whouse.Nr in (select value from string_split(@warehouseIds, '','')))')

    if @departmentIds is not null
        set @query = concat(@query, ' and (binding.BindingType = 5 and dep.Nr in (select value from string_split(@departmentIds, '','')))')

    if @clientCodeNameEdino is not null
        set @query = concat(@query,
                            ' and (binding.BindingType = 6 and (client.Code like ''%''+@clientCodeNameEdino+''%'' or client.Name like ''%''+@clientCodeNameEdino+''%'' or client.Edino like ''%''+@clientCodeNameEdino+''%''))')

    if @customFilter is not null
       set @query = concat(@query, 'and (binding.BindingType = 128 and (binding.BindingReference like ''%'' + @customFilter + ''%'' ))')

    if @assetStatus is not null
        set @query = concat(@query, ' and (asset.Status in (select value from string_split(@assetStatus, '','')))')

	if @operationStatus is not null 
	    set @query = concat(@query, ' and (binding.Status in (select value from string_split(@operationStatus, '','')))')

	
	if @bindedUser is not null
		set @query = concat(@query,' and (binding.PlannedReceivingPerson like ''%'' + @bindedUser + ''%'')')


	if @bindedReasonIds is not null
		set @query = concat(@query, ' and (binding.BindingReasonId  in (select value from string_split(@bindedReasonIds, '','')))')


    if @sorting is null set @Query = concat(@Query, ' order by binding.CreationTime desc ')

    if @sorting is not null set @Query = concat(@Query, ' order by ' + @sorting)
    insert into @Result

    EXEC sp_executesql @query,
         N' @startDate datetime,
			@endDate datetime,
			@dateType tinyint,
			@firmNr smallint,
			@assetNumber nvarchar(50),
			@bindDirection tinyint,
			@userIds nvarchar(max),	
			@salesmanCodes nvarchar(max),	
			@divisionIds nvarchar(max),			
			@warehouseIds nvarchar(max),		
			@departmentIds nvarchar(max),		
			@clientCodeNameEdino nvarchar(200),  
			@customFilter nvarchar(200),		
			@actNumber nvarchar(50),			 
			@operationStatus nvarchar(max),		
			@assetStatus nvarchar(max),			
			@bindedUser nvarchar(200),
			@bindedReasonIds nvarchar(max),		
			@currentUserId int,
			@sorting nvarchar(100),
			@skipCount int,
			@maxResultCount int,
			@totalCount int output
			',
        @startDate = @startDate,
		@endDate = @endDate,
		@dateType = @dateType,
		@firmNr = @firmNr,
		@assetNumber = @assetNumber ,
		@bindDirection = @bindDirection ,
		@userIds = @userIds,
		@salesmanCodes = @salesmanCodes,		
		@divisionIds = @divisionIds,			
		@warehouseIds = @warehouseIds,		
		@departmentIds = @departmentIds,		
		@clientCodeNameEdino = @clientCodeNameEdino,  
		@customFilter = @customFilter,		
		@actNumber = @actNumber,			 
		@operationStatus = @operationStatus,		
		@assetStatus = @assetStatus,			
		@bindedUser = @bindedUser,
		@bindedReasonIds = @bindedReasonIds,		
		@currentUserId = @currentUserId,
		@sorting = @sorting,
		@skipCount = @skipCount,
		@maxResultCount = @maxResultCount,
		@totalCount =@totalCount

    set @TotalCount = (select count(AssetBindingId) from @Result);

  select *from @Result
order by coalesce(@sorting, 'binding.CreationTime') desc
offset isnull(@skipCount, 0) rows fetch next isnull(@maxResultCount, 10) rows only;


end
