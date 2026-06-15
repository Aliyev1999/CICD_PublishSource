ALTER Function [dbo].[FN_TS_MasterData_GetItem](@firm smallint,@beginDate datetime,
    @endDate datetime)
    RETURNS TABLE
        AS RETURN(SELECT @firm                                                                                                          AS Firm,
                         ITEM.idn                                                                                                       AS ItemId,
                         active                                                                                                         AS Status,
                         0
                                                                                                                                        AS CardType,
                         serial                                                                                                         AS Code,
                         ITEM.name + ' - ' + (Select name FROM sm_ol_vah WHERE idn = ITEM.ov_idn) + ' ' + ISNULL(ITEM.kontra_name, ' ') AS Name, /*0 AS */
                         t1.idn                                                                                                            GroupCode,
                         ISNULL(t1.name, 'Tipsiz')                                                                                      AS GroupName,
                         ''                                                                                                             AS ProducerCode,
                         ''                                                                                                             AS ProducerName,
                         2023                                                                                                           AS SpecialCode,
                         'Sezon'                                                                                                        AS SpecialCodeDesc,
                      /*ITEM.zav_art*/
                         null                                                                                                           AS SpecialCode2,
                         'Zavod artikulu'                                                                                               AS SpecialCode2Desc,
                         case when kontra in (2008, 2009) then 'Satinalma' else '' end                                                  As SpecialCode3,
                         ITEM.kontra_name                                                                                               AS SpecialCode3Desc,
                         ''                                                                                                             AS SpecialCode4,
                         ''                                                                                                             AS SpecialCode4Desc,
                         ''                                                                                                             AS SpecialCode5,
                         ''                                                                                                             AS SpecialCode5Desc,
                         ''                                                                                                             AS AuthCode,
                         ''                                                                                                             AS AuthCodeDesc,
                         0                                                                                                              AS Vat,
                         0                                                                                                              AS SellVat,
                         0                                                                                                              AS ReturnVat,
                         0                                                                                                              AS SellRetailVat,
                         0                                                                                                              AS ReturnRetailVat,
                         ITEM.ins_date                                                                                                  AS CreatedDate,
                         ITEM.upd_date
                                                                                                                                        As ModifiedDate,
                         NULL                                                                                                           AS BrendCode,
                         NULL                                                                                                           AS BrendName,
                         NULL                                                                                                           AS TrackingType,
                         null                                                                                                           as TaxCode
                  FROM sm_goods ITEM WITH (NOLOCK)
                           left join sm_good_class t1 on ITEM.class = t1.idn
                  WHERE ((isnull(ITEM.ins_date, '01.01.2000') >= @beginDate AND
                          isnull(ITEM.ins_date, '01.01.2000') <= @endDate) OR (
                             isnull(ITEM.upd_date, '01.01.2222') >= @beginDate AND
                             isnull(ITEM.upd_date, '01.01.2222') <= @endDate))
                    AND isnull(active, 0) = 0);

