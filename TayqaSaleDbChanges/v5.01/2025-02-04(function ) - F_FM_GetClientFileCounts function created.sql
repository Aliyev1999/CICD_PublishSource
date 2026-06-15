CREATE OR ALTER FUNCTION [dbo].[F_FM_GetClientFileCounts](@firm SMALLINT, @currentUserId INT)
    Returns Table
        AS
        RETURN
            (
WITH GroupClientCounts AS (SELECT GroupId,
                                  COUNT(ClientId) AS GroupClientCount
                           FROM MD_ClientGroupData WITH (NOLOCK)
                           GROUP BY GroupId),
     ClientGroupFiles AS (SELECT groupData.ClientId AS ClientId,
                                 COUNT(files.Id)    AS GroupFileCount
                          FROM FM_Files files WITH (NOLOCK)
                                   JOIN FM_Folders folder WITH (NOLOCK) ON files.FolderId = folder.Id
                                   LEFT JOIN FM_Folders parentFolder WITH (NOLOCK) ON folder.ParentId = parentFolder.Id
                                   JOIN FM_FileClientMapping mapping WITH (NOLOCK) ON files.Id = mapping.FileId AND mapping.ReferenceType = 2 
                                   JOIN MD_ClientGroupData groupData WITH (NOLOCK) ON mapping.ReferenceId = groupData.GroupId
                          WHERE files.Firm = @firm
                          GROUP BY groupData.ClientId)

SELECT client.Name                          AS Name,
       client.Code                          AS Code,
       client.Edino                         AS Edino,
       client.TigerId                       AS Id,
       SUM(
               CASE
                   WHEN mapping.ReferenceType = 1 AND mapping.ReferenceId = client.TigerId
                       THEN 1
                   ELSE 0
                   END
           ) +
       ISNULL(groupFiles.GroupFileCount, 0) AS FileCount 
FROM FM_Files files WITH (NOLOCK)
         JOIN FM_Folders folder WITH (NOLOCK) ON files.FolderId = folder.Id
         LEFT JOIN FM_Folders parentFolder WITH (NOLOCK) ON folder.ParentId = parentFolder.Id
         JOIN FM_FileClientMapping mapping WITH (NOLOCK) ON files.Id = mapping.FileId
         JOIN MD_Client client WITH (NOLOCK)
              ON (mapping.ReferenceType = 1 AND mapping.ReferenceId = client.TigerId)
                  OR (mapping.ReferenceType = 2 AND client.TigerId IN
                                                    (SELECT ClientId FROM MD_ClientGroupData WHERE GroupId = mapping.ReferenceId))
         JOIN F_GetPermittedClientForUser(@currentUserId) pclient
              ON client.TigerId = pclient.ClientId AND client.Firm = pclient.Firm
         LEFT JOIN ClientGroupFiles groupFiles
                   ON client.TigerId = groupFiles.ClientId
WHERE files.Firm = @firm
GROUP BY client.Name,
         client.Code,
         client.Edino,
         client.TigerId,
         groupFiles.GroupFileCount

	)