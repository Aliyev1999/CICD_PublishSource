CREATE function [dbo].[F_IM_GetRepairDemands](@firm smallint, @beginDate datetime null, @endDate datetime null, @userId int)
    RETURNS Table
        AS
        RETURN
            (
                select * from F_IM_GetAllRepairDemands(@firm,@beginDate,@endDate,@userId)
				  where Status in (1, 2, 3, 4, 5)
            )
