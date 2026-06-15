USE [LOGODB_2021]
GO

-- replace values
-- 992 - firm number
-- YY - period number
-- @currencyType - currency type (162 for azn), 160 for TL, 27 for lari
-- @CurrencyCode - currency code, AZN, TL, GEL
-- cash card data
-- client data
ALTER function [dbo].[FN_TS_MasterData_GetClient_992] (@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                SELECT CLCARD.LOGICALREF                               AS ClientId,
                       CLCARD.ACTIVE                                   AS Status,
                       CLCARD.CARDTYPE                                 AS CardType,
                       CLCARD.CODE                                     AS Code,
                       CLCARD.DEFINITION_                              AS Name,
                       CLCARD.EMAILADDR                                AS Email,
                       ISNULL(REPLACE(CLCARD.ADDR1, 'è', N'ə'), '')    AS Address,
                       ISNULL(REPLACE(CLCARD.ADDR2, 'è', N'ə'), '')    AS AdressExtension,
                       PARENTCARD.LOGICALREF                           AS ParentId,
                       ISNULL(CLCARD.COUNTRY, '')                      AS Country,
                       ISNULL(REPLACE(CLCARD.CITY, 'è', N'ə'), '')     AS City,
                       ISNULL(REPLACE(CLCARD.TOWN, 'è', N'ə'), '')     AS Town,
                       ISNULL(REPLACE(CLCARD.DISTRICT, 'è', N'ə'), '') AS District,
                       ISNULL(CLCARD.TELNRS1, '')                      AS Telephone,
                       ISNULL(CLCARD.TAXNR, '')                        AS TaxNo,
                       ISNULL(CLCARD.TRADINGGRP, '')                   AS TradingGrp,
                       ISNULL(PARENTCARD.EDINO, '')                    AS Edino,
                       ISNULL(CLCARD.INCHARGE, '')                     AS Incharge,
                       CLCARD.TCKNO                                    AS IdentityNo,
                       CLCARD.SPECODE                                  AS Specode,
                       ISNULL(SPE.DEFINITION_, '')                     AS SpecodeDesc,
                       CLCARD.SPECODE2                                 AS Specode2,
                       ISNULL(SPE2.DEFINITION_, '')                    AS Specode2Desc,
                       CLCARD.SPECODE3                                 AS Specode3,
                       ISNULL(SPE3.DEFINITION_, '')                    AS Specode3Desc,
                       CLCARD.SPECODE4                                 AS Specode4,
                       ISNULL(SPE4.DEFINITION_, '')                    AS Specode4Desc,
                       CLCARD.SPECODE5                                 AS Specode5,
                       ISNULL(SPE5.DEFINITION_, '')                    AS Specode5Desc,
                       CLCARD.CYPHCODE                                 AS AuthCode,
                       ISNULL(AUTH.DEFINITION_, '')                    AS AuthCodeDesc,
                       CLCARD.LONGITUDE                                AS Longitude,
                       CLCARD.LATITUTE                                 AS Latitude,
                       CLCARD.PAYMENTREF                               AS PaymentPlanId,
                       CLCARD.DEFINITION2                              AS Name2,
                       CLCARD.SPECODE4                                 AS SaleChannel,
                       CLCARD.CAPIBLOCK_CREADEDDATE                    AS CreatedDate,
                       CLCARD.CAPIBLOCK_MODIFIEDDATE                   AS ModifiedDate
                FROM LG_992_CLCARD CLCARD WITH (NOLOCK)
                         LEFT JOIN LG_992_CLCARD PARENTCARD WITH (NOLOCK)
                                   ON (PARENTCARD.LOGICALREF = CLCARD.PARENTCLREF AND PARENTCARD.CARDTYPE = 4)
                         LEFT JOIN LG_992_SPECODES SPE WITH (NOLOCK)
                                   ON SPE.SPECODE = CLCARD.SPECODE and SPE.SPETYP1 = 1 and SPE.CODETYPE = 1 and
                                      SPE.SPECODETYPE = 26
                         LEFT JOIN LG_992_SPECODES SPE2 WITH (NOLOCK)
                                   ON SPE2.SPECODE = CLCARD.SPECODE2 and SPE2.SPETYP2 = 1 and SPE2.CODETYPE = 1 and
                                      SPE2.SPECODETYPE = 26
                         LEFT JOIN LG_992_SPECODES SPE3 WITH (NOLOCK)
                                   ON SPE3.SPECODE = CLCARD.SPECODE3 and SPE3.SPETYP3 = 1 and SPE3.CODETYPE = 1 and
                                      SPE3.SPECODETYPE = 26
                         LEFT JOIN LG_992_SPECODES SPE4 WITH (NOLOCK)
                                   ON SPE4.SPECODE = CLCARD.SPECODE4 and SPE4.SPETYP4 = 1 and SPE4.CODETYPE = 1 and
                                      SPE4.SPECODETYPE = 26
                         LEFT JOIN LG_992_SPECODES SPE5 WITH (NOLOCK)
                                   ON SPE5.SPECODE = CLCARD.SPECODE5 and SPE5.SPETYP5 = 1 and SPE5.CODETYPE = 1 and
                                      SPE5.SPECODETYPE = 26
                         LEFT JOIN LG_992_SPECODES AUTH WITH (NOLOCK)
                                   ON AUTH.SPECODE = CLCARD.CYPHCODE and AUTH.CODETYPE = 2 and AUTH.SPECODETYPE = 26
                WHERE ((CLCARD.CAPIBLOCK_CREADEDDATE >= @beginDate AND CLCARD.CAPIBLOCK_CREADEDDATE <= @endDate)
                    OR (CLCARD.CAPIBLOCK_MODIFIEDDATE >= @beginDate AND CLCARD.CAPIBLOCK_MODIFIEDDATE <= @endDate))
                  AND CLCARD.CARDTYPE IN (3, 4)
            );
