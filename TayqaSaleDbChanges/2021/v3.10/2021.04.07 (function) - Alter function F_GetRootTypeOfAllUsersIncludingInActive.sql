ALTER FUNCTION [dbo].[F_GetRootTypeOfAllUsersIncludingInActive]() 
Returns Table
AS
RETURN(
with
descendants as
(select ParentId as parent, Id as descendant, 1 as level
from UIM_UserType with (nolock)
union all
select d.parent, s.Id, d.level + 1 -- as level
from descendants d
join UIM_UserType s with (nolock) on d.descendant = s.ParentId) 
select DISTINCT u.Id as UserId, u.IsActive, ut.Type, ut.Id AS TypeId, utu.LicenseUserType from UIM_UserTypeUserMapping utu with (nolock)
join 
(select t.Id as parent, t.Id as descendant, 1 as level from UIM_UserType t with (nolock)
union all
select parent, descendant as TypeId, level as Level from descendants with (nolock)) d
on utu.UserTypeId = d.descendant
join UIM_UserType ut with (nolock) on d.parent = ut.Id
join AbpUsers u with (nolock) on u.Id = utu.UserId
where u.IsDeleted = 0 and u.TenantId is not null
and parent is not null
and Type in ('App', 'Web', 'Hybrid')
)
