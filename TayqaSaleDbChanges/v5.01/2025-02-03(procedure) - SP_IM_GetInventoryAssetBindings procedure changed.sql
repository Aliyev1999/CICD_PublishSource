CREATE OR ALTER PROCEDURE [dbo].[SP_IM_GetInventoryAssetBindings] @startDate DATETIME,
                                                        @endDate DATETIME,
                                                        @dateType TINYINT,-- 1 - CreationDate, 2 - BindDate
                                                        @firmNr SMALLINT,
                                                        @assetNumber NVARCHAR(50),
                                                        @bindDirection TINYINT, -- 1 - All,2 - User,3 - Salesman,4 - Division, 5 - Warehouse, 6 - Department, 7 - Client, 128 - Other
                                                        @userIds NVARCHAR(MAX),
                                                        @assignedUserIds NVARCHAR(MAX), -- comma seperated user ids
                                                        @salesmanCodes NVARCHAR(MAX), -- comma seperated salesman codes
                                                        @divisionIds NVARCHAR(MAX), -- comma seperated division nr
                                                        @warehouseIds NVARCHAR(MAX), -- comma seperated warehouse nr
                                                        @departmentIds NVARCHAR(MAX), -- comma seperated department nr
                                                        @clientCodeNameEdino NVARCHAR(200),
                                                        @customFilter NVARCHAR(200), -- digər filter`i
                                                        @actNumber NVARCHAR(50),
                                                        @operationStatus NVARCHAR(MAX), -- comma seperated,Pending = 1,Rejected = 2,Completed= 3,Cancelled= 4
                                                        @assetStatus NVARCHAR(MAX), -- comma seperated, InWarehouse = 2, InUse = 3, InReturn = 5, Cancelled = 4
                                                        @bindedUser NVARCHAR(200),
                                                        @bindedReasonIds NVARCHAR(MAX), -- comma seperated
                                                        @currentUserId INT,
                                                        @sorting NVARCHAR(100),
                                                        @skipCount INT,
                                                        @maxResultCount INT,
                                                        @totalCount INT OUTPUT
AS
BEGIN

    DECLARE @query NVARCHAR(MAX);
    DECLARE @Result TABLE
                    (

                        Firm                   NVARCHAR(50),
                        FirmNr                 SMALLINT,
                        AssetNumber            NVARCHAR(50),
                        AssetBindingId         INT,
                        BindDirection          TINYINT,
                        BindedPlace            NVARCHAR(100),
                        BindDate               DATETIME,
                        ReturnDate             DATETIME,
                        CheckPeriodInDays      INT,
                        BindReason             NVARCHAR(100),
                        Status                 TINYINT,
                        ActNumber              NVARCHAR(100),
                        Note                   NVARCHAR(500),
                        Attachment             NVARCHAR(MAX),
                        PlannedReceivingPerson NVARCHAR(100),
                        ActualReceivingPerson  NVARCHAR(100),
                        AssignedUser           NVARCHAR(100),
						CreatedDate			   DATETIME,
						RejectingPerson		   NVARCHAR(100),
						EndDate				   DATETIME
                    )

    SET @query =
            '
              with unique_attachments as (select ReferenceId,
                                             string_agg(SecureUrl, '', '') as Files
                                      from IM_AssetAttachment with (nolock)
                                      where Type in (1, 2, 3)
                                      group by ReferenceId)
          
          select isnull(Firm.Name, '''')                        as Firm,
                 isnull(binding.Firm, '''')                     as FirmNr,
                 isnull(AssetNr, '''')                          as AssetNumber,
                 isnull(binding.Id, '''')                       as AssetBindingId,
                 isnull(binding.BindingType, '''')              as BindDirection,
                 CASE
                     WHEN binding.BindingType = 1 THEN ISNULL(usr.Name + '' '' + usr.Surname, '''')
                     WHEN binding.BindingType = 2 THEN ISNULL(slsman.Name, '''')
                     WHEN binding.BindingType = 3 THEN ISNULL(division.Name, '''')
                     WHEN binding.BindingType = 4 THEN ISNULL(whouse.Name, '''')
                     WHEN binding.BindingType = 5 THEN ISNULL(dep.Name, '''')
                     WHEN binding.BindingType = 6 THEN ISNULL(client.Name, '''')
                     when binding.BindingType = 128 then ISNULL(binding.BindingReference, '''') collate SQL_Latin1_General_CP1_CI_AS
                     ELSE ''''
                     END                                        as BindedPlace,
                 isnull(binding.PlannedHandoverDate, '''')      as BindDate,
                 isnull(binding.PlannedReturnDate, '''')        as ReturnDate,
                 isnull(binding.AuditDayCount, '''')            as CheckPeriodInDays,
                 isnull(content.Name, '''')                     as BindReason,
                 isnull(binding.Status, '''')                   as Status,
                 isnull(binding.ActNo, '' '')                   as ActNumber,
                 isnull(binding.Note, '' '')                    as Note,
                 isnull(attachments.Files, '''')                as Attachment,
                 isnull(binding.PlannedReceivingPerson, '' '')  as PlannedReceivingPerson,
                 isnull(binding.ActualReceivingPerson, '' '')   as ActualReceivingPerson,
                 isnull(assignedusr.Name + '' '' + assignedusr.Surname,'' '') as AssignedUser,
				 isnull(binding.CreationTime, '''')				as CreatedDate,
				 isnull(binding.RejectingPerson, '''')			as RejectingPerson,
				 cast (history.CreationTime as date)	        as EndDate
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
                   left join AbpUsers assignedusr with (nolock) on assignedusr.Id = binding.AssignedUserId
                   left join unique_attachments attachments on attachments.ReferenceId = binding.Id
				   left join IM_AssetBindingHistory history with (nolock) on history.AssetId=binding.AssetId
          where 1 = 1
          
          
                      '
    IF @startDate IS NOT NULL
        AND @endDate IS NOT NULL
        AND @dateType = 1
        SET @query = CONCAT(@query, ' and binding.CreationTime between @startDate and @endDate')

    IF @startDate IS NOT NULL
        AND @endDate IS NOT NULL
        AND @dateType = 2
        SET @query = CONCAT(@query, ' and binding.PlannedHandoverDate between @startDate and @endDate')


    IF @firmNr IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.Firm = @firmNr)')

    IF @assetNumber IS NOT NULL
        SET @query = CONCAT(@query, ' and (AssetNr = @assetNumber)')

    IF @actNumber IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.ActNo = @actNumber)')

    IF @bindDirection IS NOT NULL
        AND @bindDirection != 0
        SET @query = CONCAT(@query, ' and (binding.BindingType = @bindDirection)')

    IF @userIds IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.BindingType = 1 and usr.Id in (select value from string_split(@userIds, '','')))')

    IF @salesmanCodes IS NOT NULL
        SET @query = CONCAT(@query,
                            ' and (binding.BindingType = 2 and slsman.Code collate SQL_Latin1_General_CP1_CI_AS in (select value from string_split(@salesmanCodes, '','')))')

    IF @divisionIds IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.BindingType = 3 and division.Nr in (select value from string_split(@divisionIds, '','')))')

    IF @warehouseIds IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.BindingType = 4 and whouse.Nr in (select value from string_split(@warehouseIds, '','')))')

    IF @departmentIds IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.BindingType = 5 and dep.Nr in (select value from string_split(@departmentIds, '','')))')

    IF @clientCodeNameEdino IS NOT NULL
        SET @query = CONCAT(@query,
                            ' and (binding.BindingType = 6 and (client.Code like ''%''+@clientCodeNameEdino+''%'' or client.Name like ''%''+@clientCodeNameEdino+''%'' or client.Edino like ''%''+@clientCodeNameEdino+''%''))')

    IF @customFilter IS NOT NULL
        SET @query = CONCAT(@query, 'and (binding.BindingType = 128 and (binding.BindingReference like ''%'' + @customFilter + ''%'' ))')

    IF @assetStatus IS NOT NULL
        SET @query = CONCAT(@query, ' and (asset.Status in (select value from string_split(@assetStatus, '','')))')

    IF @operationStatus IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.Status in (select value from string_split(@operationStatus, '','')))')


    IF @bindedUser IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.PlannedReceivingPerson like ''%'' + @bindedUser + ''%'')')


    IF @bindedReasonIds IS NOT NULL
        SET @query = CONCAT(@query, ' and (binding.BindingReasonId  in (select value from string_split(@bindedReasonIds, '','')))')

    IF @assignedUserIds IS NOT NULL
        SET @query = CONCAT(@query, ' and ( assignedusr.Id in (select value from string_split(@assignedUserIds, '','')))')


    IF @sorting IS NULL
        SET @query = CONCAT(@query, ' order by binding.CreationTime desc ')

    IF @sorting IS NOT NULL
        SET @query = CONCAT(@query, ' order by ' + @sorting)
    INSERT INTO @Result
        EXEC sp_executesql @query,
         N' @startDate datetime,
			@endDate datetime,
			@dateType tinyint,
			@firmNr smallint,
			@assetNumber nvarchar(50),
			@bindDirection tinyint,
			@userIds nvarchar(max),
            @assignedUserIds nvarchar(max),
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
			'
            , @startDate = @startDate
            , @endDate = @endDate
            , @dateType = @dateType
            , @firmNr = @firmNr
            , @assetNumber = @assetNumber
            , @bindDirection = @bindDirection
            , @userIds = @userIds
            , @assignedUserIds = @assignedUserIds
            , @salesmanCodes = @salesmanCodes
            , @divisionIds = @divisionIds
            , @warehouseIds = @warehouseIds
            , @departmentIds = @departmentIds
            , @clientCodeNameEdino = @clientCodeNameEdino
            , @customFilter = @customFilter
            , @actNumber = @actNumber
            , @operationStatus = @operationStatus
            , @assetStatus = @assetStatus
            , @bindedUser = @bindedUser
            , @bindedReasonIds = @bindedReasonIds
            , @currentUserId = @currentUserId
            , @sorting = @sorting
            , @skipCount = @skipCount
            , @maxResultCount = @maxResultCount
            , @totalCount = @totalCount

    SET @totalCount = (SELECT COUNT(AssetBindingId)
                       FROM @Result);

    SELECT *
    FROM @Result
    ORDER BY COALESCE(@sorting, 'binding.CreationTime') DESC
    OFFSET ISNULL(@skipCount, 0) ROWS FETCH NEXT ISNULL(@maxResultCount, 10) ROWS ONLY;


END