USE [Unity]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TS_MasterData_GetClient_XXX]    Script Date: 2/19/2021 12:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Function [dbo].[FN_TS_MasterData_GetClient_XXX] (@beginDate datetime, @endDate datetime)
    RETURNS TABLE
        AS RETURN
            (
                SELECT CLCARD.LOGICALREF                                                                             AS ClientId,
                       CLCARD.ACTIVE                                                                                 AS Status,
                       CLCARD.CARDTYPE                                                                               AS CardType,
                       CLCARD.CODE                                                                                   AS Code,
                       REPLACE(CLCARD.DEFINITION_, 'È', N'Ə')                                                        AS Name,
                       CLCARD.EMAILADDR                                                                              AS Email,
                       REPLACE(ISNULL(CLCARD.ADDR1, ''), 'È', N'Ə')                                                  AS Address,
                       REPLACE(ISNULL(CLCARD.ADDR2, ''), 'È', N'Ə')                                                  AS AdressExtension,
                       PARENTCARD.LOGICALREF                                                                         AS ParentId,
                       ISNULL(CLCARD.COUNTRY, '')                                                                    AS Country,
                       ISNULL(CLCARD.CITY, '')                                                                       AS City,
                       ISNULL(CLCARD.TOWN, '')                                                                       AS Town,
                       ISNULL(CLCARD.DISTRICT, '')                                                                   AS District,
                       ISNULL(CLCARD.TELNRS1, '')                                                                    AS Telephone,
                       ISNULL(CLCARD.TAXNR, '')                                                                      AS TaxNo,
                       ISNULL(CLCARD.TRADINGGRP, '')                                                                 AS TradingGrp,
                       REPLACE(ISNULL(LEFT(CLCARD.ADDR1, 20), ''), 'È', N'Ə')                                        AS Edino,
                       REPLACE(ISNULL(CLCARD.INCHARGE, ''), 'È', N'Ə')                                               AS Incharge,
                       CLCARD.TCKNO                                                                                  AS IdentityNo,
                       CLCARD.SPECODE                                                                                AS Specode,
                       ISNULL(SPE.DEFINITION_, '')                                                                   AS SpecodeDesc,
                       CLCARD.SPECODE2                                                                               AS Specode2,
                       REPLACE(ISNULL(SPE2.DEFINITION_, ''), 'È', N'Ə')                                              AS Specode2Desc,
                       CLCARD.SPECODE3                                                                               AS Specode3,
                       ISNULL(SPE3.DEFINITION_, '')                                                                  AS Specode3Desc,
                       CLCARD.SPECODE4                                                                               AS Specode4,
                       ISNULL(SPE4.DEFINITION_, '')                                                                  AS Specode4Desc,
                       CONCAT(N'MR.T.70 QR (30əd) - ', ISNULL(CAST(DEFLD.NUMFLDS5 AS NVARCHAR(10)), 'YOXDUR'),' %')  AS Specode5,
                       ISNULL(SPE5.DEFINITION_, '')                                                                  AS Specode5Desc,
                       CLCARD.CYPHCODE                                                                               AS AuthCode,
                       ISNULL(AUTH.DEFINITION_, '')                                                                  AS AuthCodeDesc,
                       CLCARD.LONGITUDE                                                                              AS Longitude,
                       CLCARD.LATITUTE                                                                               AS Latitude,
                       CLCARD.PAYMENTREF                                                                             AS PaymentPlanId,
                       ''                                                                                            AS Name2,
                       CLCARD.SPECODE4                                                                               AS SaleChannel,
                       CLCARD.CAPIBLOCK_CREADEDDATE                                                                  AS CreatedDate,
                       CLCARD.CAPIBLOCK_MODIFIEDDATE                                                                 AS ModifiedDate
                FROM LG_XXX_CLCARD CLCARD WITH (NOLOCK)
                         LEFT JOIN LG_XXX_CLCARD PARENTCARD WITH (NOLOCK)
                                   ON (PARENTCARD.LOGICALREF = CLCARD.PARENTCLREF AND PARENTCARD.CARDTYPE = 4)
                         left join LG_XXX_DEFNFLDSCARDV DEFLD on CLCARD.LOGICALREF = DEFLD.PARENTREF
                         LEFT JOIN LG_XXX_SPECODES SPE WITH (NOLOCK)
                                   ON SPE.SPECODE = CLCARD.SPECODE and SPE.CODETYPE = 1 and SPE.SPECODETYPE = 26
                         LEFT JOIN LG_XXX_SPECODES SPE2 WITH (NOLOCK)
                                   ON SPE2.SPECODE = CLCARD.SPECODE2 and SPE2.CODETYPE = 1 and SPE2.SPECODETYPE = 26
                         LEFT JOIN LG_XXX_SPECODES SPE3 WITH (NOLOCK)
                                   ON SPE3.SPECODE = CLCARD.SPECODE3 and SPE3.CODETYPE = 1 and SPE3.SPECODETYPE = 26
                         LEFT JOIN LG_XXX_SPECODES SPE4 WITH (NOLOCK)
                                   ON SPE4.SPECODE = CLCARD.SPECODE4 and SPE4.CODETYPE = 1 and SPE4.SPECODETYPE = 26
                         LEFT JOIN LG_XXX_SPECODES SPE5 WITH (NOLOCK)
                                   ON SPE5.SPECODE = CLCARD.SPECODE5 and SPE5.CODETYPE = 1 and SPE5.SPECODETYPE = 26
                         LEFT JOIN LG_XXX_SPECODES AUTH WITH (NOLOCK)
                                   ON AUTH.SPECODE = CLCARD.CYPHCODE and AUTH.CODETYPE = 2 and AUTH.SPECODETYPE = 26
                WHERE ((CLCARD.CAPIBLOCK_CREADEDDATE >= @beginDate AND CLCARD.CAPIBLOCK_CREADEDDATE <= @endDate)
                    OR (CLCARD.CAPIBLOCK_MODIFIEDDATE >= @beginDate AND CLCARD.CAPIBLOCK_MODIFIEDDATE <= @endDate))
                  AND CLCARD.CARDTYPE IN (3, 4)
            );