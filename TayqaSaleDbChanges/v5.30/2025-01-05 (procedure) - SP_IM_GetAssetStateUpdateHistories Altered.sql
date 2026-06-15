ALTER   PROCEDURE [dbo].[SP_IM_GetAssetStateUpdateHistories](
    @firm smallint,
    @currentUserId int,
    @startDate datetime,
    @endDate datetime,
    @isExists bit,
    @isPhotoTaken bit,
    @isRepairNeeded bit,
    @assetNumber nvarchar(100),
    @states nvarchar(200),
    @assetLocations nvarchar(200),
    @sorting nvarchar(100),
    @maxResultCount int,
    @skipCount int,
    @totalCount int OUTPUT
)
AS
BEGIN
       DECLARE @query NVARCHAR(MAX);
    DECLARE @totalCountQuery NVARCHAR(MAX);

    SET @query = '
    SELECT
		assetStatusHistory.Id as Id,
        firm.Name AS FirmName,
		asset.AssetNr as AssetNumber,
        COALESCE(locationType.Name, '''') AS AssetLocation,
        COALESCE(state.Name, '''') AS StateName,
        assetStatusHistory.RegisteredDate AS ControlledDate,
        creatorUser.Name AS ControlledUser,
        CONCAT(creatorUser.Name, ''  '', creatorUser.Surname) AS ControlledUserNameAndSurname,
        assetStatusHistory.IsAvailable AS Available,
        CASE WHEN COUNT(attachment.ReferenceId) > cast(0 as bit) THEN cast(1 as bit)  ELSE cast(0 as bit)  END AS IsImageExists,
        assetStatusHistory.IsRepairNeeded AS NeedsRepair,
        assetStatusHistory.Note,
		asset.Id as AssetId,
        asset.BindingType as BindingType,
        asset.BindingReference as BindingReference,
	    CASE
           WHEN asset.BindingType = 1 THEN ISNULL(usr.Name + '' '' + usr.Surname, ''adsiz'')
           WHEN asset.BindingType = 2 THEN ISNULL(slsman.Name, ''adsiz'')
           WHEN asset.BindingType = 3 THEN ISNULL(division.Name, ''adsiz'')
           WHEN asset.BindingType = 4 THEN ISNULL(whouse.Name, ''adsiz'')
           WHEN asset.BindingType = 5 THEN ISNULL(dep.Name, ''adsiz'')
           WHEN asset.BindingType = 6 THEN ISNULL(client.Name, ''adsiz'')
           when asset.BindingType = 128 then ISNULL(asset.BindingReference, ''adsiz'') collate SQL_Latin1_General_CP1_CI_AS
        ELSE '''' END      as BindingReferenceName,
        CAST(IIF(updaterSignature.Id IS NOT NULL OR bondedPersonSignature.Id IS NOT NULL, 1, 0) AS BIT) AS UpdaterOrBondedPersonSigned
    FROM IM_AssetStatusUpdateHistory assetStatusHistory
		join F_GetAllPermittedUsers(@currentUserId) Permitted on Permitted.UserId = assetStatusHistory.CreatorUserId
        LEFT JOIN IM_AssetAttachment updaterSignature WITH (NOLOCK) ON assetStatusHistory.Id = updaterSignature.ReferenceId AND updaterSignature.Type = 8
        LEFT JOIN IM_AssetAttachment bondedPersonSignature WITH (NOLOCK) ON assetStatusHistory.Id = bondedPersonSignature.ReferenceId AND bondedPersonSignature.Type = 9
		JOIN AbpUsers creatorUser WITH (NOLOCK) ON assetStatusHistory.CreatorUserId = creatorUser.Id
		JOIN IM_Asset asset WITH (NOLOCK) ON assetStatusHistory.AssetId = asset.Id
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
		JOIN MD_Firm firm WITH (NOLOCK) ON asset.Firm = firm.Nr
		LEFT JOIN IM_StaticContent locationType WITH (NOLOCK) ON assetStatusHistory.LocationType = locationType.Id
		LEFT JOIN IM_StaticContent state WITH (NOLOCK) ON assetStatusHistory.StateId = state.Id
		LEFT JOIN IM_AssetAttachment attachment WITH (NOLOCK)
        ON assetStatusHistory.Id = attachment.ReferenceId
        AND attachment.Type = 6
	where asset.Firm = @Firm
    '
	
	IF @startDate IS NOT NULL
        AND @endDate IS NOT NULL
        SET @query = CONCAT(@query, ' and assetStatusHistory.RegisteredDate between @startDate and @endDate ')
		;

			IF @isExists IS NOT NULL
BEGIN
    SET @query = CONCAT(@query, 
        CASE 
            WHEN @isExists = 1 THEN ' and assetStatusHistory.IsAvailable = 1 '
            WHEN @isExists = 0 THEN ' and assetStatusHistory.IsAvailable = 0 '
        END
    );
END;

	IF @isPhotoTaken IS NOT NULL
BEGIN
    SET @query = CONCAT(@query, 
        CASE 
            WHEN @isPhotoTaken = 1 THEN ' and attachment.ReferenceId is not null '
            WHEN @isPhotoTaken = 0 THEN ' and attachment.ReferenceId is null '
        END
    );
END;

	IF @isRepairNeeded IS NOT NULL
BEGIN
    SET @query = CONCAT(@query, 
        CASE 
            WHEN @isRepairNeeded = 1 THEN ' and assetStatusHistory.IsRepairNeeded is not null '
            WHEN @isRepairNeeded = 0 THEN ' and assetStatusHistory.IsRepairNeeded is null '
        END
    );
END;


    IF @assetNumber IS NOT NULL
        SET @query = CONCAT(@query,
                            ' and ((asset.AssetNr like ''%''+@assetNumber+''%''))')

	 IF @states IS NOT NULL
        SET @query = CONCAT(@query, ' and (state.Id in (select value from string_split(@states, '','')))')

		IF @assetLocations IS NOT NULL
        SET @query = CONCAT(@query, ' and (locationType.Id in (select value from string_split(@assetLocations, '','')))')

	SET @query = CONCAT(@query, ' GROUP BY
		assetStatusHistory.Id,
        firm.Name,
		asset.AssetNR,
        COALESCE(locationType.Name, ''''),
        COALESCE(state.Name, ''''),
        assetStatusHistory.RegisteredDate,
        creatorUser.Name,
		creatorUser.Surname,
        assetStatusHistory.IsAvailable,
        assetStatusHistory.IsRepairNeeded,
        assetStatusHistory.Note ,
		asset.Id,
        asset.BindingType,
        asset.BindingReference,
		usr.Name,
        usr.Surname,
        slsman.Name,
        division.Name,
        whouse.Name,
        dep.Name,
        client.Name,
	    updaterSignature.Id,
	    bondedPersonSignature.Id')

		 SET @totalCountQuery = CONCAT('SELECT @totalCount = COUNT(1) FROM (', @query, ' ) t');

        EXEC sp_executesql @totalCountQuery,
                N'@firm SMALLINT, 
				@currentUserId INT, 
				@startDate DATETIME, 
				@endDate DATETIME, 
				@isExists BIT, 
				@isPhotoTaken BIT,
				@isRepairNeeded BIT, 
				@assetNumber NVARCHAR(100), 
				@states NVARCHAR(200),
				@assetLocations NVARCHAR(200), 
				@sorting NVARCHAR(100), 
				@maxResultCount INT, 
				@skipCount INT,
                @totalCount INT OUT',
                @firm = @firm, 
                @currentUserId = @currentUserId, 
                @startDate = @startDate,
                @endDate = @endDate,
                @isExists = @isExists,
                @isPhotoTaken = @isPhotoTaken,
                @isRepairNeeded = @isRepairNeeded,
                @assetNumber = @assetNumber,
                @states = @states,
                @assetLocations = @assetLocations,
                @sorting = @sorting,
                @maxResultCount = @maxResultCount,
                @skipCount = @skipCount,
				@totalCount = @totalCount OUT;

  SET @query = concat(@query, ' ORDER BY ' + @sorting + '  OFFSET @skipCount ROWS FETCH NEXT @maxResultCount ROWS ONLY')


   EXECUTE sp_executesql @query,
            N'@firm SMALLINT, 
				@currentUserId INT, 
				@startDate DATETIME, 
				@endDate DATETIME, 
				@isExists BIT, 
				@isPhotoTaken BIT,
				@isRepairNeeded BIT, 
				@assetNumber NVARCHAR(100), 
				@states NVARCHAR(200),
				@assetLocations NVARCHAR(200), 
				@sorting NVARCHAR(100), 
				@maxResultCount INT, 
				@skipCount INT,
              @totalCount INT OUT',
             @firm = @firm, 
                @currentUserId = @currentUserId, 
                @startDate = @startDate,
                @endDate = @endDate,
                @isExists = @isExists,
                @isPhotoTaken = @isPhotoTaken,
                @isRepairNeeded = @isRepairNeeded,
                @assetNumber = @assetNumber,
                @states = @states,
                @assetLocations = @assetLocations,
                @sorting = @sorting,
                @maxResultCount = @maxResultCount,
                @skipCount = @skipCount,
				@totalCount = @totalCount OUT;
END;
    print (@query);