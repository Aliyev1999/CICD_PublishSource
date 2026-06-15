CREATE function [dbo].[F_RTM_RouteLevelHorizontalTree]()
    returns Table
        as return
            (
                with descendants as
                         (select ParentId as parent, Id as descendant, 1 as level
                          from CRM_RouteTemplateLevelTree
                          where IsDeleted = 0
                          union all
                          select d.parent, s.Id, d.level + 1
                          from descendants as d
                                   join CRM_RouteTemplateLevelTree s on d.descendant = s.ParentId
                          where s.IsDeleted = 0)
                select LevelTreeId,
                       ISNULL(ou4.DisplayName,
                              ISNULL(ou3.DisplayName, ISNULL(ou2.DisplayName, ou1.DisplayName))) as LevelOne,
                       IIF(ou3.DisplayName is not null,
                           IIF(ou4.DisplayName is not null, ou3.DisplayName, ou2.DisplayName),
                           IIF(ou2.DisplayName is not null, ou1.DisplayName, null))                 LevelTwo,

                       IIF(ou2.DisplayName is not null,
                           IIF(ou3.DisplayName is not null,
                               IIF(ou4.DisplayName is not null, ou2.DisplayName, ou1.DisplayName),
                               null),
                           IIF(ou2.DisplayName is not null, ou1.DisplayName, null))                 LevelThree,

                       IIF(ou1.DisplayName is not null,
                           IIF(ou2.DisplayName is not null,
                               IIF(ou3.DisplayName is not null, IIF(ou4.DisplayName is not null, ou1.DisplayName, null),
                                   null),
                               null),
                           IIF(ou2.DisplayName is not null, ou1.DisplayName, null))                 LevelFour
                       --ou4.DisplayName                                                                            as LevelOne,
                       --ou3.DisplayName                                                                            as LevelTwo,
                       --ou2.DisplayName                                                                            as LevelThree,
                       --ou1.DisplayName                                                                            as LevelFour
                from (
                         select descendant LevelTreeId,
                                [1] as     FirstParent,
                                [2]        SecondParent,
                                [3]        ThirdParent
                         from (
                                  select parent, descendant, level
                                  from descendants d
                                  where --parent is not null and
                                        level <= 3
                              ) d
                                  pivot (
                                  max(parent)
                                  for level in ([1], [2], [3])
                                  ) piv) as mainData
                         left join CRM_RouteTemplateLevelTree ou1 on mainData.LevelTreeId = ou1.Id
                         left join CRM_RouteTemplateLevelTree ou2 on mainData.FirstParent = ou2.Id
                         left join CRM_RouteTemplateLevelTree ou3 on mainData.SecondParent = ou3.Id
                         left join CRM_RouteTemplateLevelTree ou4 on mainData.ThirdParent = ou4.Id

            )
go

CREATE   FUNCTION F_RTM_RouteTemplateCalculator()
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
                           CAST(DATEADD(wk, DATEDIFF(wk, 0, StartDate), 0) AS DATE)) AS DateInStartWeek, -- Temsilcilerin startdate-in oldugu heftedeki ilk mumkun tarixi,
                   RT.EndDate                                                        AS EndDate
            FROM CRM_RouteTemplateSalesman SL
                     INNER JOIN CRM_RouteTemplate RT ON SL.TemplateId = RT.Id
                     INNER JOIN CRM_RouteTemplateClient RC ON RT.Id = RC.TemplateId
                     INNER JOIN MD_Salesman S
                                on S.TigerId = SL.SalesmanId and S.Status = 0 and
                                   (S.IsDeleted = 0 OR S.IsDeleted IS NULL) and S.Firm = RT.Firm
                     INNER JOIN CRM_Customer CC on CC.ErpId = RC.ClientId and CC.Firm = RT.Firm and cc.Status = 6
                     left JOIN MD_SalesmanClientMapping M
                               on M.SalesmanId = SL.SalesmanId and M.ClientId = RC.ClientId and M.Firm = RT.Firm

            WHERE EndDate >= CAST(GETDATE() AS DATE)
              and StartDate <= CAST(GETDATE() AS DATE)
              AND RT.Status = 0 -- Statusu aktiv olan sablonlari gostersin
              AND RT.IsDeleted = 0
              and ((RT.CreateTemplateBasedClientSalesmanMapping = 0 and M.SalesmanId is not null and M.IsFromRtm=0 or
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
                        IIF(FirstDate >= CAST(GETDATE() AS date), FirstDate,
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
go