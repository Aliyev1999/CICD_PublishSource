create or ALTER FUNCTION [dbo].[F_MGM_GetCashAccountsData]( @firm smallint,@BeginDate datetime, @EndDate datetime, @CurrentUserId bigint)
    RETURNS TABLE AS RETURN
        with Permitted as (select distinct TigerCashCardId
                           from MD_PermittedCashCard
                           where UserId = @CurrentUserId )

        select Data.Id      as Id,
               Name         as Name,
               Code         as Code,
               Amount       as Balance,
               CurrencyCode as Currency
        from TestTigerEnt_db..FN_TS_Report_GetCashCard_009(@endDate) Data
                 join Permitted on Data.Id = Permitted.TigerCashCardId 