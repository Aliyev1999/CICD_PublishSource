CREATE OR ALTER   FUNCTION [dbo].[F_FM_GetFiles](@firm SMALLINT, 
									 @clientId BIGINT,
									 @currentUserId int)
    Returns Table
        AS
        RETURN
            (
select distinct folder.Id       as FolderId,
                folder.ParentId as ParentFolderId,
                folder.Name     as FolderName,
                pFolder.Name    as ParentFolderName,
                SecureUrl       as FileUrl,
                files.Name      as FileName
from FM_Folders folder with (nolock)
         left join FM_Files files with (nolock) on files.FolderId = folder.Id AND files.Firm = folder.Firm
         left join FM_Folders pFolder with (nolock) on folder.ParentId = pFolder.Id
         join FM_FileClientMapping mapping with (nolock) on files.Id = mapping.FileId
         left join MD_Client client with (nolock) on mapping.ReferenceType = 1 AND mapping.ReferenceId = client.TigerId
         join F_GetPermittedClientForUser(@currentUserId) pclient on client.TigerId = pclient.ClientId
where isnull(folder.IsDeleted, 0) = 0
  and isnull(folder.IsActive, 1) = 1
  and isnull(files.IsDeleted, 0) = 0
  and folder.Firm = @firm
  and files.Type = 2 and @clientId is not null and client.TigerId = @clientId
  --and (@clientId is null or client.TigerId = @clientId)

union all

select distinct folder.Id       as FolderId,
                folder.ParentId as ParentFolderId,
                folder.Name     as FolderName,
                pFolder.Name    as ParentFolderName,
                SecureUrl       as FileUrl,
                files.Name      as FileName
from FM_Folders folder with (nolock)
         left join FM_Files files with (nolock) on files.FolderId = folder.Id AND files.Firm = folder.Firm
         left join FM_Folders pFolder with (nolock) on folder.ParentId = pFolder.Id
         join FM_FileClientMapping mapping with (nolock) on files.Id = mapping.FileId
         left join MD_ClientGroupData groupData with (nolock) on mapping.ReferenceType = 2 AND mapping.ReferenceId = groupData.GroupId
         join F_GetPermittedClientForUser(@currentUserId) pclient on groupData.ClientId = pclient.ClientId
where isnull(folder.IsDeleted, 0) = 0
  and isnull(folder.IsActive, 1) = 1
  and isnull(files.IsDeleted, 0) = 0
  and folder.Firm = @firm
  and files.Type = 2 and @clientId is not null and groupData.ClientId = @clientId
  --and (@clientId is null or groupData.ClientId = @clientId)



union all


select distinct 
       folder.Id                                                                     as FolderId,
       folder.ParentId                                                               as ParentFolderId,
       folder.Name                                                                   as FolderName,
       pFolder.Name                                                                  as ParentFolderName,
       SecureUrl                                                                     as FileUrl,
       files.Name                                                                    as FileName
from FM_Folders folder with (nolock)
     left join FM_Files files with (nolock) on files.FolderId = folder.Id and files.Firm = folder.Firm
     left join FM_Folders pFolder with (nolock) on folder.ParentId = pFolder.Id
     left join FM_FileUserMapping usermapping with (nolock) on files.Id = usermapping.FileId
     left join AbpUsers users with (nolock) on usermapping.ReferenceType = 1 and usermapping.ReferenceId = users.Id
     left join MD_UserGroupMapping groupmapping with (nolock) on usermapping.ReferenceType = 2 AND usermapping.ReferenceId = groupmapping.GroupId 
where isnull(folder.IsDeleted,0) = 0
  and isnull(folder.IsActive,1) = 1
  and isnull(files.IsDeleted, 0) = 0
  and folder.Firm = @firm
  and coalesce(users.Id, groupmapping.UserId) = @currentUserId
  and files.Type = 1
  and @clientId is null


			)
      