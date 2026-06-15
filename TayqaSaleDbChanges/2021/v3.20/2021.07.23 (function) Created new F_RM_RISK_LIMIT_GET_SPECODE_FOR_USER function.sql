
CREATE function [dbo].[F_RM_RISK_LIMIT_GET_SPECODE_FOR_USER] (@UserId int)
    returns table
        as
        return
            (
                select top 1 Specode1 as Specode
                from UIM_UserProperty
                where UserId = @UserId
            )







