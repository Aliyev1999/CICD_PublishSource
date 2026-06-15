
CREATE OR ALTER FUNCTION [dbo].[F_MGM_GetCashAccountsDashBoardData]( @firm smallint, @BeginDate datetime, @EndDate datetime, @CurrentUserId bigint)
    RETURNS TABLE
        AS
        RETURN
        with Permitted as (select distinct TigerCashCardId
                           from MD_PermittedCashCard with (nolock)
                           where UserId = @CurrentUserId and Firm=@firm)

        SELECT ROUND(SUM((IIF(KSLINE.SIGN = 0, 1, -1) * iif(DATE_ < @BeginDate, 1, 0)) * KSLINE.AMOUNT), 2)         as FirstAccountAmount,
               ROUND(SUM(IIF(KSLINE.SIGN = 0 and DATE_ between @BeginDate and @EndDate, 1, 0) * KSLINE.AMOUNT), 2)  as TotalIncome,
               ROUND(SUM(IIF(KSLINE.SIGN <> 0 and DATE_ between @BeginDate and @EndDate, 1, 0) * KSLINE.AMOUNT), 2) as TotalExpense,
               ROUND(SUM((IIF(KSLINE.SIGN = 0, 1, -1) * iif(DATE_ <= @EndDate, 1, 0)) * KSLINE.AMOUNT), 2)         as LastAccountAmount

        FROM TestTigerEnt_db..LG_009_06_KSLINES KSLINE WITH (NOLOCK)
                 join Permitted with (nolock) on Permitted.TigerCashCardId = KSLINE.CARDREF
        WHERE KSLINE.STATUS = 0
          AND KSLINE.CANCELLED = 0