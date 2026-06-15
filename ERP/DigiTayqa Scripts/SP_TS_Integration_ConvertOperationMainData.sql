CREATE OR ALTER PROCEDURE [dbo].[SP_TS_Integration_ConvertOperationMainData] @firm SMALLINT,  @tenantId nvarchar(100), @division SMALLINT = null, @warehouse SMALLINT = null, 
@department SMALLINT = null, @specode nvarchar(100) = null, @authCode nvarchar(100) =null, @cashCard nvarchar(100) = null
AS
BEGIN

SELECT 
Firm.Id as FirmId,
Warehouse.Id as WarehouseId,  
Specode.Id as SpecodeId,
AuthCode.Id as AuthCodeId,
Department.Id as DepartmentId,
Division.Id as DivisionId,
CashCard.Id as CashCardId
FROM TayqaCloudErp.dbo.MD_Firm Firm WITH (NOLOCK)
left join TayqaCloudErp.dbo.MD_Division Division on Division.FirmId = Firm.Id and Division.Number = @division and Division.IsActive = 1 and Division.IsDeleted = 0  and Division.TenantId = @tenantId
left join TayqaCloudErp.dbo.MD_Warehouse Warehouse on Warehouse.FirmId=Firm.Id and Warehouse.Number = @warehouse and Warehouse.IsActive = 1 and Warehouse.IsDeleted = 0  and Warehouse.TenantId = @tenantId
left join TayqaCloudErp.dbo.MD_Department Department on Department.FirmId = Firm.Id and Department.Number = @department and Department.IsActive = 1 and Department.IsDeleted = 0  and Department.TenantId = @tenantId
left join TayqaCloudErp.dbo.SD_Specode Specode on Specode.FirmId = Firm.Id and Specode.Code = @specode and Specode.IsActive = 1 and Specode.IsDeleted = 0 and Specode.TenantId = @tenantId
left join TayqaCloudErp.dbo.SD_AuthorizationCode AuthCode on AuthCode.FirmId = Firm.Id and AuthCode.Code = @authCode and AuthCode.IsActive = 1 and AuthCode.IsDeleted = 0 and AuthCode.TenantId = @tenantId
left join TayqaCloudErp.dbo.MD_CashCard CashCard on CashCard.FirmId = Firm.Id and CashCard.Code = @cashCard and CashCard.IsActive = 1 and CashCard.IsDeleted = 0 and CashCard.TenantId = @tenantId
where Firm.Number = @firm and Firm.IsActive = 1 and Firm.IsDeleted = 0 and Firm.TenantId = @tenantId-- and AuthCode.Type=5 and Specode.Type=61
END

