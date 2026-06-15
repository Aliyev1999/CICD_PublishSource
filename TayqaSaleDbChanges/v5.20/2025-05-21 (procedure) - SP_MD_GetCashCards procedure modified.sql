ALTER PROCEDURE dbo.SP_MD_GetCashCards @userId INT, @firm SMALLINT = 0
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = '
	with UserGroupPermitted as (
    select 
	    CashCard.TigerCashCardId,
        CashCard.IsDefault,
        1 as Type
    from MD_UserGroupPermittedCashCard CashCard with(nolock)
        join MD_UserGroupMapping Mapping with(nolock) on Mapping.Firm = CashCard.Firm AND CashCard.UserGroupId = Mapping.GroupId
    where CashCard.Firm = @firm AND Mapping.UserId = @userId

    union all

    select  
        Permitted.TigerCashCardId,
        Permitted.IsDefault,
        2 as Type 
    from MD_PermittedCashCard Permitted with(nolock)
    where Permitted.Firm = @firm AND Permitted.UserId = @userId
),
RankedPermissions as (
    select 
        TigerCashCardId,
        IsDefault,
        Type,
        row_number() over ( partition by TigerCashCardId order by Type, IsDefault) as rn
    from UserGroupPermitted
)

select distinct CashCard.Firm, CashCard.Code, Name , CashCard.RegisteredDate, cast(1 as tinyint) InputType
from RankedPermissions
join MD_CashCard CashCard with(nolock) on RankedPermissions.TigerCashCardId=CashCard.TigerId
where rn=1
	';
    IF (@firm > 0)
        BEGIN
            SET @sql = CONCAT(@sql, ' and CashCard.Firm=@firm');
        END
    EXEC sp_executesql @sql, N'@userId INT, @firm SMALLINT', @userId = @userId, @firm = @firm

END
GO