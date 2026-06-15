ALTER Function [dbo].[FN_TS_Integration_GetInvoice_XXX_YY](@invoiceId int)
    RETURNS TABLE
        AS RETURN(SELECT LOGICALREF                       AS FicheRef,
                         FICHENO                          As FicheNo,
                         NETTOTAL                         As NetTotal,
                         TOTALDISCOUNTS                   AS TotalDiscount,
                         TOTALDISCOUNTS - TOTALPROMOTIONS AS DiscountAmount,
                         CANCELLED                        AS Status,
                         TOTALVAT                         AS TotalVat,
                         GROSSTOTAL                       AS GrossTotal,
                         ''                               as Note
                  FROM LG_XXX_YY_INVOICE WITH (NOLOCK)
                  WHERE LOGICALREF = @invoiceId);
go

