create procedure [dbo].[SP_IM_GetDashBoardDataCounts] 
(
	@totalCount int out
)
As
Begin

	-- Should ignore data - IM_Inventory.Status = 0
	-- Current Statuses
	-- 1 - AtWarehouse - Anbarda
 	-- 2 - TurnOver    - Təhvil vermə
	-- 3 - TakeOver    - Təhvil alma
	-- 4 - AtClient    - Müştəridə

	-- Note: 
	-- Type names must remain the same
	-- Order matters. AtWarehouse-AtClient-TakeOver-TurnOver

	set @totalCount = (select count(*) from IM_Inventory where Status in(1,2,3,4))

	select 'AtWarehouse'	as Type,
		   (select count(*) from IM_Inventory where Status = 1)
							as ActiveCount
	union
	select 'AtClient'			as Type,
		   (select count(*) from IM_Inventory where Status = 4)
								as ActiveCount
	union
	
	select 'TakeOver'					as Type,
		   (select count(*) from IM_Inventory where Status = 3)
										as ActiveCount
	union
	select 'TurnOver'					as Type,
		   (select count(*) from IM_Inventory where Status = 2)
										as ActiveCount
End