alter PROCEDURE [dbo].[SP_MD_GetCashCards] @userId INT, @firm SMALLINT = 0
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT CCard.Firm, CCard.Code, Name, PCARD.RegisteredDate, cast((case when CCard.Code like ''%.U'' then 3 when CCard.Code like ''%.N'' then 2 else 1 end) as tinyint)  InputType
                                    FROM MD_CashCard CCard WITH (NOLOCK)
                                    INNER JOIN MD_PermittedCashCard PCARD WITH (NOLOCK) ON
                                        (CCard.Firm=PCARD.Firm AND CCard.TigerId=PCARD.TigerCashCardId AND PCARD.UserId=@userId)
                                    Where 1=1';
    IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and PCARD.Firm=@firm');
        END
    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT', @userId = @userId, @firm = @firm

END
go