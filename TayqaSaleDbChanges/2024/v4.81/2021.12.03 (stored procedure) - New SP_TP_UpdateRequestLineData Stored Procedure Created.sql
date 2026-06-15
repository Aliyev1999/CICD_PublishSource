CREATE PROCEDURE [dbo].[SP_TP_UpdateRequestLineData](@requestId INT NULL,
                                                             @partNo TINYINT NULL,
                                                             @itemId INT NULL,
                                                             @price FLOAT NULL,
                                                             @isCustomPrice BIT NULL,
                                                             @amount FLOAT NULL)
AS
BEGIN
    BEGIN TRY
        IF @requestId IS NULL OR @partNo IS NULL OR @price IS NULL OR @amount IS NULL OR @itemId IS NULL
            RAISERROR('NULL Value is passed', 1, 1)
        ELSE
            DECLARE @Query NVARCHAR(MAX) = 'UPDATE OP_ThirdPartyRequestQueueCommonLineExtension SET Amount = @amount, IsCustomPrice = @isCustomPrice, Price = @price WHERE Id = @requestId AND PartNo = @partNo AND ItemId = @itemId'
    END TRY
    BEGIN CATCH
		PRINT('A Null Value is passed')
	END CATCH

-- PRINT CAST(@Query AS NTEXT)

    EXEC sp_executesql @Query,
         N'@requestId INT,
         @partNo TINYINT,
         @itemId INT,
         @price FLOAT,
         @isCustomPrice BIT,
         @amount FLOAT',
         @requestId=@requestId,
         @partNo=@partNo,
         @itemId=@itemId,
         @price=@price,
         @isCustomPrice=@isCustomPrice,
         @amount=@amount

END