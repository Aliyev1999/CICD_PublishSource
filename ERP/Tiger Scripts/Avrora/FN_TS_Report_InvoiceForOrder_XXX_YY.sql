ALTER Function [dbo].[FN_TS_Report_InvoiceForOrder_XXX_YY](@erpOrderId int)
    RETURNS TABLE
        AS RETURN
            (
                select distinct INVOICE.LOGICALREF   as InvoiceId,
                                INVOICE.FICHENO      as FicheNo,
                                INVOICE.DATE_        as Date,
                                INVOICE.NETTOTAL     as Amount,
                                INVOICE.SPECODE      as Specode,
                                INVOICE.SHPAGNCOD    as Description, -- Maşın nömrəsi
                                SPECODES.DEFINITION_ as Specode2     -- Sürücünün tam adı

                from LG_XXX_YY_STLINE STLINE WITH (NOLOCK)

                         inner join LG_XXX_YY_STFICHE STFICHE WITH (NOLOCK) on STLINE.STFICHEREF  = STFICHE.LOGICALREF
                         inner join LG_XXX_YY_INVOICE INVOICE WITH (NOLOCK) on STFICHE.INVOICEREF = INVOICE.LOGICALREF
                         inner join LG_XXX_YY_ORFICHE ORFICHE WITH (NOLOCK) on STLINE.ORDFICHEREF = ORFICHE.LOGICALREF
                         inner join LG_XXX_SPECODES  SPECODES WITH (NOLOCK)  on SPECODES.SPECODE   = INVOICE.CYPHCODE
                where ORFICHE.LOGICALREF = @erpOrderId
            );