ALTER FUNCTION [dbo].[F_RTM_RouteTemplateCalculator]()
    RETURNS TABLE AS
        RETURN
        WITH CTE AS (
            SELECT RT.Firm                                                           AS Firm,
                   RT.Id                                                             AS TemplateId,
                   Rt.CreateTemplateBasedClientSalesmanMapping                       AS CreateSalesmanClientMapping,
                   RC.ClientId                                                       AS ClientId,
                   RC.ClientOrderNo                                                  AS ClientOrderNo,
                   SL.SalesmanId                                                     AS SalesmanId,
                   SL.Week                                                           AS Week,
                   SL.Day                                                            AS Day,
                   RT.StartDate                                                      AS StartDate,
                   DATEADD(DAY,
                           Day - IIF(@@DATEFIRST = 7, 1, 0), -- Heftenin baslangic gunu bazardirsa 1 cixiriq gunden , 1ci gundurse hec ne cixmiriq
                           CAST(DATEADD(WK, DATEDIFF(WK, 0, StartDate), 0) AS DATE)) AS DateInStartWeek, -- Temsilcilerin startdate-in oldugu heftedeki ilk mumkun tarixi,
                   RT.EndDate                                                        AS EndDate
            FROM CRM_RouteTemplateSalesman SL
                     INNER JOIN CRM_RouteTemplate RT ON SL.TemplateId = RT.Id
                     INNER JOIN CRM_RouteTemplateClient RC ON RT.Id = RC.TemplateId
                     INNER JOIN MD_Salesman S
                                ON S.TigerId = SL.SalesmanId AND S.Status = 0 AND
                                   (S.IsDeleted = 0 OR S.IsDeleted IS NULL) AND S.Firm = RT.Firm
                     -- INNER JOIN CRM_Customer CC ON CC.ErpId = RC.ClientId AND CC.Firm = RT.Firm AND cc.Status = 6
					 INNER JOIN MD_Client C ON C.TigerId = RC.ClientId AND C.Firm = RT.Firm AND (C.IsDeleted IS NULL OR C.IsDeleted = 0) AND C.Status = 0
                     LEFT JOIN MD_SalesmanClientMapping M
                               ON M.SalesmanId = SL.SalesmanId AND M.ClientId = RC.ClientId AND M.Firm = RT.Firm

            WHERE EndDate >= CAST(GETDATE() AS DATE)
              AND StartDate <= CAST(GETDATE() AS DATE)
              AND RT.Status = 0 -- Statusu aktiv olan sablonlari gostersin
              AND RT.IsDeleted = 0
              AND ((RT.CreateTemplateBasedClientSalesmanMapping = 0 AND M.SalesmanId IS NOT NULL OR
                    RT.CreateTemplateBasedClientSalesmanMapping = 1))
        ),

             CTE2 AS (
                 SELECT Firm,
                        TemplateId,
                        CreateSalesmanClientMapping,
                        ClientId,
                        ClientOrderNo,
                        SalesmanId,
                        Week,
                        Day,
                        StartDate,
                        DateInStartWeek,
                        IIF(DateInStartWeek < StartDate,
                            DATEADD(DAY, 7, DateInStartWeek), -- ilk mumkun gun baslangic tarixinden kicikdirse bir sonraki heftenin hemin gununu gotururuk
                            DateInStartWeek) AS FirstDate, -- eger ilk mumkun gun baslangic tarixinden boyukdurse, hemin ilk tarixi gosterir
                        IIF(DATEDIFF(DAY, CAST(GETDATE() AS DATE), EndDate) > 14,
                            DATEADD(DAY, 14, CAST(GETDATE() AS DATE)), -- sablonun enddate-i ve bu gun arasinda 14 gunden cox ferq varsa, bitis tarixi bu gunden 14 gun sonra gotururuk
                            EndDate)         AS EndDate,   -- eks halda ele enddate ozunu gotururuk
                        0                    AS Status     -- statusu manual 0 otururuk
                 FROM CTE),

             CTE3 AS (
                 SELECT Firm,
                        TemplateId,
                        CreateSalesmanClientMapping,
                        ClientId,
                        ClientOrderNo,
                        SalesmanId,
                        Week,
                        Day,
                        StartDate,
                        --DateInStartWeek,
                        --FirstDate,
                        IIF(FirstDate >= CAST(GETDATE() AS DATE), FirstDate,
                            DATEADD(DAY,
                                    (DATEDIFF(DAY, FirstDate, CAST(GETDATE() AS DATE)) / (Week * 7) +
                                     IIF(DATEDIFF(DAY, FirstDate, CAST(GETDATE() AS DATE)) % (Week * 7) = 0, 0, 1)) *
                                    Week * 7,
                                    FirstDate)
                            ) AS NextDate,
                        EndDate,
                        Status
                 FROM CTE2)

        SELECT *
        FROM CTE3
        WHERE NextDate <= EndDate
