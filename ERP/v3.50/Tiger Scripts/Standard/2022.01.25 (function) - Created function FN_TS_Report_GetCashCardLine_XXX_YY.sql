


CREATE   FUNCTION [dbo].[FN_TS_Report_GetCashCardLine_XXX](@cashCardId int,@begDate datetime,@endDate datetime)
    RETURNS TABLE
        AS
        RETURN
        with a as (SELECT card.CODE + ' - ' + card.DEFINITION_                 'Account',
                          kline.DATE_                                          'Date',
                          kline.FICHENO                                        'FicheNo',
                          CASE
                              WHEN kline.TRCODE in
                                   (11, 12, 21, 22, 32, 33, 34, 35, 36, 37, 38, 39, 41, 42, 71, 72, 73, 74, 75, 76, 77,
                                    79, 80) then kline.TRCODE
                              ELSE 'başqa' END AS                              'DocType',
                          iif(kline.SIGN = 1, -1 * kline.AMOUNT, kline.AMOUNT) 'Amount'

                   FROM LG_XXX_YY_KSLINES kline WITH (NOLOCK)
                            LEFT JOIN LG_XXX_KSCARD kcard WITH (NOLOCK) ON kcard.LOGICALREF = kline.CARDREF
                            LEFT JOIN LG_XXX_YY_CLFLINE line WITH (NOLOCK)
                                      ON line.LOGICALREF = kline.TRANSREF AND kline.VCARDREF = 0
                            LEFT JOIN LG_XXX_CLCARD card WITH (NOLOCK) ON line.CLIENTREF = card.LOGICALREF
                   WHERE kline.STATUS = 0
                     AND kline.CANCELLED = 0
                     and kline.VCARDREF = 0
                     and kline.CARDREF = @cashCardId
        ),

             b as (SELECT kcard.CODE + ' - ' + kcard.NAME as             'Account',
                          kline.DATE_                                    'Date',
                          kline.FICHENO                                  'FicheNo',
                          CASE
                              WHEN kline.TRCODE in
                                   (11, 12, 21, 22, 32, 33, 34, 35, 36, 37, 38, 39, 41, 42, 71, 72, 73, 74, 75, 76, 77,
                                    79, 80) then kline.TRCODE
                              ELSE 500 END                AS             'DocType',
                          iif(SIGN = 1, -1 * kline.AMOUNT, kline.AMOUNT) 'Amount'

                   FROM LG_XXX_YY_KSLINES kline WITH (NOLOCK)
                            LEFT JOIN LG_XXX_KSCARD kcard WITH (NOLOCK) ON kcard.LOGICALREF = kline.VCARDREF
                   WHERE kline.STATUS = 0
                     AND kline.CANCELLED = 0
                     and kline.VCARDREF <> 0
                     and kline.CARDREF = @cashCardId
             ),

             c as (select *
                   from a
                   union all
                   select *
                   from b)

        select *, sum(Amount) over (order by Date rows between unbounded preceding and current row ) as Balance
        from c where c.Date between @begDate and @endDate
GO


