ALTER PROCEDURE [dbo].[SP_MD_GetStopReasons] @userId INT
AS
BEGIN
    SET NOCOUNT ON;
--20,21,22 olanlar 
    SELECT sr.Id          AS Id,
           sr.Name        AS Name,
           sr.Type        AS Type,
           sr.Description AS Description,
           sr.IsActive    AS IsActive
    FROM MD_StopReason sr WITH (NOLOCK)
             left join UIM_UserModuleConfigParameter UserModuleConfigParameter with (nolock)
                       on UserModuleConfigParameter.ObjectValue = sr.Id and ObjectId in (20, 21, 22)
    WHERE IsDeleted = 0
      and IsActive = 1
      and UserId = @userId
    union
--20,21,22 olmayanlar 
    SELECT sr.Id          AS Id,
           sr.Name        AS Name,
           sr.Type        AS Type,
           sr.Description AS Description,
           sr.IsActive    AS IsActive
    FROM MD_StopReason sr WITH (NOLOCK)
    WHERE IsDeleted = 0
      and IsActive = 1
      and Type not in (13, 14, 15)
END