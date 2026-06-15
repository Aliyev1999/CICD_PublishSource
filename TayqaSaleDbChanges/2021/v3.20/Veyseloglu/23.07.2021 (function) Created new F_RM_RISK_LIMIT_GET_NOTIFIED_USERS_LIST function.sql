
CREATE OR ALTER function [dbo].[F_RM_RISK_LIMIT_GET_NOTIFIED_USERS_LIST] (@Specode nvarchar(200),@UserId int=null)
    returns table
        As
        return select Distinct UserId
               from UIM_UserProperty
               where (',' + RTRIM(Specode1) + ',') LIKE '%,' + @Specode + ',%'


