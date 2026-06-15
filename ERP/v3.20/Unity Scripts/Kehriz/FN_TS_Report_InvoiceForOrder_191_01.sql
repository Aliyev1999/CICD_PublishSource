USE [Unity]
GO
ALTER Function [dbo].[FN_TS_Report_InvoiceForOrder_191_01](@erpOrderId int)
    RETURNS TABLE
        AS RETURN
            (
                select distinct INVOICE.LOGICALREF as InvoiceId,
                                INVOICE.FICHENO    as FicheNo,
                                INVOICE.DATE_      as Date,
                                INVOICE.NETTOTAL   as Amount,
                                INVOICE.SPECODE    as Specode,
                                INVOICE.GENEXP1    as Description,
                                WHOUSE.NAME        as Specode2,
                                'AZN'              as CurrencyCode

                from LG_191_01_STLINE STLINE WITH (NOLOCK)

                         inner join LG_191_01_STFICHE STFICHE WITH (NOLOCK) on STLINE.STFICHEREF = STFICHE.LOGICALREF
                         inner join LG_191_01_INVOICE INVOICE WITH (NOLOCK) on STFICHE.INVOICEREF = INVOICE.LOGICALREF
                         inner join LG_191_01_ORFICHE ORFICHE WITH (NOLOCK) on STLINE.ORDFICHEREF = ORFICHE.LOGICALREF
                         inner join L_CAPIWHOUSE WHOUSE WITH (NOLOCK) on WHOUSE.NR = INVOICE.SOURCECOSTGRP 
																	 AND WHOUSE.FIRMNR = 191

                where ORFICHE.LOGICALREF = @erpOrderId
            );
