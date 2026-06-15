
create function F_IM_GetInventoryBadgeCounts
(
	@userId int,
	@firm smallint
)
returns table
as
return
(
	select count(Id) as AssetBindingCount
	from IM_AssetBinding
	where AssignedUserId = @userId and Firm = @firm and Status = 1
)

go