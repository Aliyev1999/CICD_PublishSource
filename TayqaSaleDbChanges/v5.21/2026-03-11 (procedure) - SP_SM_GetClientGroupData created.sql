
CREATE OR ALTER   PROCEDURE [dbo].[SP_SM_GetClientGroupData]
    @firm INT,
    @syncFlag BIT = NULL,
    @clientStatus INT = NULL,
    @clientCode NVARCHAR(100) = NULL,
    @clientName NVARCHAR(100) = NULL,
    @clientSpecode1 NVARCHAR(100) = NULL,
    @clientSpecode2 NVARCHAR(100) = NULL,
    @clientSpecode3 NVARCHAR(100) = NULL,
    @clientSpecode4 NVARCHAR(100) = NULL,
    @clientSpecode5 NVARCHAR(100) = NULL,
    @groupType INT = NULL,
    @groupCode NVARCHAR(100) = NULL,
    @groupName NVARCHAR(100) = NULL,
    @skipCount int,
    @takeCount int,
    @totalCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @totalCount = COUNT(*) FROM MD_ClientGroupData AS cgc
    INNER JOIN MD_Client AS client 
        ON cgc.ClientId = client.TigerId AND cgc.Firm = client.Firm
    INNER JOIN MD_ClientGroupInfo AS clientGroup 
        ON cgc.GroupId = clientGroup.GroupId AND cgc.Firm = clientGroup.Firm AND cgc.GroupType = clientGroup.GroupType
    WHERE 
        cgc.Firm = @firm
        AND (@syncFlag IS NULL OR cgc.SyncFlag = @syncFlag)
        AND client.IsDeleted = 0
        AND (@clientStatus IS NULL OR client.Status = @clientStatus)
        AND (@clientCode IS NULL OR @clientCode = '' OR client.Code LIKE @clientCode + '%')
        AND (@clientName IS NULL OR @clientName = '' OR client.Name LIKE '%' + @clientName + '%')
        AND (@clientSpecode1 IS NULL OR @clientSpecode1 = '' OR client.SpecialCode LIKE '%' + @clientSpecode1 + '%')
        AND (@clientSpecode2 IS NULL OR @clientSpecode2 = '' OR client.SpecialCode2 LIKE '%' + @clientSpecode2 + '%')
        AND (@clientSpecode3 IS NULL OR @clientSpecode3 = '' OR client.SpecialCode3 LIKE '%' + @clientSpecode3 + '%')
        AND (@clientSpecode4 IS NULL OR @clientSpecode4 = '' OR client.SpecialCode4 LIKE '%' + @clientSpecode4 + '%')
        AND (@clientSpecode5 IS NULL OR @clientSpecode5 = '' OR client.SpecialCode5 LIKE '%' + @clientSpecode5 + '%')
        AND clientGroup.IsDeleted = 0
        AND (@groupType IS NULL OR clientGroup.GroupType = @groupType)
        AND (@groupCode IS NULL OR @groupCode = '' OR clientGroup.GroupCode LIKE '%' + @groupCode + '%')
        AND (@groupName IS NULL OR @groupName = '' OR clientGroup.GroupName LIKE '%' + @groupName + '%');

    SELECT 
        cgc.GroupId,
        client.Code AS ClientCode,
        client.Name AS ClientName,
        client.SpecialCode AS ClientSpecode1,
        clientGroup.GroupCode,
        clientGroup.GroupName,
        cgc.GroupType,
        cgc.SyncFlag,
        cgc.RegisteredDate,
        cgc.ClientId,
        client.Status AS ClientStatus
    FROM MD_ClientGroupData AS cgc
    INNER JOIN MD_Client AS client 
        ON cgc.ClientId = client.TigerId AND cgc.Firm = client.Firm
    INNER JOIN MD_ClientGroupInfo AS clientGroup 
        ON cgc.GroupId = clientGroup.GroupId AND cgc.Firm = clientGroup.Firm AND cgc.GroupType = clientGroup.GroupType
    WHERE 
        cgc.Firm = @firm
        AND (@syncFlag IS NULL OR cgc.SyncFlag = @syncFlag)
        AND client.IsDeleted = 0
        AND (@clientStatus IS NULL OR client.Status = @clientStatus)
        AND (@clientCode IS NULL OR @clientCode = '' OR client.Code LIKE @clientCode + '%')
        AND (@clientName IS NULL OR @clientName = '' OR client.Name LIKE '%' + @clientName + '%')
        AND (@clientSpecode1 IS NULL OR @clientSpecode1 = '' OR client.SpecialCode LIKE '%' + @clientSpecode1 + '%')
        AND (@clientSpecode2 IS NULL OR @clientSpecode2 = '' OR client.SpecialCode2 LIKE '%' + @clientSpecode2 + '%')
        AND (@clientSpecode3 IS NULL OR @clientSpecode3 = '' OR client.SpecialCode3 LIKE '%' + @clientSpecode3 + '%')
        AND (@clientSpecode4 IS NULL OR @clientSpecode4 = '' OR client.SpecialCode4 LIKE '%' + @clientSpecode4 + '%')
        AND (@clientSpecode5 IS NULL OR @clientSpecode5 = '' OR client.SpecialCode5 LIKE '%' + @clientSpecode5 + '%')
        AND clientGroup.IsDeleted = 0
        AND (@groupType IS NULL OR clientGroup.GroupType = @groupType)
        AND (@groupCode IS NULL OR @groupCode = '' OR clientGroup.GroupCode LIKE '%' + @groupCode + '%')
        AND (@groupName IS NULL OR @groupName = '' OR clientGroup.GroupName LIKE '%' + @groupName + '%')
        ORDER BY client.RegisteredDate -- Sayfalama için şart
        OFFSET @skipCount ROWS FETCH NEXT @takeCount ROWS ONLY;
END
