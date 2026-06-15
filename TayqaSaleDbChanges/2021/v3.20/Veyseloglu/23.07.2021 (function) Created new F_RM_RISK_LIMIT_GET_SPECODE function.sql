CREATE OR ALTER function [dbo].[F_RM_RISK_LIMIT_GET_SPECODE] (@clientId int,@Firm smallint,@UserId int=null)
    Returns table
        As
        return
            (
                select Distinct SpecialCode4
                from MD_Client
                where TigerId = @clientId
                  and Firm = @Firm
            )