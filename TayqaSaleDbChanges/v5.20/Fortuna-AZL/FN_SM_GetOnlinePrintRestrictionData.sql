CREATE or alter FUNCTION FN_SM_GetOnlinePrintRestrictionData(@requestId INT, @docId varchar(50))
    returns NVARCHAR(100)
    BEGIN

        declare @Message nvarchar(255) = '', @DocType tinyint, @UserId int, @ClientId int

        select top 1 @DocType = DocType, @UserId = UserId, @ClientId = ClientId
        from OP_IncomingLog IncLog with (nolock)
                 join OP_GeneralLog GLog with (nolock) on GLog.RequestId = IncLog.Id and GLog.ImportResult = 0
        where DocId = @docId
        --         declare @UserCode nvarchar(50) = (select Code from AbpUsers with (nolock) where Id = @UserId)
--         declare @SalesmanId int = (select Id from DigiTayqaSecondary..MD_Employee with (nolock) where Code = @UserCode and IsDeleted = 0 and IsActive = 1)

        declare @SoldQuantity float = 0
        declare @ReadQuantity float = 0

        set @SoldQuantity = isnull((select isnull(sum(Line.Quantity), 0) as Quantity
                                    from DigiTayqaSecondary..OP_SaleInvoiceLine Line with (nolock)
                                             join DigiTayqaSecondary..OP_SaleInvoice Invoice with (nolock) on Line.SaleInvoiceId = Invoice.Id
                                             join OP_IncomingLog IncLog with (nolock) on IncLog.Id = Invoice.AppTransactionId
                                             join OP_GeneralLog GLog with (nolock) on GLog.RequestId = IncLog.Id and GLog.ImportResult = 0
                                    where IncLog.DocType = 4
                                      and Invoice.IsDeleted = 0
                                      and Invoice.FirmId = 2
                                      --and Invoice.OperationStatus = 2
                                      and Invoice.OperationType = 3
                                      and Line.IsDeleted = 0
                                      and IncLog.DocId = @docId), 0)

        set @ReadQuantity = isnull((select count(SerialNumber) as SerialCount
                                    from AZL_SerialNumberAfterSale with (nolock)
                                    where ResultId = 0
                                      and DocId = @DocId), 0)

        if @SoldQuantity > @ReadQuantity set @Message = N'Satışa aid paket nömrələrini oxumadan çap etmək olmaz'

        return @Message
    END
go

