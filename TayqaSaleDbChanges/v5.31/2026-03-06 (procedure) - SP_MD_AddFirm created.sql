create or alter PROCEDURE [dbo].[SP_MD_AddFirm]
    @Nr INT,
    @Name NVARCHAR(100),
    @LocalCurrencyTypeId INT,
    @ExchangeCurrencyTypeId INT,
    @IsActive BIT,
    @Status BIT, 
    @IgnoreDivisionFactoryCheck  BIT,
    @IgnoreDivisionSalesmanCheck BIT, 
    @IgnoreDivisionWarehouseCheck BIT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO MD_Firm (
        Status, Nr, Name, LocalCurrencyTypeId, ExchangeCurrencyTypeId, 
        IsActive, IgnoreDivisionFactoryCheck, IgnoreDivisionSalesmanCheck, 
        IgnoreDivisionWarehouseCheck, RegisteredDate, IsDefault, 
        MustAddDuty, MustAddDepartment, MustAddBranch, MustAddRegionalOffice, 
        MustAddBrand, UniqueUserGroup, UniqueActNoInAssetBinding
    )
    VALUES (
        @Status, @Nr, @Name, @LocalCurrencyTypeId, @ExchangeCurrencyTypeId, 
        @IsActive, @IgnoreDivisionFactoryCheck, @IgnoreDivisionSalesmanCheck, @IgnoreDivisionWarehouseCheck, GETDATE(), 0, 
        0, 0, 0, 0, 0, 0, 0
    );

    INSERT INTO SYS_AccountingPeriod (
        CreatedDate, CreatedUserId, FirmNr, Period, Year, IsActive
    )
    VALUES (
        GETDATE(), 2, @Nr, 1, YEAR(GETDATE()), @IsActive
    );
    INSERT INTO MD_PermittedFirm (
        Firm, UserId, RegisteredDate
    )
    VALUES (
        @Nr, 2, GETDATE()
    );
    INSERT INTO OP_DataExchangeStatus (LastSyncAt, MethodId, Note, RegisteredAt, RegisteredUserId, ResponseStatus, Firm)
    SELECT GETDATE(), m.Id, '', GETDATE(), 2, 'OK', @Nr FROM SYS_DataExchangeMethod m
    WHERE m.Id != 300 and Id not in (select MethodId from OP_DataExchangeStatus where Firm = @Nr)
END;
