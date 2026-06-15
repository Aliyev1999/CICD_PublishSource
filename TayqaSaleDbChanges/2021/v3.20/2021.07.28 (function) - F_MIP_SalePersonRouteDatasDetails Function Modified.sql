/****** Object:  UserDefinedFunction [dbo].[F_MIP_SalePersonRouteDatasDetails]    Script Date: 8/2/2021 5:42:09 PM ******/
ALTER FUNCTION [dbo].[F_MIP_SalePersonRouteDatasDetails](@userId int,@processDate date, @userActionTypes NVARCHAR(MAX) = NULL)
RETURNS TABLE
AS
RETURN(
    SELECT ClientName, ClientCode, Latitude, Longitude, TigerId, RouteStatus, VisitTime
FROM
    ((select T.*, ROW_NUMBER() OVER (PARTITION BY T.TigerId ORDER BY VisitTime ASC) RN
    from (
    SELECT
            C.Name ClientName,
            C.Code ClientCode,
            C.Latitude,
            C.Longitude,
            PC.ClientId TigerId,
            ISNULL(ST.RouteStatus,4) RouteStatus,
            CAST(ST.VisitDate as time) VisitTime
        from F_GetPermittedClientForUser(@userId) PC
            join MD_Client C on PC.Firm = C.Firm and PC.ClientId = C.TigerId
            LEFT JOIN (SELECT ISNULL(r.TigerClientId, l.ClientId) TigerId, CONVERT(VARCHAR, l.SendDate, 120) VisitDate,
                IIF(r.TigerClientId IS NOT NULL AND l.ClientId IS NOT NULL, 1,
				IIF(r.TigerClientId IS NOT NULL, 2,
				IIF(l.ClientId IS NOT NULL, 3, 4))) AS 'RouteStatus'
            FROM MD_Route r
                FULL JOIN OP_UserActionGpsData l ON
					l.Firm = r.Firm AND
                    l.UserId = r.UserId AND
                    l.ClientId = r.TigerClientId AND
                    CAST(l.SendDate AS Date)=r.Date
                JOIN MD_Client c ON ISNULL(r.Firm, l.Firm) = c.Firm AND ISNULL(r.TigerClientId, l.ClientId) = c.TigerId
            WHERE
				ISNULL(r.Date, CAST(l.SendDate AS Date))= @processDate AND
                ISNULL(r.UserId, l.UserId) = @userId AND
				(@userActionTypes IS NULL OR l.ActionTypeId IN (SELECT [Value] FROM F_SplitList(@userActionTypes, ', ')))) ST on ST.TigerId = PC.ClientId
) T)) X
where RN=1
)
