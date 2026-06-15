
CREATE PROCEDURE [dbo].[SP_CRM_GetCRMDashboardReport]
AS
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM MD_Route with(nolock) where Status=0) AS DailyRouteClientCount,
        (SELECT COUNT(*) FROM MD_Client with(nolock) where Status=0 and IsDeleted=0) AS TotalClientCount,
        (SELECT COUNT(*) FROM CRM_RouteTemplateClient with(nolock)) AS ClientCountInTemplate,
        (SELECT COUNT(*) FROM MD_Client with(nolock) where Status=0 and IsDeleted=0) AS TotalClientCount2, -- You may need to adjust this query if it should count differently
        (SELECT COUNT(*) FROM CRM_RouteTemplateSalesman with(nolock)) AS SalesmanCountInTemplate,
        (SELECT COUNT(*) FROM MD_Salesman with(nolock) where Status=0 and IsDeleted=0) AS TotalSalesmanCount,
        (SELECT COUNT(*) FROM CRM_RouteTemplate with(nolock) WHERE IsDeleted = 0 and Status = 0 ) AS ActiveTemplateCount;
END