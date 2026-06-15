
create   procedure [dbo].[SP_IM_GetInventoryDemandsForApp](@currentUserId int,
															 @firm smallint,
															 @startDate datetime = null,
															 @endDate datetime = null,
															 @clientTigerId int = null,
															 @inventoryDemandStatus tinyint =null,
															 @inventoryDemandType tinyint =null,
															 @clientCode nvarchar(max) = null,
															 @clientName nvarchar(max) = null,
															 @itemName nvarchar(max) = null,
															 @itemCode nvarchar(max) = null)
as
BEGIN

declare @sqlQuery nvarchar(max);


--if @currentUserId in (select UserId from UIM_UserProperty where Firm = 9 and Specode1 = 'INV')

SET @sqlQuery='SELECT 
				inventoryDemand.Id,
				CAST(inventoryDemand.CreatorUserId as int) AS CreatorUserId,
				inventoryDemand.ClientTigerId,
				client.Name AS ClientName,
				client.Code AS ClientCode,
				item.Name AS ItemName,
				item.Code AS ItemCode,
				item.TigerId AS ItemTigerId,
				inventoryDemandInventoryMapping.InventoryId,
				firm.Nr AS Firm,
				firm.Name AS FirmName,
				inventoryDemand.Description,
				inventoryDemand.ParentUserDescription,
				inventoryDemand.CreationTime,
				inventoryDemand.LastModificationTime,
				inventoryDemand.DemandStatus,
				inventoryDemand.DemandType,
				creatorUser.Name + '' '' +creatorUser.Surname AS CreatorUserFullname,
				demandReason.Id AS DemandReasonId,
				demandReason.Name DemandReasonName,
				demandReason.Type AS DemandReasonType,
				inventoryDemandImage.Id AS ImageId,
				inventoryDemandImage.SecureUrl,
				inventoryDemand.CancelReason,
				CAST(confirmedUser2.Id as int) AS ConfirmedUserId2,
				confirmedUser2.Name + '' '' + confirmedUser2.Surname AS ConfirmedUserFullName2,
				inventoryDemand.ConfirmedDate2,
				inventoryDemand.ConfirmedUserDescription2,
				CAST(rejectedUser2.Id as int) AS RejectedUserId2,
				rejectedUser2.Name + '' '' + rejectedUser2.Surname AS RejectedUserFullName2,
				inventoryDemand.RejectedDate2,
				inventoryDemand.RejectedUserDescription2,
				inventoryDemand.Step

				FROM IM_InventoryDemand inventoryDemand WITH(NOLOCK)
				JOIN MD_Item item WITH(NOLOCK) ON inventoryDemand.Firm = item.Firm AND inventoryDemand.ItemTigerId = item.TigerId
				JOIN MD_Client client WITH(NOLOCK) ON inventoryDemand.Firm = client.Firm and inventoryDemand.ClientTigerId = client.TigerId
				JOIN MD_Firm firm WITH(NOLOCK) ON inventoryDemand.Firm = firm.Nr
				JOIN F_UIM_GetModuleConfigurationBasedOrganizationTreeUsers(@currentUserId, 1) organizationUser ON inventoryDemand.CreatorUserId = organizationUser.UserId
				JOIN AbpUsers creatorUser WITH(NOLOCK) ON inventoryDemand.CreatorUserId = creatorUser.Id
				JOIN IM_StaticContent demandReason WITH(NOLOCK) ON inventoryDemand.InventoryDemandReasonId = demandReason.Id
				LEFT JOIN IM_InventoryDemandInventoryMapping inventoryDemandInventoryMapping WITH(NOLOCK) ON inventoryDemand.Id = inventoryDemandInventoryMapping.InventoryDemandId
				LEFT JOIN IM_InventoryDemandImage inventoryDemandImage WITH(NOLOCK) ON inventoryDemand.Id = inventoryDemandImage.InventoryDemandId
				LEFT JOIN AbpUsers confirmedUser2 WITH(NOLOCK) ON inventoryDemand.ConfirmedUserId2 = confirmedUser2.Id
				LEFT JOIN AbpUsers rejectedUser2 WITH(NOLOCK) ON inventoryDemand.RejectedUserId2 = rejectedUser2.Id
				WHERE inventoryDemand.Firm = @firm';

	if @startDate IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND inventoryDemand.CreationTime >= @startDate');
		END

	if @endDate IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND inventoryDemand.CreationTime <= @endDate');
		END

	if @clientTigerId IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND inventoryDemand.ClientTigerId = @clientTigerId');
		END

	if @inventoryDemandStatus IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND inventoryDemand.DemandStatus = @inventoryDemandStatus');
		END

	if @inventoryDemandType IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND inventoryDemand.DemandType = @inventoryDemandType');
		END

	if @clientCode IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND client.Code LIKE ''%@clientCode%''');
		END

	if @clientName IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND client.Name LIKE ''%@clientName%''');
		END

	if @itemCode IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND item.Code LIKE ''%@itemCode%''');
		END

	if @itemName IS NOT NULL
		BEGIN
			SET @sqlQuery = CONCAT(@sqlQuery, ' AND item.Name LIKE ''%@itemName%''');
		END

EXEC sp_executesql @sqlQuery,
				 N' @currentUserId int,
					@firm smallint,
					@startDate datetime,
					@endDate datetime,
					@clientTigerId int,
					@inventoryDemandStatus tinyint,
					@inventoryDemandType tinyint,
					@clientCode nvarchar(max),
					@clientName nvarchar(max),
					@itemName nvarchar(max),
					@itemCode nvarchar(max)',
					@currentUserId = @currentUserId,
					@firm = @firm,
					@startDate = @startDate,
					@endDate = @endDate,
					@clientTigerId = @clientTigerId,
					@inventoryDemandStatus = @inventoryDemandStatus,
					@inventoryDemandType = @inventoryDemandType,
					@clientCode = @clientCode,
					@clientName = @clientName,
					@itemName = @itemName,
					@itemCode = @itemCode

END